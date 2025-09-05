resource "fabric_lakehouse" "this" {
  for_each     = toset(var.lakehouses)
  display_name = each.value
  workspace_id = var.workspace_id
}
