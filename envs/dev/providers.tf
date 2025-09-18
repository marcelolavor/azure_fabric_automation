provider "azurerm" {
  features {}
  subscription_id = "e0c332c0-0db1-41ca-8455-27bb848a48c9"
}

provider "fabric" {
  # Configuração será herdada do ambiente (az login)
}