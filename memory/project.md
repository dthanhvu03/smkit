# Project Memory

> Agent đọc file này **đầu tiên** mỗi session.
> Không cần đọc lại toàn bộ kit nếu đã có đủ context ở đây.

<!-- AGENT_PROTOCOL: project.md
Nếu field BẮT BUỘC còn placeholder → DỪNG implement, HỎI user. KHÔNG đoán, KHÔNG fill mặc định.

Field bắt buộc (P0 — thiếu 1 là chưa setup):
- Project Overview: Name, Domain, Phase
- Problem Statement
- Target Users (≥1 role có mô tả thật)
- Tech Stack: Frontend, Backend, Database (TBD được — nhưng phải hỏi user confirm)
- Human Owners: Business/Product, Technical

Dấu hiệu CHƯA điền (coi như trống):
- Comment `DISCOVERY_FILL_HERE`
- Placeholder dạng `[Tên dự án]`, `[Role 1]`, `[Vấn đề...]`
- Ô bảng trống hoặc chỉ có example trong comment HTML
- Giá trị generic: `TBD`, `N/A`, `TODO` mà user chưa confirm trong session

Hành vi khi trống:
1. Liệt kê field P0 còn thiếu
2. Hỏi từng câu cụ thể — không assume domain/stack/users
3. Gợi ý `@sm-discovery` / `/sm-discovery` nếu mới bắt đầu dự án
4. Chỉ implement sau khi user trả lời HOẶC ghi rõ vào file này

Được phép: ghi `TBD` + lý do **sau khi user nói "chưa chốt"** — không tự ghi TBD thay user.
-->

## Project Overview

| Field | Value |
|-------|-------|
| Name | <!-- DISCOVERY_FILL_HERE --> <!-- example: CafeFlow --> [Tên dự án] |
| Domain | <!-- DISCOVERY_FILL_HERE --> <!-- example: F&B — Quản lý quán cafe --> [Lĩnh vực nghiệp vụ] |
| Started | <!-- DISCOVERY_FILL_HERE --> <!-- example: 2026-06-17 --> [Ngày] |
| Phase | <!-- DISCOVERY_FILL_HERE --> <!-- example: Discovery --> Discovery / Development / Testing / Production |
| Mode | <!-- DISCOVERY_FILL_HERE --> <!-- example: Lightweight --> Lightweight / Full |

---

## Business Context

### Problem Statement
<!-- DISCOVERY_FILL_HERE -->
<!-- example: Ghi order bằng giấy, tính tiền hay sai, mất 2-3 giờ đối soát Excel cuối tháng -->
[Vấn đề nghiệp vụ đang giải quyết]

### Target Users
| User Type | Description | Key Needs |
|-----------|-------------|-----------|
| <!-- DISCOVERY_FILL_HERE --> <!-- example: Chủ quán --> [Role 1] | <!-- DISCOVERY_FILL_HERE --> <!-- example: Quyết định menu, xem doanh thu --> [Mô tả] | <!-- DISCOVERY_FILL_HERE --> <!-- example: Chốt ca nhanh, báo cáo top món --> [Nhu cầu] |
| <!-- DISCOVERY_FILL_HERE --> <!-- example: Nhân viên pha chế --> [Role 2] | <!-- DISCOVERY_FILL_HERE --> <!-- example: Nhận order tại quầy --> [Mô tả] | <!-- DISCOVERY_FILL_HERE --> <!-- example: Tạo order nhanh, ít thao tác --> [Nhu cầu] |

### Core Value Proposition
<!-- DISCOVERY_FILL_HERE -->
<!-- example: Order không sót, chốt ca 15 phút, top 5 món bán chạy mỗi tuần -->
[Giá trị chính mang lại cho user]

---

## Business Rules (Summary)

> Chi tiết: `project-docs/business-rules.md`

| Rule ID | Summary |
|---------|---------|
| BR-001 | <!-- DISCOVERY_FILL_HERE --> <!-- example: Order paid → không sửa line items --> [Tóm tắt rule] |
| BR-002 | <!-- DISCOVERY_FILL_HERE --> <!-- example: Hủy order → bắt buộc PIN manager --> [Tóm tắt rule] |

---

## Domain Model (Summary)

> Chi tiết: `project-docs/schema.md`

### Core Entities
<!-- DISCOVERY_FILL_HERE -->
<!-- example: MenuItem: món, giá | Order: ca, nhân viên, trạng thái | Shift: ca mở/đóng -->
- [Entity 1]: [Mô tả ngắn]
- [Entity 2]: [Mô tả ngắn]

### Key Relationships
<!-- DISCOVERY_FILL_HERE -->
<!-- example: Shift → Order (1-n) | Order → MenuItem (line items) -->
- [Entity A] → [Entity B]: [relationship]

---

## Tech Stack (đã chốt)

| Layer | Choice | Rationale |
|-------|--------|-----------|
| Frontend | <!-- example: TBD — chốt ở Architect --> | |
| Backend | | |
| Database | | |
| Hosting | | |

---

## Conventions

### Naming
- Files: <!-- example: TBD sau khi setup repo -->
- Components: 
- Functions: 
- Database: 

### Domain Language
| Term | Meaning |
|------|---------|
| <!-- DISCOVERY_FILL_HERE --> <!-- example: Ca (Shift) --> [Term 1] | <!-- DISCOVERY_FILL_HERE --> <!-- example: Khoảng mở/đóng quầy trong ngày --> [Definition] |
| [Term 2] | [Definition] |

---

## Current Focus

### Active Task
<!-- DISCOVERY_FILL_HERE -->
<!-- example: Implement MVP P0 — Tạo order nhanh tại quầy -->
[Task đang làm]

### Priority Queue
<!-- DISCOVERY_FILL_HERE -->
<!-- example: 1. P0 Tạo order | 2. P0 Chốt ca | 3. P1 Báo cáo top món -->
1. [Next priority]
2. [After that]

---

## Key Decisions (Summary)

> Chi tiết: `memory/decisions.md`

| Date | Decision | Rationale |
|------|----------|-----------|
| <!-- DISCOVERY_FILL_HERE --> <!-- example: 2026-06-17 --> [Date] | <!-- DISCOVERY_FILL_HERE --> <!-- example: Mode Lightweight --> [Decision] | <!-- DISCOVERY_FILL_HERE --> <!-- example: MVP 1 quán, 2 tuần --> [Why] |

---

## Human Owners

| Domain | Owner | Contact |
|--------|-------|---------|
| Business/Product | <!-- DISCOVERY_FILL_HERE --> <!-- example: TBD — hỏi user --> | |
| Technical | | |
| Data | | |

---

## Constraints & Boundaries

### Must Have
<!-- DISCOVERY_FILL_HERE -->
<!-- example: 1 quán MVP | Order paid không sửa -->
- [Constraint 1]

### Must NOT
<!-- DISCOVERY_FILL_HERE -->
<!-- example: Không đa chi nhánh | Không app khách -->
- [Constraint 2]

### Out of Scope (this phase)
<!-- DISCOVERY_FILL_HERE -->
<!-- example: Máy in nhiệt | Quản lý kho nguyên liệu chi tiết -->
- [OOS 1]

---

*Last updated: <!-- DISCOVERY_FILL_HERE --> <!-- example: 2026-06-17T10:00:00+07:00 --> [timestamp]*
