output "server_public_ip" {
  value = oci_core_instance.app_instance.public_ip
}