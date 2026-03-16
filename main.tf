resource "oci_core_vcn" "terra_vcn" {
  #Required
  depends_on = [ oci_identity_compartment.net_compartment ]
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

  # Public subnet behavior
  prohibit_public_ip_on_vnic = false
  security_list_ids = [
    oci_core_security_list.ssh_security_list.id
  ]
  route_table_id = oci_core_route_table.public_rt.id

}

resource "oci_core_subnet" "cms_worker_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id

  #Optional
  cidr_block    = var.cms_worker_sub_cidr
  display_name  = "${var.vcn_display_name}-cms-worker-sub"
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  route_table_id             = oci_core_route_table.private_rt.id

}

resource "oci_core_subnet" "web_worker_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id

  #Optional
  cidr_block    = var.web_worker_sub_cidr
  display_name  = "${var.vcn_display_name}-web-worker-sub"
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  route_table_id             = oci_core_route_table.private_rt.id

}

resource "oci_core_subnet" "airs_micro_oke_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id

  #Optional
  cidr_block    = var.airs_micro_oke_cidr_block
  display_name  = "${var.vcn_display_name}-airs-micro-sub"
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  route_table_id             = oci_core_route_table.private_rt.id
}

resource "oci_core_subnet" "career_vm_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id

  #Optional
  cidr_block    = var.carrer_vm_cidr_block
  display_name  = "${var.vcn_display_name}-career-vm-sub"
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = false
  route_table_id             = oci_core_route_table.public_rt.id
}

resource "oci_core_subnet" "db_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  security_list_ids = [oci_core_security_list.redis_security_list.id]

  #Optional
  cidr_block    = var.db_cidr_block
  display_name  = "${var.vcn_display_name}-db-sub"
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id = oci_core_route_table.private_rt.id
}

resource "oci_core_subnet" "pub_api_gw_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id

  #Optional
  cidr_block    = var.pub_api_gw_cidr_block
  display_name  = "${var.vcn_display_name}-pub-api-gw-sub"
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  route_table_id             = oci_core_route_table.public_rt.id
}

resource "oci_core_subnet" "priv_lb_sub" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id

  #Optional
  cidr_block    = var.priv_lb_cidr_block
  display_name  = "${var.vcn_display_name}-priv-lb-sub"
  freeform_tags = var.freeform_tags

  # Public subnet behavior
  prohibit_public_ip_on_vnic = true
  # route_table_id = oci_core_route_table.private_rt.id
}

## Creating Security List ## 

resource "oci_core_security_list" "ssh_security_list" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = "all_allow_ssh_ingress"
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    description = "allow ssh from everywhere"
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol    = "1" # ICMP
    source      = "0.0.0.0/0"
    description = "Allow ICMP from anywhere"
  }


  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
    description = "Allow all egress"
  }

  freeform_tags = var.freeform_tags

}

resource "oci_core_security_list" "redis_security_list" {
  #Required
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.redis_all_db_sl
  ingress_security_rules {
    protocol    = "6"
    source      = "10.10.80.0/24"
    description = "allow 6379 from db subnet"
    tcp_options {
      min = 6379
      max = 6379
    }
  }

  # egress_security_rules {
  #   protocol    = "all"
  #   destination = "0.0.0.0/0"
  #   description = "Allow all egress"
  # }

  freeform_tags = var.freeform_tags

}

## Creating NSG ##

resource "oci_core_network_security_group" "nsg_prod_lb" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_lb
}

# # INGRESS: SSH from anywhere
# resource "oci_core_network_security_group_security_rule" "ingress_ssh" {
#   network_security_group_id = oci_core_network_security_group.allow_http_https_all_egress.id
#   direction                 = "INGRESS"
#   protocol                  = "6" # TCP
#   source                    = "0.0.0.0/0"
#   source_type               = "CIDR_BLOCK"
#   description               = "Allow SSH from anywhere"

#   tcp_options {
#     destination_port_range {
#       min = 22
#       max = 22
#     }
#   }
# }

# # INGRESS: ICMP from anywhere
# resource "oci_core_network_security_group_security_rule" "ingress_icmp" {
#   network_security_group_id = oci_core_network_security_group.allow_http_https_all_egress.id
#   direction                 = "INGRESS"
#   protocol                  = "1" # ICMP
#   source                    = "0.0.0.0/0"
#   source_type               = "CIDR_BLOCK"
#   description               = "Allow ICMP from anywhere"

