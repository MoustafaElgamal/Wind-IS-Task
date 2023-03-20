resource "oci_identity_compartment" "dev_env" {
  compartment_id = var.compartment_id
  description    = var.compartment_description
  name           = var.compartment_name
}