# fabric_admin/main.tf
# Este ficheiro pode ficar vazio ou só com comentários,
# porque a lógica real está separada em rbac.tf e policies.tf

terraform {
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      # version constraint opcional aqui; pode herdar do root
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}