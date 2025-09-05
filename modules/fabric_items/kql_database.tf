resource "fabric_kql_database" "this" {
  for_each     = toset(var.kql_databases)
  display_name = each.value
  workspace_id = var.workspace_id
}
