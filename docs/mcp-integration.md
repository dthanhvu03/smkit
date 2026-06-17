# SMKit — MCP Integration Guide

> Cho **người dùng** Claude Code / Cursor / Claude Desktop.
> Agent đọc khi task cần tool ngoài conversation (file, memory, DB, git, reasoning).

---

## Tại sao MCP quan trọng cho SMKit?

SMKit dựa trên **memory file** (`memory/project.md`, `session.md`) và **SoT** (`project-docs/`). Conversation alone không đủ vì:

| Vấn đề SMKit | MCP giải quyết |
|--------------|----------------|
| Agent quên context giữa session | **memory** — knowledge graph ngoài chat |
| Phải đọc `project-docs/` đúng file | **filesystem** — đọc/ghi trong allowlist an toàn |
| Task Mức 3 cần suy luận có cấu trúc | **sequential-thinking** — bước rõ, không nhảy kết luận |
| `@sm-database` cần schema thật | **Neon MCP** (Postgres) — introspection + read-only SQL |
| Audit / rollback cần lịch sử thay đổi | **git** — diff, log, blame trên repo |

**Nguyên tắc:** MCP **bổ sung** SMKit memory — không thay `memory/project.md`. Session start vẫn đọc memory trước; MCP dùng khi skill/rule yêu cầu data live.

---

## 5 MCP khuyến nghị (stable, production)

Chỉ liệt kê server **đang maintain** hoặc **vendor official**. Không dùng package archived.

