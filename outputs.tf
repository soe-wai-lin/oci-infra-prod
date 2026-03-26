output "internet_gateway_id" {
  value = oci_core_internet_gateway.igw.id
}

output "nat_gateway_id" {
  value = oci_core_nat_gateway.nat.id
}

output "nat_gateway_reserved_ip" {
  value = oci_core_nat_gateway.nat.nat_ip
}

output "public_route_table_id" {
  value = oci_core_route_table.public_rt.id
}

output "private_route_table_id" {
  value = oci_core_route_table.private_rt.id
}

output "vcn_id" {
  value = oci_core_vcn.terra_vcn.id
}

output "net_compartment_id" {
  value       = oci_identity_compartment.net_compartment.id
  description = "net_compartment_id"
}

output "app_compartment_id" {
  value       = oci_identity_compartment.app_compartment.id
  description = "app_compartment_id"
}

output "db_compartment_id" {
  value       = oci_identity_compartment.data_compartment.id
  description = "db_compartment_id"
}

output "vcn_name" {
  value = oci_core_vcn.terra_vcn.display_name
}


##################
#### Database  ###
##################

# output "postgres_db_system_id" {
#   value = oci_psql_db_system.postgresql.id
# }

# output "postgres_db_system_state" {
#   value = oci_psql_db_system.postgresql.state
# }

# output "postgres_admin_username" {
#   value = oci_psql_db_system.postgresql.admin_username
# }

# output "alert_name" {
#   value = oci_ons_notification_topic.network_alert_topic.name
# }

# output "alert_mail" {
#   value = oci_ons_subscription.email_subscription.endpoint
# }


# ####################
# ### Redis        ###
# ####################

# output "redis_cluster_id" {
#   description = "OCID of the Redis cluster."
#   value       = oci_redis_redis_cluster.redis.id
# }

# output "redis_cluster_display_name" {
#   description = "Display name of the Redis cluster."
#   value       = data.oci_redis_redis_cluster.redis.display_name
# }

# output "redis_cluster_mode" {
#   description = "Redis cluster mode."
#   value       = data.oci_redis_redis_cluster.redis.cluster_mode
# }

# output "redis_primary_fqdn" {
#   description = "Primary node FQDN."
#   value       = try(data.oci_redis_redis_cluster.redis.primary_fqdn, null)
# }

# output "redis_primary_ip" {
#   description = "Primary node private IP."
#   value       = try(data.oci_redis_redis_cluster.redis.primary_endpoint_ip_address, null)
# }

# output "redis_discovery_fqdn" {
#   description = "Discovery FQDN for sharded clusters."
#   value       = try(data.oci_redis_redis_cluster.redis.discovery_fqdn, null)
# }

# output "redis_discovery_ip" {
#   description = "Discovery IP for sharded clusters."
#   value       = try(data.oci_redis_redis_cluster.redis.discovery_endpoint_ip_address, null)
# }

# output "redis_node_endpoints" {
#   description = "List of per-node private endpoints."
#   value = [
#     for node in try(data.oci_redis_redis_cluster.redis.node_collection[0].items, []) : {
#       display_name                = try(node.display_name, null)
#       private_endpoint_fqdn       = try(node.private_endpoint_fqdn, null)
#       private_endpoint_ip_address = try(node.private_endpoint_ip_address, null)
#     }
#   ]
# }


# ##################
# ##  Bucket      ##
# ##################

# output "namespace" {
#   description = "Object Storage namespace used for the bucket."
#   value       = data.oci_objectstorage_namespace.ns.namespace
# }

# output "bucket_name" {
#   description = "Bucket name."
#   value       = oci_objectstorage_bucket.bucket.name
# }

# output "bucket_id" {
#   description = "Bucket identifier returned by OCI."
#   value       = data.oci_objectstorage_bucket.bucket.bucket_id
# }

# output "bucket_access_type" {
#   description = "Configured public access type."
#   value       = data.oci_objectstorage_bucket.bucket.access_type
# }

# output "bucket_storage_tier" {
#   description = "Configured storage tier."
#   value       = data.oci_objectstorage_bucket.bucket.storage_tier
# }

# output "bucket_versioning" {
#   description = "Bucket versioning status."
#   value       = data.oci_objectstorage_bucket.bucket.versioning
# }

# output "bucket_approximate_size" {
#   description = "Approximate total size in bytes of all objects in the bucket."
#   value       = data.oci_objectstorage_bucket.bucket.approximate_size
# }

##############
### Vault  ###
##############

# output "vault_id" {
#   description = "OCID of the OCI KMS vault."
#   value       = oci_kms_vault.vault.id
# }

# output "vault_name" {
#   description = "Display name of the vault."
#   value       = data.oci_kms_vault.vault.display_name
# }

# output "management_endpoint" {
#   description = "KMS management endpoint for key and vault management operations."
#   value       = data.oci_kms_vault.vault.management_endpoint
# }

# output "crypto_endpoint" {
#   description = "KMS crypto endpoint for encrypt/decrypt operations."
#   value       = data.oci_kms_vault.vault.crypto_endpoint
# }

