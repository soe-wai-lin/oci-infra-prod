
# # # #########################################
# # # # Data source: region availability domains
# # # # OCI notes that AD list ordering can change, so this module
# # # # allows you to override/pin AD names through a variable.
# # # #########################################
# # # data "oci_identity_availability_domains" "this" {
# # #   compartment_id = oci_identity_compartment.app_compartment.id
# # # }

# # # #########################################
# # # # Data source: system node pool options
# # # # Retrieves compatible shapes / image sources for the requested
# # # # Kubernetes version, OS type, and architecture.
# # # #########################################
# # # data "oci_containerengine_node_pool_option" "system" {
# # #   depends_on = [ oci_containerengine_cluster.this ]
# # #   node_pool_option_id     = oci_containerengine_cluster.this.id
# # #   compartment_id          = oci_identity_compartment.app_compartment.id
# # #   node_pool_k8s_version   = var.kubernetes_version
# # #   node_pool_os_type       = var.system_node_os_type
# # #   node_pool_os_arch       = var.system_node_os_arch
# # # }

# # # #########################################
# # # # Data source: worker node pool options
# # # # Retrieves compatible shapes / image sources for the requested
# # # # Kubernetes version, OS type, and architecture.
# # # #########################################
# # # data "oci_containerengine_node_pool_option" "worker" {
# # #   depends_on = [ oci_containerengine_cluster.this ]
# # #   node_pool_option_id     = oci_containerengine_cluster.this.id
# # #   compartment_id          = oci_identity_compartment.app_compartment.id
# # #   node_pool_k8s_version   = var.kubernetes_version
# # #   node_pool_os_type       = var.worker_node_os_type
# # #   node_pool_os_arch       = var.worker_node_os_arch
# # # }



# # # locals {
# # #   discovered_ad_names = sort([
# # #     for ad in data.oci_identity_availability_domains.this.availability_domains : ad.name
# # #   ])

# # #   ad_names = length(var.availability_domain_names) > 0 ? var.availability_domain_names : local.discovered_ad_names

# # #   auto_system_image_candidates = [
# # #     for s in data.oci_containerengine_node_pool_option.system.sources : s
# # #     if s.source_type == "IMAGE" && length(regexall(var.system_node_image_name_regex, s.source_name)) > 0
# # #   ]

# # #   auto_worker_image_candidates = [
# # #     for s in data.oci_containerengine_node_pool_option.worker.sources : s
# # #     if s.source_type == "IMAGE" && length(regexall(var.worker_node_image_name_regex, s.source_name)) > 0
# # #   ]

# # #   auto_system_image_id   = try(local.auto_system_image_candidates[0].image_id, null)
# # #   auto_system_image_name = try(local.auto_system_image_candidates[0].source_name, null)

# # #   auto_worker_image_id   = try(local.auto_worker_image_candidates[0].image_id, null)
# # #   auto_worker_image_name = try(local.auto_worker_image_candidates[0].source_name, null)

# # #   system_image_id   = var.system_node_image_id_override != null ? var.system_node_image_id_override : local.auto_system_image_id
# # #   system_image_name = local.auto_system_image_name

# # #   worker_image_id   = var.worker_node_image_id_override != null ? var.worker_node_image_id_override : local.auto_worker_image_id
# # #   worker_image_name = local.auto_worker_image_name
# # # }


# # # #########################################
# # # # Data source: validate system shape compatibility
# # # # Filters shapes by image_id + shape so we can validate that the
# # # # chosen shape is compatible with the selected OKE image.
# # # #########################################
# # # data "oci_core_shapes" "system" {
# # #   compartment_id = oci_identity_compartment.app_compartment.id
# # #   image_id       = local.system_image_id
# # #   shape          = var.system_node_shape
# # # }

# # # #########################################
# # # # Data source: validate worker shape compatibility
# # # #########################################
# # # data "oci_core_shapes" "worker" {
# # #   compartment_id = oci_identity_compartment.app_compartment.id
# # #   image_id       = local.worker_image_id
# # #   shape          = var.worker_node_shape
# # # }

# #########################################
# # Resource: OKE cluster
# # Creates an ENHANCED or BASIC OKE cluster with a PRIVATE API endpoint.
# #########################################
# resource "oci_containerengine_cluster" "this" {
#   compartment_id     = oci_identity_compartment.app_compartment.id
#   name               = var.cluster_name
#   kubernetes_version = var.kubernetes_version
#   vcn_id             = oci_core_vcn.terra_vcn.id
#   type               = var.cluster_type

#   freeform_tags = var.freeform_tags

#   # Private Kubernetes API endpoint
#   endpoint_config {
#     subnet_id            = oci_core_subnet.prod_k8s_priv_api_endpoint_sub.id
#     nsg_ids              = [oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id]
#     is_public_ip_enabled = false
#   }

#   # Cluster-wide pod networking mode
#   cluster_pod_network_options {
#     cni_type = var.cni_type
#   }

#   # Core cluster options
#   options {
#     ip_families = ["IPv4"]

#     kubernetes_network_config {
#       pods_cidr     = oci_core_subnet.web_worker_pod_sub.cidr_block
#       services_cidr = var.services_cidr
#     }

#     # These legacy add-ons are disabled for modern production setups.
#     add_ons {
#       is_kubernetes_dashboard_enabled = true
#       is_tiller_enabled               = false
#     }

