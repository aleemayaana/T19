resource "azurerm_resource_group" "rg" {
  name     = "aks_rg"
  location = "West US"
}

resource "azurerm_container_registry" "acr" {
  name                = "nextopsacr19"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Premium"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "nextopsaks19"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "nextops"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D2_v2"
    auto_scaling_enabled = true
  }

  network_profile {
    network_plugin = "azure"
    network_plugin_mode = "overlay" 
    pod_cidr = "10.10.0.0/16"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}