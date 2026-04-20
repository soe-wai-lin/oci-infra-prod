resource "oci_core_vcn" "terra_vcn" {
  #Required
  depends_on     = [oci_identity_compartment.net_compartment]
  compartment_id = oci_identity_compartment.net_compartment.id

  cidr_blocks   = var.vcn_cidr_block
  display_name  = var.vcn_display_name
  freeform_tags = var.freeform_tags
  dns_label     = var.vcn_dns_label
}

resource "oci_core_subnet" "lb_subnet" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id

  #Optional
  cidr_block    = var.lb_subnet_cidr
  display_name  = "${var.vcn_display_name}-lb-sub"
  freeform_tags = var.freeform_tags
  dns_label     = "publb"

  # Public subnet behavior
  prohibit_public_ip_on_vnic = false
  security_list_ids = [
    oci_core_security_list.pub_lb_SL.id
  ]
  route_table_id = oci_core_route_table.public_rt.id

}

resource "oci_core_subnet" "cms_worker_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id

  #Optional
  cidr_block        = var.cms_worker_sub_cidr
  display_name      = "${var.vcn_display_name}-cms-worker-sub"
  security_list_ids = [oci_core_security_list.cms_SL.id]
  freeform_tags     = var.freeform_tags
  dns_label         = "cmsworker"

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id             = oci_core_route_table.cms-workernodes-rt.id
  route_table_id             = oci_core_route_table.private_rt.id

}

resource "oci_core_subnet" "web_worker_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  dns_label      = "webworker"

  #Optional
  cidr_block   = var.web_worker_sub_cidr
  display_name = "${var.vcn_display_name}-web-worker-sub"
  security_list_ids = [oci_core_security_list.web_SL.id]
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id             = oci_core_route_table.web-workernodes-rt.id
  route_table_id             = oci_core_route_table.private_rt.id

}

resource "oci_core_subnet" "airs_micro_oke_worker_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  dns_label = "airsworker"

  #Optional
  cidr_block    = var.airs_micro_oke_worker_cidr_block
  display_name  = "${var.vcn_display_name}-airs-micro-worker-sub"
  security_list_ids = [oci_core_security_list.airs_worker_SL.id]
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id             = oci_core_route_table.airs-workernodes-rt.id
  route_table_id             = oci_core_route_table.private_rt.id
}
resource "oci_core_subnet" "airs_micro_oke_pod_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  dns_label = "airspod"

  #Optional
  cidr_block    = var.airs_micro_oke_pod_cidr_block
  display_name  = "${var.vcn_display_name}-airs-micro-pod-sub"
  security_list_ids = [oci_core_security_list.airs_worker_pod_SL.id]
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id             = oci_core_route_table.routetable_airs_pods.id
  route_table_id             = oci_core_route_table.private_rt.id
}

resource "oci_core_subnet" "apisix_oke_worker_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  dns_label = "apisixworker"

  #Optional
  cidr_block    = var.apisix_oke_worker_cidr_block
  display_name  = "${var.vcn_display_name}-apisix-worker-sub"
  security_list_ids = [oci_core_security_list.apisix_worker_SL.id]
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id             = oci_core_route_table.airs-workernodes-rt.id
  route_table_id             = oci_core_route_table.private_rt.id
}
resource "oci_core_subnet" "apisix_oke_pod_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  dns_label = "apisixpod"

  #Optional
  cidr_block    = var.apisix_oke_pod_cidr_block
  display_name  = "${var.vcn_display_name}-apisix-pod-sub"
  security_list_ids = [oci_core_security_list.apisix_worker_pod_SL.id]
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id             = oci_core_route_table.routetable_airs_pods.id
  route_table_id             = oci_core_route_table.private_rt.id
}

resource "oci_core_subnet" "authentik_oke_worker_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  dns_label = "authentikworker"

  #Optional
  cidr_block    = var.authentik_oke_worker_cidr_block
  display_name  = "${var.vcn_display_name}-authentik-worker-sub"
  security_list_ids = [oci_core_security_list.authentik_worker_SL.id]
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id             = oci_core_route_table.airs-workernodes-rt.id
  route_table_id             = oci_core_route_table.private_rt.id
}
resource "oci_core_subnet" "authentik_oke_pod_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  dns_label = "authentikpod"

  #Optional
  cidr_block    = var.authentik_oke_pod_cidr_block
  display_name  = "${var.vcn_display_name}-authentik-pod-sub"
  security_list_ids = [oci_core_security_list.authentik_worker_pod_SL.id]
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id             = oci_core_route_table.routetable_airs_pods.id
  route_table_id             = oci_core_route_table.private_rt.id
}

# resource "oci_core_subnet" "career_vm_sub" {
#   #Required
#   compartment_id = oci_identity_compartment.net_compartment.id
#   vcn_id         = oci_core_vcn.terra_vcn.id
#   dns_label = "career"

#   #Optional
#   cidr_block    = var.carrer_vm_cidr_block
#   display_name  = "${var.vcn_display_name}-career-vm-sub"
#   # security_list_ids = [oci_core_security_list.career_SL.id]
#   freeform_tags = var.freeform_tags

#   # Public subnet behavior
#   prohibit_public_ip_on_vnic = false
#   route_table_id             = oci_core_route_table.public_rt.id
# }

resource "oci_core_subnet" "db_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  dns_label      = "db"
  security_list_ids = [
    oci_core_security_list.redis_SL.id,
    oci_core_security_list.db_SL.id
  ]

  #Optional
  cidr_block    = var.db_cidr_block
  display_name  = "${var.vcn_display_name}-db-sub"
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id = oci_core_route_table.private_rt.id
}

# resource "oci_core_subnet" "pub_api_gw_sub" {
#   #Required
#   compartment_id = oci_identity_compartment.net_compartment.id
#   vcn_id         = oci_core_vcn.terra_vcn.id
#   dns_label = "pubapigw"

#   #Optional
#   cidr_block    = var.pub_api_gw_cidr_block
#   display_name  = "${var.vcn_display_name}-pub-api-gw-sub"
#   # security_list_ids = [oci_core_security_list.api_gw_SL.id]
#   freeform_tags = var.freeform_tags

#   # Public subnet behavior
#   prohibit_public_ip_on_vnic = true
#   route_table_id             = oci_core_route_table.public_rt.id
# }

resource "oci_core_subnet" "priv_lb_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  dns_label = "privlb"

  #Optional
  cidr_block    = var.priv_lb_cidr_block
  display_name  = "${var.vcn_display_name}-priv-lb-sub"
  security_list_ids = [oci_core_security_list.priv_lb_SL.id]
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  route_table_id = oci_core_route_table.private_rt.id
}

resource "oci_core_subnet" "web_worker_pod_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  dns_label      = "webworkerpod"

  #Optional
  cidr_block   = var.web_worker_pod_cidr_block
  display_name = "${var.vcn_display_name}-web-pod-sub"
  security_list_ids = [oci_core_security_list.web_worker_pod_SL.id]
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id             = oci_core_route_table.routetable_web_pods.id
  route_table_id             = oci_core_route_table.private_rt.id
}

resource "oci_core_subnet" "cms_worker_pod_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  dns_label = "cmsworkerpod"

  #Optional
  cidr_block    = var.cms_worker_pod_cidr_block
  display_name  = "${var.vcn_display_name}-cms-pod-sub"
  security_list_ids = [oci_core_security_list.cms_worker_pod_SL.id]
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id = oci_core_route_table.routetable_cms_pods.id
  route_table_id             = oci_core_route_table.private_rt.id
}


resource "oci_core_subnet" "prod_k8s_priv_api_endpoint_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  dns_label      = "privapi"

  #Optional
  cidr_block   = var.k8s_priv_api_endpoint_cidr_block
  display_name = "${var.vcn_display_name}-k8s_priv_api_endpoint_sub"
  security_list_ids = [oci_core_security_list.prod_k8s_priv_api_endpoint_SL.id]
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id             = oci_core_route_table.KubernetesAPIendpoint.id
  route_table_id             = oci_core_route_table.private_rt.id
}




############################
## Creating Security List ## 
############################

resource "oci_core_security_list" "redis_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-redis-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = var.db_cidr_block
  #   source_type = "CIDR_BLOCK"
  #   description = "allow 6379 from db subnet"
  #   tcp_options {
  #     min = 6379
  #     max = 6379
  #   }
  # }
  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = var.cms_worker_sub_cidr
  #   source_type = "CIDR_BLOCK"
  #   description = "allow 6379 from cms subnet"
  #   tcp_options {
  #     min = 6379
  #     max = 6379
  #   }
  # }
  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = var.cms_worker_pod_cidr_block
  #   source_type = "CIDR_BLOCK"
  #   description = "allow 6379 from cms pod subnet"
  #   tcp_options {
  #     min = 6379
  #     max = 6379
  #   }
  # }
  #  ingress_security_rules {
  #   protocol    = "6"
  #   source      = var.web_worker_sub_cidr
  #   source_type = "CIDR_BLOCK"
  #   description = "allow 6379 from web subnet"
  #   tcp_options {
  #     min = 6379
  #     max = 6379
  #   }
  # }
  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = var.web_worker_pod_cidr_block
  #   source_type = "CIDR_BLOCK"
  #   description = "allow 6379 from web pod subnet"
  #   tcp_options {
  #     min = 6379
  #     max = 6379
  #   }
  # }
  #  ingress_security_rules {
  #   protocol    = "6"
  #   source      = var.airs_micro_oke_worker_cidr_block
  #   source_type = "CIDR_BLOCK"
  #   description = "allow 6379 from airs subnet"
  #   tcp_options {
  #     min = 6379
  #     max = 6379
  #   }
  # }
  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = var.airs_micro_oke_pod_cidr_block
  #   source_type = "CIDR_BLOCK"
  #   description = "allow 6379 from airs pod subnet"
  #   tcp_options {
  #     min = 6379
  #     max = 6379
  #   }
  # }

  # egress_security_rules {
  #   protocol    = "6"
  #   destination = var.db_cidr_block
  #   destination_type = "CIDR_BLOCK"
  #   description = "Allow to db egress"
  # }
  # egress_security_rules {
  #   protocol    = "6"
  #   destination = var.cms_worker_sub_cidr
  #   destination_type = "CIDR_BLOCK"
  #   description = "Allow to cms egress"
  # }
  # egress_security_rules {
  #   protocol    = "6"
  #   destination = var.web_worker_sub_cidr
  #   destination_type = "CIDR_BLOCK"
  #   description = "Allow to web egress"
  # }
  # egress_security_rules {
  #   protocol    = "6"
  #   destination = var.airs_micro_oke_worker_cidr_block
  #   destination_type = "CIDR_BLOCK"
  #   description = "Allow to airs egress"
  # }
  # egress_security_rules {
  #   protocol    = "6"
  #   destination = var.web_worker_pod_cidr_block
  #   destination_type = "CIDR_BLOCK"
  #   description = "Allow to web pod egress"
  # }
  # egress_security_rules {
  #   protocol    = "6"
  #   destination = var.cms_worker_pod_cidr_block
  #   destination_type = "CIDR_BLOCK"
  #   description = "Allow to cms pod egress"
  # }
  #   egress_security_rules {
  #   protocol    = "6"
  #   destination = var.airs_micro_oke_pod_cidr_block
  #   destination_type = "CIDR_BLOCK"
  #   description = "Allow to air pod egress"
  # }


  freeform_tags = var.freeform_tags

}

