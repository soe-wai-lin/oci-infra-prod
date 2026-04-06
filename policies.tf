
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



