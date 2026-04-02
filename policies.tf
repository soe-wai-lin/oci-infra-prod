
############################################################################
## policies for reserved public IPv4 address for different compartment   ###
############################################################################

resource "oci_identity_policy" "reserved-lb-ip-different-comp-policy" {
  # Attach at tenancy/root
  compartment_id = var.tenancy_ocid

  name        = "reserved-lb-ip-different-comp-policy"
  description = "policies for reserved public IPv4 address for different compartment"

  statements = [
    # Permissions in prod-app-comp (OKE cluster + node pools)
    "ALLOW any-user to read public-ips in tenancy where request.principal.type = 'cluster'",
    "ALLOW any-user to manage floating-ips in tenancy where request.principal.type = 'cluster'"
  ]
}

############################################
### policies for create network analyzer ###
############################################

resource "oci_identity_policy" "allow-manage-vn-analyzer" {
  # Attach at tenancy/root
  compartment_id = var.tenancy_ocid

  name        = "${var.vcn_display_name}-allow-manage-vn-analyzer"
  description = "policies for create network analyzer"

  statements = [
    "allow group Administrators to manage vn-path-analyzer-test in tenancy",
    "allow any-user to inspect compartments in tenancy where all { request.principal.type = 'vnpa-service' }",
    "allow any-user to read instances in tenancy where all { request.principal.type = 'vnpa-service' }",
    "allow any-user to read virtual-network-family in tenancy where all { request.principal.type = 'vnpa-service' }",
    "allow any-user to read load-balancers in tenancy where all { request.principal.type = 'vnpa-service' }",
    "allow any-user to read network-security-group in tenancy where all { request.principal.type = 'vnpa-service' }",
    "allow any-user to read zpr-family in tenancy where all { request.principal.type = 'vnpa-service' }",
  ]
}

########################################################################
### policies for createing OKE VNIC attached in different comparment ###
########################################################################

resource "oci_identity_policy" "allow-create-oke-vnic-in-different-comp" {
  # Attach at tenancy/root
  compartment_id = var.tenancy_ocid

  name        = "${var.vcn_display_name}-allow-create-oke-vnic-in-different-comp"
  description = "allow-create-oke-vnic-in-different-comp"

  statements = [
    "Allow any-user to manage instances in tenancy where all { request.principal.type = 'cluster' }",
    "Allow any-user to use private-ips in tenancy where all { request.principal.type = 'cluster' }",
    "Allow any-user to use network-security-groups in tenancy where all { request.principal.type = 'cluster' }",
  ]
}

# #########################################
# # IAM for Cluster Autoscaler (instance principal)
# #########################################
# resource "oci_identity_dynamic_group" "cluster_autoscaler" {
#   compartment_id = var.tenancy_ocid
#   name           = "${var.cluster_name}-ca-dg"
#   description    = "Dynamic group for OKE Cluster Autoscaler instances"
#   # Autoscaler runs on OKE nodes in prod-app-comp
#   matching_rule = "ALL {instance.compartment.id = '${oci_identity_compartment.app_compartment.id}'}"
# }

# resource "oci_identity_policy" "cluster_autoscaler" {
#   compartment_id = var.tenancy_ocid

#   # Change the name once if Terraform is trying to update an old wrongly-attached policy
#   name        = "${var.cluster_name}-ca-policy"
#   description = "allow worker nodes to manage node pools"

#   statements = [
#     "Allow dynamic-group ${oci_identity_dynamic_group.cluster_autoscaler.name} to manage cluster-node-pools in compartment id ${oci_identity_compartment.app_compartment.id}",
#     "Allow dynamic-group ${oci_identity_dynamic_group.cluster_autoscaler.name} to manage instance-family in compartment id ${oci_identity_compartment.app_compartment.id}",
#     "Allow dynamic-group ${oci_identity_dynamic_group.cluster_autoscaler.name} to use subnets in compartment id ${oci_identity_compartment.app_compartment.id}",
#     "Allow dynamic-group ${oci_identity_dynamic_group.cluster_autoscaler.name} to use vnics in compartment id ${oci_identity_compartment.app_compartment.id}",
#     "Allow dynamic-group ${oci_identity_dynamic_group.cluster_autoscaler.name} to inspect compartments in compartment id ${oci_identity_compartment.app_compartment.id}",

