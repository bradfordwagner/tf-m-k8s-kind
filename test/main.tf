
module "test_module" {
  source              = "../"
  name                = var.name
  extra_port_mappings = var.extra_port_mappings
}