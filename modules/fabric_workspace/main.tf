# Resource Group vem das tags globais
resource "azurerm_resource_group" "this" {
  name     = var.tags["rg"]
  location = var.location
  tags     = module.tags.tags
}

resource "fabric_workspace" "this" {
  display_name       = var.name
  capacity_id        = var.capacity_id

  lifecycle {
    prevent_destroy = true
  }

}

# Atribuições de roles (RBAC)
resource "fabric_workspace_role_assignment" "roles" {
  for_each      = { for r in var.role_assignments : "${r.principal_id}-${r.role}" => r }
  workspace_id  = fabric_workspace.this.id
  principal     = each.value.principal_id
  role          = each.value.role
}
