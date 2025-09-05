variable "workspace_id" {
  description = "ID do workspace onde os itens serão criados"
  type        = string
}

variable "tags" {
  description = "Tags herdadas do global/tags.tf"
  type        = map(string)
}

variable "lakehouses" {
  description = "Lista de lakehouses a criar"
  type        = list(string)
  default     = []
}

variable "warehouses" {
  description = "Lista de warehouses a criar"
  type        = list(string)
  default     = []
}

variable "pipelines" {
  description = "Lista de pipelines a criar"
  type        = list(string)
  default     = []
}

variable "notebooks" {
  description = "Lista de notebooks a criar"
  type        = list(string)
  default     = []
}

variable "eventstreams" {
  description = "Lista de eventstreams a criar"
  type        = list(string)
  default     = []
}

variable "kql_databases" {
  description = "Lista de KQL databases a criar"
  type        = list(string)
  default     = []
}
variable "kql_tables" {
  description = "Lista de KQL tables a criar (requer kql_databases)"
  type        = list(object({
    database_name = string
    table_name    = string
  }))
  default = []
}
variable "kql_functions" {
  description = "Lista de KQL functions a criar (requer kql_databases)"
  type        = list(object({
    database_name = string
    function_name = string
    function_body = string
  }))
  default = []
}
variable "prevent_destroy" {
  description = "Evita a destruição acidental dos workspaces"
  type        = bool
  default     = true
}