# RBAC assignments
resource "fabric_workspace_role_assignment" "extra_roles" {
  for_each = { for r in var.role_assignments : "${r.principal_id}-${r.role}" => r }

  workspace_id = var.workspace_id
  principal    = {
    id   = each.value.principal_id
    type = each.value.principal_type
  }
  role         = each.value.role
}