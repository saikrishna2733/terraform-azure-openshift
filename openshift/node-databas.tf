module "node_databas" {
  source = "modules/node"

  name                  = "node-databas"
  count                 = var.openshift_node_databas_count
  expose_node           = true
  enable_scaling        = true
  size                  = var.openshift_node_databas_vm_size
  azure_location        = var.azure_location
  resource_group_name   = azurerm_resource_group.openshift.name
  storage_account_name  = azurerm_storage_account.openshift.name
  network_name          = azurerm_virtual_network.openshift.name
  subnet_address_prefix = "10.0.4.0/24"
  key_data              = "${file("${path.module}/../keys/openshift.pub")}"
  os_image_publisher    = var.openshift_os_image_publisher
  os_image_offer        = var.openshift_os_image_offer
  os_image_sku          = var.openshift_os_image_sku
  os_image_version      = var.openshift_os_image_version
  admin_username        = var.openshift_vm_admin_user
  platform_name         = var.platform_name
  rules = [
    {
      protocol      = "tcp"
      frontend_port = 80
      backend_port  = 80
      priority      = 100
      access        = "Allow"
      direction     = "Inbound"
    },
    {
      protocol      = "tcp"
      frontend_port = 443
      backend_port  = 443
      priority      = 200
      access        = "Allow"
      direction     = "Inbound"
    },
  ]
}
