# SMKit

> Hệ điều hành tư duy cho AI Agent — không có SMKit, không làm việc.

Framework platform-agnostic giúp AI Agent hiểu nghiệp vụ trước, tư duy hệ thống / rủi ro / phản biện, và nhớ context qua `memory/`.

## Cài đặt 1 dòng

### Windows (PowerShell)

```powershell
# Từ repo đã clone
.\install.ps1

# Remote (cần git + set URL repo thật)
$env:SMKIT_REPO_URL = "https://github.com/YOUR_ORG/smkit.git"
iwr -useb https://raw.githubusercontent.com/YOUR_ORG/smkit/main/install.ps1 | iex
```

### macOS / Linux

```bash
# Từ repo đã clone
chmod +x install.sh && ./install.sh

# Remote (cần git + set URL repo thật)
export SMKIT_REPO_URL="https://github.com/YOUR_ORG/smkit.git"
curl -fsSL https://raw.githubusercontent.com/YOUR_ORG/smkit/main/install.sh | bash
```

### Non-interactive

```powershell
.\install.ps1 -TargetDir C:\Projects\my-app -Mode full -NonInteractive
```

```bash
./install.sh --target ~/Projects/my-app --mode full --non-interactive
```

## Installer làm gì?

| Bước | Mô tả |
|------|--------|
| Hỏi target | Default: thư mục hiện tại |
| Hỏi mode | `lightweight` (core) hoặc `full` (+ artifacts, docs) |
| Copy | `smkit/`, `memory/`, `project-docs/`, `AGENTS.md`, `CLAUDE.md` |
| Skip | **Không ghi đè** file đã tồn tại — cảnh báo + bỏ qua |
| Cursor | Copy `.cursor/` loader + pointers; junction/symlink `.cursor/smkit-rules` |
| Git check | Cảnh báo nếu target không phải git repo |

**Idempotent:** chạy lại nhiều lần an toàn.

## Sau khi cài

```text
1. cd <target-project>
2. Sửa memory/project.md — điền business context
3. Mở Cursor hoặc chạy: claude
4. Prompt: Đọc AGENTS.md và memory/project.md
```

## Mode

| Mode | Cài gì |
|------|--------|
| **lightweight** | Core: smkit, memory, project-docs, AGENTS.md, CLAUDE.md, .cursor |
| **full** | Lightweight + `artifacts/`, `docs/` |

## Cấu trúc sau install

```
your-project/
├── AGENTS.md
├── CLAUDE.md
├── memory/
├── smkit/
├── project-docs/
├── .cursor/          # Cursor integration
├── .smkit/install.json
└── artifacts/        # full mode only
```

## Tài liệu

- [AGENTS.md](./AGENTS.md) — Hub cho AI Agent
- [docs/getting-started.md](./docs/getting-started.md) — Hướng dẫn chi tiết
- [docs/platform-integration.md](./docs/platform-integration.md) — Cursor, Claude, GPT, Codex

## License

MIT (hoặc license dự án — cập nhật khi publish)
