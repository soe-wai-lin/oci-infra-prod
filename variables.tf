################################
### Infra Setup 
################################


variable "region" {
  default = "ap-singapore-1"
}

variable "compartment_id" {
  default = "ocid1.compartment.oc1..aaaaaaaafmd3eynylajhayrhegk6typot73nexdgkj7iksc3374pcv3zb45q"
  description = "mgmt compartment"
}

variable "vcn_display_name" {
  default = "prod"
  type    = string
}

variable "freeform_tags" {
  type        = map(string)
  description = "Freeform tags"
  default = {
    Environment = "Prod"
    Managed_by  = "Terraform"
  }
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

variable "nsg_db" {
  default = "NSG-PROD-DB"
}

variable "nsg_bastion" {
  default = "NSG-PROD-BASTION"
}

variable "alert_email" {
  default = "wailin.s@trinitywizards.com"
}

variable "tenancy_ocid" {
  description = "Tenancy OCID (needed to query Availability Domains)."
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaatqwblz7zyqmzal6265vaijaqiwfmqejptj5zh7dhnornymkvlina"
}

variable "ssh_public_key" {
  description = "SSH public key content used for instance login."
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMMNtwjmuKJ2sZgOm6hFTD0Vu2LVyR9ac72w5uyiRe8U swl@swl"
}



# variable "common_freeform_tags" {
#   type = map(string)
#   default = {
#     Env = "Prod"
#   }
# }

variable "net_comp" {
  default = "prod-net-comp"
}

variable "app_comp" {
  default = "prod-app-comp"
}

variable "db_comp" {
  default = "prod-db-comp"
}

variable "compartment_description" {
  default = "prod-compartment"
}

variable "service_gateway_display_name" {
  default = "prod-service-gateway"
}


###################################
### Database Variable 
###################################

variable "db_display_name" {
  type        = string
  description = "Display name for the PostgreSQL DB system"
  default     = "oci-postgresql-db"
}

variable "description" {
  type        = string
  description = "Description for the PostgreSQL DB system"
  default     = "Managed PostgreSQL DB system created by Terraform"
}

variable "db_version" {
  type        = number
  description = "PostgreSQL major version"
  default     = 14
}

variable "shape" {
  type        = string
  description = "Shape for OCI PostgreSQL DB system"
  default     = "PostgreSQL.VM.Standard.E5.Flex"
}

variable "instance_count" {
  type        = number
  description = "Number of DB instances/nodes"
  default     = 1
}

variable "instance_ocpu_count" {
  type        = number
  description = "OCPU count per DB instance"
  default     = 4
}

variable "instance_memory_size_in_gbs" {
  type        = number
  description = "Memory per DB instance in GB"
  default     = 16
}

variable "admin_username" {
  type        = string
  description = "PostgreSQL admin username"
  default     = "admin"
}

variable "admin_password" {
  type        = string
  description = "PostgreSQL admin password"
  default = "153709Swl$%"
  # sensitive   = true  
}

variable "enable_reader_endpoint" {
  type        = bool
  description = "Enable reader endpoint"
  default     = false
}

variable "storage_is_regionally_durable" {
  type        = bool
  description = "Use regionally durable storage"
  default     = false
}

variable "storage_system_type" {
  type        = string
  description = "Storage system type"
  default     = "OCI_OPTIMIZED_STORAGE"
}

variable "availability_domain" {
  type        = string
  description = "Required only when storage_is_regionally_durable = false"
  default     = "aluk:AP-SINGAPORE-1-AD-1" ## null
}

# variable "user_ocid" {
#   type        = string
#   description = "OCI user OCID"
# }

# variable "fingerprint" {
#   type        = string
#   description = "API key fingerprint"
# }

# variable "private_key_path" {
#   type        = string
#   description = "Path to OCI API private key"
# }


# variable "subnet_ocid" {
#   type        = string
#   description = "Existing private subnet OCID for the PostgreSQL DB system"
# }

# variable "allowed_cidr" {
#   type        = string
#   description = "CIDR block allowed to connect to PostgreSQL on port 5432"
#   default     = "10.0.0.0/16"
# }

# variable "storage_iops" {
#   type        = number
#   description = "Provisioned IOPS if applicable"
#   default     = null
# }





#################################
# For Instances
#################################

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

# Image selection (auto)
variable "image_operating_system" {
  type        = string
  default     = "Oracle Linux"
}

variable "image_operating_system_version" {
  type        = string
  default     = "9"
}

variable "image_ocid" {
  type        = string
  default     = null
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

variable "career_vm" {
  default = "CareerVM"
}

##################################
### Loadbalancer Variable
##################################


variable "lb_display_name" {
  type    = string
  default = "pub-lb"
}

variable "is_private" {
  type    = bool
  default = false
}

variable "lb_shape" {
  description = "flexible or traditional shapes"
  type        = string
  default     = "flexible"
}

variable "min_bandwidth" {
  type    = number
  default = 10
}

variable "max_bandwidth" {
  type    = number
  default = 100
}

variable "backendset_name" {
  type    = string
  default = "backendset1"
}

variable "listener_name" {
  type    = string
  default = "listener1"
}

variable "listener_port" {
  type    = number
  default = 80
}

variable "backend_port" {
  type    = number
  default = 80
}

variable "backend_ips" {
  description = "Map of backend IPs"
  type        = map(string)
  default     = {}
}

variable "healthcheck_port" {
  type    = number
  default = 80
}

