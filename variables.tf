################################
### Infra Setup              ###
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

variable "nsg_redis" {
  default = "NSG-PROD-REDIS"
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
### Database Variable           ###
###################################

# variable "db_display_name" {
#   type        = string
#   description = "Display name for the PostgreSQL DB system"
#   default     = "oci-postgresql-db"
# }

# variable "description" {
#   type        = string
#   description = "Description for the PostgreSQL DB system"
#   default     = "Managed PostgreSQL DB system created by Terraform"
# }

# variable "db_version" {
#   type        = number
#   description = "PostgreSQL major version"
#   default     = 14
# }

# variable "shape" {
#   type        = string
#   description = "Shape for OCI PostgreSQL DB system"
#   default     = "PostgreSQL.VM.Standard.E5.Flex"
# }

# variable "instance_count" {
#   type        = number
#   description = "Number of DB instances/nodes"
#   default     = 1
# }

# variable "instance_ocpu_count" {
#   type        = number
#   description = "OCPU count per DB instance"
#   default     = 4
# }

# variable "instance_memory_size_in_gbs" {
#   type        = number
#   description = "Memory per DB instance in GB"
#   default     = 16
# }

# variable "admin_username" {
#   type        = string
#   description = "PostgreSQL admin username"
#   default     = "admin"
# }

# variable "admin_password" {
#   type        = string
#   description = "PostgreSQL admin password"
#   default = "153709Swl$%"
#   # sensitive   = true  
# }

# variable "enable_reader_endpoint" {
#   type        = bool
#   description = "Enable reader endpoint"
#   default     = false
# }

# variable "storage_is_regionally_durable" {
#   type        = bool
#   description = "Use regionally durable storage"
#   default     = false
# }

# variable "storage_system_type" {
#   type        = string
#   description = "Storage system type"
#   default     = "OCI_OPTIMIZED_STORAGE"
# }

# variable "availability_domain" {
#   type        = string
#   description = "Required only when storage_is_regionally_durable = false"
#   default     = "aluk:AP-SINGAPORE-1-AD-1" ## null
# }





# ################################
# ###      For Instances       ###
# ################################

# variable "ad_index" {
#   description = "Which AD index to use (0 = first AD)."
#   type        = number
#   default     = 0
# }


# variable "instance_shape" {
#   description = "Compute shape (e.g., VM.Standard.E4.Flex, VM.Standard.A1.Flex, etc.)"
#   type        = string
#   default     = "VM.Standard.E5.Flex"
# }

# # Image selection (auto)
# variable "image_operating_system" {
#   type        = string
#   default     = "Oracle Linux"
# }

# variable "image_operating_system_version" {
#   type        = string
#   default     = "9"
# }

# variable "image_ocid" {
#   type        = string
#   default     = null
# }


# variable "instance_ocpus" {
#   description = "OCPUs for Flex shapes."
#   type        = number
#   default     = 1
# }

# variable "instance_memory_in_gbs" {
#   description = "Memory (GB) for Flex shapes."
#   type        = number
#   default     = 8
# }

# variable "career_vm" {
#   default = "CareerVM"
# }

# ##################################
# ### Loadbalancer Variable      ###
# ##################################


# variable "lb_display_name" {
#   type    = string
#   default = "pub-lb"
# }

# variable "is_private" {
#   type    = bool
#   default = false
# }

# variable "lb_shape" {
#   description = "flexible or traditional shapes"
#   type        = string
#   default     = "flexible"
# }

# variable "min_bandwidth" {
#   type    = number
#   default = 10
# }

# variable "max_bandwidth" {
#   type    = number
#   default = 100
# }

# variable "backendset_name" {
#   type    = string
#   default = "backendset1"
# }

# variable "listener_name" {
#   type    = string
#   default = "listener1"
# }

# variable "listener_port" {
#   type    = number
#   default = 80
# }

# variable "backend_port" {
#   type    = number
#   default = 80
# }

# variable "backend_ips" {
#   description = "Map of backend IPs"
#   type        = map(string)
#   default     = {}
# }

# variable "healthcheck_port" {
#   type    = number
#   default = 80
# }

# ###################
# ## Redis Cluster ##
# ###################

# variable "redis_display_name" {
#   description = "Display name for the Redis cluster."
#   type        = string
#   default = "prod-redis"
# }


# variable "software_version" {
#   description = "OCI Cache engine version, for example REDIS_7_0."
#   type        = string
#   default     = "REDIS_7_0"
# }

# variable "cluster_mode" {
#   description = "Cluster mode: NONSHARDED or SHARDED."
#   type        = string
#   default     = "NONSHARDED"

#   validation {
#     condition     = contains(["NONSHARDED", "SHARDED"], var.cluster_mode)
#     error_message = "cluster_mode must be either NONSHARDED or SHARDED."
#   }
# }

# variable "node_count" {
#   description = "For NONSHARDED this is total nodes; for SHARDED this is nodes per shard."
#   type        = number
#   default     = 1
# }

# variable "node_memory_in_gbs" {
#   description = "Memory allocated per node in GB."
#   type        = number
#   default     = 2
# }

# variable "shard_count" {
#   description = "Number of shards when cluster_mode is SHARDED."
#   type        = number
#   default     = 3
# }

# variable "oci_cache_config_set_id" {
#   description = "Optional OCI Cache Config Set OCID."
#   type        = string
#   default     = null
# }

# ###############
# ##  Buckets  ##
# ###############

# variable "bucket_name" {
#   description = "Name of the Object Storage bucket."
#   type        = string
#   default = "prod_bucket"
# }

# variable "access_type" {
#   description = "Bucket public access type: NoPublicAccess, ObjectRead, or ObjectReadWithoutList."
#   type        = string
#   default     = "NoPublicAccess"

#   validation {
#     condition     = contains(["NoPublicAccess", "ObjectRead", "ObjectReadWithoutList"], var.access_type)
#     error_message = "access_type must be one of: NoPublicAccess, ObjectRead, ObjectReadWithoutList."
#   }
# }

# variable "storage_tier" {
#   description = "Bucket storage tier: Standard or Archive."
#   type        = string
#   default     = "Standard"

#   validation {
#     condition     = contains(["Standard", "Archive"], var.storage_tier)
#     error_message = "storage_tier must be either Standard or Archive."
#   }
# }

# variable "auto_tiering" {
#   description = "Auto tiering setting. Common values are Disabled or InfrequentAccess."
#   type        = string
#   default     = "Disabled"
# }

# variable "versioning" {
#   description = "Enable object versioning on the bucket: Enabled or Disabled."
#   type        = string
#   default     = "Enabled"

#   validation {
#     condition     = contains(["Enabled", "Disabled"], var.versioning)
#     error_message = "versioning must be either Enabled or Disabled."
#   }
# }

# variable "object_events_enabled" {
#   description = "Whether Object Storage events are enabled for the bucket."
#   type        = bool
#   default     = false
# }

# variable "kms_key_id" {
#   description = "Optional KMS key OCID for bucket encryption."
#   type        = string
#   default     = null
# }

# variable "metadata" {
#   description = "Optional bucket metadata map."
#   type        = map(string)
#   default     = {}
# }

###############
###  Vault  ###
###############


# variable "vault_name" {
#   description = "Display name of the OCI KMS vault."
#   type        = string
#   default = "prod_vault"
# }

# variable "vault_type" {
#   description = "Vault type to create. DEFAULT is the standard OCI vault type."
#   type        = string
#   default     = "VIRTUAL_PRIVATE"
# }

# variable "secret_name" {
#   description = "Name of the secret."
#   type        = string
#   default = "db_cred"
# }

# variable "secret_value" {
#   description = "Plaintext secret value. It will be base64 encoded before being sent to OCI."
#   type        = map(string)
#   sensitive   = false
#   default = {
#     "username" = "user01"
#     "password" = "pa55w0rd"
#   }
# }

# variable "secret_version_name" {
#   description = "Optional name for the secret version."
#   type        = string
#   default     = null
# }

# variable "secret_stage" {
#   description = "Optional stage for the secret version, such as CURRENT or PENDING."
#   type        = string
#   default     = null
# }

# variable "rotation_interval_in_days" {
#   default = 7
#   description = "Key Rotation Day"
#   type = number
# }

# variable "time_of_schedule_start" {
#   default = "2026-03-20T00:00:00Z"
#   description = "Key Rotation Start Schedule"
# }

#######################
###     NPA         ###
#######################


variable "npa_display_name" {
  description = "Friendly name for the Path Analyzer Test."
  type        = string
  default     = "subnet-connectivity-test"
}

variable "protocol" {
  description = "IP protocol to use for the test. Common values: TCP, UDP, ICMP."
  type        = string
  default     = "TCP"

  validation {
    condition     = contains(["TCP", "UDP", "ICMP"], var.protocol)
    error_message = "protocol must be one of: TCP, UDP, ICMP."
  }
}


variable "cms_source_ip" {
  description = "Source IPv4 address inside the source subnet CIDR. It does not need to be active."
  type        = string
  default = "10.10.16.10"
}

variable "cms_destination_ip" {
  description = "Source IPv4 address inside the source subnet CIDR. It does not need to be active."
  type        = string
  default = "10.10.16.10"
}

variable "web_source_ip" {
  description = "Source IPv4 address inside the source subnet CIDR. It does not need to be active."
  type        = string
  default = "10.10.32.10"
}

variable "web_destination_ip" {
  description = "Source IPv4 address inside the source subnet CIDR. It does not need to be active."
  type        = string
  default = "10.10.32.10"
}


variable "db_destination_ip" {
  description = "Destination IPv4 address inside the destination subnet CIDR. It does not need to be active."
  type        = string
  default = "10.10.80.30"
}

variable "db_destination_port" {
  description = "Destination port for TCP/UDP analysis."
  type        = number
  default     = 3307
}

variable "cms_destination_port" {
  description = "Destination port for TCP/UDP analysis."
  type        = number
  default     = 80
}

variable "web_destination_port" {
  description = "Destination port for TCP/UDP analysis."
  type        = number
  default     = 80
}

variable "source_port" {
  description = "Optional source port for TCP/UDP analysis."
  type        = number
  default     = 1024
}

variable "is_bi_directional_analysis" {
  description = "Whether to check both forward and reverse paths."
  type        = bool
  default     = true
}





