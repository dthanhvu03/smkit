# Data Safety — An toàn dữ liệu

> Không rule nào override data safety.
> Áp dụng khi đụng DB, migration, import/export, production data.

## Guardrails

- **Never** `DELETE` / `TRUNCATE` / `DROP` trên production
- **Never** hard delete core business data
- Soft delete ≠ physical purge
- Audit tables **append-only** — không UPDATE/DELETE để "sửa lỗi"
- Business correction → **cancel / reversal / adjustment** only
- Future purge **must** have: whitelist, dry-run, batch limit, reference check, audit, approval, backup, rollback plan

## DB user separation (khuyến nghị)

| User | Role |
|------|------|
| `app_user` | Normal read/write |
| `report_user` | Read-only |
| `migration_user` | Deploy/migration only |
| `admin` | **Never** used by app |

## Stop conditions

DỪNG và hỏi Human Owner khi task:
- Xóa/purge production data
- Drop/rename schema
- Bypass audit
- Đổi data retention behavior

## Safe patterns

**Soft delete:** set `deleted_at`, query exclude — không xóa vật lý.

**Correction:** reversal transaction (ref original + reason), không sửa record cũ.

**Deploy data change:** DRY_RUN → Staging → Production (có backup).
