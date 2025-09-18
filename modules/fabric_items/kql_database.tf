resource "fabric_kql_database" "this" {
  for_each     = var.eventhouse_id != null ? toset(var.kql_databases) : toset([])
  display_name = each.value
  workspace_id = var.workspace_id
  
  configuration = {
    database_type  = "ReadWrite"  # ou "ReadOnlyFollowing"
    eventhouse_id  = var.eventhouse_id
  }
}