resource "oci_core_security_list" "web_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-web-worker-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   # source      = "10.10.16.0/20"
  #   source = var.cms_worker_sub_cidr
  #   description = "allow all cms to web"
  # }
  #   ingress_security_rules {
  #   protocol    = "6"
  #   # source      = "10.10.80.0/24"
  #   source = var.db_cidr_block
  #   description = "allow all db to web"
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.0.0/24"
  #   description = "Allow load balancer to communicate with kube-proxy on worker nodes"
  #   tcp_options {
  #     max = 10256
  #     min = 10256
  #   }
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.60.0/24"
  #   description = "Allow Kubernetes API endpoint to communicate with worker nodes."
  #   tcp_options {
  #     max = 10250
  #     min = 10250
  #   }
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.0.0/24"
  #   description = "Load balancer to worker nodes node ports."
  #   tcp_options {
  #     max = 32767
  #     min = 30000
  #   }
  # }

  # ingress_security_rules {
  #   protocol    = "1" # ICMP
  #   source      = "0.0.0.0/0"
  #   source_type = "CIDR_BLOCK"
  #   icmp_options {
  #     type = 3
  #     code = 4
  #   }
  #   description = "Path Discovery."
  # }

  # egress_security_rules {
  #   protocol         = "all"
  #   destination      = "10.10.112.0/20"
  #   destination_type = "CIDR_BLOCK"
  #   description      = "Allow worker nodes to access pods."
  # }
  # egress_security_rules {
  #   protocol = "all"
  #   destination = "0.0.0.0/0"
  #   destination_type = "CIDR_BLOCK"
  # }
  # egress_security_rules {
  #   protocol         = "1"
  #   destination      = "0.0.0.0/0"
  #   destination_type = "CIDR_BLOCK"
  #   description      = "Path Discovery."
  #   icmp_options {
  #     type = 3
  #     code = 4
  #   }
  # }
  # egress_security_rules {
  #   protocol         = "6"
  #   destination      = data.oci_core_services.services.services[0].cidr_block
  #   destination_type = "SERVICE_CIDR_BLOCK"
  #   description      = "Allow worker nodes to communicate with OKE."
  # }
  # egress_security_rules {
  #   protocol         = "6"
  #   destination      = "10.10.60.0/24"
  #   destination_type = "CIDR_BLOCK"
  #   description      = "Kubernetes worker to Kubernetes API endpoint communication."
  #   tcp_options {
  #     min = 12250
  #     max = 12250
  #   }
  # }
  # egress_security_rules {
  #   protocol         = "6"
  #   destination      = "10.10.60.0/24"
  #   destination_type = "CIDR_BLOCK"
  #   description      = "Kubernetes worker to Kubernetes API endpoint communication."
  #   tcp_options {
  #     min = 6443
  #     max = 6443
  #   }
  # }

  freeform_tags = var.freeform_tags

}

resource "oci_core_security_list" "web_worker_pod_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-web-pod-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   # source      = "10.10.32.0/20"
  #   source = var.web_worker_sub_cidr
  #   description = "Allow worker nodes to access pods."
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.60.0/24"
  #   description = "Allow Kubernetes API endpoint to communicate with pods."
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.112.0/20"
  #   description = "Allow pods to communicate with other pods."
  # }


  # ingress_security_rules {
  #   protocol    = "1" # ICMP
  #   source      = "0.0.0.0/0"
  #   description = "Allow ICMP from cms to web"
  # }

  # egress_security_rules {
  #   destination      = data.oci_core_services.services.services[0].cidr_block
  #   destination_type = "SERVICE_CIDR_BLOCK"
  #   protocol         = "1"
  #   description      = "Path Discovery."
  #   icmp_options {
  #     code = 4
  #     type = 3
  #   }
  # }
  # egress_security_rules {
  #   destination      = data.oci_core_services.services.services[0].cidr_block
  #   destination_type = "SERVICE_CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Allow pods to communicate with OCI services."
  # }
  # egress_security_rules {
  #   destination      = "0.0.0.0/0"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   tcp_options {
  #     max = 443
  #     min = 443
  #   }
  #   description = "(optional) Allow pods to communicate with internet."
  # }
  # egress_security_rules {
  #   destination      = "10.10.112.0/20"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "all"
  #   description      = "Allow pods to communicate with other pods."
  # }
  # egress_security_rules {
  #   destination      = "10.10.60.0/24"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  #   tcp_options {
  #     max = 12250
  #     min = 12250
  #   }
  # }
  # egress_security_rules {
  #   destination      = "10.10.60.0/24"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  #   tcp_options {
  #     min = 6443
  #     max = 6443
  #   }
  # }


  freeform_tags = var.freeform_tags

}

resource "oci_core_security_list" "cms_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-cms-worker-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   # source      = "10.10.32.0/20"
  #   source = var.web_worker_sub_cidr
  #   description = "allow all web to cms"
  # }
  # ingress_security_rules {
  #   protocol    = "6"
  #   # source      = "10.10.80.0/24"
  #   source = var.db_cidr_block
  #   description = "allow all db to cms"
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.0.0/24"
  #   description = "allow 80 lb to cms"
  #   tcp_options {
  #     max = 80
  #     min = 80
  #   }
  # }

  # ingress_security_rules {
  #   protocol    = "1" # ICMP
  #   source      = "0.0.0.0/0"
  #   description = "Allow ICMP web to cms"
  # }


  # egress_security_rules {
  #   protocol    = "all"
  #   destination = "0.0.0.0/0"
  #   description = "Allow all egress"
  # }

  freeform_tags = var.freeform_tags

}
resource "oci_core_security_list" "cms_worker_pod_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-cms-pod-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   # source      = "10.10.32.0/20"
  #   source = var.web_worker_sub_cidr
  #   description = "Allow worker nodes to access pods."
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.60.0/24"
  #   description = "Allow Kubernetes API endpoint to communicate with pods."
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.112.0/20"
  #   description = "Allow pods to communicate with other pods."
  # }


  # ingress_security_rules {
  #   protocol    = "1" # ICMP
  #   source      = "0.0.0.0/0"
  #   description = "Allow ICMP from cms to web"
  # }

  # egress_security_rules {
  #   destination      = data.oci_core_services.services.services[0].cidr_block
  #   destination_type = "SERVICE_CIDR_BLOCK"
  #   protocol         = "1"
  #   description      = "Path Discovery."
  #   icmp_options {
  #     code = 4
  #     type = 3
  #   }
  # }
  # egress_security_rules {
  #   destination      = data.oci_core_services.services.services[0].cidr_block
  #   destination_type = "SERVICE_CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Allow pods to communicate with OCI services."
  # }
  # egress_security_rules {
  #   destination      = "0.0.0.0/0"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   tcp_options {
  #     max = 443
  #     min = 443
  #   }
  #   description = "(optional) Allow pods to communicate with internet."
  # }
  # egress_security_rules {
  #   destination      = "10.10.112.0/20"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "all"
  #   description      = "Allow pods to communicate with other pods."
  # }
  # egress_security_rules {
  #   destination      = "10.10.60.0/24"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  #   tcp_options {
  #     max = 12250
  #     min = 12250
  #   }
  # }
  # egress_security_rules {
  #   destination      = "10.10.60.0/24"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  #   tcp_options {
  #     min = 6443
  #     max = 6443
  #   }
  # }


  freeform_tags = var.freeform_tags

}


resource "oci_core_security_list" "prod_k8s_priv_api_endpoint_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-k8s-priv-api-endpoint-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.32.0/20"
  #   description = "Kubernetes worker to Kubernetes API endpoint communication."
  #   tcp_options {
  #     max = 6443
  #     min = 6443
  #   }
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.112.0/20"
  #   description = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)"
  #   tcp_options {
  #     max = 6443
  #     min = 6443
  #   }
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.32.0/20"
  #   description = "Kubernetes worker to Kubernetes API endpoint communication."
  #   tcp_options {
  #     max = 12250
  #     min = 12250
  #   }
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.112.0/20"
  #   description = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)"
  #   tcp_options {
  #     max = 12250
  #     min = 12250
  #   }
  # }
  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "0.0.0.0/0"
  #   description = "Bastion subnet CIDR when access is made through OCI Bastion"
  #   tcp_options {
  #     max = 6443
  #     min = 6443
  #   }
  # }
  # ingress_security_rules {
  #   protocol    = "1"
  #   source      = "10.10.32.0/20"
  #   source_type = "CIDR_BLOCK"
  #   description = "Path Discovery."
  #   icmp_options {
  #     code = 4
  #     type = 3
  #   }
  # }

  # egress_security_rules {
  #   destination_type = "SERVICE_CIDR_BLOCK"
  #   protocol         = "6"
  #   destination      = data.oci_core_services.services.services[0].cidr_block
  #   description      = "Allow Kubernetes API endpoint to communicate with OKE."
  # }
  # egress_security_rules {
  #   destination_type = "SERVICE_CIDR_BLOCK"
  #   protocol         = "1"
  #   destination      = data.oci_core_services.services.services[0].cidr_block
  #   description      = "Path Discovery."
  #   icmp_options {
  #     code = 4
  #     type = 3
  #   }
  # }
  # egress_security_rules {
  #   protocol         = "all"
  #   destination      = "10.10.112.0/20"
  #   destination_type = "CIDR_BLOCK"
  #   description      = "Allow Kubernetes API endpoint to communicate with pods."
  # }
  # egress_security_rules {
  #   protocol         = "6"
  #   destination      = "10.10.32.0/20"
  #   destination_type = "CIDR_BLOCK"
  #   tcp_options {
  #     min = 10250
  #     max = 10250
  #   }
  #   description = "Allow Kubernetes API endpoint to communicate with worker nodes."
  # }
  # egress_security_rules {
  #   protocol         = "1"
  #   destination      = "10.10.32.0/20"
  #   destination_type = "CIDR_BLOCK"
  #   icmp_options {
  #     code = 4
  #     type = 3
  #   }
  #   description = "Path Discovery."
  # }


  freeform_tags = var.freeform_tags

}



resource "oci_core_security_list" "db_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-db-sl"

  ingress_security_rules {
    protocol    = "6"
    # source      = "10.10.16.0/20"
    source = var.cms_worker_sub_cidr
    description = "allow_from_cms_to_db"
    tcp_options {
      min = 5432
      max = 5432
    }
  }

  ingress_security_rules {
    protocol    = "6"
    # source      = "10.10.32.0/20"
    source = var.web_worker_sub_cidr
    description = "allow_web_to_db"
    tcp_options {
      min = 5432
      max = 5432
    }
  }
  ingress_security_rules {
    protocol    = "6"
    # source      = "10.10.96.0/20"
    source = var.airs_micro_oke_worker_cidr_block
    description = "allow_airs_to_db"
    tcp_options {
      min = 5432
      max = 5432
    }
  }
  ingress_security_rules {
    protocol    = "6"
    # source      = "10.10.112.0/20"
    source = var.web_worker_pod_cidr_block
    description = "allow_web_pod_to_db"
    tcp_options {
      min = 5432
      max = 5432
    }
  }
  ingress_security_rules {
    protocol    = "6"
    # source      = "10.10.128.0/20"
    source = var.cms_worker_pod_cidr_block
    description = "allow_cms_pod_to_db"
    tcp_options {
      min = 5432
      max = 5432
    }
  }
  ingress_security_rules {
    protocol    = "6"
    # source      = "10.10.144.0/20"
    source = var.airs_micro_oke_pod_cidr_block
    description = "allow_airs_pod_to_db"
    tcp_options {
      min = 5432
      max = 5432
    }
  }

  # ingress_security_rules {
  #   protocol    = "1" # ICMP
  #   source      = "0.0.0.0/0"
  #   description = "Allow ICMP from web to cms"
  # }


  # egress_security_rules {
  #   protocol    = "all"
  #   destination = "0.0.0.0/0"
  #   description = "Allow all egress"
  # }

  freeform_tags = var.freeform_tags

}

