#!/usr/bin/env bash
#
# Install SMKit into a target project directory.
# Idempotent: existing files are never overwritten (warn + skip).
# No external dependencies.
#
# Usage:
#   ./install.sh
#   ./install.sh --target /path/to/project --mode full --non-interactive
#
set -euo pipefail

TARGET_DIR=""
MODE=""
NON_INTERACTIVE=0

info()  { printf '\033[36m%s\033[0m\n' "$*" >&2; }
warn()  { printf '\033[33mWARN: %s\033[0m\n' "$*" >&2; }
ok()    { printf '\033[32mOK:   %s\033[0m\n' "$*" >&2; }
err()   { printf '\033[31mERROR: %s\033[0m\n' "$*" >&2; }

usage() {
  cat <<EOF
Usage: install.sh [options]

Options:
  --target, -t PATH     Target directory (default: current directory)
  --mode, -m MODE       lightweight | full (default: lightweight)
  --non-interactive     Skip prompts (use defaults)
  --help, -h            Show this help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target|-t) TARGET_DIR="$2"; shift 2 ;;
    --mode|-m) MODE="$2"; shift 2 ;;
    --non-interactive) NON_INTERACTIVE=1; shift ;;
    --help|-h) usage; exit 0 ;;
    *) err "Unknown option: $1"; usage; exit 1 ;;
  esac
done

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

initialize_smkit_source() {
  local current="$1"
  if [[ -f "$current/smkit/rules/00-core.md" ]]; then
    echo "$current"
    return 0
  fi

  if ! command -v git >/dev/null 2>&1; then
    err "SMKit source not found at '$current'. Clone the repo first, or install git for remote bootstrap."
    exit 1
  fi

  local repo_url="${SMKIT_REPO_URL:-https://github.com/dthanhvu03/smkit.git}"
  local clone_dir
  clone_dir="$(mktemp -d "${TMPDIR:-/tmp}/smkit-src.XXXXXX")"

  info "Cloning SMKit from $repo_url ..."
  if ! git clone --depth 1 "$repo_url" "$clone_dir" >/dev/null 2>&1; then
    err "Failed to clone SMKit. Set SMKIT_REPO_URL or clone manually."
    rm -rf "$clone_dir"
    exit 1
  fi

  if [[ ! -f "$clone_dir/smkit/rules/00-core.md" ]]; then
    err "Clone succeeded but SMKit layout not found."
    rm -rf "$clone_dir"
    exit 1
  fi

  ok "SMKit source ready at $clone_dir"
  echo "$clone_dir"
}

SOURCE_DIR="$(initialize_smkit_source "$SOURCE_DIR")"

read_choice() {
  local prompt="$1"
  local default="$2"
  local input
  read -r -p "$prompt [$default]: " input || true
  input="${input:-$default}"
  echo "$input"
}

copy_tree_no_overwrite() {
  local src="$1"
  local dest="$2"
  LAST_COPIED=0
  LAST_SKIPPED=0

  if [[ ! -d "$src" ]]; then
    warn "Source missing, skip: $src"
    return
  fi

  mkdir -p "$dest"

  while IFS= read -r -d '' file; do
    local rel="${file#"$src"/}"
    local dest_file="$dest/$rel"
    local dest_dir
    dest_dir="$(dirname "$dest_file")"
    mkdir -p "$dest_dir"

    if [[ -e "$dest_file" ]]; then
      warn "SKIP (exists): $rel"
      LAST_SKIPPED=$((LAST_SKIPPED + 1))
    else
      cp "$file" "$dest_file"
      ok "COPY: $rel"
      LAST_COPIED=$((LAST_COPIED + 1))
    fi
  done < <(find "$src" -type f -print0)
}

copy_file_no_overwrite() {
  local src="$1"
  local dest="$2"
  local name
  name="$(basename "$dest")"
  LAST_COPIED=0
  LAST_SKIPPED=0

  if [[ ! -f "$src" ]]; then
    warn "Source missing, skip: $src"
    LAST_SKIPPED=1
    return
  fi

  if [[ -e "$dest" ]]; then
    warn "SKIP (exists): $name"
    LAST_SKIPPED=1
    return
  fi

  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
  ok "COPY: $name"
  LAST_COPIED=1
}

set_project_mode() {
  local project_file="$1"
  local selected_mode="$2"
  local was_copied="$3"

  if [[ "$was_copied" != "1" ]]; then
    warn "memory/project.md already exists — set Mode manually if needed."
    return
  fi

  [[ -f "$project_file" ]] || return

  local cap_mode
  cap_mode="$(echo "$selected_mode" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')"
  if sed -i.bak "s/| Mode | Lightweight \/ Full |/| Mode | ${cap_mode} |/" "$project_file" 2>/dev/null; then
    rm -f "${project_file}.bak"
    ok "Set memory/project.md Mode = $selected_mode"
  elif sed -i '' "s/| Mode | Lightweight \/ Full |/| Mode | ${cap_mode} |/" "$project_file" 2>/dev/null; then
    ok "Set memory/project.md Mode = $selected_mode"
  fi
}

write_install_manifest() {
  local target="$1"
  local selected_mode="$2"
  local manifest_dir="$target/.smkit"
  local manifest_path="$manifest_dir/install.json"

  mkdir -p "$manifest_dir"

  if [[ -f "$manifest_path" ]]; then
    warn "SKIP (exists): .smkit/install.json"
    return
  fi

  local installed_at
  installed_at="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  cat > "$manifest_path" <<EOF
{
  "mode": "$selected_mode",
  "version": "2.1",
  "installedAt": "$installed_at",
  "source": "smkit-installer"
}
EOF
  ok "CREATE: .smkit/install.json"
}

