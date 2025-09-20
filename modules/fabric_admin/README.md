# Fabric Admin Module

This module handles administrative aspects of Microsoft Fabric (extra RBAC and simulated policies) whilst the official provider does not expose a native "fabric_policy" resource.

## 📌 Policies (Limited Support)

**Official status (Sep/2024):** The Microsoft Fabric REST API **does not offer a generic endpoint** for governance policies. Only:

✅ **Network Communication Policy** (preview): 
- `PUT /v1/workspaces/{workspaceId}/networking/communicationPolicy`
- Supported via script

❌ **General Governance Policies**: There is no official endpoint for:
- Naming conventions
- Custom RBAC 
- Compliance rules
- Data quality policies

### Current Workaround
- `null_resource` + `local-exec`
- Python script `scripts/apply_fabric_policies.py` that:
  - Applies Network Communication Policy via official REST API
  - Simulates/registers other policies (awaiting future endpoints)

### Example: Network Communication Policy
```hcl
module "admin" {
  source              = "../../modules/fabric_admin"
  workspace_id        = module.workspace.workspace.id
  enable_policy_apply = true
  policies = [
    {
      name = "communicationPolicy"
      definition = jsonencode({
        allowInternetAccess     = false
        allowPublicNetworkAccess = true
        virtualNetworkRules     = []
      })
    }
  ]
}
```

### Example: Policy Placeholder (awaiting endpoint)
```hcl
policies = [
  {
    name = "naming-guard"
    definition = jsonencode({
      rule        = "naming"
      pattern     = "^[a-z0-9-]{3,40}$"
      description = "Enforce workspace item naming convention"
    })
  }
]
```

### Alternatives for General Governance
Whilst official endpoints are not available:
- **Azure Policy**: Infrastructure-level governance for Azure
- **Microsoft Purview**: Data classification, protection policies  
- **PowerBI Admin API**: Legacy governance (inheritance in Fabric)
- **Custom governance**: Scripts + inventory + compliance dashboards

### Variables
```hcl
variable "policies" {
  type = list(object({
    name       = string
    definition = string # JSON string
  }))
  default = []
}

variable "enable_policy_apply" {
  type    = bool
  default = false
}
```

### Example usage in environment
```hcl
module "admin" {
  source              = "../../modules/fabric_admin"
  workspace_id        = module.workspace.workspace.id
  enable_policy_apply = true
  policies = [
    {
      name = "naming-guard"
      definition = jsonencode({
        rule        = "naming"
        description = "Enforce workspace item naming convention"
        pattern     = "^[a-z0-9-]{3,40}$"
      })
    }
  ]
}
```

### Running policy application
Enable `enable_policy_apply = true` only after analysing the plan.

### Suggested pipeline
1. `terraform plan` – validates syntax and displays policies to apply.
2. Review and approval (Change Management).
3. `terraform apply` – executes `null_resource` and script.
4. **Network Communication Policy**: Applied via official REST API.
5. **Other policies**: Registered for future auditing/compliance.

### Limitations
- **Only Network Communication Policy** has a real endpoint.
- Other policies are simulated (logs + triggers for idempotency).
- General governance requires complementary tools (Azure Policy, Purview).

### Next Steps
- Monitor Fabric roadmap for new policy endpoints.
- Implement governance via Azure Policy + Purview whilst waiting.
- Consider PowerBI Admin API for specific cases (inheritance).

---
Licence: Apache 2.0
