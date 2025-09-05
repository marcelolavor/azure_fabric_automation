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
  { principal_id = "<guid>", role = "Admin" },
  { principal_id = "<guid>", role = "Contributor" },
  { principal_id = "<guid>", role = "Viewer" }
]
EOT
  type = list(object({
    principal_id = string
    role         = string
  }))
  default = []
}

variable "policies" {
  description = <<EOT
Lista de policies a aplicar no workspace.
Formato:
[
  { name = "policy-data-classification", definition = jsonencode({...}) },
  { name = "policy-data-retention", definition = jsonencode({...}) }
]
EOT
  type = list(object({
    name       = string
    definition = string
  }))
  default = []
}
