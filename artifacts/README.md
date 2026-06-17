# Task Artifacts

> Mỗi task **bắt buộc** có folder riêng (Full Mode). Agent **ghi artifact vào đây** — không chỉ trả lời trong chat.

## Quy tắc

| Quy tắc | Chi tiết |
|---------|----------|
| **Task ID** | `TASK-YYYYMMDD-slug` hoặc format tự chọn |
| **Folder** | `artifacts/{Task-ID}/` — tạo **trước** implement |
| **Gate status** | `00-gate-status.md` — cập nhật sau mỗi bước workflow |
| **Template gốc** | `smkit/templates/` — **copy** sang folder task, điền nội dung |

## File chuẩn trong folder task

| File | Khi nào | Bắt buộc |
|------|---------|----------|
| `00-gate-status.md` | Bước 0 — PM / Orchestrator | **Luôn** (Full Mode) |
| `01-task-brief.md` | Task mới | **Luôn** (Full Mode) |
| `02-acceptance-criteria.md` | Feature nghiệp vụ | Nếu có BA |
| `03-architecture-impact.md` | Logic / DB / API | Nếu đụng *(trước code)* |
| `04-migration-note.md` | Đổi schema | Nếu đụng *(trước migrate)* |
| `05-impact-risk-rollback.md` | Mutation data thật | Nếu đụng |
| `06-test-plan.md` | Sau implement | **Code task** |
| `08-release-checklist.md` | Deploy | Nếu deploy |

## Lightweight Mode

Task nhỏ (fix 1 dòng, prototype nhanh): **không bắt buộc** folder artifact.

Ghi rõ trong chat: *"lightweight mode, no artifact"*

## Review blocker *(agent không được báo "xong" nếu thiếu — Full Mode)*

**Mọi task (Full Mode):** `00-gate-status.md` + `01-task-brief.md` tồn tại.

**Task có sửa code:**

- `06-test-plan.md` — post-feature gate **PASS**
- `00-gate-status.md` → `qa_gate: PASS`
- Mọi Human Owner gate = `APPROVED` hoặc `N/A`

**Task docs-only:** `qa_gate: N/A`

Chi tiết: `AGENTS.md` § Kỷ luật vận hành · `smkit/rules/05-human-gate.md`.

## Example structure

```
artifacts/
├── README.md (file này)
├── TASK-20240115-user-auth/
│   ├── 00-gate-status.md
│   ├── 01-task-brief.md
│   ├── 03-architecture-impact.md
│   ├── 04-migration-note.md
│   └── 06-test-plan.md
└── TASK-20240120-dashboard/
    ├── 00-gate-status.md
    ├── 01-task-brief.md
    └── 06-test-plan.md
```
