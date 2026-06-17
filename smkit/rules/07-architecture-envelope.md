# Architecture Envelope — Mutation pattern

> Mọi mutation đi qua flow nhất quán.
> Business logic trong Service — không trong Controller/UI.

## Flow bắt buộc

```
User action (UI / API / CLI)
  → Input Validation
  → Authorization
  → Domain Service
  → Transaction (if multi-table)
  → Audit Log (if important)
  → Response
```

## Principles

1. **Thin entry points** — validation + routing only
2. **Fat services** — business logic ở Service layer
3. **Validation first** — fail fast
4. **Authorization always** — UI hide không thay backend check
5. **Transaction** khi multi-table
6. **Audit** cho important mutations

## Critical services

Định nghĩa trong `project-docs/decisions.md` — mọi mutation domain quan trọng phải qua single-entry service, không bypass.

## Cấm

- Bypass service layer cho critical domains
- Business logic trong Controller/UI
- Schema change không có migration-note + Human Gate
