# Systems Thinking — Tư duy hệ thống

> Thấy toàn cảnh, không chỉ task đơn lẻ.
> Mỗi thay đổi đều có ripple effect.

## Nguyên tắc

### 1. Context trước action

Trước khi làm bất kỳ task:

```
Task này thuộc MODULE/DOMAIN nào?
         ↓
Ai BỊ ẢNH HƯỞNG (user, team, system)?
         ↓
Thay đổi này KÉO THEO những gì?
         ↓
DEPENDENCIES là gì?
         ↓
[Sau đó mới] Implement
```

### 2. Một task không tồn tại độc lập

Mọi task đều có:
- **Input:** Từ đâu đến?
- **Process:** Xử lý gì?
- **Output:** Đi đâu?
- **Side effects:** Ảnh hưởng gì khác?

### 3. Boundary awareness

Biết rõ:
- **Module boundary:** Task này trong module nào?
- **Data boundary:** Data nào được đọc/ghi?
- **User boundary:** User nào affected?
- **System boundary:** Service nào involved?

---

## Framework đánh giá

### Impact Scope Matrix

| Scope | Câu hỏi |
|-------|---------|
| **Module** | Module nào bị ảnh hưởng? |
| **Data** | Bảng/field nào thay đổi? |
| **User** | User role nào affected? |
| **Flow** | Business flow nào thay đổi? |
| **Downstream** | Hệ thống/report nào depend on this? |

### Dependency Map

```
[Upstream]     →    [Task này]    →    [Downstream]
   ↑                    ↑                   ↑
   │                    │                   │
Cái gì feed        Thay đổi gì?      Cái gì depend
vào đây?                              on output này?
```

---

## Câu hỏi bắt buộc

Trước khi implement, trả lời:

1. **Module scope:**
   - Task này thuộc module nào?
   - Có cross-module không?

2. **Data impact:**
   - Đọc data từ đâu?
   - Ghi data vào đâu?
   - Data đó còn được dùng ở đâu?

3. **User impact:**
   - User nào dùng feature này?
   - User nào bị ảnh hưởng gián tiếp?

4. **System dependencies:**
   - Service/API nào involved?
   - Có cache/queue nào bị affect?

5. **Downstream effects:**
   - Report nào depend on this?
   - Feature khác có rely on behavior cũ?

---

## Output Format (cho Mức 2-3)

```markdown
## Systems Assessment

### Scope
- Module: [tên module]
- Cross-module: [Yes/No — nếu Yes, list modules]

### Data Flow
- Input: [data sources]
- Output: [data destinations]
- Side effects: [other data affected]

### Stakeholders
- Direct: [users directly affected]
- Indirect: [users indirectly affected]

### Dependencies
- Upstream: [what feeds into this]
- Downstream: [what depends on this]

### Impact Summary
[1-2 câu tóm tắt impact]
```

---

## Khi nào cần full assessment?

**Bắt buộc khi:**
- Cross-module change
- Data model change
- Business rule change
- User-facing change
- Performance-sensitive change

**Có thể skip khi:**
- Bug fix isolated
- Docs/comment change
- Test change only
- Config change không affect logic

---

## Anti-patterns

❌ **Tunnel vision:** Chỉ nhìn task, không nhìn context
❌ **Siloed thinking:** Module tôi OK là được
❌ **No downstream check:** Không biết ai depend on this
❌ **Assume isolation:** Task này không affect gì khác

✅ **Always ask:** "Nếu thay đổi này, còn gì khác bị ảnh hưởng?"
