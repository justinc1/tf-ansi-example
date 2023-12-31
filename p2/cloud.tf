terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.30.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

variable "cloud_terraform_integration_id" {
  type = string
#  default = "jcvnet"
}

variable "cloud_terraform_integration_resource_group" {
  type = string
#  default = "jcrg"
}

variable "cloud_terraform_integration_location" {
  type = string
  default = "westeurope"
}

resource "azurerm_resource_group" "jcrg" {
  name                = var.cloud_terraform_integration_resource_group
  location            = var.cloud_terraform_integration_location
  tags = {
    desc = "jc-test"
    cloud_terraform_integration    = "true"
    cloud_terraform_integration_id = var.cloud_terraform_integration_id
  }
}

resource "azurerm_virtual_network" "test_vnet" {
  # ansible uses names as identifiers, so this must be generated
  name                = var.cloud_terraform_integration_id
  resource_group_name = var.cloud_terraform_integration_resource_group
  location            = var.cloud_terraform_integration_location
  address_space       = ["10.11.12.0/24"]
  tags = {
    desc = "jc-test"
    cloud_terraform_integration    = "true"
    cloud_terraform_integration_id = var.cloud_terraform_integration_id
  }
}
