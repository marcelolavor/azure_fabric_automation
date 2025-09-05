# Policies aplicadas ao workspace
resource "fabric_policy" "workspace_policies" {
  for_each = { for p in var.policies : p.name => p }

  name         = each.key
  workspace_id = var.workspace_id
  definition   = each.value.definition
  tags         = var.tags
}
