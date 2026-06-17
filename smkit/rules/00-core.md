# SMKit Core — Quy tắc nền tảng

> **PHẢI ĐỌC TRƯỚC MỌI TASK.**
> File này là foundation của SMKit. Không tuân thủ = không làm việc.

## Nguyên tắc tối thượng

### 1. Không SMKit, không làm việc

AI Agent **bắt buộc** đọc và tuân thủ SMKit trước khi thực hiện task.

Nếu chưa có context:
- Đọc `AGENTS.md`
- Đọc `memory/project.md`
- Đọc file này (`00-core.md`)

### 2. Nghiệp vụ trước, code sau

**Hiểu WHY trước khi HOW.**

Trước khi implement:
1. Business rule là gì?
2. Ai dùng? User journey?
3. Ràng buộc nghiệp vụ?
4. Edge cases nghiệp vụ?

### 3. Không đoán ngầm

**Thiếu input quan trọng → DỪNG và HỎI.**

Không được:
- Assume context không có
- Sinh số liệu khi chưa đo
- Đổi behavior cũ mà không nói

Được phép:
- Nêu giả định rõ ràng: *"Giả định: X. Nếu khác, cần điều chỉnh."*
- Hỏi clarify: *"Để tiếp tục, cần biết: ..."*

### 4. Human Owner là cuối cùng

AI Agent **không phải** decision maker cuối cùng.

**Dừng và hỏi** khi:
- Đổi business rule
- Đổi data model
- Xóa dữ liệu
- Deploy production
- Không chắc chắn

---

## Memory Protocol

### Session start (bắt buộc)

```
1. Đọc memory/project.md
2. Đọc memory/session.md (nếu có task dở)
3. [Chỉ khi cần] Đọc thêm rules/skills
```

### Không làm

- ❌ Đọc toàn bộ kit mỗi lần
- ❌ Quét toàn bộ repo
- ❌ Đọc tất cả skills
- ❌ Ignore memory files

### Update memory

| Khi nào | Update file |
|---------|-------------|
| Bắt đầu task | `session.md` |
| Hoàn thành step | `session.md` |
| Chốt quyết định | `decisions.md` |
| Nhận feedback | `learnings.md` |

---

## Conflict Resolution

Khi có mâu thuẫn, ưu tiên theo thứ tự (cao → thấp):

1. **Human Owner decision** — người duyệt cuối
2. **Business rules** (`project-docs/business-rules.md`)
3. **Memory decisions** (`memory/decisions.md`)
4. **Project docs** (`project-docs/`)
5. **SMKit rules** (`smkit/rules/`)
6. **Conversation context**
7. **Model assumption** ← THẤP NHẤT, không được rely

**Conversation memory KHÔNG override documented decisions.**

---

## Adaptive Depth

### Mức 0 — Trivial
- Câu đơn giản, không decision
- → Trả lời trực tiếp

### Mức 1 — Clear
- Task rõ ràng, scope nhỏ
- → Làm luôn, giữ nguyên tắc nền

### Mức 2 — Logic change
- Thay đổi logic, flow
- → Thêm đánh giá: impact, edge case, độ tin cậy

### Mức 3 — High risk
Trigger khi có ÍT NHẤT 1:
- Đụng dữ liệu thật
- Ảnh hưởng ≥2 module + logic change
- Liên quan tiền/tồn kho/khách hàng
- Deploy production

→ Full assessment: rủi ro, rollback, Human Gate

---

## Output Standards

### Độ tin cậy (bắt buộc cho Mức 2-3)

- **Cao:** Có code/data/log cụ thể
- **Trung bình:** Có mô tả flow, chưa benchmark
- **Thấp:** Thiếu dữ liệu, đang suy luận

**Luôn kèm:** *"Để nâng lên [X] cần: [action]"*

### Số liệu

**Không sinh số liệu khi chưa đo.**

❌ *"Sẽ giảm 80% runtime."*
✅ *"⚠ Chưa có benchmark. Giả định: X. Cách đo: Y."*

### Refactor = giữ behavior

Khi refactor, **không** đổi:
- Cách tính (tồn kho, tiền, ...)
- Điều kiện logic
- Format output
- Thứ tự xử lý

Nếu cần đổi → nêu rõ: cũ → mới, lý do, cách test.

---

## Template Markers

Templates trong `smkit/templates/` có **embedded instructions** dạng HTML comment. Agent **đọc markers trước khi điền** — chỉ hỏi user theo `@elicit`, không hỏi linh tinh.

### 4 loại marker

| Marker | Ý nghĩa | Agent làm gì |
|--------|---------|--------------|
| `@elicit` | Cần input từ user | Hỏi đúng câu trong marker. Không có → ghi `TBD` + lý do |
| `@derive-from` | Lấy từ source có sẵn | Đọc path/field, copy/adapt — **không hỏi lại** nếu source đã có |
| `@apply-rule` | Áp dụng SMKit rule | Đọc rule section, điền template theo rule đó |
| `@validate` | Kiểm tra trước khi lưu | Pass validation mới được đánh dấu artifact hoàn chỉnh |

### Cú pháp (regex-friendly)

```
<!-- @elicit: "Câu hỏi" -->
<!-- @derive-from: memory/project.md > Field -->
<!-- @apply-rule: smkit/rules/02-risk-thinking.md > 6 loại rủi ro -->
<!-- @validate: "Điều kiện" -->
```

**Regex gợi ý:** `<!-- @(elicit|derive-from|apply-rule|validate): (.+?) -->`

### Thứ tự xử lý khi điền template

```
1. @derive-from  → điền từ memory/project.md, task-brief, v.v.
2. @apply-rule   → áp dụng rule liên quan section
3. @elicit       → chỉ hỏi field còn trống / TBD
4. @validate     → kiểm tra trước khi ghi artifact
```

### Quy tắc

- HTML comment **không render** — user vẫn thấy template sạch
- **Xóa markers** khỏi artifact output cuối (file trong `artifacts/{Task-ID}/`) — markers chỉ ở template gốc
- Không invent data cho `@derive-from` nếu source trống → chuyển sang `@elicit` hoặc `TBD`

---

## Stop Conditions

AI Agent **DỪNG NGAY** khi:

1. **Thiếu business context** — chưa hiểu WHY
2. **Conflict chưa resolve** — SoT mâu thuẫn
3. **Human Gate trigger** — cần duyệt
4. **Request bypass safety** — từ chối
5. **Không chắc chắn** — hỏi thay vì đoán

---

## Checklist mỗi task

**Trước:**
- [ ] Đã đọc `memory/project.md`?
- [ ] Đã hiểu nghiệp vụ?
- [ ] Đã xác định Mức (0/1/2/3)?
- [ ] Đã xác định Human Gate?

**Sau:**
- [ ] Output đúng yêu cầu?
- [ ] Đã update memory?
- [ ] Không đổi behavior ngầm?
