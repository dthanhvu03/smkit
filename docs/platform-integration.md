# Platform Integration — SMKit

> SMKit không phụ thuộc platform. Hướng dẫn tích hợp với các AI tools.

## Core Principle

SMKit = **Thinking Framework**, không phải tool-specific.

Bất kỳ AI nào (Cursor, Claude, GPT, Codex, Copilot, Gemini...) đều có thể apply.

---

## Cursor IDE

### Option 1: Symlink (recommended)

```powershell
# Windows PowerShell (Admin)
New-Item -ItemType SymbolicLink -Path ".cursor\rules" -Target "smkit\rules"
New-Item -ItemType SymbolicLink -Path ".cursor\skills" -Target "smkit\skills"
```

```bash
# macOS/Linux
ln -s ../smkit/rules .cursor/rules
ln -s ../smkit/skills .cursor/skills
```

### Option 2: Copy

```bash
cp -r smkit/rules/* .cursor/rules/
cp -r smkit/skills/* .cursor/skills/
```

### Option 3: Reference in prompt

```
Đọc smkit/rules/00-core.md trước khi làm task.
```

### Cursor-specific config

Tạo `.cursor/rules/loader.md`:

```markdown
# SMKit Loader for Cursor

Load order:
1. memory/project.md (always)
2. smkit/rules/00-core.md (always)
3. Relevant rules/skills (when needed)

Do NOT read all files. Follow memory protocol.
```

---

## Claude (claude.ai / API)

### System Prompt

```
Bạn tuân thủ SMKit — framework tư duy cho AI Agent.

BẮT BUỘC đọc theo thứ tự:
1. AGENTS.md
2. memory/project.md
3. smkit/rules/00-core.md

Áp dụng 3 trụ cột tư duy:
- Systems Thinking: Xem xét impact scope
- Risk Thinking: Đánh giá rủi ro
- Critical Thinking: Challenge assumptions

Human Gate: DỪNG khi cần approval.
Business-First: Hiểu nghiệp vụ trước khi code.
```

### With Claude Code

`CLAUDE.md` đã có pointer → AGENTS.md

---

## OpenAI GPT / Codex

### System Prompt

```
You follow SMKit — a thinking framework for AI Agents.

REQUIRED reading order:
1. AGENTS.md (hub)
2. memory/project.md (project context)
3. smkit/rules/00-core.md (core rules)

Apply 3 thinking pillars:
- Systems Thinking: Consider impact scope
- Risk Thinking: Assess risks before action
- Critical Thinking: Challenge assumptions, no silent assumptions

Human Gate: STOP and ASK when approval needed.
Business-First: Understand business before implementation.
```

### Custom GPT

1. Upload AGENTS.md, smkit/rules/*.md
2. Instructions: "Follow SMKit framework. Read files in order."

---

## GitHub Copilot

### Repository Instructions

Tạo `.github/copilot-instructions.md`:

```markdown
# Copilot Instructions

This project follows SMKit — a thinking framework.

Before implementing:
1. Read memory/project.md for context
2. Apply Systems Thinking (impact scope)
3. Apply Risk Thinking (assess risks)
4. Apply Critical Thinking (verify assumptions)

Stop and comment when:
- Business rule unclear
- Schema change needed
- Production impact

Refer to: AGENTS.md, smkit/rules/
```

---

## Automation / API Integration

### When calling AI API

```python
# Example: Include SMKit context in API call

def get_smkit_context():
    with open('AGENTS.md') as f:
        agents = f.read()
    with open('memory/project.md') as f:
        project = f.read()
    with open('smkit/rules/00-core.md') as f:
        core = f.read()
    return f"""
SMKit Context:
---
{agents}
---
{project}
---
{core}
"""

# In API call
messages = [
    {"role": "system", "content": get_smkit_context()},
    {"role": "user", "content": user_task}
]
```

### Memory Persistence

```python
# After each session, update memory
def update_session_memory(task, status, decisions):
    with open('memory/session.md', 'w') as f:
        f.write(f"# Session\nTask: {task}\nStatus: {status}")
    
    if decisions:
        with open('memory/decisions.md', 'a') as f:
            f.write(f"\n### {datetime.now()}\n{decisions}")
```

---

## Multi-Agent Systems

### LangChain / LangGraph

```python
# Include SMKit as agent context
smkit_context = """
Follow SMKit framework:
1. Read memory/project.md first
2. Apply 3 thinking pillars
3. Respect Human Gates
4. Update memory after task
"""

agent = create_agent(
    system_prompt=smkit_context,
    tools=[...]
)
```

### AutoGPT / AgentGPT

Include AGENTS.md in initial context.
Set up memory persistence to `memory/` folder.

---

## Minimal Setup

Nếu chỉ cần essentials:

```
1. AGENTS.md — đọc đầu tiên
2. smkit/rules/00-core.md — core principles
3. memory/project.md — project context
```

Đủ cho 80% use cases.

---

## Verification

AI Agent đang follow SMKit đúng khi:

- [ ] Đọc memory trước khi hành động
- [ ] Hỏi business context trước khi implement
- [ ] Mention risk assessment cho task Mức 2-3
- [ ] DỪNG khi trigger Human Gate
- [ ] Update memory sau task
