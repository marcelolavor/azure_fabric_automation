[Início](README.md) | [Objetivo](01-objective.md) | [Escopo](02-scope.md) | [Processo](03-process-overview.md) | [Controle de Mudanças](04-change-control.md) | [Riscos](05-risks.md) | [Ferramentas](06-tools.md) | [Timeline](07-timeline.md) | [Critérios de Sucesso](08-success-criteria.md) | 
[Conclusão](09-conclusion.md) | 
[Delta Table Files](delta-file-benefits.md)

---
# Azure Fabric Automation Documentation

## Change Control

### 4.1 Approval Workflow
- **Requester**: Infrastructure/Automation Team.
- **Technical Reviewer**: Cloud/Infrastructure Architect.
- **Final Approver**: Governance Committee (Infra + Security + Data).

### 4.2 Workflow Automation
All change submissions must follow a controlled CI/CD process using GitHub Actions or Azure DevOps:

1. Pull Request created with Terraform change.
2. Pipeline execution:
   - `terraform fmt` → code formatting validation.
   - `terraform validate` → syntax and provider validation.
   - `terraform plan` → preview of changes.
   - Publish report of `plan` in Markdown/HTML for review.
3. Mandatory review and approval.
4. Only after approval → `terraform apply`.

### 4.3 Logs and Audit
- Execution logs stored in **Azure Monitor / Log Analytics**.
- Change reports accessible in **Power BI dashboards**.
- Approval history preserved in GitHub/Azure DevOps repositories.

---
[Contribuição](CONTRIBUTING.md) | [Templates](templates/change-request-template.md) | 
[Governança](01-objective.md) | [Contato](mailto:contato@empresa.com) | [Licença](../LICENSE)
