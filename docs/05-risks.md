[Home](README.md) | [Objective](01-objective.md) | [Scope](02-scope.md) | [Process](03-process-overview.md) | [Change Control](04-change-control.md) | [Risks](05-risks.md) | [Tools](06-tools.md) | [Timeline](07-timeline.md) | [Success Criteria](08-success-criteria.md) | 
[Conclusion](09-conclusion.md) | 
[Delta Table Files](delta-file-benefits.md)

---
# Azure Fabric Automation Documentation

## Risks

| Risk                                 | Impact                                  | Mitigation |
|--------------------------------------|------------------------------------------|------------|
| Accidental resource deletion         | High – potential service outage          | Use `lifecycle { prevent_destroy = true }` in Terraform |
| Drift between manual and IaC changes | Medium – loss of consistency             | Enforce import before migration; regular drift detection |
| Inconsistent naming conventions      | Medium – lack of clarity in resources    | Apply regex validation and naming modules |
| Unauthorised changes                 | High – security breach                   | RBAC enforcement, approval gates, logging |
| Production impact during migration   | High – downtime or data loss             | Staging environment first, mandatory approvals |

---
[Contributing](CONTRIBUTING.md) | [Templates](templates/change-request-template.md) | 
[Governance](01-objective.md) | [Contact](mailto:contato@empresa.com) | [Licence](../LICENSE)
