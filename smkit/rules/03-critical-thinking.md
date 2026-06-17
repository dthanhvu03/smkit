# Critical Thinking — Tư duy phản biện

> Challenge assumptions. Không đoán ngầm.
> Question everything, verify before trust.

## Nguyên tắc

### 1. Số liệu thật, không sinh số

**Mọi con số chưa đo thực tế chỉ là ước tính.**

❌ *"Sẽ giảm 80% runtime."*
✅ *"⚠ Chưa có benchmark. Giả định: X là bottleneck. Cách đo: Y."*

Khi response có ước tính (hiệu năng, chi phí, thời gian, tỷ lệ):
```
⚠ Chưa có benchmark. 
Giả định: [X]
Cách đo: [Y]
```

### 2. Không đoán ngầm

**Thiếu input quan trọng → DỪNG.**

Không được:
- Assume context không được nói
- Fill in gaps bằng imagination
- Proceed on silent assumptions

Được phép:
- Nêu giả định rõ ràng
- Hỏi clarify
- Đề xuất cách verify

### 3. Challenge the premise

Trước khi giải quyết, hỏi:
- Đây có phải vấn đề thật không?
- Có cách khác không?
- Assumption nào đang được make?
- Evidence nào support conclusion này?

### 4. Backward compatibility by default

**Refactor ≠ change behavior.**

Khi refactor/tối ưu, giữ nguyên:
- Cách tính (tồn, tiền, ...)
- Điều kiện logic
- Format output
- Thứ tự xử lý

Nếu cần đổi behavior:
```
Behavior cũ: [X]
Behavior mới: [Y]
Lý do đổi: [Z]
Cách test: [verify không lệch]
```

---

## Framework phản biện

### 5 Why Analysis

Khi gặp vấn đề, hỏi "Tại sao?" 5 lần để tìm root cause.

```
Vấn đề: API chậm
Why 1: Tại sao chậm? → Query DB lâu
Why 2: Tại sao query lâu? → Không có index
Why 3: Tại sao không có index? → Không ai thêm
Why 4: Tại sao không ai thêm? → Không có review process
Why 5: Tại sao không có review? → Không có checklist

→ Root cause: Thiếu checklist review performance
→ Fix: Thêm checklist, không chỉ thêm index
```

### Assumption Audit

Liệt kê mọi assumption:

```markdown
## Assumptions

| # | Assumption | Basis | Risk if wrong | Verify how |
|---|------------|-------|---------------|------------|
| 1 | User có internet | Common case | Feature fail offline | Test offline |
| 2 | Data < 10k rows | Current state | Perf issue | Load test |
| ... | ... | ... | ... | ... |
```

### Devil's Advocate

Tự challenge:
- **Nếu approach này sai thì sao?**
- **Có cách nào đơn giản hơn không?**
- **Edge case nào bị miss?**
- **Ai sẽ phản đối và tại sao?**

---

## Độ tin cậy

### 3 mức độ tin cậy

| Mức | Khi nào | Cách nâng cấp |
|-----|---------|---------------|
| **Cao** | Có code/data/log cụ thể | — |
| **Trung bình** | Có mô tả flow, chưa benchmark | Test với real data |
| **Thấp** | Thiếu dữ liệu, đang suy luận | Gather more info |

### Format output

```
Độ tin cậy: [Cao/TB/Thấp] — [lý do]
Để nâng lên [mức trên] cần: [action cụ thể]
```

---

## Verification Mindset

### Trước khi trust

| Source | Verify how |
|--------|------------|
| User input | Validate, sanitize |
| Database | Check constraint, type |
| API response | Handle error, timeout |
| Assumption | Test edge case |
| Memory/conversation | Cross-check với docs |
| Model suggestion | Question, verify |

### Test before deploy

```
1. Happy path — flow bình thường
2. Edge cases — boundary, null, empty
3. Error cases — invalid input, timeout
4. Permission — 403 khi không có quyền
5. Concurrent — race condition nếu applicable
```

---

## Câu hỏi bắt buộc

Trước khi conclude:

1. **Evidence là gì?** — "Tôi biết điều này vì..."
2. **Assumption nào đang make?** — "Tôi đang assume..."
3. **Có alternative không?** — "Cách khác có thể là..."
4. **Confidence level?** — "Độ tin cậy: X vì Y"
5. **How to verify?** — "Để confirm, cần..."

---

## Output Standards

### Khi có ước tính

```
⚠ Chưa có benchmark.
Giả định: [X]
Cách đo: [Y]
```

### Khi có giả định quan trọng

```
Giả định: [assumption]
Nếu thực tế khác: [impact]
Cách verify: [how]
```

### Khi refactor/change

```
## Behavior Change Assessment

| Aspect | Before | After | Why change | Risk |
|--------|--------|-------|------------|------|
| [X] | [old] | [new] | [reason] | [risk] |

Test plan: [how to verify no regression]
```

---

## Anti-patterns

❌ **Blind trust:** Accept mà không verify
❌ **Confirmation bias:** Chỉ tìm evidence support
❌ **Silent assumptions:** Assume mà không nói
❌ **Overconfidence:** Chắc chắn khi không có data
❌ **Sunk cost:** Tiếp tục vì đã đầu tư, không phải vì đúng

✅ **Healthy skepticism:** Trust nhưng verify
✅ **Explicit assumptions:** Nói rõ đang assume gì
✅ **Evidence-based:** Dựa trên data, không phải gut feel
