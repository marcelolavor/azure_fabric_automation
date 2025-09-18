

locals {
  policies_map = { for p in var.policies : p.name => p }
}

resource "null_resource" "fabric_policies" {
  for_each = var.enable_policy_apply ? local.policies_map : {}

  triggers = {
    name       = each.value.name
    definition = each.value.definition
    workspace  = var.workspace_id
  }

  provisioner "local-exec" {
    command = <<EOT
python3 ${path.module}/scripts/apply_fabric_policies.py \
  --workspace-id ${var.workspace_id} \
  --policy-name ${each.value.name} \
  --definition '${replace(each.value.definition, "'", "'\"'\"'")}'
EOT
    interpreter = ["/bin/bash", "-c"]
  }
}


