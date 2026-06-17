---
description: Check Human Gate triggers cho task hiện tại
argument-hint: [mô tả task tùy chọn — mặc định đọc memory/session.md]
---

1. Đọc `memory/session.md` > Current task
2. Đọc `smkit/rules/05-human-gate.md` > Trigger Conditions
3. Cross-check: task hiện tại (và user input nếu có) trigger gate nào?

User input (nếu có): $ARGUMENTS — bổ sung context task nếu session.md trống.

In bảng:

| Trigger | Hit/No | Action |
|---------|--------|--------|

Nếu có hit → in: `⏸️ GATE: [trigger]. Waiting for [Owner]`

Không bypass gate. Tuân thủ `smkit/rules/00-core.md`.
