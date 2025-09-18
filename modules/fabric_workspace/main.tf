# Resource Group vem das tags globais
terraform {
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      # version constraint opcional aqui; pode herdar do root
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

resource "azurerm_resource_group" "this" {
  name     = var.tags["rg"]
  location = var.location
  tags     = var.tags
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
  principal     = {
    id   = each.value.principal_id
    type = each.value.principal_type
  }
  role          = each.value.role
}
