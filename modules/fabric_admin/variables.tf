variable "workspace_id" {
  description = "ID do workspace onde aplicar RBAC e Policies"
  type        = string
}

variable "tags" {
  description = "Tags herdadas do módulo global de tags"
  type        = map(string)
}

variable "role_assignments" {
  description = <<EOT
Lista de RBAC assignments adicionais no workspace.
Formato:
[
  { principal_id = "<guid>", principal_type = "User", role = "Admin" },
  { principal_id = "<guid>", principal_type = "Group", role = "Contributor" },
  { principal_id = "<guid>", principal_type = "ServicePrincipal", role = "Viewer" }
]
EOT
  type = list(object({
    principal_id   = string
    principal_type = string
    role          = string
  }))
  default = []
}

# variable "policies" {
#   description = <<EOT
# Lista de policies a aplicar no workspace.
# Formato:
# [
#   { name = "policy-data-classification", definition = jsonencode({...}) },
#   { name = "policy-data-retention", definition = jsonencode({...}) }
# ]
# EOT
#   type = list(object({
#     name       = string
#     definition = string
#   }))
#   default = []
# }

# Policies – provider ainda não oferece fabric_policy (workaround via REST API)
variable "policies" {
  description = "Lista de políticas a aplicar. Cada item: { name = string, definition = jsonstring }"
  type = list(object({
    name       = string
    definition = string
  }))
  default = []
}

variable "enable_policy_apply" {
  description = "Se true, executa aplicação de policies via script local-exec"
  type        = bool
  default     = false
}