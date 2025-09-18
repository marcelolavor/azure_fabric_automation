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

# Managed Private Endpoints (MPE) - Comentado temporariamente (requer preview mode)
# resource "fabric_workspace_managed_private_endpoint" "this" {
#   for_each = { for mpe in var.managed_private_endpoints : mpe.name => mpe }
#
#   name         = each.key
#   workspace_id = var.workspace_id
#
#   # Replaced invalid 'target_resource' with required attributes.
#   target_private_link_resource_id = each.value.target_resource_id
#   target_subresource_type         = each.value.target_subresource_type
#   # Use provided request_message if present; otherwise build a default.
#   request_message                 = coalesce(try(each.value.request_message, null), "Access request for managed private endpoint ${each.key}")
# }

# Mounted Data Factories (MDF) - Comentado temporariamente (requer investigação do formato da definition)
# resource "fabric_mounted_data_factory" "this" {
#   for_each = { for mdf in var.mounted_data_factories : mdf.name => mdf }
#
#   workspace_id = var.workspace_id
#
#   # Removed invalid: data_factory_id, tags
#   # Added required attributes:
#   display_name = each.value.display_name
#   format       = each.value.format
#   definition   = each.value.definition
# }
