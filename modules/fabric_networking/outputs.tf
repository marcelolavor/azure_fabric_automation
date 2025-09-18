output "networking" {
  description = "Configurações de rede do workspace (Managed Private Endpoints e Mounted Data Factories)"
  value = {
    managed_private_endpoints = {
      # Comentado temporariamente até configurar preview mode
      # for k, v in fabric_workspace_managed_private_endpoint.this :
      # k => {
      #   id           = v.id
      #   display_name = v.display_name
      # }
    }
    mounted_data_factories = {
      # Comentado temporariamente até investigar formato da definition
      # for k, v in fabric_mounted_data_factory.this :
      # k => {
      #   id           = v.id
      #   display_name = v.display_name
      # }
    }
  }
}
