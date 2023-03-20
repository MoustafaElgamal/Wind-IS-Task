resource "oci_core_security_list" "public_subnet_security_list" {
  compartment_id = var.compartment_id
  display_name = var.public_subnet_sl_name
  vcn_id = oci_core_vcn.app_vcn.id

# Outbound Rules
    # Internet access to anywhere
  egress_security_rules {
    protocol = var.egress_sl_protocol
    destination = var.egress_sl_destination
  }

# Inbound Rules
    # HTTP access from anywhere
  ingress_security_rules {
    protocol = "80"
    source = var.ingress_sl_source_all_cidr
  }

    # HTTPS access from anywhere
    ingress_security_rules {
    protocol = "443"
    source = var.ingress_sl_source_all_cidr
  }

    # SSH access from my IP
    ingress_security_rules {
    protocol = "22"
    source = var.ingress_sl_source_my_ip
  }
}

resource "oci_core_route_table" "public_subnet_route_table" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.app_vcn.id
    display_name = var.public_subnet_route_table_name

    route_rules {
        destination = var.public_route_table_route_rules_destination
        destination_type = var.public_route_table_route_rules_destination_type
        network_entity_id = oci_core_internet_gateway.IGW.id
    }
}

resource "oci_core_subnet" "public_subnet" {
    cidr_block = var.public_subnet_cidr_block
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.app_vcn.id
    display_name = var.public_subnet_display_name
    route_table_id = oci_core_route_table.public_subnet_route_table.id
    security_list_ids = [oci_core_security_list.public_subnet_security_list.id]
}