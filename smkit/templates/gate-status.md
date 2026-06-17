# Gate Status

<!-- @derive-from: artifacts/{Task-ID}/01-task-brief.md > Task ID -->
<!-- @derive-from: artifacts/{Task-ID}/01-task-brief.md > Mode -->
| Field | Value |
|-------|-------|
| Task ID | |
| Artifact folder | `artifacts/{Task-ID}/` |
| Mode | Lightweight / Full |
| Task type | `code` / `docs-only` |
| Cập nhật lần cuối | |

> Agent **cập nhật file này** sau mỗi bước. Human Owner đọc file này để biết task đang ở đâu.

---

## Workflow steps

<!-- @apply-rule: smkit/rules/00-core.md > Template Markers > Thứ tự xử lý -->
| Bước | Artifact | Status | Ghi chú |
|------|----------|--------|---------|
| 0 | `00-gate-status.md` | `NOT_STARTED` / `IN_PROGRESS` / `DONE` | File này |
| 1 | `01-task-brief.md` | | |
| 2 | `02-acceptance-criteria.md` | `N/A` / … | Nếu feature nghiệp vụ |
| 3 | `03-architecture-impact.md` | `N/A` / `PENDING_HO` / `APPROVED` | Trước code nếu logic/DB |
| 4 | `04-migration-note.md` | `N/A` / `PENDING_HO` / `APPROVED` | Trước DDL nếu schema |
| 5 | Implement | | Backend / Frontend |
| 6 | `05-impact-risk-rollback.md` | `N/A` / `DONE` | Nếu đụng data |
| 7 | `06-test-plan.md` | `N/A` / `FAIL` / `PASS` | Post-feature gate |
| 8 | `08-release-checklist.md` | `N/A` / … | Nếu deploy |

**Status values:** `NOT_STARTED` · `IN_PROGRESS` · `DONE` · `PASS` · `FAIL` · `N/A` · `PENDING_HO` · `APPROVED` · `BLOCKED`

---

## Human Owner gates

<!-- @apply-rule: smkit/rules/05-human-gate.md > Trigger Conditions -->
| Gate | Owner | Status | Ngày / evidence |
|------|-------|--------|-----------------|
| Đổi schema | | `N/A` / `PENDING` / `APPROVED` | |
| Đổi business rule | | | |
| ≥2 module | | | |
| Permission change | | | |
| Data delete/purge | | | |
| Production deploy | | | |

---

## QA post-feature gate *(code task)*

| Kiểm tra | Kết quả | Ghi chú |
|----------|---------|---------|
| Lint / format | `PASS` / `FAIL` / `SKIP` | |
| Tests | | |
| Security checklist | | |
| **qa_gate tổng** | `NOT_RUN` / `PASS` / `FAIL` | **FAIL → không ship** |

---

## Review readiness

<!-- @validate: "qa_gate PASS hoặc N/A docs-only; không gate PENDING" -->
- [ ] `01-task-brief.md` hoàn chỉnh
- [ ] Artifacts bắt buộc theo task type đã có
- [ ] `qa_gate: PASS` *(hoặc N/A docs-only)*
- [ ] Không còn Human Owner gate `PENDING`
- [ ] **Sẵn sàng xin review**

**Agent stop:** nếu bất kỳ mục trên chưa đạt — **không** tuyên bố task hoàn thành.