resource "oci_core_security_list" "airs_worker_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-airs-worker-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   # source      = "10.10.80.0/24"
  #   source = var.db_cidr_block
  #   description = "allow db to airs"
  # }
  # egress_security_rules {
  #   protocol    = "all"
  #   destination = "0.0.0.0/0"
  #   description = "Allow all egress"
  # }

  freeform_tags = var.freeform_tags

}
resource "oci_core_security_list" "airs_worker_pod_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-airs-pod-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   # source      = "10.10.32.0/20"
  #   source = var.web_worker_sub_cidr
  #   description = "Allow worker nodes to access pods."
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.60.0/24"
  #   description = "Allow Kubernetes API endpoint to communicate with pods."
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.112.0/20"
  #   description = "Allow pods to communicate with other pods."
  # }


  # ingress_security_rules {
  #   protocol    = "1" # ICMP
  #   source      = "0.0.0.0/0"
  #   description = "Allow ICMP from cms to web"
  # }

  # egress_security_rules {
  #   destination      = data.oci_core_services.services.services[0].cidr_block
  #   destination_type = "SERVICE_CIDR_BLOCK"
  #   protocol         = "1"
  #   description      = "Path Discovery."
  #   icmp_options {
  #     code = 4
  #     type = 3
  #   }
  # }
  # egress_security_rules {
  #   destination      = data.oci_core_services.services.services[0].cidr_block
  #   destination_type = "SERVICE_CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Allow pods to communicate with OCI services."
  # }
  # egress_security_rules {
  #   destination      = "0.0.0.0/0"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   tcp_options {
  #     max = 443
  #     min = 443
  #   }
  #   description = "(optional) Allow pods to communicate with internet."
  # }
  # egress_security_rules {
  #   destination      = "10.10.112.0/20"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "all"
  #   description      = "Allow pods to communicate with other pods."
  # }
  # egress_security_rules {
  #   destination      = "10.10.60.0/24"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  #   tcp_options {
  #     max = 12250
  #     min = 12250
  #   }
  # }
  # egress_security_rules {
  #   destination      = "10.10.60.0/24"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  #   tcp_options {
  #     min = 6443
  #     max = 6443
  #   }
  # }


  freeform_tags = var.freeform_tags

}

resource "oci_core_security_list" "apisix_worker_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-apisix-worker-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   # source      = "10.10.80.0/24"
  #   source = var.db_cidr_block
  #   description = "allow db to airs"
  # }
  # egress_security_rules {
  #   protocol    = "all"
  #   destination = "0.0.0.0/0"
  #   description = "Allow all egress"
  # }

  freeform_tags = var.freeform_tags

}
resource "oci_core_security_list" "apisix_worker_pod_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-apisix-pod-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   # source      = "10.10.32.0/20"
  #   source = var.web_worker_sub_cidr
  #   description = "Allow worker nodes to access pods."
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.60.0/24"
  #   description = "Allow Kubernetes API endpoint to communicate with pods."
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.112.0/20"
  #   description = "Allow pods to communicate with other pods."
  # }


  # ingress_security_rules {
  #   protocol    = "1" # ICMP
  #   source      = "0.0.0.0/0"
  #   description = "Allow ICMP from cms to web"
  # }

  # egress_security_rules {
  #   destination      = data.oci_core_services.services.services[0].cidr_block
  #   destination_type = "SERVICE_CIDR_BLOCK"
  #   protocol         = "1"
  #   description      = "Path Discovery."
  #   icmp_options {
  #     code = 4
  #     type = 3
  #   }
  # }
  # egress_security_rules {
  #   destination      = data.oci_core_services.services.services[0].cidr_block
  #   destination_type = "SERVICE_CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Allow pods to communicate with OCI services."
  # }
  # egress_security_rules {
  #   destination      = "0.0.0.0/0"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   tcp_options {
  #     max = 443
  #     min = 443
  #   }
  #   description = "(optional) Allow pods to communicate with internet."
  # }
  # egress_security_rules {
  #   destination      = "10.10.112.0/20"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "all"
  #   description      = "Allow pods to communicate with other pods."
  # }
  # egress_security_rules {
  #   destination      = "10.10.60.0/24"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  #   tcp_options {
  #     max = 12250
  #     min = 12250
  #   }
  # }
  # egress_security_rules {
  #   destination      = "10.10.60.0/24"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  #   tcp_options {
  #     min = 6443
  #     max = 6443
  #   }
  # }


  freeform_tags = var.freeform_tags

}

resource "oci_core_security_list" "authentik_worker_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-authentik-worker-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   # source      = "10.10.80.0/24"
  #   source = var.db_cidr_block
  #   description = "allow db to airs"
  # }
  # egress_security_rules {
  #   protocol    = "all"
  #   destination = "0.0.0.0/0"
  #   description = "Allow all egress"
  # }

  freeform_tags = var.freeform_tags

}
resource "oci_core_security_list" "authentik_worker_pod_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-authentik-pod-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   # source      = "10.10.32.0/20"
  #   source = var.web_worker_sub_cidr
  #   description = "Allow worker nodes to access pods."
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.60.0/24"
  #   description = "Allow Kubernetes API endpoint to communicate with pods."
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.112.0/20"
  #   description = "Allow pods to communicate with other pods."
  # }


  # ingress_security_rules {
  #   protocol    = "1" # ICMP
  #   source      = "0.0.0.0/0"
  #   description = "Allow ICMP from cms to web"
  # }

  # egress_security_rules {
  #   destination      = data.oci_core_services.services.services[0].cidr_block
  #   destination_type = "SERVICE_CIDR_BLOCK"
  #   protocol         = "1"
  #   description      = "Path Discovery."
  #   icmp_options {
  #     code = 4
  #     type = 3
  #   }
  # }
  # egress_security_rules {
  #   destination      = data.oci_core_services.services.services[0].cidr_block
  #   destination_type = "SERVICE_CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Allow pods to communicate with OCI services."
  # }
  # egress_security_rules {
  #   destination      = "0.0.0.0/0"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   tcp_options {
  #     max = 443
  #     min = 443
  #   }
  #   description = "(optional) Allow pods to communicate with internet."
  # }
  # egress_security_rules {
  #   destination      = "10.10.112.0/20"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "all"
  #   description      = "Allow pods to communicate with other pods."
  # }
  # egress_security_rules {
  #   destination      = "10.10.60.0/24"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  #   tcp_options {
  #     max = 12250
  #     min = 12250
  #   }
  # }
  # egress_security_rules {
  #   destination      = "10.10.60.0/24"
  #   destination_type = "CIDR_BLOCK"
  #   protocol         = "6"
  #   description      = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  #   tcp_options {
  #     min = 6443
  #     max = 6443
  #   }
  # }


  freeform_tags = var.freeform_tags

}


resource "oci_core_security_list" "pub_lb_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-pub-lb-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "0.0.0.0/0"
  #   description = "allow "
  #   tcp_options {
  #     max = 22
  #     min = 22
  #   }
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "0.0.0.0/0"
  #   description = "allow "
  #   tcp_options {
  #     max = 80
  #     min = 80
  #   }
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "0.0.0.0/0"
  #   description = "allow "
  # }


  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "0.0.0.0/0"
  #   description = "allow "
  #   tcp_options {
  #     max = 443
  #     min = 443
  #   }
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.32.0/20"
  #   description = "allow "
  #   tcp_options {
  #     min = 30000
  #     max = 32767
  #   }
  # }

  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "10.10.32.0/20"
  #   description = "allow "
  #   tcp_options {
  #     max = 10256
  #     min = 10256
  #   }
  # }

  # egress_security_rules {
  #   protocol    = "6"
  #   destination = "10.10.32.0/20"
  #   description = "Load balancer to worker nodes node ports."
  #   tcp_options {
  #     min = 30000
  #     max = 32767
  #   }
  # }

  # egress_security_rules {
  #   protocol    = "6"
  #   destination = "10.10.32.0/20"
  #   description = "Allow load balancer to communicate with kube-proxy on worker nodes."
  #   tcp_options {
  #     min = 10256
  #     max = 10256
  #   }
  # }

  freeform_tags = var.freeform_tags

}

resource "oci_core_security_list" "priv_lb_SL" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-priv-lb-sl"
  # ingress_security_rules {
  #   protocol    = "6"
  #   source      = "0.0.0.0/0"
  #   description = "allow"
  # }
  # egress_security_rules {
  #   protocol    = "all"
  #   destination = "0.0.0.0/0"
  #   description = "Allow all egress"
  # }

  freeform_tags = var.freeform_tags

}

# resource "oci_core_security_list" "api_gw_SL" {
#   #Required
#   compartment_id = oci_identity_compartment.net_compartment.id
#   vcn_id         = oci_core_vcn.terra_vcn.id
#   display_name   = "${var.vcn_display_name}-api-gw-SL"
#   # ingress_security_rules {
#   #   protocol    = "6"
#   #   source      = "0.0.0.0/0"
#   #   description = "allow "
#   # }
#   egress_security_rules {
#     protocol    = "all"
#     destination = "0.0.0.0/0"
#     description = "Allow all egress"
#   }

#   freeform_tags = var.freeform_tags

# }

## Creating NSG ##

#######################
###### NSG LB      ####
#######################

resource "oci_core_network_security_group" "nsg_prod_lb" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_lb
}
# INGRESS: 
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_ingress_443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Allow inbound traffic to Load Balancer."

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}

resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_ingress_80" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Allow inbound traffic to Load Balancer."

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
}

resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_ingress_prometheus_9090" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Allow prometheus port to Load Balancer."

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 9090
      max = 9090
    }
  }
}

# For multiple egress target , create "local" data

locals {
  lb_egress_targets = {
    cms  = { id = oci_core_network_security_group.nsg_prod_cms.id }
    web  = { id = oci_core_network_security_group.nsg_prod_web.id }
    airs = { id = oci_core_network_security_group.nsg_prod_airs.id }
    apisix = { id = oci_core_network_security_group.nsg_prod_apisix.id }
    authentik = { id = oci_core_network_security_group.nsg_prod_authentik.id }
  }
}

