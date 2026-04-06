
# resource "oci_psql_db_system" "postgresql" {
#   compartment_id = oci_identity_compartment.data_compartment.id
#   db_version     = var.db_version
#   display_name   = var.db_display_name
#   description    = var.description

#   shape                       = var.pg_db_shape
#   instance_count              = var.pg_db_instance_count
#   instance_ocpu_count         = var.pg_db_instance_ocpu_count
#   instance_memory_size_in_gbs = var.pg_db_instance_memory_size_in_gbs

#   credentials {
#     username = var.admin_username

#     password_details {
#       password_type = "PLAIN_TEXT"
#       password      = var.admin_password
#     #    password_type = "VAULT_SECRET"
#     #    secret_id = oci_vault_secret.secret.id
#     #    secret_version = oci_vault_secret.secret.current_version_number
#     }
#   }

#   network_details {
#     subnet_id                  = oci_core_subnet.db_sub.id
#     nsg_ids                    = [oci_core_network_security_group.nsg_prod_db.id]
#     is_reader_endpoint_enabled = var.pg_db_enable_reader_endpoint
#   }

#   storage_details {
#     is_regionally_durable = var.pg_db_storage_is_regionally_durable
#     system_type           = var.pg_db_storage_system_type

#     # Required only when is_regionally_durable = false
#     availability_domain = var.pg_db_storage_is_regionally_durable ? null : var.pg_db_availability_domain

#     # Optional, useful for OCI optimized storage tiers
#     # iops = var.storage_iops
#   }

#   freeform_tags = var.freeform_tags
# }


