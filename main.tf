provider "azurerm" {
    features {}
}

terraform {
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