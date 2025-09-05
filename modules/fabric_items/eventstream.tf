resource "fabric_eventstream" "this" {
  for_each     = toset(var.eventstreams)
  display_name = each.value
  workspace_id = var.workspace_id
}
