resource "oci_core_internet_gateway" "IGW" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.app_vcn.id
    display_name = var.IGW_name
}