# EGRESS: Allow to CMS, WEB, AIRS NSG
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_egress" {
  for_each                  = local.lb_egress_targets
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "0.0.0.0/0"
  # destination_type          = "CIDR_BLOCK"
  destination_type = "NETWORK_SECURITY_GROUP"
  destination      = each.value.id

  # tcp_options {
  #   destination_port_range {
  #     min = each.value.port
  #     max = each.value.port
  #   }
  # }
  description = "Allow LB to ${each.key}"
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_web_worker_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.32.0/20"
  destination = var.web_worker_sub_cidr
  destination_type          = "CIDR_BLOCK"
  description               = "Allow traffic to web worker nodes."
  tcp_options {
    destination_port_range {
      min = 30000
      max = 32767
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_web_worker_proxy_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.32.0/20"
  destination = var.web_worker_sub_cidr
  destination_type          = "CIDR_BLOCK"
  description               = "Allow OCI load balancer or network load balancer to communicate with kube-proxy on worker nodes"
  tcp_options {
    destination_port_range {
      min = 10256
      max = 10256
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_cms_worker_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.16.0/20"
  destination = var.cms_worker_sub_cidr
  destination_type          = "CIDR_BLOCK"
  description               = "Allow traffic to cms worker nodes."
  tcp_options {
    destination_port_range {
      min = 30000
      max = 32767
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_cms_worker_proxy_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.16.0/20"
  destination = var.cms_worker_sub_cidr
  destination_type          = "CIDR_BLOCK"
  description               = "Allow OCI load balancer or network load balancer to communicate with kube-proxy on worker nodes"
  tcp_options {
    destination_port_range {
      min = 10256
      max = 10256
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_airs_worker_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.96.0/20"
  destination = var.airs_micro_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow traffic to cms worker nodes."
  tcp_options {
    destination_port_range {
      min = 30000
      max = 32767
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_airs_worker_proxy_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.96.0/20"
  destination = var.airs_micro_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow OCI load balancer or network load balancer to communicate with kube-proxy on worker nodes"
  tcp_options {
    destination_port_range {
      min = 10256
      max = 10256
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_apisix_worker_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.96.0/20"
  destination = var.apisix_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow traffic to cms worker nodes."
  tcp_options {
    destination_port_range {
      min = 30000
      max = 32767
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_apisix_worker_proxy_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.96.0/20"
  destination = var.apisix_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow OCI load balancer or network load balancer to communicate with kube-proxy on worker nodes"
  tcp_options {
    destination_port_range {
      min = 10256
      max = 10256
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_authentik_worker_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.96.0/20"
  destination = var.authentik_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow traffic to cms worker nodes."
  tcp_options {
    destination_port_range {
      min = 30000
      max = 32767
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_authentik_worker_proxy_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.96.0/20"
  destination = var.authentik_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow OCI load balancer or network load balancer to communicate with kube-proxy on worker nodes"
  tcp_options {
    destination_port_range {
      min = 10256
      max = 10256
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_gfhost" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  # destination = var.airs_micro_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow to install yum update port 443"
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_gfhost_3000" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  # destination = var.airs_micro_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow to access grafana port 3000"
  tcp_options {
    destination_port_range {
      min = 3000
      max = 3000
    }
  }
}

###########################
###### NSG CMS Worker  ####
###########################

resource "oci_core_network_security_group" "nsg_prod_cms" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_cms
}

# Create local data for 80/443
locals {
  lb_ingress_target = {
    # http  = { id = oci_core_network_security_group.nsg_prod_lb.id, port = 80 }
    # https = { id = oci_core_network_security_group.nsg_prod_lb.id, port = 443 }
    web   = { id = oci_core_network_security_group.nsg_prod_web.id, port = 9090 }
  }
}
# INGRESS: 
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_ingress" {
  for_each                  = local.lb_ingress_target
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = each.value.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "Allow 9090 From NSG PROD WEB"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      max = each.value.port
      min = each.value.port
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_ingress_all_from_prod_LB" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_network_security_group.nsg_prod_lb.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "Allow all From NSG PROD LB"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {}
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_ingress_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.16.0/20"
  source = var.cms_worker_sub_cidr
  source_type               = "CIDR_BLOCK"
  description               = "Allows communication from (or to) worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_ingress_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.128.0/20"
  source = var.cms_worker_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods on one worker node to communicate with pods on other worker nodes (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_ingress_lb" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.0.0/24"
  source = var.lb_subnet_cidr
  source_type               = "CIDR_BLOCK"
  description               = "Allow OCI load balancer or network load balancer to communicate with kube-proxy on worker nodes."
  tcp_options {
    destination_port_range {
      min = 10256
      max = 10256
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_ingress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "INGRESS"
  protocol                  = "1"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Path Discovery."
  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_ingress_api_ep_all" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow Kubernetes API endpoint to communicate with worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_ingress_api_ep_10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to worker node communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 10250
      max = 10250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_ingress_ssh" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_network_security_group.nsg_prod_bastion.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "(optional) Allow inbound SSH traffic from Bastion NSG to worker nodes."
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_ingress_icmp_from_bastion" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "INGRESS"
  protocol                  = "1" # ICMP
  source                    = oci_core_network_security_group.nsg_prod_bastion.id
  source_type               = "NETWORK_SECURITY_GROUP"
  stateless                 = false
  description               = "Allow Ping from Bastion NSG"
}

# EGRESS: Allow all
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.80.0/24"
  destination = var.db_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow to DB subnet"
  tcp_options {
    destination_port_range {
      max = "3306"
      min = "3306"
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_egress_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.16.0/20"
  destination = var.cms_worker_sub_cidr
  destination_type          = "CIDR_BLOCK"
  description               = "Allows communication from (or to) worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_egress_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.128.0/20"
  destination = var.cms_worker_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow worker nodes to communicate with pods on other worker nodes (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_egress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "EGRESS"
  protocol                  = "1"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "Path Discovery."
  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_egress_api_ep_6443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes worker to Kubernetes API endpoint communication."
  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_egress_api_worker_allow_to_internet" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "(optional) Allow worker nodes to communicate with internet."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_egress_api_ep_12250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes worker to Kubernetes API endpoint communication."
  tcp_options {
    destination_port_range {
      min = 12250
      max = 12250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_engress_osn" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "EGRESS"
  protocol                  = "6"
  stateless                 = false
  tcp_options {}
  destination      = data.oci_core_services.services.services[0].cidr_block
  destination_type = "SERVICE_CIDR_BLOCK"
  description      = "Allow nodes to communicate with OKE."
}

####################
### CMS POD NSG ####
####################
resource "oci_core_network_security_group" "nsg_prod_cms_pod" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_cms_pod
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_pod_k8s_api_ep_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to pod communication (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_pod_woker_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.16.0/20"
  source = var.cms_worker_sub_cidr
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods on one worker node to communicate with pods on other worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_pod_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.128.0/20"
  source = var.cms_worker_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods to communicate with each other."
}

# Egress
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_pod_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms_pod.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.128.0/20"
  destination = var.cms_worker_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow pods to communicate with each other."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_pod_egress_osn" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  tcp_options {}
  stateless        = false
  destination      = data.oci_core_services.services.services[0].cidr_block
  destination_type = "SERVICE_CIDR_BLOCK"
  description      = "Allow worker nodes to communicate with OCI services."
}
# resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_egress_osn_tcp" {
#   network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
#   direction                 = "EGRESS"
#   protocol                  = "1"
#   icmp_options {
#     type = 3
#     code = 4
#   }
#   stateless = false
#   destination      = data.oci_core_services.services.services[0].cidr_block
#   destination_type = "SERVICE_CIDR_BLOCK"
#   description      = "Path Discovery."
# }
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_pod_egress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms_pod.id
  direction                 = "EGRESS"
  protocol                  = "1" # ICMP
  destination               = data.oci_core_services.services.services[0].cidr_block
  destination_type          = "SERVICE_CIDR_BLOCK"
  stateless                 = false
  description               = "Path MTU Discovery from worker nodes (ICMP type 3 code 4)."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_pod_egress10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 12250
      max = 12250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_pod_egress_6443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_pod_egress_443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "(optional) Allow pods to communicate with internet."
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}


###########################
##### WEB Worker NSG        ######
###########################
resource "oci_core_network_security_group" "nsg_prod_web" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_web
}

# locals {
#   nsg_lb_ingress_target = {
#     lb_http  = { id = oci_core_network_security_group.nsg_prod_lb.id, port = 80 }
#     lb_https = { id = oci_core_network_security_group.nsg_prod_lb.id, port = 443 }
#   }
# }

# # INGRESS: 80 , 443  from PROD_LB
# resource "oci_core_network_security_group_security_rule" "nsg_prod_web_ingress" {
#   for_each                  = local.nsg_lb_ingress_target
#   network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
#   direction                 = "INGRESS"
#   protocol                  = "6"
#   source                    = each.value.id
#   source_type               = "NETWORK_SECURITY_GROUP"
#   description               = "Allow http from NSG-PROD-LB"

#   # Optional: Restrict to ping only (echo request = type 8)
#   tcp_options {
#     destination_port_range {
#       min = each.value.port
#       max = each.value.port
#     }
#   }
# }

# INGRESS: Allow All from PROD_LB

resource "oci_core_network_security_group_security_rule" "nsg_prod_web_ingress_all_from_prod_lb" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_network_security_group.nsg_prod_lb.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "Allow all from NSG-PROD-LB"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {}
}

resource "oci_core_network_security_group_security_rule" "nsg_prod_web_ingress_from_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.32.0/20"
  source = var.web_worker_sub_cidr
  source_type               = "CIDR_BLOCK"
  description               = "Allows communication from (or to) worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_ingress_from_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.112.0/20"
  source = var.web_worker_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods on one worker node to communicate with pods on other worker nodes (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_ingress_from_k8s_api_ep" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow Kubernetes API endpoint to communicate with worker nodes"
  tcp_options {}
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_ingress_from_k8s_api_ep_10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to worker node communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 10250
      max = 10250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_ingress_from_lb_10256" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.0.0/24"
  source = var.lb_subnet_cidr
  source_type               = "CIDR_BLOCK"
  description               = "Allow OCI load balancer or network load balancer to communicate with kube-proxy on worker nodes.."
  tcp_options {
    destination_port_range {
      min = 10256
      max = 10256
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_ingress_from_ssh" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_network_security_group.nsg_prod_bastion.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = " Allow inbound SSH traffic from Bastion to worker nodes."
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_ingress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "INGRESS"
  protocol                  = "1" # ICMP
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  stateless                 = false
  description               = "Path MTU Discovery from worker nodes (ICMP type 3 code 4)."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_ingress_icmp_from_bastion" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "INGRESS"
  protocol                  = "1" # ICMP
  source                    = oci_core_network_security_group.nsg_prod_bastion.id
  source_type               = "NETWORK_SECURITY_GROUP"
  stateless                 = false
  description               = "Allow Ping from Bastion NSG"
}

# EGRESS:
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = oci_core_network_security_group.nsg_prod_airs.id
  destination_type          = "NETWORK_SECURITY_GROUP"
  description               = "Allow all egress"
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_egress_all_to_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.32.0/20"
  destination = var.web_worker_sub_cidr
  destination_type          = "CIDR_BLOCK"
  description               = "Allows communication from (or to) worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_egress_all_to_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.112.0/20"
  destination = var.web_worker_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow worker nodes to communicate with pods on other worker nodes (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_egress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "EGRESS"
  protocol                  = "1" # ICMP
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  stateless                 = false
  description               = "Path MTU Discovery from worker nodes (ICMP type 3 code 4)."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_engress_osn" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "EGRESS"
  protocol                  = "6"
  stateless                 = false
  tcp_options {}
  destination      = data.oci_core_services.services.services[0].cidr_block
  destination_type = "SERVICE_CIDR_BLOCK"
  description      = "Allow nodes to communicate with OKE."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_egress_10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes worker to Kubernetes API endpoint communication."
  tcp_options {
    destination_port_range {
      min = 12250
      max = 12250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_egress_10256" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.0.0/24"
  destination = var.lb_subnet_cidr
  destination_type          = "CIDR_BLOCK"
  description               = "Allow OCI load balancer or network load balancer to communicate with kube-proxy on worker nodes."
  tcp_options {
    destination_port_range {
      min = 10256
      max = 10256
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_egress_6443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes worker to Kubernetes API endpoint communication."
  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_egress_all" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "EGRESS"
  protocol                  = "all"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "(optional) Allow worker nodes to communicate with internet."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_egress_1" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.80.0/24"
  destination = var.db_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow 3306 to DB"
  tcp_options {
    destination_port_range {
      max = 3306
      min = 3306
    }
  }
}

############################
###### NSG AIRS WORKER  ####
############################

resource "oci_core_network_security_group" "nsg_prod_airs" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_airs
}

locals {
  web_ingress = {
    # apigw = { id = oci_core_network_security_group.nsg_prod_api_gw.id, port = 8080 }
    web   = { id = oci_core_network_security_group.nsg_prod_web.id, port = 8088 }
  }
}
# INGRESS:
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_ingress" {
  for_each                  = local.web_ingress
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = each.value.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "Allow service port from ${each.key}"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = each.value.port
      max = each.value.port
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_ingress_all_from_lb" {
  for_each                  = local.web_ingress
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_network_security_group.nsg_prod_lb.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "Allow All from NSG PROD LB"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {}
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_ingress_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.96.0/20"
  source = var.airs_micro_oke_worker_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allows communication from (or to) worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_ingress_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.144.0/20"
  source = var.airs_micro_oke_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods on one worker node to communicate with pods on other worker nodes (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_ingress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "INGRESS"
  protocol                  = "1"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Path Discovery."
  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_ingress_api_ep_all" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow Kubernetes API endpoint to communicate with worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_ingress_api_ep_10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to worker node communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 10250
      max = 10250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_ingress_ssh" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_network_security_group.nsg_prod_bastion.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "(optional) Allow inbound SSH traffic from Bastion to worker nodes."
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_ingress_lb" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.0.0/24"
  source = var.lb_subnet_cidr
  source_type               = "CIDR_BLOCK"
  description               = "Allow OCI load balancer or network load balancer to communicate with kube-proxy on worker nodes."
  tcp_options {
    destination_port_range {
      min = 10256
      max = 10256
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_ingress_icmp_from_bastion" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "INGRESS"
  protocol                  = "1" # ICMP
  source                    = oci_core_network_security_group.nsg_prod_bastion.id
  source_type               = "NETWORK_SECURITY_GROUP"
  stateless                 = false
  description               = "Allow Ping from Bastion NSG"
}

# EGRESS
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.80.0/24"
  destination = var.db_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow to db_subnet"
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_egress_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.96.0/20"
  destination = var.airs_micro_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allows communication from (or to) worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_egress_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.144.0/20"
  destination = var.airs_micro_oke_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow worker nodes to communicate with pods on other worker nodes (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_egress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "EGRESS"
  protocol                  = "1"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "Path Discovery."
  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_egress_api_ep_6443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes worker to Kubernetes API endpoint communication."
  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_egress_api_worker_allow_to_internet" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "(optional) Allow worker nodes to communicate with internet."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_egress_api_ep_12250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes worker to Kubernetes API endpoint communication."
  tcp_options {
    destination_port_range {
      min = 12250
      max = 12250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_engress_osn" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "EGRESS"
  protocol                  = "6"
  stateless                 = false
  tcp_options {}
  destination      = data.oci_core_services.services.services[0].cidr_block
  destination_type = "SERVICE_CIDR_BLOCK"
  description      = "Allow nodes to communicate with OKE."
}

####################
### AIRS POD NSG ####
####################
resource "oci_core_network_security_group" "nsg_prod_airs_pod" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_airs_pod
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_pod_k8s_api_ep_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to pod communication (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_pod_woker_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.96.0/20"
  source = var.airs_micro_oke_worker_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods on one worker node to communicate with pods on other worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_pod_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.144.0/20"
  source = var.airs_micro_oke_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods to communicate with each other."
}

# Egress
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_pod_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs_pod.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.144.0/20"
  destination = var.airs_micro_oke_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow pods to communicate with each other."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_pod_egress_osn" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  tcp_options {}
  stateless        = false
  destination      = data.oci_core_services.services.services[0].cidr_block
  destination_type = "SERVICE_CIDR_BLOCK"
  description      = "Allow worker nodes to communicate with OCI services."
}
# resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_egress_osn_tcp" {
#   network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
#   direction                 = "EGRESS"
#   protocol                  = "1"
#   icmp_options {
#     type = 3
#     code = 4
#   }
#   stateless = false
#   destination      = data.oci_core_services.services.services[0].cidr_block
#   destination_type = "SERVICE_CIDR_BLOCK"
#   description      = "Path Discovery."
# }
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_pod_egress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs_pod.id
  direction                 = "EGRESS"
  protocol                  = "1" # ICMP
  destination               = data.oci_core_services.services.services[0].cidr_block
  destination_type          = "SERVICE_CIDR_BLOCK"
  stateless                 = false
  description               = "Path MTU Discovery from worker nodes (ICMP type 3 code 4)."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_pod_egress10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 12250
      max = 12250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_pod_egress_6443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_pod_egress_443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "(optional) Allow pods to communicate with internet."
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}

############################
###### NSG APISIX WORKER  ####
############################

resource "oci_core_network_security_group" "nsg_prod_apisix" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_apisix
}

locals {
  web_ingress_apisix = {
    # apigw = { id = oci_core_network_security_group.nsg_prod_api_gw.id, port = 8080 }
    web   = { id = oci_core_network_security_group.nsg_prod_web.id, port = 8088 }
  }
}
# INGRESS:
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_ingress" {
  for_each                  = local.web_ingress_apisix
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = each.value.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "Allow service port from ${each.key}"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = each.value.port
      max = each.value.port
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_ingress_all_from_lb" {
  for_each                  = local.web_ingress
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_network_security_group.nsg_prod_lb.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "Allow All from NSG PROD LB"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {}
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_ingress_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.96.0/20"
  source = var.apisix_oke_worker_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allows communication from (or to) worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_ingress_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.144.0/20"
  source = var.apisix_oke_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods on one worker node to communicate with pods on other worker nodes (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_ingress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "INGRESS"
  protocol                  = "1"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Path Discovery."
  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_ingress_api_ep_all" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow Kubernetes API endpoint to communicate with worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_ingress_api_ep_10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to worker node communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 10250
      max = 10250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_ingress_ssh" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_network_security_group.nsg_prod_bastion.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "(optional) Allow inbound SSH traffic from Bastion to worker nodes."
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_ingress_lb" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.0.0/24"
  source = var.lb_subnet_cidr
  source_type               = "CIDR_BLOCK"
  description               = "Allow OCI load balancer or network load balancer to communicate with kube-proxy on worker nodes."
  tcp_options {
    destination_port_range {
      min = 10256
      max = 10256
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_ingress_icmp_from_bastion" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "INGRESS"
  protocol                  = "1" # ICMP
  source                    = oci_core_network_security_group.nsg_prod_bastion.id
  source_type               = "NETWORK_SECURITY_GROUP"
  stateless                 = false
  description               = "Allow Ping from Bastion NSG"
}

# EGRESS
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.80.0/24"
  destination = var.db_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow to db_subnet"
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_egress_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.96.0/20"
  destination = var.apisix_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allows communication from (or to) worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_egress_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.144.0/20"
  destination = var.apisix_oke_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow worker nodes to communicate with pods on other worker nodes (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_egress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "EGRESS"
  protocol                  = "1"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "Path Discovery."
  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_egress_api_ep_6443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes worker to Kubernetes API endpoint communication."
  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_egress_api_worker_allow_to_internet" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "(optional) Allow worker nodes to communicate with internet."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_egress_api_ep_12250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes worker to Kubernetes API endpoint communication."
  tcp_options {
    destination_port_range {
      min = 12250
      max = 12250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_engress_osn" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix.id
  direction                 = "EGRESS"
  protocol                  = "6"
  stateless                 = false
  tcp_options {}
  destination      = data.oci_core_services.services.services[0].cidr_block
  destination_type = "SERVICE_CIDR_BLOCK"
  description      = "Allow nodes to communicate with OKE."
}

####################
### APISIX POD NSG ####
####################
resource "oci_core_network_security_group" "nsg_prod_apisix_pod" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_apisix_pod
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_pod_k8s_api_ep_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to pod communication (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_pod_woker_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.96.0/20"
  source = var.apisix_oke_worker_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods on one worker node to communicate with pods on other worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_pod_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.144.0/20"
  source = var.apisix_oke_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods to communicate with each other."
}

# Egress
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_pod_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix_pod.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.144.0/20"
  destination = var.apisix_oke_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow pods to communicate with each other."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_pod_egress_osn" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  tcp_options {}
  stateless        = false
  destination      = data.oci_core_services.services.services[0].cidr_block
  destination_type = "SERVICE_CIDR_BLOCK"
  description      = "Allow worker nodes to communicate with OCI services."
}
# resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_egress_osn_tcp" {
#   network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
#   direction                 = "EGRESS"
#   protocol                  = "1"
#   icmp_options {
#     type = 3
#     code = 4
#   }
#   stateless = false
#   destination      = data.oci_core_services.services.services[0].cidr_block
#   destination_type = "SERVICE_CIDR_BLOCK"
#   description      = "Path Discovery."
# }
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_pod_egress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix_pod.id
  direction                 = "EGRESS"
  protocol                  = "1" # ICMP
  destination               = data.oci_core_services.services.services[0].cidr_block
  destination_type          = "SERVICE_CIDR_BLOCK"
  stateless                 = false
  description               = "Path MTU Discovery from worker nodes (ICMP type 3 code 4)."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_pod_egress10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 12250
      max = 12250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_pod_egress_6443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_apisix_pod_egress_443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_apisix_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "(optional) Allow pods to communicate with internet."
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}

############################
###### NSG AUTHENTIK WORKER  ####
############################

resource "oci_core_network_security_group" "nsg_prod_authentik" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_authentik
}

locals {
  web_ingress_authentik = {
    # apigw = { id = oci_core_network_security_group.nsg_prod_api_gw.id, port = 8080 }
    web   = { id = oci_core_network_security_group.nsg_prod_web.id, port = 8088 }
  }
}
# INGRESS:
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_ingress" {
  for_each                  = local.web_ingress_authentik
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = each.value.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "Allow service port from ${each.key}"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = each.value.port
      max = each.value.port
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_ingress_all_from_lb" {
  for_each                  = local.web_ingress
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_network_security_group.nsg_prod_lb.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "Allow All from NSG PROD LB"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {}
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_ingress_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.96.0/20"
  source = var.authentik_oke_worker_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allows communication from (or to) worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_ingress_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.144.0/20"
  source = var.authentik_oke_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods on one worker node to communicate with pods on other worker nodes (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_ingress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "INGRESS"
  protocol                  = "1"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Path Discovery."
  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_ingress_api_ep_all" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow Kubernetes API endpoint to communicate with worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_ingress_api_ep_10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to worker node communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 10250
      max = 10250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_ingress_ssh" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_network_security_group.nsg_prod_bastion.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "(optional) Allow inbound SSH traffic from Bastion to worker nodes."
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_ingress_lb" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "INGRESS"
  protocol                  = "6"
  # source                    = "10.10.0.0/24"
  source = var.lb_subnet_cidr
  source_type               = "CIDR_BLOCK"
  description               = "Allow OCI load balancer or network load balancer to communicate with kube-proxy on worker nodes."
  tcp_options {
    destination_port_range {
      min = 10256
      max = 10256
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_ingress_icmp_from_bastion" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "INGRESS"
  protocol                  = "1" # ICMP
  source                    = oci_core_network_security_group.nsg_prod_bastion.id
  source_type               = "NETWORK_SECURITY_GROUP"
  stateless                 = false
  description               = "Allow Ping from Bastion NSG"
}

# EGRESS
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.80.0/24"
  destination = var.db_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow to db_subnet"
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_egress_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.96.0/20"
  destination = var.authentik_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allows communication from (or to) worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_egress_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.144.0/20"
  destination = var.authentik_oke_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow worker nodes to communicate with pods on other worker nodes (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_egress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "EGRESS"
  protocol                  = "1"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "Path Discovery."
  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_egress_api_ep_6443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes worker to Kubernetes API endpoint communication."
  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_egress_api_worker_allow_to_internet" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "(optional) Allow worker nodes to communicate with internet."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_egress_api_ep_12250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes worker to Kubernetes API endpoint communication."
  tcp_options {
    destination_port_range {
      min = 12250
      max = 12250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_engress_osn" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik.id
  direction                 = "EGRESS"
  protocol                  = "6"
  stateless                 = false
  tcp_options {}
  destination      = data.oci_core_services.services.services[0].cidr_block
  destination_type = "SERVICE_CIDR_BLOCK"
  description      = "Allow nodes to communicate with OKE."
}

####################
### APISIX POD NSG ####
####################
resource "oci_core_network_security_group" "nsg_prod_authentik_pod" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_authentik_pod
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_pod_k8s_api_ep_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to pod communication (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_pod_woker_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.96.0/20"
  source = var.authentik_oke_worker_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods on one worker node to communicate with pods on other worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_pod_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.144.0/20"
  source = var.authentik_oke_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods to communicate with each other."
}

# Egress
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_pod_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik_pod.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.144.0/20"
  destination = var.authentik_oke_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow pods to communicate with each other."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_pod_egress_osn" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  tcp_options {}
  stateless        = false
  destination      = data.oci_core_services.services.services[0].cidr_block
  destination_type = "SERVICE_CIDR_BLOCK"
  description      = "Allow worker nodes to communicate with OCI services."
}
# resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_egress_osn_tcp" {
#   network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
#   direction                 = "EGRESS"
#   protocol                  = "1"
#   icmp_options {
#     type = 3
#     code = 4
#   }
#   stateless = false
#   destination      = data.oci_core_services.services.services[0].cidr_block
#   destination_type = "SERVICE_CIDR_BLOCK"
#   description      = "Path Discovery."
# }
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_pod_egress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik_pod.id
  direction                 = "EGRESS"
  protocol                  = "1" # ICMP
  destination               = data.oci_core_services.services.services[0].cidr_block
  destination_type          = "SERVICE_CIDR_BLOCK"
  stateless                 = false
  description               = "Path MTU Discovery from worker nodes (ICMP type 3 code 4)."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_pod_egress10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 12250
      max = 12250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_pod_egress_6443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_authentik_pod_egress_443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_authentik_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "(optional) Allow pods to communicate with internet."
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}


####################
### WEB POD NSG ####
####################
resource "oci_core_network_security_group" "nsg_prod_web_pod" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_web_pod
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_k8s_api_ep_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.60.0/24"
  source = var.k8s_priv_api_endpoint_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to pod communication (when using VCN-native pod networking)."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_woker_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.32.0/20"
  source = var.web_worker_sub_cidr
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods on one worker node to communicate with pods on other worker nodes."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
  direction                 = "INGRESS"
  protocol                  = "all"
  # source                    = "10.10.112.0/20"
  source = var.web_worker_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow pods to communicate with each other."
}

# Egress
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
  direction                 = "EGRESS"
  protocol                  = "all"
  # destination               = "10.10.112.0/20"
  destination = var.web_worker_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow pods to communicate with each other."
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_egress_osn" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  tcp_options {}
  stateless        = false
  destination      = data.oci_core_services.services.services[0].cidr_block
  destination_type = "SERVICE_CIDR_BLOCK"
  description      = "Allow worker nodes to communicate with OCI services."
}
# resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_egress_osn_tcp" {
#   network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
#   direction                 = "EGRESS"
#   protocol                  = "1"
#   icmp_options {
#     type = 3
#     code = 4
#   }
#   stateless = false
#   destination      = data.oci_core_services.services.services[0].cidr_block
#   destination_type = "SERVICE_CIDR_BLOCK"
#   description      = "Path Discovery."
# }
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_egress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
  direction                 = "EGRESS"
  protocol                  = "1" # ICMP
  destination               = data.oci_core_services.services.services[0].cidr_block
  destination_type          = "SERVICE_CIDR_BLOCK"
  stateless                 = false
  description               = "Path MTU Discovery from worker nodes (ICMP type 3 code 4)."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_egress10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 12250
      max = 12250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_egress_6443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_pod_egress_443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web_pod.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "(optional) Allow pods to communicate with internet."
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}


# ################
# ### Career NSG #
# ################
# resource "oci_core_network_security_group" "nsg_prod_careers" {
#   compartment_id = oci_identity_compartment.net_compartment.id
#   vcn_id         = oci_core_vcn.terra_vcn.id
#   display_name   = var.nsg_careers
# }

# locals {
#   lb_ingress_allow = {
#     http        = { id = oci_core_network_security_group.nsg_prod_lb.id, port = "80" }
#     https       = { id = oci_core_network_security_group.nsg_prod_lb.id, port = "443" }
#     bastion_ssh = { id = oci_core_network_security_group.nsg_prod_bastion.id, port = "22" }
#   }
# }
# # INGRESS: LB subnet to 80, 443, ssh from bastion
# resource "oci_core_network_security_group_security_rule" "nsg_prod_career_ingress" {
#   for_each                  = local.lb_ingress_allow
#   network_security_group_id = oci_core_network_security_group.nsg_prod_careers.id
#   direction                 = "INGRESS"
#   protocol                  = "6"
#   source                    = each.value.id
#   source_type               = "NETWORK_SECURITY_GROUP"
#   description               = "Allow http/https from LB"
#   # Optional: Restrict to ping only (echo request = type 8)
#   tcp_options {
#     destination_port_range {
#       min = each.value.port
#       max = each.value.port
#     }
#   }
# }

# # EGRESS: Allow all
# resource "oci_core_network_security_group_security_rule" "nsg_prod_career_egress" {
#   network_security_group_id = oci_core_network_security_group.nsg_prod_careers.id
#   direction                 = "EGRESS"
#   protocol                  = "6"
#   destination               = "10.10.80.0/24"
#   destination_type          = "CIDR_BLOCK"
#   description               = "Allow egress to DB 3306"
#   tcp_options {
#     destination_port_range {
#       max = 3306
#       min = 3306
#     }
#   }
# }


####################
### Bastion NSG  ###
####################
resource "oci_core_network_security_group" "nsg_prod_bastion" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_bastion
}

# INGRESS: ssh from anywhere
resource "oci_core_network_security_group_security_rule" "nsg_prod_bastion_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_bastion.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Allow ssh from anywhere"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}


# EGRESS: Allow all 
resource "oci_core_network_security_group_security_rule" "nsg_prod_bastion_egress_k8s_api" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_bastion.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.60.0/24"
  destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow access to k8s API endpoints"
  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_bastion_egress_web_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_bastion.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.32.0/20"
  destination = var.web_worker_sub_cidr
  destination_type          = "CIDR_BLOCK"
  description               = "SSH access to WEB Worker Nodes"
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_bastion_egress_cms_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_bastion.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.16.0/20"
  destination = var.cms_worker_sub_cidr
  destination_type          = "CIDR_BLOCK"
  description               = "SSH access to CMS Worker Nodes"
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_bastion_egress_airs_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_bastion.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "10.10.96.0/20"
  destination = var.airs_micro_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "SSH access to AIRS Worker Nodes"
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}

####################
### GFhsot NSG  ###
####################
resource "oci_core_network_security_group" "nsg_prod_gfhost" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_gf_host
}

# INGRESS: ssh from anywhere
resource "oci_core_network_security_group_security_rule" "nsg_prod_gfhost_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_gfhost.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Allow ssh from anywhere"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_gfhost_ingress_3000" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_gfhost.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Allow Grafana port 3000 from anywhere"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 3000
      max = 3000
    }
  }
}


# EGRESS: Allow all 
resource "oci_core_network_security_group_security_rule" "nsg_prod_gfhost_egress_all" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_gfhost.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  # destination = var.k8s_priv_api_endpoint_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Allow allow access to everywhere"
  tcp_options {
    # destination_port_range {
    #   min = 6443
    #   max = 6443
    # }
  }
}

# ###################
# ### NSG API GW  ###
# ###################
# resource "oci_core_network_security_group" "nsg_prod_api_gw" {
#   compartment_id = oci_identity_compartment.net_compartment.id
#   vcn_id         = oci_core_vcn.terra_vcn.id
#   display_name   = var.nsg_api_gw
# }

# # INGRESS: 443 from anywhere
# resource "oci_core_network_security_group_security_rule" "nsg_prod_api_gw_ingress" {
#   network_security_group_id = oci_core_network_security_group.nsg_prod_api_gw.id
#   direction                 = "INGRESS"
#   protocol                  = "6"
#   source                    = "0.0.0.0/0"
#   source_type               = "CIDR_BLOCK"
#   description               = "Allow https from anywhere"

#   # Optional: Restrict to ping only (echo request = type 8)
#   tcp_options {
#     destination_port_range {
#       min = 443
#       max = 443
#     }
#   }
# }

# # EGRESS: Allow 443 to AIRS
# resource "oci_core_network_security_group_security_rule" "nsg_prod_api_gw_egress" {
#   network_security_group_id = oci_core_network_security_group.nsg_prod_api_gw.id
#   direction                 = "EGRESS"
#   protocol                  = "6"
#   # destination               = "0.0.0.0/0"
#   # destination_type          = "CIDR_BLOCK"
#   destination      = oci_core_network_security_group.nsg_prod_airs.id
#   destination_type = "NETWORK_SECURITY_GROUP"
#   description      = "Allow to AIRS 443"

#   tcp_options {
#     destination_port_range {
#       max = 443
#       min = 443
#     }
#   }
# }

####################
#### NSG DB  #######
####################
resource "oci_core_network_security_group" "nsg_prod_db" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_db
}

# INGRESS: 5432 from Worker
resource "oci_core_network_security_group_security_rule" "nsg_prod_db_ingress_from_cms_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_db.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.cms_worker_sub_cidr
  source_type               = "CIDR_BLOCK"
  description               = "Allow 5432 from CMS worker"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 5432
      max = 5432
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_db_ingress_from_cms_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_db.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.cms_worker_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow 5432 from CMS pod"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 5432
      max = 5432
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_db_ingress_from_web_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_db.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.web_worker_sub_cidr
  source_type               = "CIDR_BLOCK"
  description               = "Allow 5432 from WEB worker"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 5432
      max = 5432
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_db_ingress_from_web_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_db.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.web_worker_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow 5432 from web pod"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 5432
      max = 5432
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_db_ingress_from_airs_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_db.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.airs_micro_oke_worker_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow 5432 from AIRS worker"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 5432
      max = 5432
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_db_ingress_from_airs_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_db.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.airs_micro_oke_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow 5432 from AIRS pod"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 5432
      max = 5432
    }
  }
}
# EGRESS: Allow all 
resource "oci_core_network_security_group_security_rule" "nsg_prod_db_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_db.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  # destination      = oci_core_network_security_group.nsg_prod_airs.id
  # destination_type = "NETWORK_SECURITY_GROUP"
  description      = "Allow to all"

  tcp_options { }
}

#########################
##### NSG Redis      ####
#########################
resource "oci_core_network_security_group" "nsg_prod_redis" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_redis
}

# # INGRESS: 5432 from anywhere
# resource "oci_core_network_security_group_security_rule" "nsg_prod_redis_ingress" {
#   network_security_group_id = oci_core_network_security_group.nsg_prod_redis.id
#   direction                 = "INGRESS"
#   protocol                  = "6"
#   # source                    = "10.10.32.0/20"
#   source = var.web_worker_sub_cidr
#   source_type               = "CIDR_BLOCK"
#   description               = "Allow 6379 from web_worker"

#   # Optional: Restrict to ping only (echo request = type 8)
#   tcp_options {
#     destination_port_range {
#       min = 6379
#       max = 6379
#     }
#   }
# }
# INGRESS: 5432 from Worker
resource "oci_core_network_security_group_security_rule" "nsg_prod_redis_ingress_from_cms_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_redis.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.cms_worker_sub_cidr
  source_type               = "CIDR_BLOCK"
  description               = "Allow 6379 from CMS worker"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 6379
      max = 6379
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_redis_ingress_from_cms_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_redis.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.cms_worker_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow 6379 from CMS pod"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 6379
      max = 6379
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_redis_ingress_from_web_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_redis.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.web_worker_sub_cidr
  source_type               = "CIDR_BLOCK"
  description               = "Allow 6379 from WEB worker"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 6379
      max = 6379
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_redis_ingress_from_web_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_redis.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.web_worker_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow 6379 from web pod"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 6379
      max = 6379
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_redis_ingress_from_airs_worker" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_redis.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.airs_micro_oke_worker_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow 6379 from AIRS worker"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 6379
      max = 6379
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_redis_ingress_from_airs_pod" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_redis.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.airs_micro_oke_pod_cidr_block
  source_type               = "CIDR_BLOCK"
  description               = "Allow 6379 from AIRS pod"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 6379
      max = 6379
    }
  }
}
# EGRESS: Allow all 
resource "oci_core_network_security_group_security_rule" "nsg_prod_redis_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_redis.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  # destination      = oci_core_network_security_group.nsg_prod_airs.id
  # destination_type = "NETWORK_SECURITY_GROUP"
  description      = "Allow to all"

  tcp_options { }
}


##############################
#### NSG for OKE          ####
##############################

resource "oci_core_network_security_group" "nsg_prod_k8s_api_endpoints" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_k8s_api_endpoint
}

locals {
  k8s_api_ep = {
    web_worker_6443  = { cidr = var.web_worker_sub_cidr, port = "6443" }
    web_worker_12250 = { cidr = var.web_worker_sub_cidr, port = "12250" }
    web_pod_6443     = { cidr = var.web_worker_pod_cidr_block, port = "6443" }
    web_pod_12250    = { cidr = var.web_worker_pod_cidr_block, port = "12250" }
    cms_worker_6443  = { cidr = var.cms_worker_sub_cidr, port = "6443" }
    cms_worker_12250 = { cidr = var.cms_worker_sub_cidr, port = "12250" }
    cms_pod_6443     = { cidr = var.cms_worker_pod_cidr_block, port = "6443" }
    cms_pod_12250    = { cidr = var.cms_worker_pod_cidr_block, port = "12250" }
    airs_worker_6443  = { cidr = var.airs_micro_oke_worker_cidr_block, port = "6443" }
    airs_worker_12250 = { cidr = var.airs_micro_oke_worker_cidr_block, port = "12250" }
    airs_pod_6443     = { cidr = var.airs_micro_oke_pod_cidr_block, port = "6443" }
    airs_pod_12250    = { cidr = var.airs_micro_oke_pod_cidr_block, port = "12250" }
    apisix_worker_6443  = { cidr = var.apisix_oke_worker_cidr_block, port = "6443" }
    apisix_worker_12250 = { cidr = var.apisix_oke_worker_cidr_block, port = "12250" }
    apisix_pod_6443     = { cidr = var.apisix_oke_pod_cidr_block, port = "6443" }
    apisix_pod_12250    = { cidr = var.apisix_oke_pod_cidr_block, port = "12250" }
    authentik_worker_6443  = { cidr = var.authentik_oke_worker_cidr_block, port = "6443" }
    authentik_worker_12250 = { cidr = var.authentik_oke_worker_cidr_block, port = "12250" }
    authentik_pod_6443     = { cidr = var.authentik_oke_pod_cidr_block, port = "6443" }
    authentik_pod_12250    = { cidr = var.authentik_oke_pod_cidr_block, port = "12250" }
  }
}

# INGRESS 
resource "oci_core_network_security_group_security_rule" "nsg_prod_k8s_api_endpoints_ingress" {
  for_each                  = local.k8s_api_ep
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = each.value.cidr
  source_type               = "CIDR_BLOCK"
  description               = "Kubernetes ${each.key} to Kubernetes API endpoint communication."

  tcp_options {
    destination_port_range {
      min = each.value.port
      max = each.value.port
    }
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_k8s_api_endpoints_worker_ingress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "INGRESS"
  protocol                  = "1" # ICMP
  # source                    = "10.10.32.0/20"
  source = var.web_worker_sub_cidr
  source_type               = "CIDR_BLOCK"
  stateless                 = false
  description               = "Path MTU Discovery from web worker nodes (ICMP type 3 code 4)."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_k8s_api_endpoints_cms_ingress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "INGRESS"
  protocol                  = "1" # ICMP
  # source                    = "10.10.16.0/20"
  source = var.cms_worker_sub_cidr
  source_type               = "CIDR_BLOCK"
  stateless                 = false
  description               = "Path MTU Discovery from cms worker nodes (ICMP type 3 code 4)."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_k8s_api_endpoints_airs_ingress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "INGRESS"
  protocol                  = "1" # ICMP
  # source                    = "10.10.96.0/20"
  source = var.airs_micro_oke_worker_cidr_block
  source_type               = "CIDR_BLOCK"
  stateless                 = false
  description               = "Path MTU Discovery from airs worker nodes (ICMP type 3 code 4)."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_k8s_api_endpoints_apisix_ingress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "INGRESS"
  protocol                  = "1" # ICMP
  # source                    = "10.10.96.0/20"
  source = var.apisix_oke_worker_cidr_block
  source_type               = "CIDR_BLOCK"
  stateless                 = false
  description               = "Path MTU Discovery from airs worker nodes (ICMP type 3 code 4)."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_k8s_api_endpoints_authentik_ingress_icmp" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "INGRESS"
  protocol                  = "1" # ICMP
  # source                    = "10.10.96.0/20"
  source = var.authentik_oke_worker_cidr_block
  source_type               = "CIDR_BLOCK"
  stateless                 = false
  description               = "Path MTU Discovery from airs worker nodes (ICMP type 3 code 4)."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "nsg_prod_k8s_api_endpoints_ingress_all" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  stateless                 = false
  description               = "Client access to Kubernetes API endpoint"

  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}

# EGRESS: 
resource "oci_core_network_security_group_security_rule" "nsg_prod_k8s_api_endpoints_ingress_osn_443" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "6"
  stateless                 = false
  destination               = data.oci_core_services.services.services[0].cidr_block
  destination_type          = "SERVICE_CIDR_BLOCK"
  description               = "Allow Kubernetes API endpoint to communicate with OKE."

  tcp_options {
    destination_port_range {
      max = 443
      min = 443
    }
  }
}
resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_pod_tcp_all" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "all"
  stateless                 = false
  # destination               = "10.10.112.0/20"
  destination = var.web_worker_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to pod communication (when using VCN-native pod networking)"
}
resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_worker_tcp_10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "6" # TCP
  stateless                 = false
  # destination               = "10.10.32.0/20"
  destination = var.web_worker_sub_cidr
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to worker node communication over TCP/10250 (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 10250
      max = 10250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_worker_icmp_3_4" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "1" # ICMP
  stateless                 = false
  # destination               = "10.10.32.0/20"
  destination = var.web_worker_sub_cidr
  destination_type          = "CIDR_BLOCK"
  description               = "Path Discovery (ICMP type 3 code 4) to worker nodes."

  icmp_options {
    type = 3
    code = 4
  }
}

resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_cms_pod_tcp_all" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "all"
  stateless                 = false
  # destination               = "10.10.128.0/20"
  destination = var.cms_worker_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to cms pod communication (when using VCN-native pod networking)"
}
resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_cms_worker_tcp_10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "6" # TCP
  stateless                 = false
  # destination               = "10.10.16.0/20"
  destination = var.cms_worker_sub_cidr
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to cms worker node communication over TCP/10250 (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 10250
      max = 10250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_cms_worker_icmp_3_4" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "1" # ICMP
  stateless                 = false
  # destination               = "10.10.16.0/20"
  destination = var.cms_worker_sub_cidr
  destination_type          = "CIDR_BLOCK"
  description               = "Path Discovery (ICMP type 3 code 4) to cms worker nodes."

  icmp_options {
    type = 3
    code = 4
  }
}

resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_airs_pod_tcp_all" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "all"
  stateless                 = false
  # destination               = "10.10.144.0/20"
  destination = var.airs_micro_oke_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to airs pod communication (when using VCN-native pod networking)"
}
resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_airs_worker_tcp_10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "6" # TCP
  stateless                 = false
  # destination               = "10.10.96.0/20"
  destination = var.airs_micro_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to airs worker node communication over TCP/10250 (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 10250
      max = 10250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_airs_worker_icmp_3_4" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "1" # ICMP
  stateless                 = false
  # destination               = "10.10.96.0/20"
  destination = var.airs_micro_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Path Discovery (ICMP type 3 code 4) to cms worker nodes."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_apisix_pod_tcp_all" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "all"
  stateless                 = false
  # destination               = "10.10.144.0/20"
  destination = var.apisix_oke_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to airs pod communication (when using VCN-native pod networking)"
}
resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_apisix_worker_tcp_10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "6" # TCP
  stateless                 = false
  # destination               = "10.10.96.0/20"
  destination = var.apisix_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to airs worker node communication over TCP/10250 (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 10250
      max = 10250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_apisix_worker_icmp_3_4" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "1" # ICMP
  stateless                 = false
  # destination               = "10.10.96.0/20"
  destination = var.apisix_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Path Discovery (ICMP type 3 code 4) to cms worker nodes."

  icmp_options {
    type = 3
    code = 4
  }
}
resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_authentik_pod_tcp_all" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "all"
  stateless                 = false
  # destination               = "10.10.144.0/20"
  destination = var.authentik_oke_pod_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to airs pod communication (when using VCN-native pod networking)"
}
resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_authentik_worker_tcp_10250" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "6" # TCP
  stateless                 = false
  # destination               = "10.10.96.0/20"
  destination = var.authentik_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Kubernetes API endpoint to airs worker node communication over TCP/10250 (when using VCN-native pod networking)."
  tcp_options {
    destination_port_range {
      min = 10250
      max = 10250
    }
  }
}
resource "oci_core_network_security_group_security_rule" "k8s_api_endpoint_egress_authentik_worker_icmp_3_4" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_k8s_api_endpoints.id
  direction                 = "EGRESS"
  protocol                  = "1" # ICMP
  stateless                 = false
  # destination               = "10.10.96.0/20"
  destination = var.authentik_oke_worker_cidr_block
  destination_type          = "CIDR_BLOCK"
  description               = "Path Discovery (ICMP type 3 code 4) to cms worker nodes."

  icmp_options {
    type = 3
    code = 4
  }
}




## Creating IGW and NAT Gateway##

resource "oci_core_internet_gateway" "igw" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id

  display_name = "${var.vcn_display_name}-igw"
  enabled      = true

  freeform_tags = var.freeform_tags
}


