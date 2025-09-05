output "networking" {
  description = "Configurações de rede do workspace (Managed Private Endpoints e Mounted Data Factories)"
  value = {
    managed_private_endpoints = {
      for k, v in fabric_workspace_managed_private_endpoint.this :
      k => {
        id           = v.id
        display_name = v.display_name
      }
    }
    mounted_data_factories = {
      for k, v in fabric_mounted_data_factory.this :
      k => {
        id           = v.id
        display_name = v.display_name
      }
    }
  }
}
