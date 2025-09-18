# Fabric Admin Module

Este módulo lida com aspectos administrativos do Microsoft Fabric (RBAC extra e policies simuladas) enquanto o provider oficial não expõe um recurso nativo de "fabric_policy".

## 📌 Policies (Limited Support)

**Status oficial (Set/2024):** O Microsoft Fabric REST API **não oferece endpoint genérico** para políticas de governança. Apenas:

✅ **Network Communication Policy** (preview): 
- `PUT /v1/workspaces/{workspaceId}/networking/communicationPolicy`
- Suportado via script

❌ **General Governance Policies**: Não há endpoint oficial para:
- Naming conventions
- RBAC personalizadas 
- Compliance rules
- Data quality policies

### Workaround Atual
- `null_resource` + `local-exec`
- Script Python `scripts/apply_fabric_policies.py` que:
  - Aplica Network Communication Policy via REST API oficial
  - Simula/registra outras policies (aguardando endpoints futuros)

### Exemplo: Network Communication Policy
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

### Exemplo: Policy Placeholder (aguardando endpoint)
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

### Alternativas para Governança Geral
Enquanto endpoints oficiais não são disponibilizados:
- **Azure Policy**: Governança a nível de infraestrutura Azure
- **Microsoft Purview**: Data classification, protection policies  
- **PowerBI Admin API**: Legacy governance (herança no Fabric)
- **Custom governance**: Scripts + inventory + compliance dashboards

### Variáveis
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

### Exemplo de uso no ambiente
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

### Rodando aplicação das policies
Habilite `enable_policy_apply = true` somente após analisar o plano.

### Pipeline sugerido
1. `terraform plan` – valida sintaxe e exibe policies a aplicar.
2. Revisão e aprovação (Change Management).
3. `terraform apply` – executa `null_resource` e script.
4. **Network Communication Policy**: Aplicada via REST API oficial.
5. **Outras policies**: Registradas para auditoria/compliance futura.

### Limitações
- **Apenas Network Communication Policy** tem endpoint real.
- Outras policies são simuladas (logs + triggers para idempotência).
- Governance geral requer ferramentas complementares (Azure Policy, Purview).

### Próximos Passos
- Monitor roadmap Fabric para novos endpoints de policies.
- Implementar governance via Azure Policy + Purview enquanto aguarda.
- Considerar PowerBI Admin API para casos específicos (herança).

---
Licença: Apache 2.0