#   # Optional: Restrict to ping only (echo request = type 8)
#   # icmp_options {
#   #   type = 8
#   # }
# }

# INGRESS: 80 from anywhere
resource "oci_core_network_security_group_security_rule" "ingress_http" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Allow http from anywhere"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
}

# INGRESS: 443 from anywhere
resource "oci_core_network_security_group_security_rule" "nsg_prod_lb_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_lb.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Allow 443 from anywhere"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}

# For multiple egress target , create "local" data

locals {
  lb_egress_targets = {
    cms  = { id = oci_core_network_security_group.nsg_prod_cms.id }
    web  = { id = oci_core_network_security_group.nsg_prod_web.id }
    airs = { id = oci_core_network_security_group.nsg_prod_airs.id }
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

resource "oci_core_network_security_group" "nsg_prod_cms" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_cms
}

# Create local data for 80/443
locals {
  lb_ingress_target = {
    http  = { id = oci_core_network_security_group.nsg_prod_lb.id, port = 80 }
    https = { id = oci_core_network_security_group.nsg_prod_lb.id, port = 443 }
    web   = { id = oci_core_network_security_group.nsg_prod_web.id, port = 9090 }
  }
}
# INGRESS: 80 from anywhere
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_ingress" {
  for_each                  = local.lb_ingress_target
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = each.value.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "Allow From NSG PROD LB"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      max = each.value.port
      min = each.value.port
    }
  }
}

# resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_ingress_1" {
#   network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
#   direction                 = "INGRESS"
#   protocol                  = "6" 
#   source                    = oci_core_network_security_group.nsg_prod_web.id
#   source_type               = "NETWORK_SECURITY_GROUP"
#   description               = "Allow From NSG PROD LB"

#   # Optional: Restrict to ping only (echo request = type 8)
#   tcp_options {
#     destination_port_range {
#       min = "9090"
#       max = "9090"
#     }
#   }
# }


# EGRESS: Allow all
resource "oci_core_network_security_group_security_rule" "nsg_prod_cms_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_cms.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "10.10.80.0/24"
  destination_type          = "CIDR_BLOCK"
  description               = "Allow to DB subnet"
  tcp_options {
    destination_port_range {
      max = "3306"
      min = "3306"
    }
  }
}

resource "oci_core_network_security_group" "nsg_prod_web" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_web
}

locals {
  nsg_lb_ingress_target = {
    http  = { id = oci_core_network_security_group.nsg_prod_lb.id, port = 80 }
    https = { id = oci_core_network_security_group.nsg_prod_lb.id, port = 443 }
  }
}

# INGRESS: 80 from anywhere
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_ingress" {
  for_each                  = local.nsg_lb_ingress_target
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = each.value.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "Allow http from NSG-PROD-LB"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = each.value.port
      max = each.value.port
    }
  }
}

# EGRESS: Allow all
resource "oci_core_network_security_group_security_rule" "nsg_prod_web_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = oci_core_network_security_group.nsg_prod_airs.id
  destination_type          = "NETWORK_SECURITY_GROUP"
  description               = "Allow all egress"
}

resource "oci_core_network_security_group_security_rule" "nsg_prod_web_egress_1" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_web.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "10.10.80.0/24"
  destination_type          = "CIDR_BLOCK"
  description               = "Allow 3306 to DB"
  tcp_options {
    destination_port_range {
      max = 3306
      min = 3306
    }
  }
}

resource "oci_core_network_security_group" "nsg_prod_airs" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_airs
}

locals {
  api_web_ingress = {
    apigw = { id = oci_core_network_security_group.nsg_prod_api_gw.id, port = 8080 }
    web   = { id = oci_core_network_security_group.nsg_prod_web.id, port = 8088 }
  }
}
# INGRESS: 80 from anywhere
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_ingress" {
  for_each                  = local.api_web_ingress
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

# EGRESS: Allow all to DB
resource "oci_core_network_security_group_security_rule" "nsg_prod_airs_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_airs.id
  direction                 = "EGRESS"
  protocol                  = "all"
  destination               = "10.10.80.0/24"
  destination_type          = "CIDR_BLOCK"
  description               = "Allow to db_subnet"
}

