variable "environment" {
  description = "Ambiente herdado do tfvars de cada ambiente"
  type        = string
}
// Global tags definition for all environments
locals {
  tags = {
    # ========================================
    # Nivel 0 - Cloud & Organização
    # ========================================
    cloud           = "azure"
    company         = "company"
    deployment_mode = "TF"
    framework       = "terraform+python"

    # ========================================
    # Nivel 1 - Unidade de Negócio & Subscrição
    # ========================================
    bu          = "business unit"
    subscription = "subscription name"
    location    = "West Europe"
    domain      = "data-analytics"

    # ========================================
    # Nivel 2 - Projeto & Custos
    # ========================================
    state             = "project"            # Valores controlados: project | service | shared
    project           = "PRJ00000"
    costs             = "OPEX"
    provisioning_date = timestamp()          # Data de provisionamento gerada automaticamente

    # ========================================
    # Nivel 3 - Resource Group & App
    # ========================================
    rg          = "xxx-rg-01"
    alias       = "xxx"
    app         = "xxx app"
    owner       = "xxx@gmail.com"                 # Pode evoluir para lista de owners (AD groups)
    environment = var.environment            # herdado do tfvars de cada ambiente

    # ========================================
    # Nivel 4 - Change & Contexto
    # ========================================
    change       = "RITM0000001"             # Opcional (nullable)
    description  = "Resource group for xxx app"
  }
}
