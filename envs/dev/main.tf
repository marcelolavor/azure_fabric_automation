# Importa tags globais
module "tags" {
  source      = "../../global/tags"
  environment = var.environment
}

# Workspace principal
module "workspace" {
  source      = "../../modules/fabric_workspace"
  name        = "${module.tags.tags.alias}_fabric-${var.environment}-ws"
  location    = "westeurope"
  capacity_id = var.capacity_id
  tags        = module.tags.tags

  role_assignments = [
    { principal_id = "11111111-2222-3333-4444-555555555555", principal_type = "User", role = "Admin" },
    { principal_id = "66666666-7777-8888-9999-000000000000", principal_type = "User", role = "Contributor" }
  ]
}

# Itens do workspace (Lakehouses, Warehouses, Pipelines, Notebooks, Eventstreams, KQL DBs)
module "items" {
  source       = "../../modules/fabric_items"
  workspace_id = module.workspace.workspace.id
  tags         = module.tags.tags


  lakehouses    = ["${module.tags.tags.alias}_lakehouse_${var.environment}"]
  warehouses    = ["${module.tags.tags.alias}_wh_${var.environment}"]
  pipelines     = ["${module.tags.tags.alias}_etl_pipeline_${var.environment}"]
  notebooks     = ["${module.tags.tags.alias}_analytics_nb_${var.environment}"]
  eventstreams  = ["${module.tags.tags.alias}_eventstream_logs_${var.environment}"]
  kql_databases = ["${module.tags.tags.alias}_kql_${var.environment}_db"]
}

# Networking (Managed Private Endpoints + Mounted Data Factories)
module "networking" {
  source       = "../../modules/fabric_networking"
  workspace_id = module.workspace.workspace.id
  tags         = module.tags.tags

  managed_private_endpoints = [
    {
      name                    = "${module.tags.tags.alias}_mpe-sqlserver-${var.environment}"
      target_resource_id      = "/subscriptions/xxxx/resourceGroups/rg-sql-${var.environment}/providers/Microsoft.Sql/servers/sql-${var.environment}"
      target_subresource_type = "sqlServer"
      request_message         = "Acesso necessário ao SQL Server no ambiente ${var.environment} para ${module.tags.tags.alias}"
    },
    {
      name                    = "${module.tags.tags.alias}_mpe-storage-${var.environment}"
      target_resource_id      = "/subscriptions/xxxx/resourceGroups/rg-storage-${var.environment}/providers/Microsoft.Storage/storageAccounts/st${var.environment}"
      target_subresource_type = "blob"
    }
  ]

  mounted_data_factories = [
    {
      name         = "${module.tags.tags.alias}_mdf-adf-${var.environment}"
      display_name = "ADF ${upper(var.environment)} for ${module.tags.tags.alias}"
      format       = "DataFactoryV2"
      definition   = {
        dataFactoryId = "/subscriptions/xxxx/resourceGroups/rg-adf-${var.environment}/providers/Microsoft.DataFactory/factories/adf-${var.environment}"
      }
    }
  ]
}

# Administração (RBAC extra + Policies)
module "admin" {
  source       = "../../modules/fabric_admin"
  workspace_id = module.workspace.workspace.id
  tags         = module.tags.tags

  role_assignments = [
    { principal_id = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee", principal_type = "User", role = "Viewer" },
    { principal_id = "ffffffff-1111-2222-3333-444444444444", principal_type = "User", role = "Contributor" }
  ]

  policies = [
    {
      name       = "policy-data-classification"
      definition = jsonencode({
        rules = [
          { column = "ssn", classification = "Confidential" },
          { column = "email", classification = "PII" }
        ]
      })
    },
    {
      name       = "policy-data-retention"
      definition = jsonencode({
        retention_days = 365
      })
    }
  ]
}

terraform {
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = ">= 1.5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.43.0"
    }
  }
  required_version = ">= 1.9.0"
}
