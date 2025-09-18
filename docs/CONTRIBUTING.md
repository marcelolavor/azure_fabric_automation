[Início](README.md) | [Objetivo](01-objective.md) | [Escopo](02-scope.md) | [Processo](03-process-overview.md) | [Controle de Mudanças](04-change-control.md) | [Riscos](05-risks.md) | [Ferramentas](06-tools.md) | [Timeline](07-timeline.md) | [Critérios de Sucesso](08-success-criteria.md) | 
[Conclusão](09-conclusion.md) | 
[Delta Table Files](delta-file-benefits.md)

---
# Azure Fabric Automation Documentation

## Contributing Guide – Governance Documentation

Thank you for contributing to the **Governance and Change Management Documentation**.  
This guide defines the standards and workflow to ensure that all contributions remain consistent, auditable, and aligned with corporate best practices.

---

## 📌 1. Contribution Principles
- All contributions must follow **corporate governance standards**.
- Documentation must be written in **English** for international alignment, unless explicitly defined otherwise.
- Content must be **professional, concise, and structured**, avoiding informal tone.
- All diagrams should use **Mermaid** and be exported as `.png` to `/docs/governance-change-management/images/`.

---

## 📌 2. Repository Structure
- **Main documentation** is located under `/docs`.
- Each major initiative (e.g., Change Management) has its own folder:
  - `/docs/governance-change-management/`
- Shared templates are stored in:
  - `/docs/templates/`

---

## 📌 3. File Naming Conventions
- Use **numeric prefixes** for ordered content:
  - Example: `01-objective.md`, `02-scope.md`
- Use **kebab-case** (lowercase with hyphens) for filenames.
- Place all images in a dedicated `images/` folder inside the documentation path.

---

## 📌 4. Writing Guidelines
- Use **Markdown headings** consistently:
  - `#` for page title  
  - `##` for main sections  
  - `###` for subsections  
- Write in **corporate style** with bullet points, tables, and diagrams when appropriate.
- Always provide **context before detail** (executive-first approach).
- Use **tables** for risk, scope, or comparison sections.
- Keep each Markdown file **self-contained** and focused.

---

## 📌 5. Diagrams and Images
- Use **Mermaid** for flowcharts, sequence diagrams, and architecture.
- Export diagrams to `.png` using Mermaid CLI or VS Code extensions.
- Store images in:
  - `/docs/governance-change-management/images/`

Example command to export Mermaid to PNG:
```bash
mmdc -i process-flow.mmd -o process-flow.png
```

## 📌 6. Change Workflow
1. Fork or create a branch from the repository.
2. Add or update documentation under `/docs`.
3. Validate before committing:
   - Markdown syntax (markdownlint)
   - Internal links and references
   - Diagram rendering
4. Commit with a clear message (example):
   ```
   docs: update risks section in governance-change-management
   ```
5. Submit a Pull Request (PR):
   - Include a concise summary of changes
   - At least 1 reviewer approval required
   - Governance Committee provides final approval
6. No direct commits to `main` are allowed.

## 📌 7. Templates
Use the official templates for consistency:
- Change Request Submission Template (store under `/docs/templates/`)

## 📌 8. Governance Review
- Technical Reviewer: validates technical accuracy.
- Governance Committee: validates policy compliance.
- Changes may be requested before approval.

## 📌 9. License & Ownership
- All documentation is corporate intellectual property.
- Contributions may be edited for compliance.
- External reuse requires formal approval.

## 📌 10. Contacts
For questions about contribution or governance standards contact:
- Governance Committee – Cloud & Data

---
[Contribuição](CONTRIBUTING.md) | [Templates](templates/change-request-template.md) | 
[Governança](01-objective.md) | [Contato](mailto:contato@empresa.com) | [Licença](../LICENSE)
