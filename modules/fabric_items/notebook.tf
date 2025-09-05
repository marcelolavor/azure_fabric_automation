resource "fabric_notebook" "this" {
  for_each     = toset(var.notebooks)
  display_name = each.value
  workspace_id = var.workspace_id
}
