resource "fabric_data_pipeline" "this" {
  for_each     = toset(var.pipelines)
  display_name = each.value
  workspace_id = var.workspace_id
}