# Reserved (Regional) Public IP
# ----------------------------
resource "oci_core_public_ip" "nat_reserved_ip" {
  compartment_id = oci_identity_compartment.net_compartment.id
  lifetime       = "RESERVED"

  lifecycle {
    ignore_changes = [private_ip_id]
  }

  display_name  = "${var.vcn_display_name}-nat-reserved-ip"
  freeform_tags = var.freeform_tags
}

resource "oci_core_public_ip" "lb_reserved_ip" {
  compartment_id = oci_identity_compartment.net_compartment.id
  lifetime       = "RESERVED"

  lifecycle {
    ignore_changes = [private_ip_id]
  }


  display_name  = "${var.vcn_display_name}-lb-reserved-ip"
  freeform_tags = var.freeform_tags
}

resource "oci_core_public_ip" "web_cluster_lb_reserved_ip" {
  compartment_id = oci_identity_compartment.net_compartment.id
  lifetime       = "RESERVED"

  lifecycle {
    ignore_changes = [private_ip_id]
  }


  display_name  = "${var.vcn_display_name}-web-cluster-lb-reserved-ip"
  freeform_tags = var.freeform_tags
}

resource "oci_core_public_ip" "cms_cluster_lb_reserved_ip" {
  compartment_id = oci_identity_compartment.net_compartment.id
  lifetime       = "RESERVED"

  lifecycle {
    ignore_changes = [private_ip_id]
  }


  display_name  = "${var.vcn_display_name}-cms-cluster-lb-reserved-ip"
  freeform_tags = var.freeform_tags
}

