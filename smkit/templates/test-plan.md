# Test Plan

<!-- @derive-from: artifacts/{Task-ID}/01-task-brief.md > Task ID -->
<!-- @derive-from: artifacts/{Task-ID}/02-acceptance-criteria.md > Acceptance Criteria -->
| Field | Value |
|-------|-------|
| Task ID | |
| Feature | |
| Tester | <!-- @elicit: "Tester? Nếu không có → TBD" --> |
| Ngày | |

## Overview

- **What's being tested:** [Feature name]
- **Acceptance Criteria:** [Link or summary]

## Test Scope

### In Scope

<!-- @derive-from: artifacts/{Task-ID}/01-task-brief.md > Scope > IN -->
- [Feature A]
- [Feature B]

### Out of Scope

<!-- @derive-from: artifacts/{Task-ID}/01-task-brief.md > Scope > OUT -->
- [Feature C - tested separately]

## Test Cases

<!-- @validate: "Phải có TC happy path + 401 + 403 cho API task" -->
<!-- @apply-rule: smkit/skills/qa.md > Test Strategy -->
| ID | Type | Description | Expected | Priority | Status |
|----|------|-------------|----------|----------|--------|
| TC-01 | Happy path | [Normal flow] | Success | P0 | |
| TC-02 | Validation | [Invalid input] | Error message | P0 | |
| TC-03 | Auth | [Without token] | 401 | P0 | |
| TC-04 | Permission | [Wrong role] | 403 | P0 | |
| TC-05 | Edge | [Boundary case] | [Expected] | P1 | |

### TC-01: [Test name]

**Precondition:** [Setup needed]

**Steps:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Expected:** [What should happen]

**Status:** PASS / FAIL / BLOCKED

**Notes:** [If any]

### TC-02: [Test name]

...

## Edge Cases Tested

- [ ] Empty input
- [ ] Null values
- [ ] Very long input
- [ ] Special characters
- [ ] Negative numbers
- [ ] Zero
- [ ] Concurrent requests
- [ ] Network failure

## Security Checklist

<!-- @apply-rule: smkit/skills/qa.md > Security Checklist -->
- [ ] Auth required where needed
- [ ] Permission checked
- [ ] Input validated
- [ ] SQL injection prevented
- [ ] XSS prevented
- [ ] Sensitive data protected

## Test Results

| ID | Status | Notes |
|----|--------|-------|
| TC-01 | PASS / FAIL | |
| TC-02 | | |

## Issues Found

| Issue | Severity | Status | Notes |
|-------|----------|--------|-------|
| [Description] | P0 / P1 / P2 | Open / Fixed | |

## Test Coverage

| Type | Coverage |
|------|----------|
| Unit tests | ___ % |
| Integration tests | ___ tests |
| E2E tests | ___ flows |

## Environment

| Env | Tested | Notes |
|-----|--------|-------|
| Local | [ ] | |
| Staging | [ ] | |
| Production | [ ] | |

---

## QA Gate

<!-- @validate: "qa_gate PASS mới ship; FAIL phải ghi reason" -->
| Check | Result |
|-------|--------|
| All P0 tests pass | [ ] |
| All P1 tests pass | [ ] |
| No P0 issues open | [ ] |
| Security checklist done | [ ] |
| **qa_gate** | `PASS` / `FAIL` |

**If FAIL:** [Reason and blocker]

---

## Sign-off

| Role | Name | Date |
|------|------|------|
| QA | | |
| Dev | | |
