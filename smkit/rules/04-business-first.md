# Business-First — Nghiệp vụ là trung tâm

> AI Agent không phải code monkey.
> Hiểu nghiệp vụ trước, implement sau.

## Nguyên tắc

### 1. WHY trước HOW

Trước khi viết 1 dòng code:

```
WHY  — Tại sao cần feature này? Business value?
WHO  — Ai dùng? User journey là gì?
WHAT — Business rule là gì? Logic nghiệp vụ?
THEN — Constraint, edge case nghiệp vụ?
ONLY THEN — Implement
```

### 2. Domain language

Dùng **ngôn ngữ nghiệp vụ** trong code:

| Thay vì | Dùng |
|---------|------|
| `updateStatus()` | `approveOrder()`, `rejectPayment()` |
| `data1`, `data2` | `customer`, `order` |
| `process()` | `calculateDiscount()`, `validateInventory()` |
| `flag`, `type` | Tên có nghĩa nghiệp vụ |

### 3. Business rules là source of truth

**Code phải reflect business rules, không phải ngược lại.**

Nếu code khác với business rule:
- Business rule đúng → fix code
- Business rule sai → escalate, không tự sửa

### 4. Edge cases = business edge cases

Edge cases không chỉ là technical:

| Technical | Business |
|-----------|----------|
| Null input | Khách chưa có order |
| Empty array | Kho hết hàng |
| Timeout | Thanh toán pending |
| Duplicate | Order trùng |

---

## Business Context Framework

### 4 câu hỏi bắt buộc

Trước mỗi task:

```markdown
## Business Context

### 1. WHY (Business Value)
- Feature này giải quyết vấn đề gì?
- Ai cần và tại sao?
- KPI/metric nào improve?

### 2. WHO (Users & Journey)
- User role nào dùng?
- Họ làm gì trước/sau feature này?
- Pain point hiện tại?

### 3. WHAT (Business Rules)
- Quy tắc nghiệp vụ là gì?
- Điều kiện/constraint?
- Exception handling?

### 4. WHEN/WHERE (Context)
- Flow nào trigger feature này?
- Integration points?
- Dependencies?
```

---

## Source of Truth

### Hierarchy

```
project-docs/business-rules.md  ← Quy tắc nghiệp vụ (CAO NHẤT)
project-docs/requirements.md    ← Yêu cầu
memory/decisions.md             ← Quyết định đã chốt
project-docs/schema.md          ← Data model
conversation context            ← Có thể outdated
model assumption                ← THẤP NHẤT
```

### Khi conflict

1. Check business-rules.md trước
2. Check với Human Owner nếu unclear
3. KHÔNG assume từ conversation memory

---

## Business Rules Documentation

### Format chuẩn

```markdown
## BR-001: [Tên rule]

**Domain:** [Module/area]

**Rule:**
[Mô tả rule rõ ràng]

**Conditions:**
- IF [condition] THEN [action]
- ELSE [alternative]

**Exceptions:**
- [Exception 1]: [handling]

**Examples:**
- [Example 1]
- [Example 2]

**Owner:** [Ai quyết định rule này]
```

### Ví dụ

```markdown
## BR-001: Discount Calculation

**Domain:** Order/Pricing

**Rule:**
Discount được tính theo tier khách hàng và giá trị đơn.

**Conditions:**
- IF order_value >= 1M AND customer_tier = "VIP" THEN discount = 15%
- IF order_value >= 1M AND customer_tier = "Regular" THEN discount = 10%
- IF order_value < 1M THEN discount = 0%

**Exceptions:**
- Flash sale: Override discount theo campaign
- Employee order: Fixed 20%

**Examples:**
- VIP, order 2M → discount 300k (15%)
- Regular, order 500k → discount 0

**Owner:** Sales Manager
```

---

## Domain Knowledge Requirements

### Trước khi implement, phải biết

| Aspect | Question |
|--------|----------|
| **Entities** | Domain có những entity nào? Relationship? |
| **States** | Entity có những trạng thái nào? Transition rules? |
| **Actors** | Ai làm gì? Permissions? |
| **Events** | Event nào trigger gì? |
| **Rules** | Quy tắc tính toán? Validation? |
| **Edge cases** | Exception? Special cases? |

### Nếu không biết

**DỪNG và HỎI.** Không được assume.

```
Để implement feature này, cần clarify:
1. [Question 1]
2. [Question 2]

Giả định hiện tại (cần confirm):
- [Assumption 1]
- [Assumption 2]
```

---

## Câu hỏi bắt buộc

Trước mỗi task:

1. **Business value?** — "Feature này mang lại gì?"
2. **User story?** — "As a [who], I want [what], so that [why]"
3. **Business rules?** — "Quy tắc nghiệp vụ áp dụng?"
4. **Edge cases nghiệp vụ?** — "Trường hợp đặc biệt?"
5. **Success criteria?** — "Thế nào là xong?"

---

## Anti-patterns

❌ **Code-first:** Viết code rồi mới hỏi business
❌ **Technical language:** Nói chuyện tech với stakeholder
❌ **Assume rules:** Tự đặt business rule
❌ **Ignore context:** Làm feature mà không biết WHY
❌ **Siloed implementation:** Không biết feature nằm trong flow nào

✅ **Understand first:** Hiểu trước, code sau
✅ **Speak domain:** Dùng ngôn ngữ nghiệp vụ
✅ **Verify rules:** Confirm business rules trước implement
✅ **See the flow:** Biết feature nằm ở đâu trong journey