resource "oci_core_public_ip" "airs_cluster_lb_reserved_ip" {
  compartment_id = oci_identity_compartment.net_compartment.id
  lifetime       = "RESERVED"

  lifecycle {
    ignore_changes = [private_ip_id]
  }


  display_name  = "${var.vcn_display_name}-airs-cluster-lb-reserved-ip"
  freeform_tags = var.freeform_tags
}

resource "oci_core_public_ip" "apisix_cluster_lb_reserved_ip" {
  compartment_id = oci_identity_compartment.net_compartment.id
  lifetime       = "RESERVED"

  lifecycle {
    ignore_changes = [private_ip_id]
  }


  display_name  = "${var.vcn_display_name}-apisix-cluster-lb-reserved-ip"
  freeform_tags = var.freeform_tags
}


resource "oci_core_nat_gateway" "nat" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "${var.vcn_display_name}-nat"
  depends_on     = [oci_core_public_ip.nat_reserved_ip]
  
  # Attach the reserved IP here
  public_ip_id = oci_core_public_ip.nat_reserved_ip.id


  freeform_tags = var.freeform_tags
}

###############################################
## Creating Public and Private Routing Table ##
###############################################

resource "oci_core_route_table" "public_rt" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id

  display_name = "${var.vcn_display_name}-public-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
    description       = "Public subnet default route via Internet Gateway"
  }

  freeform_tags = var.freeform_tags
}