| # | MCP | Package / Endpoint | GitHub | Khi nào |
|---|-----|-------------------|--------|---------|
| 1 | **Filesystem** | `@modelcontextprotocol/server-filesystem` | [modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem) | Mọi task — đọc `project-docs/`, `artifacts/` |
| 2 | **Memory** | `@modelcontextprotocol/server-memory` | [modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers/tree/main/src/memory) | Discovery, quyết định dài hạn |
| 3 | **Sequential Thinking** | `@modelcontextprotocol/server-sequential-thinking` | [modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking) | Mức 3 — risk, migration, deploy prod |
| 4 | **Git** | `mcp-server-git` (Python) | [modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers/tree/main/src/git) | Audit log, review diff trước merge |
| 5 | **Database** | Neon MCP — `https://mcp.neon.tech/mcp` | [neondatabase/mcp-server-neon](https://github.com/neondatabase/mcp-server-neon) | Project có **PostgreSQL** |

### PostgreSQL vs SQLite

| Stack DB | Khuyến nghị |
|----------|-------------|
| **PostgreSQL** (Neon, Supabase, RDS, local) | **Neon MCP** — vendor-maintained, OAuth hoặc API key |
| **SQLite file** | Không còn MCP official maintained (`@modelcontextprotocol/server-postgres` / sqlite **archived** — [servers-archived](https://github.com/modelcontextprotocol/servers-archived)). SMKit: giữ schema trong `project-docs/schema.md`, đọc qua **filesystem**. Chỉ thêm DB MCP khi chuyển sang Postgres. |

> ⚠️ **Không dùng** `@modelcontextprotocol/server-postgres` trên npm — repo archived, có lỗ hổng bảo mật đã công bố.

---

## Setup nhanh (copy-paste)

Thay `YOUR_PROJECT_PATH` bằng đường dẫn root repo (Windows dùng `/` hoặc `\\`):

```
C:/Users/you/your-project
```

### Claude Desktop — `claude_desktop_config.json`

| OS | Path |
|----|------|
| Windows | `%APPDATA%\Claude\claude_desktop_config.json` |
| macOS | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| Linux | `~/.config/Claude/claude_desktop_config.json` |

Mở: **Settings → Developer → Edit Config**. Dán block sau, **restart Claude Desktop**:

```json
{
  "mcpServers": {
    "smkit-filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "YOUR_PROJECT_PATH"]
    },
    "smkit-memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "smkit-sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    },
    "smkit-git": {
      "command": "uvx",
      "args": ["mcp-server-git", "--repository", "YOUR_PROJECT_PATH"]
    }
  }
}
```

**Git trên Windows không có `uvx`?** Cài [uv](https://docs.astral.sh/uv/) hoặc bỏ `smkit-git` tạm thời — 4 MCP còn lại vẫn đủ cho hầu hết workflow.

**Thêm Postgres (Neon)** — OAuth (không cần API key trong file):

```json
"neon": {
  "url": "https://mcp.neon.tech/mcp"
}
```

### Cursor — `.cursor/mcp.json`

Tạo file `YOUR_PROJECT_PATH/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "smkit-filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "YOUR_PROJECT_PATH"]
    },
    "smkit-memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "smkit-sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    },
    "smkit-git": {
      "command": "uvx",
      "args": ["mcp-server-git", "--repository", "YOUR_PROJECT_PATH"]
    },
    "neon": {
      "url": "https://mcp.neon.tech/mcp"
    }
  }
}
```

Restart Cursor (**Developer: Reload Window**). Bật server trong **Settings → MCP**.

Copy mẫu sẵn từ repo: `cp mcp.json.example .cursor/mcp.json` (đổi `YOUR_PROJECT_PATH`).

**One-liner Neon (Cursor + Claude Code):**

```bash
npx neonctl@latest init
```

Tự OAuth + ghi config MCP — xem [Neon MCP docs](https://neon.com/docs/ai/neon-mcp-server).

### Claude Code — `.mcp.json` (project scope)

Tạo `YOUR_PROJECT_PATH/.mcp.json` (copy từ `mcp.json.example` ở root SMKit), hoặc dùng CLI:

```bash
# Memory (test nhanh — không cần path)
claude mcp add smkit-memory -- npx -y @modelcontextprotocol/server-memory

# Filesystem (thay path)
claude mcp add smkit-filesystem -- npx -y @modelcontextprotocol/server-filesystem YOUR_PROJECT_PATH

# Sequential thinking
claude mcp add smkit-sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking

# Neon (HTTP + OAuth)
claude mcp add --transport http neon https://mcp.neon.tech/mcp
```

Kiểm tra: `claude mcp list`. Sau khi sửa config → thoát session Claude Code và mở lại.

---

## Mapping: SMKit workflow → MCP

| Workflow / Skill | Mức | MCP gọi | Mục đích |
|------------------|-----|---------|----------|
| **Discovery** (`@sm-discovery`) | 1–2 | filesystem + memory | Đọc `project-docs/`; lưu entity/decision vào knowledge graph |
| **Discovery `*fill`** | 2 | filesystem | Ghi `memory/project.md` |
| **PM `*brief`** | 1 | filesystem | Copy template từ `smkit/templates/` |
| **Risk assessment** | **3** | sequential-thinking | 6 loại rủi ro, mitigation từng bước |
| **`impact-risk-rollback.md`** | 3 | sequential-thinking + filesystem | Suy luận có cấu trúc → ghi artifact |
| **Database `@sm-database`** | 2–3 | filesystem + **neon** | `*schema`: đối chiếu `schema.md` vs DB live |
| **Database `*migrate`** | 3 | sequential-thinking + neon + filesystem | Migration-note + dry-run trước prod |
| **Backend `@sm-backend`** | 1–2 | filesystem + git | Code review diff, audit trước PR |
| **DevOps `*deploy`** | 3 | sequential-thinking + git + neon | Release checklist, rollback, migration staging |
| **QA `@sm-qa`** | 1–2 | filesystem + git | Test plan + review diff |
| **Orchestrator `*gate`** | 2 | filesystem + memory | Gate status + context task trước đó |

### Thứ tự ưu tiên cài (tối thiểu → đủ)

```
1. filesystem          ← bắt buộc cho mọi SMKit project
2. memory              ← Discovery + decisions
3. sequential-thinking ← trước task Mức 3 đầu tiên
4. git                 ← khi có repo + PR workflow
5. neon                ← khi `memory/project.md` ghi Database: PostgreSQL
```

---

## Troubleshooting

| Triệu chứng | Cách xử lý |
|-------------|------------|
| MCP không hiện tool | Restart client; validate JSON (không trailing comma) |
| Filesystem "access denied" | Path trong config phải trùng root project |
| Git MCP lỗi `uvx` | `pip install mcp-server-git` rồi dùng `python -m mcp_server_git` |
| Neon OAuth fail | Chạy `npx neonctl@latest init` hoặc dùng API key header |
| Agent vẫn không đọc memory file | Nhắc Session Start Protocol — MCP không thay `memory/project.md` |

---

## Liên quan

- Agent hub: [AGENTS.md](../AGENTS.md)
- Core rules: [smkit/rules/00-core.md](../smkit/rules/00-core.md) — Memory Protocol
- Human setup: [docs/getting-started.md](./getting-started.md)