#     # Optional attributes applied to dynamically created Kubernetes LBs and PVC backing resources.
#     service_lb_subnet_ids = [oci_core_subnet.lb_subnet.id]

#     service_lb_config {
#       freeform_tags = merge(var.freeform_tags, {
#         "oke-resource-type" = "service-lb"
#       })
#       defined_tags = var.defined_tags
#     }

#     persistent_volume_config {
#       freeform_tags = merge(var.freeform_tags, {
#         "oke-resource-type" = "persistent-volume"
#       })
#       defined_tags = var.defined_tags
#     }
#   }

#   timeouts {
#     create = "2h"
#     update = "2h"
#     delete = "2h"
#   }

#   # lifecycle {
#   #   precondition {
#   #     condition     = length(local.ad_names) > 0
#   #     error_message = "No availability domains were discovered. Set availability_domain_names explicitly."
#   #   }
#   # }
# }

# #########################################
# # Resource: system node pool
# # Intended for platform/system workloads.
# #########################################
# resource "oci_containerengine_node_pool" "system" {
#   cluster_id      = oci_containerengine_cluster.this.id
#   compartment_id  = oci_identity_compartment.app_compartment.id
#   name            = var.system_node_pool_name
#   kubernetes_version = var.kubernetes_version

#   node_shape = var.system_node_shape

#   freeform_tags = merge(var.freeform_tags, {
#     "oke-nodepool-role" = "system"
#   })
#   defined_tags = var.defined_tags


#   # Rolling replacement / safer maintenance behavior.
#   node_eviction_node_pool_settings {
#     eviction_grace_duration               = var.node_eviction_grace_duration
#     is_force_action_after_grace_duration  = var.node_force_action_after_grace_duration
#     is_force_delete_after_grace_duration  = var.node_force_delete_after_grace_duration
#   }

#   node_pool_cycling_details {
#     is_node_cycling_enabled = var.node_cycling_enabled
#     maximum_surge           = var.node_cycling_maximum_surge
#     maximum_unavailable     = var.node_cycling_maximum_unavailable
#   }

#   node_source_details {
#     image_id = var.node_image_id
#     source_type = "IMAGE"
#   }
#   node_shape_config {
#         memory_in_gbs = var.system_memory_in_gbs
#         ocpus = var.system_ocpus
#     }



#   # Node placement and network configuration.
#   node_config_details {
#     size         = var.system_node_count

#     # For regional subnets, OCI expects a placement config for each AD.
#     placement_configs {
#         availability_domain = var.system_availability_domain
#         subnet_id           = oci_core_subnet.web_worker_sub.id
#     }
#     nsg_ids = [oci_core_network_security_group.nsg_prod_web.id]




#     # Only required / rendered for OCI_VCN_IP_NATIVE pod networking.
#     node_pool_pod_network_option_details {
#         cni_type          = var.cni_type
#         max_pods_per_node = var.system_max_pods_per_node
#         pod_subnet_ids    = [oci_core_subnet.web_worker_pod_sub.id]
#         pod_nsg_ids = [oci_core_network_security_group.nsg_prod_web_pod.id]

#     }

#   }
# }

# #########################################
# # Resource: worker node pool
# # Intended for platform/worker workloads.
# #########################################

# resource "oci_containerengine_node_pool" "worker" {
#   cluster_id      = oci_containerengine_cluster.this.id
#   compartment_id  = oci_identity_compartment.app_compartment.id
#   name            = var.worker_node_pool_name
#   kubernetes_version = var.kubernetes_version

#   node_shape = var.worker_node_shape

#   freeform_tags = merge(var.freeform_tags, {
#     "oke-nodepool-role" = "worker"
#   })
#   defined_tags = var.defined_tags


#   # Rolling replacement / safer maintenance behavior.
#   node_eviction_node_pool_settings {
#     eviction_grace_duration               = var.node_eviction_grace_duration
#     is_force_action_after_grace_duration  = var.node_force_action_after_grace_duration
#     is_force_delete_after_grace_duration  = var.node_force_delete_after_grace_duration
#   }

#   node_pool_cycling_details {
#     is_node_cycling_enabled = var.node_cycling_enabled
#     maximum_surge           = var.node_cycling_maximum_surge
#     maximum_unavailable     = var.node_cycling_maximum_unavailable
#   }

#   node_source_details {
#     image_id = var.node_image_id
#     source_type = "IMAGE"
#   }
#   node_shape_config {
#         memory_in_gbs = var.worker_memory_in_gbs
#         ocpus = var.worker_ocpus
#     }



#   # Node placement and network configuration.
#   node_config_details {
#     size         = var.worker_node_count

#     # For regional subnets, OCI expects a placement config for each AD.
#     placement_configs {
#         availability_domain = var.worker_availability_domain
#         subnet_id           = oci_core_subnet.web_worker_sub.id
#     }
#     nsg_ids = [oci_core_network_security_group.nsg_prod_web.id]




#     # Only required / rendered for OCI_VCN_IP_NATIVE pod networking.
#     node_pool_pod_network_option_details {
#         cni_type          = var.cni_type
#         max_pods_per_node = var.worker_max_pods_per_node
#         pod_subnet_ids    = [oci_core_subnet.web_worker_pod_sub.id]
#         pod_nsg_ids = [oci_core_network_security_group.nsg_prod_web_pod.id]

#     }

#   }
# }