resource "oci_core_route_table" "private_rt" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id

  display_name = "${var.vcn_display_name}-private-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat.id
    description       = "Private subnet default route via NAT Gateway"
  }

  route_rules {
    destination       = data.oci_core_services.services.services[0].cidr_block
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.service_gateway.id
    description       = "Private subnet default route via NAT Gateway"
  }

  freeform_tags = var.freeform_tags
}

# resource "oci_core_route_table" "web-workernodes-rt" {
#   compartment_id = oci_identity_compartment.net_compartment.id
#   vcn_id         = oci_core_vcn.terra_vcn.id

#   display_name = "${var.vcn_display_name}-routetable-web-workernodes"

#   route_rules {
#     destination       = data.oci_core_services.services.services[0].cidr_block
#     destination_type  = "SERVICE_CIDR_BLOCK"
#     network_entity_id = oci_core_service_gateway.service_gateway.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   route_rules {
#     destination       = "0.0.0.0/0"
#     destination_type  = "CIDR_BLOCK"
#     network_entity_id = oci_core_nat_gateway.nat.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   freeform_tags = var.freeform_tags
# }

# resource "oci_core_route_table" "cms-workernodes-rt" {
#   compartment_id = oci_identity_compartment.net_compartment.id
#   vcn_id         = oci_core_vcn.terra_vcn.id

