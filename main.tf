provider "oci" {
  tenancy_ocid     = var.oci_tenancy
  user_ocid        = var.oci_user
  fingerprint      = var.oci_fingerprint
  private_key_path = var.oci_key
  region           = var.oci_region
}

module "myapp_server" {
  source = "./modules/compute"

  compartment_id               = oci_identity_compartment.dev_env.id
  instance_availability_domain = var.instance_availability_domain
  app_instance_shape           = var.app_instance_shape
  app_instance_display_name    = var.app_instance_display_name
  instance_os                  = var.instance_os
  linux_os_version             = var.linux_os_version
  os_shape                     = var.os_shape
  path_local_public_key        = var.path_local_public_key
  subnet_id                    = module.myapp_network.public_subnet_id
}

module "myapp_network" {
  source = "./modules/network"

  compartment_id                                  = oci_identity_compartment.dev_env.id
  vcn_cidr_block                                  = var.vcn_cidr_block
  app_vcn_name                                    = var.app_vcn_name
  public_route_table_route_rules_destination      = var.public_route_table_route_rules_destination
  public_route_table_route_rules_destination_type = var.public_route_table_route_rules_destination_type
  public_subnet_cidr_block                        = var.public_subnet_cidr_block
  public_subnet_display_name                      = var.public_subnet_display_name
  public_subnet_route_table_name                  = var.public_subnet_route_table_name
  IGW_name                                        = var.IGW_name
  public_subnet_sl_name                           = var.public_subnet_sl_name
  egress_sl_protocol                              = var.egress_sl_protocol
  egress_sl_destination                           = var.egress_sl_destination
  ingress_sl_source_all_cidr                      = var.ingress_sl_source_all_cidr
  ingress_sl_source_my_ip                         = var.ingress_sl_source_my_ip
}