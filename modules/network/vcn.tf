resource "oci_core_vcn" "app_vcn" {
    compartment_id = var.compartment_id
    cidr_block = var.vcn_cidr_block
    display_name = var.app_vcn_name
}