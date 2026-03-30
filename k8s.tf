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

#     add_ons {
#       is_kubernetes_dashboard_enabled = true
#       is_tiller_enabled               = false
#     }

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
# }

# #########################################
# # Data source: OKE node pool options
# # Supported shapes, k8s versions, and image sources for node pools.
# # Use "all" so Terraform can evaluate at plan time.
# #########################################
# data "oci_containerengine_node_pool_option" "all_options" {
#   node_pool_option_id = "all"
#   compartment_id      = oci_identity_compartment.app_compartment.id
# }

# #########################################
# # Locals: image selection for system + worker
# #########################################
# locals {
#   system_k8s_version = replace(var.kubernetes_version, "v", "")
#   worker_k8s_version = replace(var.kubernetes_version, "v", "")

#   # -----------------------------
#   # SYSTEM image selection
#   # -----------------------------
#   # Pick OKE Oracle Linux images matching the requested k8s version.
#   # Exclude Arm and GPU images.
#   system_candidate_source_map = {
#     for s in data.oci_containerengine_node_pool_option.all_options.sources :
#     s.source_name => s
#     if s.source_type == "IMAGE"
#       && can(regex("^Oracle-Linux", s.source_name))
#       && can(regex("-OKE-${local.system_k8s_version}-", s.source_name))
#       && !can(regex("aarch64", lower(s.source_name)))
#       && !can(regex("gpu", lower(s.source_name)))
#   }

#   system_candidate_source_names = reverse(sort(keys(local.system_candidate_source_map)))

#   system_node_image_id = (
#     length(local.system_candidate_source_names) > 0
#     ? local.system_candidate_source_map[local.system_candidate_source_names[0]].image_id
#     : null
#   )

#   # -----------------------------
#   # WORKER image selection
#   # -----------------------------
#   worker_candidate_source_map = {
#     for s in data.oci_containerengine_node_pool_option.all_options.sources :
#     s.source_name => s
#     if s.source_type == "IMAGE"
#       && can(regex("^Oracle-Linux", s.source_name))
#       && can(regex("-OKE-${local.worker_k8s_version}-", s.source_name))
#       && !can(regex("aarch64", lower(s.source_name)))
#       && !can(regex("gpu", lower(s.source_name)))
#   }

#   worker_candidate_source_names = reverse(sort(keys(local.worker_candidate_source_map)))

#   worker_node_image_id = (
#     length(local.worker_candidate_source_names) > 0
#     ? local.worker_candidate_source_map[local.worker_candidate_source_names[0]].image_id
#     : null
#   )
# }

# #########################################
# # Resource: system node pool
# # Intended for platform/system workloads.
# #########################################
# resource "oci_containerengine_node_pool" "system" {
#   cluster_id         = oci_containerengine_cluster.this.id
#   compartment_id     = oci_identity_compartment.app_compartment.id
#   name               = var.system_node_pool_name
#   kubernetes_version = var.kubernetes_version

#   node_shape = var.system_node_shape

#   freeform_tags = merge(var.freeform_tags, {
#     "oke-nodepool-role" = "system"
#   })
#   defined_tags = var.defined_tags

#   # Rolling replacement / safer maintenance behavior.
#   node_eviction_node_pool_settings {
#     eviction_grace_duration              = var.node_eviction_grace_duration
#     is_force_action_after_grace_duration = var.node_force_action_after_grace_duration
#     is_force_delete_after_grace_duration = var.node_force_delete_after_grace_duration
#   }

#   node_pool_cycling_details {
#     is_node_cycling_enabled = var.node_cycling_enabled
#     maximum_surge           = var.node_cycling_maximum_surge
#     maximum_unavailable     = var.node_cycling_maximum_unavailable
#   }

#   node_source_details {
#     image_id    = local.system_node_image_id
#     source_type = "IMAGE"
#   }

