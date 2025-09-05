module "tags" {
  source      = "./tags"
  environment = var.environment
}

module "capacity" {
  source   = "../modules/fabric_capacity"
  name     = "cap-su-global"
  sku_name = "F16"
  location = "westeurope"
  tags     = module.tags.tags   # <-- Agora usando o módulo tags
}
