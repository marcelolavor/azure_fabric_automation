variable "environment" {
  description = "Ambiente de execução (ex: dev, pre, prd)"
  type        = string
}

variable "capacity_id" {
  description = "ID da capacity do Fabric para este workspace"
  type        = string
}
