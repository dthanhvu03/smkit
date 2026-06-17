# Architecture Impact

<!-- @derive-from: artifacts/{Task-ID}/01-task-brief.md > Task ID -->
| Field | Value |
|-------|-------|
| Task ID | |
| Reviewed by | <!-- @elicit: "Architect reviewer? Nếu không có → TBD" --> |
| Ngày | |

## Summary

<!-- @derive-from: artifacts/{Task-ID}/01-task-brief.md > Yêu cầu gốc -->
[One paragraph describing the change]

## Scope

<!-- @apply-rule: smkit/rules/01-systems-thinking.md > Impact Scope Matrix -->
- [ ] Single module
- [ ] Multiple modules
- [ ] Cross-cutting (auth, logging, etc.)

## Changes Required

<!-- @derive-from: project-docs/schema.md > Tables -->
<!-- @derive-from: project-docs/decisions.md > Critical Services -->
| Area | Current | Proposed | Risk |
|------|---------|----------|------|
| Schema | | | Low/Med/High |
| API | | | |
| Services | | | |
| UI | | | |

## Dependencies

### Upstream (what this depends on)

<!-- @elicit: "Upstream dependencies? Nếu không có → None" -->
- 

### Downstream (what depends on this)

<!-- @elicit: "Downstream impact? Nếu không có → TBD" -->
- 

## Migration Path

<!-- @apply-rule: smkit/rules/02-risk-thinking.md > Prefer reversible actions -->
1. [Step 1]
2. [Step 2]
3. [Rollback if needed]

## Data Migration

- [ ] No data migration needed
- [ ] Backfill required: [describe]
- [ ] Data format change: [describe]

## API Changes

### New endpoints

| Method | Path | Description |
|--------|------|-------------|
| | | |

### Modified endpoints

| Endpoint | Change | Breaking? |
|----------|--------|-----------|
| | | Yes/No |

## Performance Considerations

<!-- @validate: "Không cam kết số liệu chưa đo — ghi cách đo nếu ước tính" -->
- Query complexity: O(?)
- Expected load: [requests/sec]
- Caching strategy: [if needed]
- Index needed: [if applicable]

## Security Considerations

<!-- @apply-rule: smkit/rules/07-architecture-envelope.md > Principles -->
- [ ] Auth required
- [ ] Rate limiting needed
- [ ] Data validation
- [ ] Sensitive data handling
- [ ] Permission check

## Testing Strategy

- [ ] Unit tests
- [ ] Integration tests
- [ ] Manual testing
- [ ] Load testing (if performance critical)

## Risks

<!-- @apply-rule: smkit/rules/02-risk-thinking.md > 6 loại rủi ro -->
| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| | High/Med/Low | High/Med/Low | |

## Decision

<!-- @apply-rule: smkit/rules/05-human-gate.md > Schema/API breaking -->
- [ ] **APPROVED** — proceed with implementation
- [ ] **NEEDS CHANGES** — [describe what needs to change]
- [ ] **REJECTED** — [reason]

## Human Owner Gate

- [ ] Schema change → requires approval from: ___
- [ ] API breaking change → requires approval from: ___
- [ ] No approval needed
