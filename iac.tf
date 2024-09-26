terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.0.1"
    }
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  subscription_id = "250ae9c3-6c33-4030-b72a-ed22fce22920"
  features {    
  }
}

resource "azurerm_resource_group" "yuri-bot-t-group" {
  name = "yuri-bot-t-group"
  location = "eastus2"
}

resource "azurerm_service_plan" "yuri-bot-t-sp" {
    name = "yuri-bot-t-sp"
    resource_group_name = azurerm_resource_group.yuri-bot-t-group.name
    location = azurerm_resource_group.yuri-bot-t-group.location
    sku_name = "S1"
    os_type = "Windows"
}

resource "azurerm_windows_web_app" "yuri-bot-t-app" {
  name = "yuri-bot-t-app"
  resource_group_name = azurerm_resource_group.yuri-bot-t-group.name
  location = azurerm_resource_group.yuri-bot-t-group.location
  service_plan_id = azurerm_service_plan.yuri-bot-t-sp.id
  site_config {
    always_on = false
  }
}

resource "azurerm_windows_web_app_slot" "yuri-bot-t-app-QA" {
  name = "yuri-bot-t-app-QA"
  app_service_id = azurerm_windows_web_app.yuri-bot-t-app.id
  site_config {
  
    }
  }  