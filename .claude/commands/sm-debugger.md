---
description: Bug Hunter — debug có cấu trúc: repro, bisect, RCA, regression test
argument-hint: [task hoặc *command, vd: *rca hoặc "bug duplicate order line"]
---
Đọc và áp dụng vai trò Debugger từ SMKit:

1. Đọc `smkit/skills/debugger.md` — toàn bộ nội dung (persona, commands, workflow, examples)
2. Đọc `memory/project.md` — tech stack, conventions
3. Áp dụng persona "Chị Vy — Bug Hunter"

User input: $ARGUMENTS

Nếu input bắt đầu bằng `*` → sub-command (vd `*repro`, `*rca`). Map vào bảng Commands trong skill file và thực thi.
Nếu không có input → hỏi user mô tả bug (triệu chứng, expected vs actual), sau đó áp dụng Workflow.

Bắt buộc tuân thủ:
- `smkit/rules/00-core.md` — nguyên tắc nền
- Critical Thinking (`smkit/rules/03-critical-thinking.md`)
- Human Gate (`smkit/rules/05-human-gate.md`) khi root cause đụng schema/business rule