#   node_shape_config {
#     memory_in_gbs = var.system_memory_in_gbs
#     ocpus         = var.system_ocpus
#   }

#   # Node placement and network configuration.
#   node_config_details {
#     size = var.system_node_count

#     placement_configs {
#       availability_domain = var.system_availability_domain
#       subnet_id           = oci_core_subnet.web_worker_sub.id
#     }

#     nsg_ids = [oci_core_network_security_group.nsg_prod_web.id]

#     node_pool_pod_network_option_details {
#       cni_type          = var.cni_type
#       max_pods_per_node = var.system_max_pods_per_node
#       pod_subnet_ids    = [oci_core_subnet.web_worker_pod_sub.id]
#       pod_nsg_ids       = [oci_core_network_security_group.nsg_prod_web_pod.id]
#     }
#   }

#   ssh_public_key = var.oke_ssh_public_key

#   lifecycle {
#     precondition {
#       condition     = contains(data.oci_containerengine_node_pool_option.all_options.shapes, var.system_node_shape)
#       error_message = "The requested system_node_shape is not listed as a supported OKE node-pool shape in this tenancy/region."
#     }

#     precondition {
#       condition     = local.system_node_image_id != null
#       error_message = "No compatible OKE image was found in node-pool-options for the requested Kubernetes version."
#     }
#   }
# }

# #########################################
# # Resource: worker node pool
# # Intended for platform/worker workloads.
# #########################################
# resource "oci_containerengine_node_pool" "worker" {
#   cluster_id         = oci_containerengine_cluster.this.id
#   compartment_id     = oci_identity_compartment.app_compartment.id
#   name               = var.worker_node_pool_name
#   kubernetes_version = var.kubernetes_version

#   node_shape = var.worker_node_shape

#   freeform_tags = merge(var.freeform_tags, {
#     "oke-nodepool-role" = "worker"
#   })
#   defined_tags = var.defined_tags

#   # Rolling replacement / safer maintenance behavior.
#   node_eviction_node_pool_settings {
#     eviction_grace_duration              = var.node_eviction_grace_duration
#     is_force_action_after_grace_duration = var.node_force_action_after_grace_duration
#     is_force_delete_after_grace_duration = var.node_force_delete_after_grace_duration
#   }

#   node_pool_cycling_details {
#     is_node_cycling_enabled = var.node_cycling_enabled
#     maximum_surge           = var.node_cycling_maximum_surge
#     maximum_unavailable     = var.node_cycling_maximum_unavailable
#   }

#   node_source_details {
#     image_id    = local.worker_node_image_id
#     source_type = "IMAGE"
#   }

#   node_shape_config {
#     memory_in_gbs = var.worker_memory_in_gbs
#     ocpus         = var.worker_ocpus
#   }

#   # Node placement and network configuration.
#   node_config_details {
#     size = var.worker_node_count

#     placement_configs {
#       availability_domain = var.worker_availability_domain
#       subnet_id           = oci_core_subnet.web_worker_sub.id
#     }

#     nsg_ids = [oci_core_network_security_group.nsg_prod_web.id]

#     node_pool_pod_network_option_details {
#       cni_type          = var.cni_type
#       max_pods_per_node = var.worker_max_pods_per_node
#       pod_subnet_ids    = [oci_core_subnet.web_worker_pod_sub.id]
#       pod_nsg_ids       = [oci_core_network_security_group.nsg_prod_web_pod.id]
#     }
#   }

#   ssh_public_key = var.oke_ssh_public_key

#   lifecycle {
#     precondition {
#       condition     = contains(data.oci_containerengine_node_pool_option.all_options.shapes, var.worker_node_shape)
#       error_message = "The requested worker_node_shape is not listed as a supported OKE node-pool shape in this tenancy/region."
#     }

#     precondition {
#       condition     = local.worker_node_image_id != null
#       error_message = "No compatible OKE image was found in node-pool-options for the requested Kubernetes version."
#     }
#   }
# }



