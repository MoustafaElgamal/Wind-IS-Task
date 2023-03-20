resource "oci_core_instance" "app_instance" {
    availability_domain = var.instance_availability_domain
    compartment_id = var.compartment_id
    shape = var.app_instance_shape
    display_name = var.app_instance_display_name

    source_details {
        source_id = lookup(data.oci_core_images.oracle_linux_last_ver.images[0], "id")
        source_type = "image"
    }

    metadata = {
     ssh_authorized_keys = file(var.path_local_public_key)
    }

    create_vnic_details {
      subnet_id = var.subnet_id
      assign_public_ip = true
    }
}

