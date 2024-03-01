terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }

  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "func" {
  name     = "funcRG"
  location = "Germany West Central"
}

resource "azurerm_sql_server" "func" {
  name                         = "funcsqlserver"
  resource_group_name          = azurerm_resource_group.func.name
  location                     = azurerm_resource_group.func.location
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = "complexPassword!"
}

resource "azurerm_sql_database" "func" {
  name                = "funcsqldatabase"
  resource_group_name = azurerm_resource_group.func.name
  location            = azurerm_resource_group.func.location
  server_name         = azurerm_sql_server.func.name
  edition = "Free"
}

resource "azurerm_storage_account" "func" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  name                     = "bogdanfuncsa"
  resource_group_name      = azurerm_resource_group.func.name
  location                 = azurerm_resource_group.func.location
}