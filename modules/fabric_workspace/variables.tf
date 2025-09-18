variable "name" {
  description = "Nome do workspace Fabric"
  type        = string
}

variable "location" {
  description = "Região do workspace"
  type        = string
  default     = "westeurope"
}

variable "capacity_id" {
  description = "ID da capacity associada ao workspace"
  type        = string
}

variable "tags" {
  description = "Tags herdadas do global/tags.tf"
  type        = map(string)
  default     = {}
}

variable "prevent_destroy" {
  description = "Se true, impede a destruição acidental do workspace"
  type        = bool
  default     = true
}

variable "role_assignments" {
  description = <<EOT
Lista de atribuições de role no workspace.
Formato:
[
  { principal_id = "<guid>", principal_type = "User", role = "Admin" },
  { principal_id = "<guid>", principal_type = "Group", role = "Contributor" }
]
EOT
  type    = list(object({
    principal_id   = string
    principal_type = string
    role          = string
  }))
  default = []
}
