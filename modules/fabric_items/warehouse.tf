resource "fabric_warehouse" "this" {
  for_each     = toset(var.warehouses)
  display_name = each.value
  workspace_id = var.workspace_id
}
