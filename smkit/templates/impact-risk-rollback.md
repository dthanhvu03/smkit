# Impact, Risk & Rollback

| Field | Value |
|-------|-------|
| Task ID | <!-- @derive-from: artifacts/{Task-ID}/01-task-brief.md > Task ID --> |
| Ngày | |
| Author | <!-- @elicit: "Author artifact? Nếu không có → agent session" --> |

## Summary

<!-- @elicit: "Mô tả thao tác data (1-2 câu). Nếu không có → TBD" -->
[What data operation is being performed]

## Impact Assessment

### Data affected

<!-- @derive-from: project-docs/schema.md > Tables -->
| Table | Records | Operation |
|-------|---------|-----------|
| | [count] | INSERT / UPDATE / DELETE |

### Who is affected

<!-- @elicit: "Ai bị ảnh hưởng (tick)? Nếu không có → TBD" -->
- [ ] End users
- [ ] Admin users
- [ ] External systems
- [ ] Reporting

## Risk Analysis

<!-- @apply-rule: smkit/rules/02-risk-thinking.md > 6 loại rủi ro -->
<!-- @elicit: "Dữ liệu: rủi ro mất/sai/trùng/lệch? Likelihood, Impact, Mitigation. Nếu không có → TBD" -->
<!-- @elicit: "Vận hành: quy trình gián đoạn/bottleneck? Likelihood, Impact, Mitigation. Nếu không có → TBD" -->
<!-- @elicit: "Kỹ thuật: bug/timeout/race condition? Likelihood, Impact, Mitigation. Nếu không có → TBD" -->
<!-- @elicit: "Con người: chưa training/hiểu sai flow? Likelihood, Impact, Mitigation. Nếu không có → TBD" -->
<!-- @elicit: "Tài chính: tính sai tiền/chi phí ẩn? Likelihood, Impact, Mitigation. Nếu không có → TBD" -->
<!-- @elicit: "Khách hàng: ảnh hưởng UX/delay? Likelihood, Impact, Mitigation. Nếu không có → TBD" -->

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Data loss | High/Med/Low | High/Med/Low | [Backup before] |
| Wrong data | | | [Validation] |
| Performance | | | [Batch processing] |
| Downtime | | | [Off-peak] |

## Execution Plan

### Phase 1: Preparation

<!-- @apply-rule: smkit/rules/06-data-safety.md > Dry-run trước production -->
- [ ] Backup database
- [ ] Notify stakeholders
- [ ] Test on staging

### Phase 2: Dry Run

```sql
-- Dry run query (SELECT only, show what will change)
```

Expected result: [what you expect to see]

### Phase 3: Execute

```sql
-- Actual mutation query
```

### Phase 4: Verify

```sql
-- Verification query
```

Expected result: [what success looks like]

## Rollback Plan

<!-- @apply-rule: smkit/rules/06-data-safety.md > Safe patterns, stop conditions -->
### Trigger conditions

<!-- @elicit: "Điều kiện trigger rollback (số liệu cụ thể)? Nếu không có → TBD" -->
Rollback if:
- [ ] More than X records affected
- [ ] Error rate > Y%
- [ ] [Other condition]

### Rollback steps

<!-- @elicit: "Các bước rollback cụ thể? Nếu không có → TBD" -->
1. [Step 1]
2. [Step 2]
3. [Verify rollback]

### Rollback SQL (if applicable)

```sql
-- Rollback query
```

## Communication

| When | Who | What |
|------|-----|------|
| Before | [Team] | [Announcement] |
| After success | [Team] | [Confirmation] |
| If rollback | [Team] | [Explanation] |

## Observability

<!-- @apply-rule: smkit/rules/00-core.md > Output Standards > Số liệu -->
### Logs to watch

- [Log 1]
- [Log 2]

### Metrics to monitor

- [Metric 1]
- [Metric 2]

### Alerts

- [Alert condition]

---

## Approval

<!-- @validate: "Tech Lead + Product Owner nếu đụng data production" -->
| Role | Name | Date | Approved |
|------|------|------|----------|
| Tech Lead | | | [ ] |
| Product Owner | | | [ ] |