# output "is_primary" {
#   description = "Whether this vault is the primary vault."
#   value       = data.oci_kms_vault.vault.is_primary
# }


# output "auto_key_rotation" {
#   value = try({
#     last_rotation_message     = data.oci_kms_key.secret_key.auto_key_rotation_details[0].last_rotation_message
#     last_rotation_status      = data.oci_kms_key.secret_key.auto_key_rotation_details[0].last_rotation_status
#     rotation_interval_in_days = data.oci_kms_key.secret_key.auto_key_rotation_details[0].rotation_interval_in_days
#     time_of_last_rotation     = data.oci_kms_key.secret_key.auto_key_rotation_details[0].time_of_last_rotation
#     time_of_next_rotation     = data.oci_kms_key.secret_key.auto_key_rotation_details[0].time_of_next_rotation
#     time_of_schedule_start    = data.oci_kms_key.secret_key.auto_key_rotation_details[0].time_of_schedule_start
#   }, null)
# }

##################################
###### Network Path Analyzer   ###
##################################


output "web_to_db_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.web_to_db_subnet_connectivity.id
}

output "cms_to_db_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.cms_to_db_subnet_connectivity.id
}

output "airs_to_db_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.airs_to_db_subnet_connectivity.id
}

output "web_pod_to_db_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.web_pod_to_db_subnet_connectivity.id
}

output "cms_pod_to_db_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.cms_pod_to_db_subnet_connectivity.id
}

output "airs_pod_to_db_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.airs_pod_to_db_subnet_connectivity.id
}

output "web_to_cms_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.web_to_cms_subnet_connectivity.id
}

output "cms_to_web_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.cms_to_web_subnet_connectivity.id
}

output "web_to_redis_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.web_to_redis_subnet_connectivity.id
}

output "web_pod_to_redis_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.web_pod_to_redis_subnet_connectivity.id
}

output "cms_to_redis_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.cms_to_redis_subnet_connectivity.id
}

output "cms_pod_to_redis_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.cms_pod_to_redis_subnet_connectivity.id
}

output "airs_to_redis_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.airs_to_redis_subnet_connectivity.id
}

output "airs_pod_to_redis_npa_test_id" {
  value = oci_vn_monitoring_path_analyzer_test.airs_pod_to_redis_subnet_connectivity.id
}




# ###################
# #### Bastion   ####
# ###################

# output "bastion_instance_id" {
#   description = "OCID of the bastion host compute instance."
#   value       = oci_core_instance.bastion.id
# }

# output "bastion_public_ip" {
#   description = "Public IP address of the bastion host."
#   value       = data.oci_core_vnic.bastion_primary_vnic.public_ip_address
# }

# output "bastion_private_ip" {
#   description = "Private IP address of the bastion host."
#   value       = data.oci_core_vnic.bastion_primary_vnic.private_ip_address
# }

# output "bastion_ssh_example" {
#   description = "Example SSH command for the bastion host."
#   value       = "ssh opc@${data.oci_core_vnic.bastion_primary_vnic.public_ip_address}"
# }

# output "oke_cluster_id" {
#   description = "OCID of the OKE cluster."
#   value       = oci_containerengine_cluster.oke_cluster.id
# }

# output "oke_private_endpoint" {
#   description = "Private Kubernetes API endpoint for the OKE cluster."
#   value       = try(oci_containerengine_cluster.oke_cluster.endpoints[0].private_endpoint, null)
# }

# output "oke_public_endpoint" {
#   description = "Public Kubernetes API endpoint for the OKE cluster, if enabled."
#   value       = try(oci_containerengine_cluster.oke_cluster.endpoints[0].public_endpoint, null)
# }

# output "oke_vcn_hostname_endpoint" {
#   description = "VCN hostname endpoint for the private Kubernetes API endpoint, if available."
#   value       = try(oci_containerengine_cluster.oke_cluster.endpoints[0].vcn_hostname_endpoint, null)
# }

# output "system_node_pool_id" {
#   description = "OCID of the system node pool."
#   value       = oci_containerengine_node_pool.system_pool.id
# }

# output "app_node_pool_id" {
#   description = "OCID of the application node pool."
#   value       = oci_containerengine_node_pool.app_pool.id
# }

# output "create_kubeconfig_private_endpoint_command" {
#   description = "Example command to build a kubeconfig on the bastion host using the private OKE endpoint."
#   value       = "oci ce cluster create-kubeconfig --cluster-id ${oci_containerengine_cluster.oke_cluster.id} --file $HOME/.kube/config --region ${var.region} --token-version 2.0.0 --kube-endpoint PRIVATE_ENDPOINT"
# }

#################
###    OKE    ###
#################

output "system_pool_shape" {
  value = var.system_node_shape
}

# output "system_pool_shape_arch" {
#   value = local.system_node_shape_arch
# }

# output "system_pool_selected_source_name" {
#   value = local.oke_selected_source_name
# }

# output "system_pool_selected_image_id" {
#   value = local.oke_selected_image_ocid
# }




