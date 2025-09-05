output "capacity" {
  description = "Output consolidado da capacity"
  value       = module.capacity.capacity
}

output "workspace" {
  description = "Output consolidado do workspace"
  value       = module.workspace.workspace
}

output "items" {
  description = "Output consolidado dos itens do workspace"
  value       = module.items.items
}

output "networking" {
  description = "Output consolidado de networking"
  value       = module.networking.networking
}

output "admin" {
  description = "Output consolidado de RBAC e policies"
  value       = module.admin.admin
}
