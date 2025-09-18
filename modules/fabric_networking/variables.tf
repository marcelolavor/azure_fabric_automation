variable "workspace_id" {
  description = "ID do workspace onde os recursos de rede serão criados"
  type        = string
}

variable "tags" {
  description = "Tags herdadas do módulo global de tags"
  type        = map(string)
}

variable "managed_private_endpoints" {
  description = <<EOT
Lista de Managed Private Endpoints (MPE) a criar.
Formato:
[
  {
    name                    = "mpe-sqlserver"
    target_resource_id      = "<ARM_ID_SQL_SERVER>"
    target_subresource_type = "sqlServer"   # Exemplo: 'blob', 'sqlServer'
    request_message         = "Acesso necessário ao SQL Server (dev)" # Opcional
  }
]
EOT
  type = list(object({
    name                    = string
    target_resource_id      = string
    target_subresource_type = string
    request_message         = optional(string)
  }))
  default = []
}

variable "mounted_data_factories" {
  description = <<EOT
Lista de Mounted Data Factories (MDF) a criar.
Formato:
[
  {
    name         = "mdf-adf-prd"
    display_name = "ADF Produção"
    format       = "DataFactoryV2"
    definition   = {
                      dataFactoryId = "<ARM_ID_ADF>"
                   }
  }
]
EOT
  type = list(object({
    name         = string
    display_name = string
    format       = string
    definition   = any
  }))
  default = []
}
