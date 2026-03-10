
resource "oci_psql_db_system" "postgresql" {
  compartment_id = oci_identity_compartment.db_compartment.id
  db_version     = var.db_version
  display_name   = var.db_display_name
  description    = var.description

  shape                       = var.shape
  instance_count              = var.instance_count
  instance_ocpu_count         = var.instance_ocpu_count
  instance_memory_size_in_gbs = var.instance_memory_size_in_gbs

  credentials {
    username = var.admin_username

    password_details {
      password_type = "PLAIN_TEXT"
      password      = var.admin_password
    }
  }

  network_details {
    subnet_id                  = oci_core_subnet.db_sub.id
    nsg_ids                    = [oci_core_network_security_group.nsg_prod_db.id]
    is_reader_endpoint_enabled = var.enable_reader_endpoint
  }

  storage_details {
    is_regionally_durable = var.storage_is_regionally_durable
    system_type           = var.storage_system_type

    # Required only when is_regionally_durable = false
    availability_domain = var.storage_is_regionally_durable ? null : var.availability_domain

    # Optional, useful for OCI optimized storage tiers
    # iops = var.storage_iops
  }

  freeform_tags = var.freeform_tags
}


