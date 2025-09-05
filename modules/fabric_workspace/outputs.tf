output "workspace" {
  description = "Workspace criado (id, display_name e resource_group)"
  value = {
    id             = fabric_workspace.this.id
    display_name   = fabric_workspace.this.display_name
    resource_group = azurerm_resource_group.this.name
  }
}
