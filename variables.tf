variable "region" {
  default = "ap-singapore-1"
}

variable "compartment_id" {
  default = "ocid1.compartment.oc1..aaaaaaaa66fxteh6dfourcq5gawtsriddatufcb5dmqyxhdyiutntzsvbpza"
}

variable "vcn_display_name" {
  default = "prod"
  type    = string
}

variable "vcn_cidr_block" {
  default = ["10.10.0.0/16"]
  type    = list(string)
}

variable "vcn_dns_label" {
  default = "prod"
  type    = string
}

variable "lb_subnet_cidr" {
  default = "10.10.0.0/24"
}

variable "cms_worker_sub_cidr" {
  default = "10.10.16.0/20"
}

variable "web_worker_sub_cidr" {
  default = "10.10.32.0/20"
}

variable "airs_micro_oke_cidr_block" {
  default = "10.10.96.0/20"
}

variable "carrer_vm_cidr_block" {
  default = "10.10.70.0/24"
}

variable "db_cidr_block" {
  default = "10.10.80.0/24"
}

variable "pub_api_gw_cidr_block" {
  default = "10.10.5.0/24"
}

variable "priv_lb_cidr_block" {
  default = "10.10.55.0/24"
}

variable "nsg_lb" {
  default = "NSG-PROD-LB"
}

variable "nsg_cms" {
  default = "NSG-PROD-CMS"
}

variable "nsg_web" {
  default = "NSG-PROD-WEB"
}

variable "nsg_airs" {
  default = "NSG-PROD-AIRS"
}

variable "nsg_careers" {
  default = "NSG-PROD-CARRERS"
}

variable "nsg_api_gw" {
  default = "NSG-PROD-API-GW"
}

variable "nsg_bastion" {
  default = "NSG-PROD-BASTION"
}

variable "tenancy_ocid" {
  description = "Tenancy OCID (needed to query Availability Domains)."
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaatqwblz7zyqmzal6265vaijaqiwfmqejptj5zh7dhnornymkvlina"
}


variable "ad_index" {
  description = "Which AD index to use (0 = first AD)."
  type        = number
  default     = 0
}


variable "instance_shape" {
  description = "Compute shape (e.g., VM.Standard.E4.Flex, VM.Standard.A1.Flex, etc.)"
  type        = string
  default     = "VM.Standard.E5.Flex"
}


variable "ssh_public_key" {
  description = "SSH public key content used for instance login."
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMMNtwjmuKJ2sZgOm6hFTD0Vu2LVyR9ac72w5uyiRe8U swl@swl"
}


# Image selection (auto)
variable "image_operating_system" {
  type    = string
  default = "Oracle Linux"
}


variable "common_freeform_tags" {
  type = map(string)
  default = {
    Department = "Dev"
  }
}


variable "image_operating_system_version" {
  type    = string
  default = "9"
}


variable "image_ocid" {
  type    = string
  default = null
}


variable "instance_ocpus" {
  description = "OCPUs for Flex shapes."
  type        = number
  default     = 1
}

variable "instance_memory_in_gbs" {
  description = "Memory (GB) for Flex shapes."
  type        = number
  default     = 8
}

# Optional validation to reduce mistakes
variable "is_flex_shape" {
  description = "Set true if instance_shape ends with .Flex (recommended to auto-detect via locals; see below)."
  type        = bool
  default     = true
}

# Who can access public LB listeners (80/443). Tighten to office/VPN CIDRs in prod.
variable "lb_ingress_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "lb_listener_ports" {
  type    = list(number)
  default = [80, 443]
}

# Default Kubernetes NodePort range (OCI LB -> worker backends)
variable "nodeport_min" {
  type    = number
  default = 30000
}

variable "nodeport_max" {
  type    = number
  default = 32767
}

# # Allow "all within cluster" traffic (common baseline).
# variable "allow_all_cluster_east_west" {
#   type    = bool
#   default = true
# }

## OKE ##


# # For public cluster endpoint - must be PUBLIC subnet if public endpoint enabled
# variable "endpoint_subnet_id" { 
#   type = string 
# }

# # Latest supported version (pinned clearly)
# # Oracle recommends using newest supported version; as of 2026-02-25 it's v1.34.2. [1](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengnetworkconfigexample.htm)
# variable "kubernetes_version" {
#   type    = string
#   default = "v1.34.2"
# }

# variable "cluster_name" {
#   type    = string
#   default = "oke-public-cluster"
# }

# variable "cluster_type" {
#   description = "BASIC_CLUSTER or ENHANCED_CLUSTER"
#   type        = string
#   default     = "BASIC_CLUSTER"
# }


# # Optional NSG attachments
# variable "cluster_endpoint_nsg_ids" {
#   type    = list(string)
#   default = []
# }

# variable "worker_nsg_ids" {
#   type    = list(string)
#   default = []
# }

# variable "pod_nsg_ids" {
#   type    = list(string)
#   default = []
# }
