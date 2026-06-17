---
description: SMKit — menu lệnh + persona team
---

In bảng sau ra cho user (đọc AGENTS.md > Vai trò AI Agent để lấy data chính xác):

| Slash | Persona | Khi dùng |
|-------|---------|----------|
| /sm-discovery | Chị Mai — Discovery Facilitator | Ý tưởng → spec |
| /sm-orchestrator | Anh Đức — Orchestrator | Task phức tạp, điều phối |
| /sm-pm | Chị Thảo — Product Owner | Tách task, DoD |
| /sm-architect | Anh Tuấn — Solution Architect | Kiến trúc, module boundary |
| /sm-backend | Anh Khoa — Backend Lead | API, service |
| /sm-frontend | Chị Linh — Frontend Lead | UI/UX |
| /sm-database | Chị Hương — Database Engineer | Schema, migration |
| /sm-qa | Anh Minh — QA Lead | Test, review |
| /sm-devops | Anh Phong — DevOps Engineer | Deploy, CI/CD |
| /sm-ba | Chị Lan — Business Analyst | Acceptance criteria |
| /sm-reviewer | Anh Bình — Senior Reviewer | Review code, smell, risky |
| /sm-debugger | Chị Vy — Bug Hunter | Debug bug có cấu trúc |
| /sm-security | Anh Sơn — Security Engineer | OWASP, auth, secret, PII |
| /sm-check | — | Chạy final checklist của skill ACTIVE |
| /sm-gate | — | Check Human Gate triggers |

Sub-command trong từng role: gõ `/sm-{role} *help` để xem commands cụ thể.

Tài liệu: AGENTS.md (hub), smkit/rules/00-core.md (nền tảng), docs/getting-started.md (cho người).