setup_cursor_integration() {
  local source="$1"
  local target="$2"
  local cursor_src="$source/.cursor"

  if [[ ! -d "$cursor_src" ]]; then
    warn ".cursor source not found — skip Cursor integration."
    return
  fi

  info "Setting up .cursor/ (loader + skill pointers)..."
  copy_tree_no_overwrite "$cursor_src" "$target/.cursor"
  TOTAL_COPIED=$((TOTAL_COPIED + LAST_COPIED))
  TOTAL_SKIPPED=$((TOTAL_SKIPPED + LAST_SKIPPED))

  local link_path="$target/.cursor/smkit-rules"
  local link_target="$target/smkit/rules"

  if [[ ! -d "$link_target" ]]; then
    warn "smkit/rules not in target — skip symlink .cursor/smkit-rules"
    return
  fi

  if [[ -e "$link_path" ]]; then
    warn "SKIP (exists): .cursor/smkit-rules symlink"
    return
  fi

  ln -s "../smkit/rules" "$link_path"
  ok "SYMLINK: .cursor/smkit-rules -> smkit/rules"
}

is_git_repo() {
  [[ -d "$1/.git" ]]
}

printf '\n'
info "SMKit Installer (macOS/Linux)"
echo "Source: $SOURCE_DIR"
printf '\n'

if [[ "$NON_INTERACTIVE" -eq 0 ]]; then
  if [[ -z "$TARGET_DIR" ]]; then
    TARGET_DIR="$(read_choice "Target directory?" "$(pwd)")"
  fi
  if [[ -z "$MODE" ]]; then
    while true; do
      MODE="$(read_choice "Mode? (lightweight/full)" "lightweight")"
      MODE="$(echo "$MODE" | tr '[:upper:]' '[:lower:]')"
      if [[ "$MODE" == "lightweight" || "$MODE" == "full" ]]; then
        break
      fi
      warn "Invalid choice. Use lightweight or full."
    done
  fi
else
  TARGET_DIR="${TARGET_DIR:-$(pwd)}"
  MODE="${MODE:-lightweight}"
fi

MODE="$(echo "$MODE" | tr '[:upper:]' '[:lower:]')"
if [[ "$MODE" != "lightweight" && "$MODE" != "full" ]]; then
  err "Invalid mode: $MODE"
  exit 1
fi

mkdir -p "$TARGET_DIR"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

printf '\n'
info "Target: $TARGET_DIR"
info "Mode:   $MODE"
printf '\n'

if ! is_git_repo "$TARGET_DIR"; then
  warn "Target is not a git repository. Consider: git init"
fi

TOTAL_COPIED=0
TOTAL_SKIPPED=0
LAST_COPIED=0
LAST_SKIPPED=0
PROJECT_MD_COPIED=0

copy_and_count() {
  "$@"
  TOTAL_COPIED=$((TOTAL_COPIED + LAST_COPIED))
  TOTAL_SKIPPED=$((TOTAL_SKIPPED + LAST_SKIPPED))
}

PROJECT_MD_BEFORE=0
[[ -f "$TARGET_DIR/memory/project.md" ]] && PROJECT_MD_BEFORE=1

copy_and_count copy_tree_no_overwrite "$SOURCE_DIR/smkit" "$TARGET_DIR/smkit"
copy_and_count copy_tree_no_overwrite "$SOURCE_DIR/memory" "$TARGET_DIR/memory"
copy_and_count copy_tree_no_overwrite "$SOURCE_DIR/project-docs" "$TARGET_DIR/project-docs"
copy_and_count copy_file_no_overwrite "$SOURCE_DIR/AGENTS.md" "$TARGET_DIR/AGENTS.md"
copy_and_count copy_file_no_overwrite "$SOURCE_DIR/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"

if [[ "$PROJECT_MD_BEFORE" -eq 0 && -f "$TARGET_DIR/memory/project.md" ]]; then
  PROJECT_MD_COPIED=1
fi

if [[ "$MODE" == "full" ]]; then
  info "Full mode: installing artifacts/ and docs/..."
  copy_and_count copy_tree_no_overwrite "$SOURCE_DIR/artifacts" "$TARGET_DIR/artifacts"
  copy_and_count copy_tree_no_overwrite "$SOURCE_DIR/docs" "$TARGET_DIR/docs"
  if [[ ! -f "$TARGET_DIR/artifacts/.gitkeep" ]]; then
    mkdir -p "$TARGET_DIR/artifacts"
    : > "$TARGET_DIR/artifacts/.gitkeep"
    ok "CREATE: artifacts/.gitkeep"
  fi
else
  info "Lightweight mode: skipping artifacts/ and docs/ (core framework only)."
fi

set_project_mode "$TARGET_DIR/memory/project.md" "$MODE" "$PROJECT_MD_COPIED"
write_install_manifest "$TARGET_DIR" "$MODE"
setup_cursor_integration "$SOURCE_DIR" "$TARGET_DIR"

printf '\n'
info "Install summary: copied=$TOTAL_COPIED skipped=$TOTAL_SKIPPED"
printf '\n'
echo "Next steps:"
echo "  1. cd \"$TARGET_DIR\""
echo "  2. Edit memory/project.md — điền tên dự án, business context"
echo "  3. Mở Cursor hoặc chạy: claude"
echo "  4. Prompt đầu tiên: Đọc AGENTS.md và memory/project.md"
printf '\n'
if [[ "$MODE" == "full" ]]; then
  echo "  Full mode: xem docs/getting-started.md để biết workflow đầy đủ."
else
  echo "  Lightweight mode: bắt đầu với ý tưởng → Discovery skill."
fi
printf '\n'
