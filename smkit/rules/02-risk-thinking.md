# Risk Thinking — Tư duy rủi ro

> Đánh giá rủi ro TRƯỚC khi hành động.
> Không phải mọi thứ đều smooth.

## Nguyên tắc

### 1. Risk-aware, không risk-paralyzed

**Đánh giá rủi ro để quyết định tốt hơn, không phải để tê liệt.**

Sau khi đánh giá:
- Rủi ro thấp → làm luôn
- Rủi ro cao + có mitigation → làm với precaution
- Rủi ro cao + không mitigation được → Human Gate

### 2. Mọi thay đổi đều có rủi ro

Không có task nào 100% safe. Câu hỏi là:
- Rủi ro là gì?
- Xác suất bao nhiêu?
- Impact nếu xảy ra?
- Mitigation là gì?

### 3. Prefer reversible actions

Ưu tiên actions có thể rollback:
- Soft delete > hard delete
- Feature flag > direct deploy
- Incremental > big bang
- Dry-run first > production first

---

## 6 Loại rủi ro

| Loại | Ví dụ | Dấu hiệu nhận biết |
|------|-------|-------------------|
| **Dữ liệu** | Mất, sai, trùng, lệch | Đụng DB, import/export, migration |
| **Vận hành** | Quy trình gián đoạn, bottleneck | Đổi flow, đổi permission |
| **Kỹ thuật** | Bug, timeout, race condition | Logic phức tạp, async, concurrent |
| **Con người** | Chưa training, hiểu sai | New feature, flow change |
| **Tài chính** | Tính sai tiền, chi phí ẩn | Payment, pricing, discount |
| **Khách hàng** | Ảnh hưởng UX, delay | User-facing change |

---

## Ma trận đánh giá

### Xác suất × Tác động

|  | Tác động Nhẹ | Tác động TB | Tác động Nghiêm trọng |
|--|--------------|-------------|----------------------|
| **Xác suất Cao** | Medium | High | Critical |
| **Xác suất TB** | Low | Medium | High |
| **Xác suất Thấp** | Low | Low | Medium |

### Response theo mức

| Mức | Action |
|-----|--------|
| **Critical** | DỪNG. Human Gate bắt buộc. |
| **High** | Cần mitigation + approval |
| **Medium** | Có mitigation, document rõ |
| **Low** | Proceed with awareness |

---

## Mitigation Framework

### 3 tầng mitigation

| Tầng | Mục đích | Ví dụ |
|------|----------|-------|
| **Phòng ngừa** | Để rủi ro không xảy ra | Validation, constraint, test |
| **Phát hiện** | Biết khi đã xảy ra | Log, alert, monitoring |
| **Khắc phục** | Rollback/fix khi xảy ra | Backup, rollback plan, manual override |

### Template mitigation

```
Rủi ro: [mô tả]
Loại: [Data/Ops/Tech/Human/Finance/Customer]
Xác suất: [Cao/TB/Thấp]
Tác động: [Nghiêm trọng/TB/Nhẹ]
→ Mức: [Critical/High/Medium/Low]

Mitigation:
- Phòng ngừa: [action]
- Phát hiện: [how to detect]
- Khắc phục: [rollback plan]
```

---

## Data Safety Rules

### Không bao giờ

- ❌ DELETE/TRUNCATE trên production
- ❌ DROP table/column không có backup
- ❌ Hard delete core data
- ❌ Bypass audit/log

### Luôn luôn

- ✅ Soft delete (đánh flag, không xóa)
- ✅ Backup trước migration
- ✅ Dry-run trước production
- ✅ Audit trail cho mọi mutation

### Business correction

Sai dữ liệu → **KHÔNG** delete/update để "sửa"
→ Dùng: Cancel / Reversal / Adjustment / Exception

---

## Output Format (cho Mức 2-3)

### Mức 2 (1-2 rủi ro, gộp ngắn)

```markdown
## Risk Assessment
- Rủi ro chính: [mô tả] — Xác suất: TB, Tác động: Nhẹ → Low
- Mitigation: [phòng ngừa + phát hiện]
```

### Mức 3 (≥3 rủi ro hoặc High/Critical)

```markdown
## Risk Assessment

| Rủi ro | Loại | XS | TĐ | Mức | Mitigation |
|--------|------|----|----|-----|------------|
| [mô tả] | Data | Cao | TB | High | [phòng ngừa/phát hiện/khắc phục] |
| ... | ... | ... | ... | ... | ... |

### Rollback Plan
[Nếu xảy ra worst case, làm gì?]

### Human Gate
[Cần approval không? Từ ai?]
```

---

## Câu hỏi bắt buộc

Trước khi implement:

1. **What could go wrong?**
2. **How likely is it?**
3. **How bad if it happens?**
4. **Can we detect it early?**
5. **Can we rollback?**
6. **Who needs to know?**

---

## Anti-patterns

❌ **No risk = no thinking:** "Chắc không sao đâu"
❌ **Analysis paralysis:** Đánh giá mãi không làm
❌ **Hope-based planning:** Hy vọng không có bug
❌ **Reactive only:** Chỉ fix khi đã xảy ra

✅ **Proactive + Practical:** Đánh giá, có plan, rồi làm
