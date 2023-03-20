output "vcn_id" {
  value = oci_core_vcn.app_vcn.id
}

output "public_subnet_id" {
  value = oci_core_subnet.public_subnet.id
}