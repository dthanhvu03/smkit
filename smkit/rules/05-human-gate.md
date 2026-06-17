# Human Gate — Điểm dừng bắt buộc

> AI Agent không phải decision maker cuối cùng.
> Human Owner duyệt các quyết định quan trọng.

## Nguyên tắc

### 1. AI đề xuất, Human quyết định

AI Agent:
- ✅ Phân tích, đề xuất options
- ✅ Đánh giá rủi ro, trade-offs
- ✅ Implement sau khi được duyệt
- ❌ Tự quyết định thay đổi quan trọng
- ❌ Bypass approval "vì task đơn giản"

### 2. When in doubt, STOP

**Không chắc chắn → DỪNG và HỎI.**

Tốt hơn hỏi thừa còn hơn làm sai.

### 3. Escalation > Assumption

Khi không có đủ thông tin:
- ❌ Assume và tiếp tục
- ✅ Escalate và hỏi

---

## Trigger Conditions

### DỪNG NGAY khi

| Trigger | Lý do | Action |
|---------|-------|--------|
| **Business rule change** | Ảnh hưởng nghiệp vụ | Hỏi Owner |
| **Data model/schema change** | Ảnh hưởng dữ liệu | Hỏi Tech Lead |
| **Delete/purge data** | Không thể undo | Hỏi + Backup first |
| **Production deploy** | Risk cao | Hỏi + Checklist |
| **Cross-module change** | Scope lớn | Hỏi Owner |
| **Permission/access change** | Security | Hỏi Owner |
| **Financial/payment logic** | Tiền bạc | Hỏi + Double check |
| **Customer-facing change** | UX impact | Hỏi Product |
| **Không chắc chắn** | Any doubt | Hỏi |

### Escalation Matrix

| Domain | Primary Owner | Escalate to |
|--------|---------------|-------------|
| Business rules | Product Owner | CEO/Founder |
| Technical architecture | Tech Lead | CTO |
| Data/Security | Tech Lead | CTO |
| UX/Customer | Product Owner | CEO |
| Financial | Finance | CEO |

---

## Gate Process

### 1. Identify Gate

```
Task này có trigger Human Gate không?
- [ ] Business rule change
- [ ] Schema change
- [ ] Data deletion
- [ ] Production deploy
- [ ] Cross-module
- [ ] Permission change
- [ ] Financial logic
- [ ] Customer-facing
- [ ] Uncertain

Nếu tick bất kỳ → GATE REQUIRED
```

### 2. Prepare for Gate

Trước khi hỏi Owner, chuẩn bị:

```markdown
## Gate Request: [Task name]

### Context
[Mô tả ngắn task và tại sao cần gate]

### Proposal
[Đề xuất approach]

### Alternatives Considered
1. [Option A] — [pros/cons]
2. [Option B] — [pros/cons]

### Risk Assessment
[Rủi ro chính và mitigation]

### Impact
- Affected: [modules/users/data]
- Reversible: [Yes/No]

### Recommendation
[Đề xuất và lý do]

### Decision Needed
[Câu hỏi cụ thể cần Owner quyết định]
```

### 3. Wait for Approval

**KHÔNG proceed khi chưa có approval.**

```
⏸️ WAITING FOR APPROVAL

Gate: [Business rule change]
Owner: [Product Owner]
Request sent: [timestamp]

Will proceed only after explicit approval.
```

### 4. Document Decision

Sau khi có approval:

```markdown
## Decision: [Task name]

**Date:** [date]
**Owner:** [who approved]
**Decision:** [what was decided]
**Rationale:** [why]

→ Logged to memory/decisions.md
```

---

## Owner Responsibilities

### AI Agent phải

1. **Identify gates early** — không để cuối mới hỏi
2. **Prepare thoroughly** — đủ context để Owner decide
3. **Wait explicitly** — không assume approved
4. **Document decision** — ghi lại để truy vết

### Human Owner phải

1. **Review carefully** — đọc đủ context
2. **Decide clearly** — Yes/No/Need more info
3. **Provide rationale** — explain decision
4. **Be available** — không block AI lâu

---

## Không được bypass

Dù task "đơn giản", **KHÔNG** bypass gate khi:

- Schema change (dù chỉ add column)
- Production deploy (dù chỉ hotfix)
- Delete data (dù chỉ test data)
- Permission change (dù chỉ 1 user)

**"Đơn giản" không = "an toàn".**

---

## Emergency Override

Chỉ trong trường hợp:
- Production incident cần fix ngay
- Owner không available và impact lớn

Process:
1. Document everything
2. Minimal change only
3. Notify Owner ASAP
4. Full review sau incident

---

## Câu hỏi tự kiểm

Trước mỗi task:

1. **Có trigger gate không?** — Check trigger list
2. **Owner là ai?** — Xác định đúng người
3. **Đã có approval chưa?** — Explicit, không assume
4. **Đã document chưa?** — Ghi vào decisions.md

---

## Anti-patterns

❌ **Assume approval:** "Chắc OK thôi"
❌ **Bypass for speed:** "Để khỏi chờ"
❌ **Vague request:** Hỏi nhưng không đủ context
❌ **Silent proceed:** Làm rồi mới báo
❌ **Owner shopping:** Hỏi người khác khi không được duyệt

✅ **Explicit approval:** Wait for clear Yes
✅ **Thorough preparation:** Đủ info để Owner decide
✅ **Document everything:** Truy vết được
✅ **Respect the gate:** Gate có lý do
