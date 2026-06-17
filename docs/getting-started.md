# SMKit — Getting Started

> Không có SMKit, không làm việc.
> Framework tư duy cho AI Agent, không phụ thuộc platform.

## SMKit là gì?

**Không phải tool — là cách tư duy.**

SMKit giúp AI Agent:
- Hiểu **nghiệp vụ** trước khi code
- Tư duy **hệ thống** — thấy toàn cảnh
- Tư duy **rủi ro** — đánh giá trước khi làm
- Tư duy **phản biện** — không đoán ngầm

---

## Cấu trúc

```
your-project/
├── AGENTS.md                 ← BẮT BUỘC đọc đầu tiên
├── memory/                   ← Context persist
│   ├── project.md            ← Business context (đọc mỗi session)
│   ├── session.md            ← Task hiện tại
│   ├── decisions.md          ← Quyết định đã chốt
│   └── learnings.md          ← Lessons learned
├── smkit/                    ← Core framework
│   ├── rules/                ← Thinking frameworks
│   │   ├── 00-core.md        ← PHẢI đọc
│   │   ├── 01-systems-thinking.md
│   │   ├── 02-risk-thinking.md
│   │   ├── 03-critical-thinking.md
│   │   ├── 04-business-first.md
│   │   └── 05-human-gate.md
│   ├── skills/               ← Vai trò (đọc khi cần)
│   └── templates/            ← Output templates
├── project-docs/             ← Tài liệu nghiệp vụ
│   ├── business-rules.md     ← Quy tắc nghiệp vụ
│   ├── requirements.md       ← Yêu cầu
│   └── schema.md             ← Data model
└── artifacts/                ← Output mỗi task
```

---

## Quick Start

### 0. Clone SMKit

```bash
git clone https://github.com/dthanhvu03/smkit.git
cd smkit
```

```powershell
git clone https://github.com/dthanhvu03/smkit.git
cd smkit
```

### 1. Cài SMKit vào dự án (khuyến nghị)

```powershell
# Windows - từ repo SMKit
.\install.ps1

# Hoặc non-interactive
.\install.ps1 -TargetDir C:\Projects\my-app -Mode full -NonInteractive
```

```bash
# macOS/Linux
chmod +x install.sh && ./install.sh

./install.sh --target ~/Projects/my-app --mode full --non-interactive
```

Xem [README.md](../README.md) cho one-liner remote install.

### 2. Clone/Copy SMKit vào project (thủ công)

```bash
# Copy smkit folder vào project của bạn
cp -r smkit/ your-project/smkit/
cp AGENTS.md your-project/
cp -r memory/ your-project/memory/
```

### 3. Setup business context

Edit `memory/project.md`:

```markdown
## Project Overview
| Field | Value |
|-------|-------|
| Name | [Tên dự án của bạn] |
| Domain | [Lĩnh vực] |

## Business Context
### Problem Statement
[Vấn đề đang giải quyết]

### Target Users
[Ai dùng]
```

### 4. Bắt đầu với AI

**Prompt đầu tiên:**

```
Đọc AGENTS.md và memory/project.md. 
Sau đó giúp tôi [mô tả task].
```

---

## Workflow cơ bản

### Mỗi session

```
AI đọc memory/project.md → Hiểu context → Làm task → Update memory
```

### Mỗi task

```
Hiểu nghiệp vụ (WHY)
    ↓
Systems Thinking (impact?)
    ↓
Risk Thinking (rủi ro?)
    ↓
Critical Thinking (assumptions?)
    ↓
Human Gate (cần duyệt?)
    ↓
Implement
    ↓
Update memory
```

---

## 3 Trụ cột tư duy

### 1. Systems Thinking

> Thấy toàn cảnh, không chỉ task.

Trước khi làm, hỏi:
- Task này ảnh hưởng module nào?
- Ai bị ảnh hưởng?
- Dependencies là gì?

### 2. Risk Thinking

> Đánh giá rủi ro trước khi hành động.

6 loại rủi ro:
- Dữ liệu, Vận hành, Kỹ thuật
- Con người, Tài chính, Khách hàng

### 3. Critical Thinking

> Không đoán ngầm, challenge assumptions.

- Số liệu thật, không sinh số
- Thiếu input → hỏi, không assume
- Verify trước khi trust

---

## Human Gate

AI **DỪNG và HỎI** khi:

- [ ] Đổi business rule
- [ ] Đổi schema/data model
- [ ] Xóa dữ liệu
- [ ] Deploy production
- [ ] Không chắc chắn

---

## Vai trò AI Agent

| Role | Khi dùng |
|------|----------|
| **Discovery** | Bắt đầu dự án, biến ý tưởng → spec |
| **Orchestrator** | Task phức tạp, điều phối |
| **PM** | Tách task, priority |
| **Architect** | Kiến trúc, module boundary |
| **Backend** | Code backend |
| **Frontend** | UI/UX |
| **Database** | Schema |
| **QA** | Test |
| **DevOps** | Deploy |
| **BA** | Acceptance criteria |

---

## Platform Integration

SMKit hoạt động với mọi AI:

| Platform | Cách dùng |
|----------|-----------|
| **Cursor** | Symlink smkit/ → .cursor/ |
| **Claude** | Include AGENTS.md trong system prompt |
| **GPT/Codex** | Upload AGENTS.md + rules |
| **Copilot** | Dùng .github/copilot-instructions.md |

Chi tiết: `docs/platform-integration.md`

---

## Tips

### 1. Business trước, code sau

Luôn hỏi WHY trước khi HOW.

### 2. Update memory

Mỗi session, update `memory/session.md`.
Mỗi decision quan trọng, ghi vào `memory/decisions.md`.

### 3. Respect Human Gates

Không bypass. Tốt hơn hỏi thừa còn hơn làm sai.

### 4. Incremental

Làm nhỏ, test sớm, feedback nhanh.

---

## FAQ

**Q: Tại sao cần SMKit?**

A: AI Agent không có context. SMKit cung cấp framework tư duy và persistent memory.

**Q: Có thể dùng với GPT/Claude/Copilot?**

A: Có. SMKit là framework, không phải tool-specific.

**Q: Bắt buộc đọc tất cả files?**

A: Không. Chỉ cần: AGENTS.md + memory/project.md + 00-core.md. Đọc thêm khi cần.

**Q: Làm sao biết AI đang follow SMKit?**

A: AI sẽ hỏi business context, mention risk assessment, và DỪNG khi cần approval.

---

## Next Steps

1. Setup `memory/project.md` với context dự án
2. Đọc `smkit/rules/00-core.md` để hiểu principles
3. Bắt đầu task với prompt: *"Đọc AGENTS.md và giúp tôi..."*