#   display_name = "${var.vcn_display_name}-routetable-cms-workernodes"

#   route_rules {
#     destination       = data.oci_core_services.services.services[0].cidr_block
#     destination_type  = "SERVICE_CIDR_BLOCK"
#     network_entity_id = oci_core_service_gateway.service_gateway.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   route_rules {
#     destination       = "0.0.0.0/0"
#     destination_type  = "CIDR_BLOCK"
#     network_entity_id = oci_core_nat_gateway.nat.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   freeform_tags = var.freeform_tags
# }

# resource "oci_core_route_table" "airs-workernodes-rt" {
#   compartment_id = oci_identity_compartment.net_compartment.id
#   vcn_id         = oci_core_vcn.terra_vcn.id

#   display_name = "${var.vcn_display_name}-routetable-airs-workernodes"

#   route_rules {
#     destination       = data.oci_core_services.services.services[0].cidr_block
#     destination_type  = "SERVICE_CIDR_BLOCK"
#     network_entity_id = oci_core_service_gateway.service_gateway.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   route_rules {
#     destination       = "0.0.0.0/0"
#     destination_type  = "CIDR_BLOCK"
#     network_entity_id = oci_core_nat_gateway.nat.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   freeform_tags = var.freeform_tags
# }

# resource "oci_core_route_table" "KubernetesAPIendpoint" {
#   compartment_id = oci_identity_compartment.net_compartment.id
#   vcn_id         = oci_core_vcn.terra_vcn.id

#   display_name = "${var.vcn_display_name}-KubernetesAPIendpoint"

#   route_rules {
#     destination       = data.oci_core_services.services.services[0].cidr_block
#     destination_type  = "SERVICE_CIDR_BLOCK"
#     network_entity_id = oci_core_service_gateway.service_gateway.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   route_rules {
#     destination       = "0.0.0.0/0"
#     destination_type  = "CIDR_BLOCK"
#     network_entity_id = oci_core_nat_gateway.nat.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   freeform_tags = var.freeform_tags
# }

# resource "oci_core_route_table" "routetable_web_pods" {
#   compartment_id = oci_identity_compartment.net_compartment.id
#   vcn_id         = oci_core_vcn.terra_vcn.id

#   display_name = "${var.vcn_display_name}-routetable-web-pods"

#   route_rules {
#     destination       = data.oci_core_services.services.services[0].cidr_block
#     destination_type  = "SERVICE_CIDR_BLOCK"
#     network_entity_id = oci_core_service_gateway.service_gateway.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   route_rules {
#     destination       = "0.0.0.0/0"
#     destination_type  = "CIDR_BLOCK"
#     network_entity_id = oci_core_nat_gateway.nat.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   freeform_tags = var.freeform_tags
# }

# resource "oci_core_route_table" "routetable_cms_pods" {
#   compartment_id = oci_identity_compartment.net_compartment.id
#   vcn_id         = oci_core_vcn.terra_vcn.id

#   display_name = "${var.vcn_display_name}-routetable-cms-pods"

#   route_rules {
#     destination       = data.oci_core_services.services.services[0].cidr_block
#     destination_type  = "SERVICE_CIDR_BLOCK"
#     network_entity_id = oci_core_service_gateway.service_gateway.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   route_rules {
#     destination       = "0.0.0.0/0"
#     destination_type  = "CIDR_BLOCK"
#     network_entity_id = oci_core_nat_gateway.nat.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   freeform_tags = var.freeform_tags
# }

# resource "oci_core_route_table" "routetable_airs_pods" {
#   compartment_id = oci_identity_compartment.net_compartment.id
#   vcn_id         = oci_core_vcn.terra_vcn.id

#   display_name = "${var.vcn_display_name}-routetable-airs-pods"

#   route_rules {
#     destination       = data.oci_core_services.services.services[0].cidr_block
#     destination_type  = "SERVICE_CIDR_BLOCK"
#     network_entity_id = oci_core_service_gateway.service_gateway.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   route_rules {
#     destination       = "0.0.0.0/0"
#     destination_type  = "CIDR_BLOCK"
#     network_entity_id = oci_core_nat_gateway.nat.id
#     description       = "Private subnet default route via NAT Gateway"
#   }

#   freeform_tags = var.freeform_tags
# }

# resource "oci_core_route_table" "routetable_pub_lb" {
#   compartment_id = oci_identity_compartment.net_compartment.id
#   vcn_id         = oci_core_vcn.terra_vcn.id

#   display_name = "${var.vcn_display_name}-routetable-pub-lb"

#   route_rules {
#     destination       = "0.0.0.0/0"
#     destination_type  = "CIDR_BLOCK"
#     network_entity_id = oci_core_internet_gateway.igw.id
#   }

#   freeform_tags = var.freeform_tags
# }


data "oci_core_services" "services" {}

resource "oci_core_service_gateway" "service_gateway" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  services {
    #Required
    service_id = data.oci_core_services.services.services[0].id
  }
  vcn_id = oci_core_vcn.terra_vcn.id

  #Optional
  display_name  = var.service_gateway_display_name
  freeform_tags = var.freeform_tags
  # route_table_id = oci_core_route_table.test_route_table.id
}
