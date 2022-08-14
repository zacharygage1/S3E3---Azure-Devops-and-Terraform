provider "azurerm" {
    features {}
}

terraform {
  backend "azurerm" {
    resource_group_name = "tf_rg_blobstore"
    storage_account_name = "tfstoragezacharygage1"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.85.0"
    }
  }
}

resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "South Central US"
}

resource "azurerm_container_group" "tfcg_test" {
    name = "weatherapi"
    location = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name

    ip_address_type = "public"
    dns_name_label = "zacharyowa"
    os_type = "Linux"

    container {
        name = "weatherapi"
        image = "zacharygage1/weatherapi"
            cpu = "1"
            memory = "1"

            ports {
                port = 80
                protocol = "TCP"
            }
    }
}