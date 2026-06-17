# Release Checklist

<!-- @derive-from: artifacts/{Task-ID}/01-task-brief.md > Task ID -->
| Field | Value |
|-------|-------|
| Version | <!-- @elicit: "Version release (semver)? Nếu không có → TBD" --> |
| Release date | |
| Deployer | <!-- @elicit: "Deployer? Nếu không có → TBD" --> |
| Environment | Staging / Production |

## Release Info

### What's included

<!-- @derive-from: artifacts/{Task-ID}/01-task-brief.md > Definition of Done -->
- [ ] [Feature 1]
- [ ] [Feature 2]
- [ ] [Bug fix 1]

### Related tasks

- Task ID: [link]
- PR: [link]

## Pre-release

### Code

<!-- @derive-from: artifacts/{Task-ID}/06-test-plan.md > qa_gate -->
- [ ] All tests pass
- [ ] Code review approved
- [ ] No P0 bugs open
- [ ] Security review done (if needed)

### Documentation

- [ ] Changelog updated
- [ ] API docs updated (if changed)
- [ ] User guide updated (if needed)

### Database

<!-- @apply-rule: smkit/rules/06-data-safety.md > Dry-run trước production -->
<!-- @derive-from: artifacts/{Task-ID}/04-migration-note.md > Rollback Plan -->
- [ ] Migrations tested on staging
- [ ] Backup created
- [ ] Rollback tested
- [ ] No data loss risk

### Dependencies

- [ ] Dependencies up to date
- [ ] No security vulnerabilities
- [ ] License compliance checked

## Deployment

### Preparation

<!-- @apply-rule: smkit/rules/05-human-gate.md > Production deploy -->
- [ ] Notify stakeholders
- [ ] Schedule maintenance window (if needed)
- [ ] Prepare rollback plan

### Staging

- [ ] Deploy to staging
- [ ] Run migrations
- [ ] Smoke test critical flows
- [ ] Performance acceptable
- [ ] No errors in logs

### Production

<!-- @validate: "Human Owner approved production deploy" -->
- [ ] Final backup before deploy
- [ ] Enable maintenance mode (if needed)
- [ ] Deploy to production
- [ ] Run migrations
- [ ] Disable maintenance mode
- [ ] Verify deployment

## Post-release

### Immediate (0-30 min)

- [ ] Smoke test critical flows
- [ ] Check error rates
- [ ] Check performance metrics
- [ ] Monitor logs

### Short-term (1-24 hours)

- [ ] Monitor user feedback
- [ ] Check analytics
- [ ] Confirm no regressions

### Announcement

- [ ] Notify team
- [ ] Update status page (if applicable)
- [ ] Announce to users (if major)

## Rollback Plan

<!-- @apply-rule: smkit/rules/06-data-safety.md > Safe patterns -->
### Trigger conditions

<!-- @elicit: "Rollback trigger (error rate, feature broken)? Nếu không có → TBD" -->
Rollback if:
- [ ] Critical feature broken
- [ ] Error rate > X%
- [ ] Data corruption detected
- [ ] Security issue found

### Rollback steps

1. [Step 1]
2. [Step 2]
3. [Verify rollback]
4. Notify: [who]

### Rollback timeline

- Decision deadline: [time after deploy]
- Rollback completion: [expected duration]

## Contacts

<!-- @derive-from: memory/project.md > Human Owners -->
| Role | Name | Contact |
|------|------|---------|
| On-call engineer | | |
| Tech lead | | |
| Product owner | | |

---

## Sign-off

| Phase | Role | Name | Date | Approved |
|-------|------|------|------|----------|
| Pre-release | QA | | | [ ] |
| Pre-release | Tech Lead | | | [ ] |
| Staging | Deployer | | | [ ] |
| Production | Product Owner | | | [ ] |
| Post-release | On-call | | | [ ] |
