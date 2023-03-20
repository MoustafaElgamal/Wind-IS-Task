data "oci_core_images" "oracle_linux_last_ver" {
  compartment_id = var.compartment_id
  operating_system = var.instance_os
  operating_system_version = var.linux_os_version
  shape = var.os_shape

  filter {
    name = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex = true
  }
}
