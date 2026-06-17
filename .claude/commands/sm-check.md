---
description: Chạy final checklist của skill đang active
argument-hint: [role tùy chọn, vd: backend — mặc định đọc memory/session.md]
---

Hỏi: skill nào đang active? (đọc `memory/session.md` xem có ghi không, nếu không hỏi user)

User input (nếu có): $ARGUMENTS — dùng làm role hint nếu session.md không ghi.

1. Xác định role active → map sang `smkit/skills/{role}.md`
2. Đọc section **Final Checklist** trong skill file đó
3. Chạy từng item, in `[x]` / `[ ]` / `[N/A]`
4. Nếu fail → suggest fix cụ thể

Tuân thủ `smkit/rules/00-core.md`. Update `memory/session.md` nếu phát hiện gap.
