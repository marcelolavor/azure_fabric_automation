output "capacity" {
  description = "Capacity criada (id e name)"
  value = {
    id   = fabric_capacity.this.id
    name = fabric_capacity.this.name
  }
}
