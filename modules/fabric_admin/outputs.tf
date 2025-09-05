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
    policies = {
      for k, v in fabric_policy.workspace_policies :
      k => {
        id   = v.id
        name = v.name
      }
    }
  }
}
