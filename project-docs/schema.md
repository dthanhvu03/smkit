# Database Schema

> **USER TỰ ĐIỀN** — Ghi lại schema database của dự án.

## Overview

- **Database:** [PostgreSQL / MySQL / SQLite / MongoDB / ...]
- **ORM:** [Prisma / TypeORM / Eloquent / ...]

## Tables / Collections

### users

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| id | BIGINT / UUID | PK, AUTO | |
| email | VARCHAR(255) | UNIQUE, NOT NULL | |
| password | VARCHAR(255) | NOT NULL | Hashed |
| name | VARCHAR(100) | | |
| created_at | TIMESTAMP | DEFAULT NOW() | |
| updated_at | TIMESTAMP | | |
| deleted_at | TIMESTAMP | NULL | Soft delete |

### [other_table]

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| | | | |

## Relationships

```
users 1───* orders
orders 1───* order_items
order_items *───1 products
```

## Indexes

| Table | Index | Columns | Type |
|-------|-------|---------|------|
| users | idx_users_email | email | UNIQUE |
| | | | |

## Migrations Log

| # | Date | Description | Status |
|---|------|-------------|--------|
| 001 | | Create users table | Applied |
| | | | |

## Notes

- [Any important notes about the schema]