resource "oci_core_network_security_group" "nsg_prod_careers" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_careers
}

locals {
  lb_ingress_allow = {
    http        = { id = oci_core_network_security_group.nsg_prod_lb.id, port = "80" }
    https       = { id = oci_core_network_security_group.nsg_prod_lb.id, port = "443" }
    bastion_ssh = { id = oci_core_network_security_group.nsg_prod_bastion.id, port = "22" }
  }
}
# INGRESS: LB subnet to 80, 443, ssh from bastion
resource "oci_core_network_security_group_security_rule" "nsg_prod_career_ingress" {
  for_each                  = local.lb_ingress_allow
  network_security_group_id = oci_core_network_security_group.nsg_prod_careers.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = each.value.id
  source_type               = "NETWORK_SECURITY_GROUP"
  description               = "Allow http/https from LB"


  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = each.value.port
      max = each.value.port
    }
  }
}

# EGRESS: Allow all
resource "oci_core_network_security_group_security_rule" "nsg_prod_career_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_careers.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "10.10.80.0/24"
  destination_type          = "CIDR_BLOCK"
  description               = "Allow egress to DB 3306"
  tcp_options {
    destination_port_range {
      max = 3306
      min = 3306
    }
  }
}

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
  source                    = "211.24.105.105/32"
  source_type               = "CIDR_BLOCK"
  description               = "Allow ssh from office vpn"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}

# EGRESS: Allow all 
resource "oci_core_network_security_group_security_rule" "nsg_prod_bastion_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_bastion.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  description               = "Allow to All"
}

resource "oci_core_network_security_group" "nsg_prod_api_gw" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_api_gw
}

# INGRESS: 443 from anywhere
resource "oci_core_network_security_group_security_rule" "nsg_prod_api_gw_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_api_gw.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Allow https from anywhere"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}

# EGRESS: Allow 443 to AIRS
resource "oci_core_network_security_group_security_rule" "nsg_prod_api_gw_egress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_api_gw.id
  direction                 = "EGRESS"
  protocol                  = "6"
  # destination               = "0.0.0.0/0"
  # destination_type          = "CIDR_BLOCK"
  destination      = oci_core_network_security_group.nsg_prod_airs.id
  destination_type = "NETWORK_SECURITY_GROUP"
  description      = "Allow to AIRS 443"

  tcp_options {
    destination_port_range {
      max = 443
      min = 443
    }
  }
}

resource "oci_core_network_security_group" "nsg_prod_db" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_db
}

# INGRESS: 5432 from anywhere
resource "oci_core_network_security_group_security_rule" "nsg_prod_db_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_db.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  description               = "Allow 5432 from anywhere"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 5432
      max = 5432
    }
  }
}

resource "oci_core_network_security_group" "nsg_prod_redis" {
  compartment_id = oci_identity_compartment.net_compartment.id
  vcn_id         = oci_core_vcn.terra_vcn.id
  display_name   = var.nsg_redis
}

# INGRESS: 5432 from anywhere
resource "oci_core_network_security_group_security_rule" "nsg_prod_redis_ingress" {
  network_security_group_id = oci_core_network_security_group.nsg_prod_redis.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.10.32.0/20"
  source_type               = "CIDR_BLOCK"
  description               = "Allow 6379 from web_worker"

  # Optional: Restrict to ping only (echo request = type 8)
  tcp_options {
    destination_port_range {
      min = 6379
      max = 6379
    }
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


  display_name = "${var.vcn_display_name}-nat-reserved-ip"
  freeform_tags = var.freeform_tags
}

resource "oci_core_public_ip" "lb_reserved_ip" {
  compartment_id = oci_identity_compartment.net_compartment.id
  lifetime       = "RESERVED"

lifecycle {
    ignore_changes = [private_ip_id]
  }


  display_name = "${var.vcn_display_name}-lb-reserved-ip"
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

## Creating Public and Private Routing Table ##

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

  freeform_tags = var.freeform_tags
}
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
    display_name = var.service_gateway_display_name
    freeform_tags = var.freeform_tags
    # route_table_id = oci_core_route_table.test_route_table.id
}
