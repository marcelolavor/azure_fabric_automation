output "admin" {
  description = "Administração do workspace (RBAC extra e Policies aplicadas)"
  value = {
    extra_roles = {
      for k, v in fabric_workspace_role_assignment.extra_roles :
      k => {
        id   = v.id
        role = v.role
      }
    }
    policies = [for k, v in null_resource.fabric_policies : k]
  }
}

output "policies_applied" {
  description = "Lista de policies aplicadas (workaround)"
  value       = [for k, v in null_resource.fabric_policies : k]
}