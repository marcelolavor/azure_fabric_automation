[Início](README.md) | [Objetivo](01-objective.md) | [Escopo](02-scope.md) | [Processo](03-process-overview.md) | [Controle de Mudanças](04-change-control.md) | [Riscos](05-risks.md) | [Ferramentas](06-tools.md) | [Timeline](07-timeline.md) | [Critérios de Sucesso](08-success-criteria.md) | 
[Conclusão](09-conclusion.md) | 
[Delta Table Files](delta-file-benefits.md)

---
# Azure Fabric Automation Documentation

## Risks

| Risk                                 | Impact                                  | Mitigation |
|--------------------------------------|------------------------------------------|------------|
| Accidental resource deletion         | High – potential service outage          | Use `lifecycle { prevent_destroy = true }` in Terraform |
| Drift between manual and IaC changes | Medium – loss of consistency             | Enforce import before migration; regular drift detection |
| Inconsistent naming conventions      | Medium – lack of clarity in resources    | Apply regex validation and naming modules |
| Unauthorized changes                 | High – security breach                   | RBAC enforcement, approval gates, logging |
| Production impact during migration   | High – downtime or data loss             | Staging environment first, mandatory approvals |

---
[Contribuição](CONTRIBUTING.md) | [Templates](templates/change-request-template.md) | 
[Governança](01-objective.md) | [Contato](mailto:contato@empresa.com) | [Licença](../LICENSE)
