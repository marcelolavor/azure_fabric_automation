# Módulo fabric_items
# Este módulo cria os componentes principais do Microsoft Fabric
# (Lakehouses, Warehouses, Pipelines, Notebooks, Eventstreams, KQL Databases)
#
# Recursos estão separados em ficheiros específicos (*.tf).

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