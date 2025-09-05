resource "fabric_capacity" "this" {
  name     = var.name
  location = var.location
  sku_name = var.sku_name

  tags = var.tags

  lifecycle {
    prevent_destroy = var.prevent_destroy
  }
}