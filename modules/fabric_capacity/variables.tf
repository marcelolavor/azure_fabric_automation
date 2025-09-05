variable "name" {
  description = "Nome da capacity no Microsoft Fabric"
  type        = string
}

variable "location" {
  description = "Região onde a capacity será provisionada"
  type        = string
  default     = "westeurope"
}

variable "sku_name" {
  description = "SKU da capacity (ex: F64, F128, F256, etc.)"
  type        = string
}

variable "tags" {
  description = "Tags para governança e rastreamento de custos"
  type        = map(string)
  default     = {}
}

variable "prevent_destroy" {
  description = "Se true, evita destruição acidental da capacity"
  type        = bool
  default     = true
}