#     "Allow dynamic-group ${oci_identity_dynamic_group.cluster_autoscaler.name} to use subnets in compartment id ${oci_identity_compartment.net_compartment.id}",
#     "Allow dynamic-group ${oci_identity_dynamic_group.cluster_autoscaler.name} to read virtual-network-family in compartment id ${oci_identity_compartment.net_compartment.id}",
#     "Allow dynamic-group ${oci_identity_dynamic_group.cluster_autoscaler.name} to use vnics in compartment id ${oci_identity_compartment.net_compartment.id}",
#     "Allow dynamic-group ${oci_identity_dynamic_group.cluster_autoscaler.name} to inspect compartments in compartment id ${oci_identity_compartment.net_compartment.id}"
#   ]
# }

# resource "oci_identity_policy" "enable_access_node_pool" {
#   # Attach at tenancy/root
#   compartment_id = var.tenancy_ocid

#   name        = "${var.cluster_name}-enable-access-node-pool-policy"
#   description = "allow node pool management"

#   statements = [
#     # Permissions in prod-app-comp (OKE cluster + node pools)
#     "Allow any-user to manage cluster-node-pools in compartment id ${oci_identity_compartment.app_compartment.id} where ALL {request.principal.type='workload', request.principal.namespace='kube-system', request.principal.service_account='cluster-autoscaler', request.principal.cluster_id='${oci_containerengine_cluster.this.id}'}",
#     "Allow any-user to manage instance-family in compartment id ${oci_identity_compartment.app_compartment.id} where ALL {request.principal.type='workload', request.principal.namespace='kube-system', request.principal.service_account='cluster-autoscaler', request.principal.cluster_id='${oci_containerengine_cluster.this.id}'}",
#     "Allow any-user to inspect compartments in compartment id ${oci_identity_compartment.app_compartment.id} where ALL {request.principal.type='workload', request.principal.namespace='kube-system', request.principal.service_account='cluster-autoscaler', request.principal.cluster_id='${oci_containerengine_cluster.this.id}'}",
#     "Allow any-user to use subnets in compartment id ${oci_identity_compartment.app_compartment.id} where ALL {request.principal.type='workload', request.principal.namespace='kube-system', request.principal.service_account='cluster-autoscaler', request.principal.cluster_id='${oci_containerengine_cluster.this.id}'}",
#     "Allow any-user to use vnics in compartment id ${oci_identity_compartment.app_compartment.id} where ALL {request.principal.type='workload', request.principal.namespace='kube-system', request.principal.service_account='cluster-autoscaler', request.principal.cluster_id='${oci_containerengine_cluster.this.id}'}",

#     # Permissions in prod-net-comp (VCN, subnets, vnics, network metadata)
#     "Allow any-user to use subnets in compartment id ${oci_identity_compartment.net_compartment.id} where ALL {request.principal.type='workload', request.principal.namespace='kube-system', request.principal.service_account='cluster-autoscaler', request.principal.cluster_id='${oci_containerengine_cluster.this.id}'}",
#     "Allow any-user to read virtual-network-family in compartment id ${oci_identity_compartment.net_compartment.id} where ALL {request.principal.type='workload', request.principal.namespace='kube-system', request.principal.service_account='cluster-autoscaler', request.principal.cluster_id='${oci_containerengine_cluster.this.id}'}",
#     "Allow any-user to use vnics in compartment id ${oci_identity_compartment.net_compartment.id} where ALL {request.principal.type='workload', request.principal.namespace='kube-system', request.principal.service_account='cluster-autoscaler', request.principal.cluster_id='${oci_containerengine_cluster.this.id}'}",
#     "Allow any-user to inspect compartments in compartment id ${oci_identity_compartment.net_compartment.id} where ALL {request.principal.type='workload', request.principal.namespace='kube-system', request.principal.service_account='cluster-autoscaler', request.principal.cluster_id='${oci_containerengine_cluster.this.id}'}"
#   ]
# }

