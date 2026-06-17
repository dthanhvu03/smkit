# Task Brief

<!-- @derive-from: memory/project.md > Project Overview > Name -->
<!-- @derive-from: memory/project.md > Project Overview > Mode -->
| Field | Value |
|-------|-------|
| Task ID | <!-- @elicit: "Task ID (TASK-YYYYMMDD-slug)? Nếu không có → TBD" --> |
| Artifact folder | `artifacts/{Task-ID}/` |
| Ngày | <!-- @derive-from: memory/session.md > Current Session > Started --> |
| Priority | P0 / P1 / P2 |
| Mode | Lightweight / Full |
| Human Owner | <!-- @elicit: "Human Owner duyệt task này? Nếu không có → TBD" --> |

## Yêu cầu gốc

<!-- @elicit: "Mô tả yêu cầu gốc từ Human Owner (1-3 câu). Nếu không có → TBD" -->
[Mô tả ngắn từ Human Owner / user]

## Scope

### IN

<!-- @elicit: "Liệt kê scope IN (bullet). Nếu không có → TBD" -->
- 

### OUT

<!-- @elicit: "Liệt kê scope OUT (bullet). Nếu không có → TBD" -->
- 

## Module ảnh hưởng

<!-- @derive-from: memory/project.md > Business Context > Problem Statement -->
| Module | Thay đổi |
|--------|----------|
| | |

## Definition of Done

<!-- @validate: "≥3 criteria, measurable" -->
<!-- @elicit: "Mỗi DoD criterion đo/verify thế nào? Nếu không có → TBD" -->
- [ ] 
- [ ] 

## Architecture checklist *(tick khi áp dụng)*

<!-- @apply-rule: smkit/rules/07-architecture-envelope.md > Flow bắt buộc -->
- [ ] Logic trong Service layer (không Controller/UI)
- [ ] Validation đầy đủ
- [ ] Authorization checked
- [ ] Transaction khi multi-table
- [ ] Audit log nếu important mutation
- [ ] Tests: happy path + 401/403

## Ràng buộc

- Không đổi behavior cũ (trừ khi Human Owner duyệt)
- Không đổi schema (trừ khi có migration note + duyệt)
- 1 module chính (trừ khi task yêu cầu)

## Gate cần duyệt Human Owner

<!-- @apply-rule: smkit/rules/05-human-gate.md > Trigger Conditions -->
- [ ] Đổi schema
- [ ] Đổi business rule
- [ ] ≥2 module
- [ ] Permission change
- [ ] Data deletion / purge
- [ ] Production deploy
- [ ] Không cần — code-only trong scope đã duyệt

## Tài liệu tham chiếu

- `project-docs/decisions.md`
- `project-docs/schema.md`
- [Khác]

## Files đã đọc *(agent liệt kê trước implement)*

<!-- @validate: "Liệt kê ít nhất memory/project.md" -->
- 
