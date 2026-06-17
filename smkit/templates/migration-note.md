# Migration Note

| Field | Value |
|-------|-------|
| Task ID | <!-- @derive-from: artifacts/{Task-ID}/01-task-brief.md > Task ID --> |
| Migration name | <!-- @elicit: "Tên migration (snake_case)? Nếu không có → TBD" --> |
| Author | <!-- @elicit: "Author? Nếu không có → TBD" --> |
| Ngày | |

## Summary

<!-- @elicit: "Migration làm gì (plain language, 1-2 câu)? Nếu không có → TBD" -->
[What this migration does in plain language]

## Changes

<!-- @derive-from: project-docs/schema.md > Tables -->
| Table | Action | Details |
|-------|--------|---------|
| | ADD TABLE / ADD COLUMN / DROP / MODIFY | |

## SQL

### Up Migration

```sql
-- Migration up
```

### Down Migration (Rollback)

```sql
-- Migration down (rollback)
```

## Risk Assessment

<!-- @apply-rule: smkit/rules/06-data-safety.md > Guardrails -->
| Question | Answer |
|----------|--------|
| Data loss possible? | Yes / No |
| Table locking? | Yes / No — duration: ___ |
| Backfill needed? | Yes / No — row count: ___ |
| Downtime required? | Yes / No — duration: ___ |

## Data Impact

<!-- @elicit: "Số rows affected ước tính? Nếu chưa đo → TBD + cách đo" -->
- Estimated rows affected: ___
- Tables affected: ___
- Backfill strategy: [if needed]

## Dependencies

- [ ] No dependencies
- [ ] Depends on: [other migration]
- [ ] Required before: [feature/deploy]

## Testing

- [ ] Tested on local
- [ ] Tested on staging
- [ ] Rollback tested
- [ ] Performance tested (if large table)

## Rollback Plan

<!-- @apply-rule: smkit/rules/06-data-safety.md > Safe patterns, stop conditions -->
<!-- @elicit: "Rollback steps nếu migration fail? Nếu không có → TBD" -->
1. [Step 1]
2. [Step 2]
3. Verify: [how to verify rollback worked]

## Pre-migration Checklist

<!-- @apply-rule: smkit/rules/06-data-safety.md > Never / Always -->
- [ ] Backup database
- [ ] Notify stakeholders
- [ ] Schedule maintenance window (if needed)
- [ ] Test rollback works

## Post-migration Checklist

- [ ] Verify data integrity
- [ ] Monitor for errors
- [ ] Update documentation
- [ ] Notify stakeholders

---

## Approval

<!-- @apply-rule: smkit/rules/05-human-gate.md > Schema change -->
<!-- @validate: "Human Owner approved trước production" -->
| Role | Name | Date | Approved |
|------|------|------|----------|
| Tech Lead | | | [ ] |
| DBA (if complex) | | | [ ] |
