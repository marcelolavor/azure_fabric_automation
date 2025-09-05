# RBAC assignments
resource "fabric_workspace_role_assignment" "extra_roles" {
  for_each = { for r in var.role_assignments : "${r.principal_id}-${r.role}" => r }

  workspace_id = var.workspace_id
  principal    = each.value.principal_id  # Renamed from principal_id to match provider schema
  role         = each.value.role
}