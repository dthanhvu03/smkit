# Business Rules

> Source of truth cho quy tắc nghiệp vụ.
> Code PHẢI reflect những rules này.

## Format

```markdown
## BR-XXX: [Tên rule]

**Domain:** [Module/area]
**Owner:** [Ai quyết định rule này]
**Status:** Active / Draft / Deprecated

**Rule:**
[Mô tả rule rõ ràng]

**Conditions:**
- IF [condition] THEN [action]
- ELSE [alternative]

**Exceptions:**
- [Exception]: [handling]

**Examples:**
- [Example với số liệu cụ thể]

**Related:**
- [BR-XXX]: [relationship]
```

---

## Rules

### BR-001: [Rule Name]

**Domain:** [Module]
**Owner:** [Owner name]
**Status:** Active

**Rule:**
[Describe the rule clearly]

**Conditions:**
- IF [condition 1] THEN [action 1]
- IF [condition 2] THEN [action 2]
- ELSE [default action]

**Exceptions:**
- [Exception case]: [how to handle]

**Examples:**
- Example 1: [specific case with numbers]
- Example 2: [another case]

**Related:**
- None

---

## Rule Categories

### Validation Rules
[Rules về validation input/data]

### Calculation Rules
[Rules về tính toán: giá, discount, inventory, etc.]

### State Transition Rules
[Rules về chuyển trạng thái: order flow, approval flow, etc.]

### Permission Rules
[Rules về quyền: ai được làm gì]

### Integration Rules
[Rules về tích hợp: external systems, APIs]

---

## Glossary

| Term | Definition |
|------|------------|
| [Domain term] | [Clear definition] |

---

## Change Log

| Date | Rule | Change | Owner |
|------|------|--------|-------|
| [Date] | BR-XXX | [What changed] | [Who] |
