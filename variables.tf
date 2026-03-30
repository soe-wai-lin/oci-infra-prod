################################
### Infra Setup              ###
################################


variable "dc_region" {
  default = "ap-singapore-1"
}

variable "dr_region" {
  default = "ap-sydney-1"
}


# variable "dc_vcn_provider" {
#   default = oci.dc
# }


# provider "ocidr" {
#   alias  = "dr"
#   region = var.dr_region
# }

variable "compartment_id" {
  default     = "ocid1.compartment.oc1..aaaaaaaafmd3eynylajhayrhegk6typot73nexdgkj7iksc3374pcv3zb45q"
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

variable "airs_micro_oke_worker_cidr_block" {
  default = "10.10.96.0/20"
}

variable "airs_micro_oke_pod_cidr_block" {
  default = "10.10.144.0/20"
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

variable "web_worker_pod_cidr_block" {
  default = "10.10.112.0/20"
}

variable "cms_worker_pod_cidr_block" {
  default = "10.10.128.0/20"
}

variable "k8s_priv_api_endpoint_cidr_block" {
  default = "10.10.60.0/24"
}

variable "nsg_lb" {
  default = "NSG-PROD-LB"
}

variable "nsg_cms" {
  default = "NSG-PROD-CMS-WORKER"
}

variable "nsg_web" {
  default = "NSG-PROD-WEB-WORKER"
}

variable "nsg_airs" {
  default = "NSG-PROD-AIRS-WORKER"
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

variable "nsg_k8s_api_endpoint" {
  default = "NSG-PROD-K8S_API_ENDPOINTS"
}

variable "nsg_web_pod" {
  default = "NSG-PROD-WEB-POD"
}

variable "nsg_cms_pod" {
  default = "NSG-PROD-CMS-POD"
}

variable "nsg_airs_pod" {
  default = "NSG-PROD-AIRS-POD"
}

variable "alert_email" {
  type = list(string)
  default = [
    "wailin.s@trinitywizards.com"
  ]
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

variable "data_comp" {
  default = "prod-data-comp"
}

variable "mgmt_comp" {
  default = "prod-mgmt-comp"
}

variable "net_compartment_description" {
  default = "All subnets, Network Security Group, security list, route tables,etc"
}

variable "app_compartment_description" {
  default = "All OKE, workers nodes, Instances, etc "
}

variable "data_compartment_description" {
  default = "All Database, Redis, Block Storage, etc "
}

variable "mgmt_compartment_description" {
  default = "log analytics, log group, key vault, etc "
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

###############
##  Buckets  ##
###############

variable "bucket_name" {
  description = "Name of the Object Storage bucket."
  type        = string
  default = "prod_bucket"
}

variable "access_type" {
  description = "Bucket public access type: NoPublicAccess, ObjectRead, or ObjectReadWithoutList."
  type        = string
  default     = "NoPublicAccess"

  validation {
    condition     = contains(["NoPublicAccess", "ObjectRead", "ObjectReadWithoutList"], var.access_type)
    error_message = "access_type must be one of: NoPublicAccess, ObjectRead, ObjectReadWithoutList."
  }
}

variable "storage_tier" {
  description = "Bucket storage tier: Standard or Archive."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Archive"], var.storage_tier)
    error_message = "storage_tier must be either Standard or Archive."
  }
}

variable "auto_tiering" {
  description = "Auto tiering setting. Common values are Disabled or InfrequentAccess."
  type        = string
  default     = "Disabled"
}

variable "versioning" {
  description = "Enable object versioning on the bucket: Enabled or Disabled."
  type        = string
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Disabled"], var.versioning)
    error_message = "versioning must be either Enabled or Disabled."
  }
}

variable "object_events_enabled" {
  description = "Whether Object Storage events are enabled for the bucket."
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "Optional KMS key OCID for bucket encryption."
  type        = string
  default     = null
}

variable "metadata" {
  description = "Optional bucket metadata map."
  type        = map(string)
  default     = {}
}

###############
###  Vault  ###
###############


variable "vault_name" {
  description = "Display name of the OCI KMS vault."
  type        = string
  default = "prod_vault"
}

variable "vault_type" {
  description = "Vault type to create. DEFAULT is the standard OCI vault type."
  type        = string
  default     = "VIRTUAL_PRIVATE"
}

variable "secret_name" {
  description = "Name of the secret."
  type        = string
  default = "db_cred"
}

variable "secret_value" {
  description = "Plaintext secret value. It will be base64 encoded before being sent to OCI."
  type        = map(string)
  sensitive   = false
  default = {
    "username" = "user01"
    "password" = "pa55w0rd"
  }
}

variable "secret_version_name" {
  description = "Optional name for the secret version."
  type        = string
  default     = null
}

variable "secret_stage" {
  description = "Optional stage for the secret version, such as CURRENT or PENDING."
  type        = string
  default     = null
}

variable "rotation_interval_in_days" {
  default = 7
  description = "Key Rotation Day"
  type = number
}

variable "time_of_schedule_start" {
  default = "2026-03-20T00:00:00Z"
  description = "Key Rotation Start Schedule"
}

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
  default     = "10.10.16.10"
}

variable "cms_pod_source_ip" {
  description = "Source IPv4 address inside the source subnet CIDR. It does not need to be active."
  type        = string
  default     = "10.10.128.10"
}

variable "cms_destination_ip" {
  description = "Source IPv4 address inside the source subnet CIDR. It does not need to be active."
  type        = string
  default     = "10.10.16.10"
}

variable "cms_pod_destination_ip" {
  description = "Source IPv4 address inside the source subnet CIDR. It does not need to be active."
  type        = string
  default     = "10.10.128.10"
}

variable "web_source_ip" {
  description = "Source IPv4 address inside the source subnet CIDR. It does not need to be active."
  type        = string
  default     = "10.10.32.10"
}

variable "web_pod_source_ip" {
  description = "Source IPv4 address inside the source subnet CIDR. It does not need to be active."
  type        = string
  default     = "10.10.112.10"
}

variable "web_destination_ip" {
  description = "Source IPv4 address inside the source subnet CIDR. It does not need to be active."
  type        = string
  default     = "10.10.32.10"
}

variable "web_pod_destination_ip" {
  description = "Source IPv4 address inside the source subnet CIDR. It does not need to be active."
  type        = string
  default     = "10.10.112.10"
}

variable "airs_source_ip" {
  description = "Source IPv4 address inside the source subnet CIDR. It does not need to be active."
  type        = string
  default     = "10.10.96.10"
}

variable "airs_pod_source_ip" {
  description = "Source IPv4 address inside the source subnet CIDR. It does not need to be active."
  type        = string
  default     = "10.10.144.10"
}


variable "db_destination_ip" {
  description = "Destination IPv4 address inside the destination subnet CIDR. It does not need to be active."
  type        = string
  default     = "10.10.80.30"
}

variable "redis_destination_ip" {
  description = "Destination IPv4 address inside the destination subnet CIDR. It does not need to be active."
  type        = string
  default     = "10.10.80.40"
}

variable "db_destination_port" {
  description = "Destination port for TCP/UDP analysis."
  type        = number
  default     = 5432
}

variable "redis_destination_port" {
  description = "Destination port for TCP/UDP analysis."
  type        = number
  default     = 6379
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


##############################
### Bastion host variables ###
##############################

variable "bastion_ad_index" {
  description = "Which AD index to use (0 = first AD)."
  type        = number
  default     = 0
}

variable "bastion_ssh_public_keys" {
  description = "One or more OpenSSH public keys that can log in to the bastion host. Separate keys with newlines."
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDjNRHetQJYNR93uEaiNe9j+DXfT3ssapYp/npJ74AqDxbTzt2aky8ofRMU1OFgrZQglCywL0T1qY1x2oYFVp3BLJUOKMaWP28jQlX2L9KDqD8kziKgq0ydVW7RkevApAGeVflD6jv2LF34+S9zlgjRezq+UzE1zAaFPWdZRaHOfbMhb86uxBpFU+I2SmRni9qYpzQAMcoTmGA0crVN2mhdP/9ZxRr+BllVCXeiSnmoXHlaNujUY6qGzzjew29W7bNi3OLjtiCVy6O+H6+HQP4Xhn83CYVZZTdHjpm28fu1yz2XmnhmEs8XG9fsU8vR/hv3u0psmB1rIS2EAhA0+VmukNSkP2yVIBcwhYgS5jsZEoTeKUXF+eld+mV88vpRFfEJ3Koog/Vvc47mfJ5l6F0yiPIDGWS2Sv/MhzRVxIaDpWHjgOxQEysq6sQ7hwUrO1uDkLvUXFx7Ru97Eaz6RMhPLd1yHBbq4inRTXLEfCYaPdGbReU9CvAXlruycfw556E= wailin_s@a6b3bc12eb0b"
}

variable "bastion_image_operating_system" {
  default = "Oracle Linux"
  type    = string
}

variable "bastion_image_operating_system_version" {
  default = "9"
  type    = string
}

variable "bastion_instance_shape" {
  description = "Compute shape for the bastion host."
  type        = string
  default     = "VM.Standard.A1.Flex"
}

variable "bastion_availability_domain" {
  default = "aluk:AP-SINGAPORE-1-AD-1"
}

variable "bastion_shape_is_flex" {
  description = "Set to true when using a Flex shape for the bastion host."
  type        = bool
  default     = true
}

variable "bastion_shape_ocpus" {
  description = "OCPUs for bastion Flex shape."
  type        = number
  default     = 1
}

variable "bastion_shape_memory_in_gbs" {
  description = "Memory in GB for bastion Flex shape."
  type        = number
  default     = 6
}

variable "bastion_boot_volume_size_in_gbs" {
  description = "Boot volume size for the bastion host."
  type        = number
  default     = 50
}

##############################
### OKE cluster variables  ###
##############################

#########################################
# Optional pod networking (VCN-native)  #
#########################################

variable "cni_type" {
  description = "Pod networking mode. Use FLANNEL_OVERLAY for simpler networking, or OCI_VCN_IP_NATIVE if you already have pod subnets and want routable pod IPs."
  type        = string
  default     = "OCI_VCN_IP_NATIVE"

  validation {
    condition     = contains(["FLANNEL_OVERLAY", "OCI_VCN_IP_NATIVE"], var.cni_type)
    error_message = "cni_type must be FLANNEL_OVERLAY or OCI_VCN_IP_NATIVE."
  }
}



variable "services_cidr" {
  description = "Kubernetes services CIDR."
  type        = string
  default     = "10.96.0.0/16"
}

variable "system_max_pods_per_node" {
  description = "Max pods per node for the system node pool when cni_type is OCI_VCN_IP_NATIVE."
  type        = number
  default     = 31
}


variable "worker_max_pods_per_node" {
  description = "Max pods per node for the worker node pool when cni_type is OCI_VCN_IP_NATIVE."
  type        = number
  default     = 31
}

#####################
# Cluster settings  #
#####################

variable "cluster_name" {
  description = "OKE cluster name."
  type        = string
  default     = "prod-test-cluster"
}

variable "node_image_id" {
  # default     = "ocid1.image.oc1.ap-singapore-1.aaaaaaaaepwcslo4gfwgfzw5saqpnfrjvqvlfj3izxtfaytcmvblyzxyvxza"
  default = "ocid1.image.oc1.ap-singapore-1.aaaaaaaazzzecbburmrbeythywibbgs6iukplxkxvjpqmen2klhv62yscf7q"
  description = "Need to compatitable with node shape,oke cluster version"
}

variable "kubernetes_version" {
  description = "OKE Kubernetes version for the control plane and node pools. Pin this explicitly for production."
  type        = string
  default     = "v1.34.2"
}

variable "cluster_type" {
  description = "OKE cluster type. ENHANCED_CLUSTER is recommended for production use."
  type        = string
  default     = "ENHANCED_CLUSTER"

  validation {
    condition     = contains(["BASIC_CLUSTER", "ENHANCED_CLUSTER"], var.cluster_type)
    error_message = "cluster_type must be BASIC_CLUSTER or ENHANCED_CLUSTER."
  }
}



##############################
# SSH / node instance extras #
##############################

variable "oke_ssh_public_key" {
  description = "SSH public key injected into OKE worker nodes."
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDjNRHetQJYNR93uEaiNe9j+DXfT3ssapYp/npJ74AqDxbTzt2aky8ofRMU1OFgrZQglCywL0T1qY1x2oYFVp3BLJUOKMaWP28jQlX2L9KDqD8kziKgq0ydVW7RkevApAGeVflD6jv2LF34+S9zlgjRezq+UzE1zAaFPWdZRaHOfbMhb86uxBpFU+I2SmRni9qYpzQAMcoTmGA0crVN2mhdP/9ZxRr+BllVCXeiSnmoXHlaNujUY6qGzzjew29W7bNi3OLjtiCVy6O+H6+HQP4Xhn83CYVZZTdHjpm28fu1yz2XmnhmEs8XG9fsU8vR/hv3u0psmB1rIS2EAhA0+VmukNSkP2yVIBcwhYgS5jsZEoTeKUXF+eld+mV88vpRFfEJ3Koog/Vvc47mfJ5l6F0yiPIDGWS2Sv/MhzRVxIaDpWHjgOxQEysq6sQ7hwUrO1uDkLvUXFx7Ru97Eaz6RMhPLd1yHBbq4inRTXLEfCYaPdGbReU9CvAXlruycfw556E= wailin_s@a6b3bc12eb0b"
}

#####################
# System node pool  #
#####################

variable "system_node_pool_name" {
  description = "Name of the system node pool."
  type        = string
  default     = "system-pool"
}

variable "system_node_count" {
  description = "Desired number of nodes in the system node pool."
  type        = number
  default     = 1
}

variable "system_node_shape" {
  description = "Compute shape for the system node pool."
  type        = string
  default     = "VM.Standard.E4.Flex"
}

variable "system_memory_in_gbs" {
  default = 16
}

variable "system_ocpus" {
  default = 2
}

variable "system_node_os_type" {
  description = "OS type used to discover compatible OKE node images for the system node pool."
  type        = string
  default     = "OL8"
}

variable "system_node_os_arch" {
  description = "OS architecture used to discover compatible OKE node images for the system node pool."
  type        = string
  default     = "X86_64"
}

variable "worker_node_os_type" {
  description = "OS type used to discover compatible OKE node images for the worker node pool."
  type        = string
  default     = "OL8"
}

variable "worker_node_os_arch" {
  description = "OS architecture used to discover compatible OKE node images for the worker node pool."
  type        = string
  default     = "X86_64"
}

variable "system_availability_domain" {
  default = "aluk:AP-SINGAPORE-1-AD-1"
}

#####################
# Worker node pool  #
#####################

variable "worker_node_pool_name" {
  description = "Name of the worker node pool."
  type        = string
  default     = "worker-pool"
}

variable "worker_node_count" {
  description = "Desired number of nodes in the worker node pool."
  type        = number
  default     = 1
}

variable "worker_availability_domain" {
  default = "aluk:AP-SINGAPORE-1-AD-1"
}

variable "worker_node_shape" {
  description = "Compute shape for the worker node pool."
  type        = string
  default     = "VM.Standard.E4.Flex"
}

variable "worker_memory_in_gbs" {
  default = "16"
}

variable "worker_ocpus" {
  default = "2"
}



############################
# Rolling update behaviors #
############################

variable "node_eviction_grace_duration" {
  description = "Drain grace duration used by OKE during node actions such as cycling or replacement."
  type        = string
  default     = "PT60M"
}

variable "node_force_action_after_grace_duration" {
  description = "Whether OKE should continue node actions if pods cannot be fully evicted before the grace duration."
  type        = bool
  default     = false
}

variable "node_force_delete_after_grace_duration" {
  description = "Whether the underlying compute instance should be deleted if eviction cannot complete in time."
  type        = bool
  default     = false
}

variable "node_cycling_enabled" {
  description = "Enable node cycling for safer rolling replacement/updates."
  type        = bool
  default     = false
}

variable "node_cycling_maximum_surge" {
  description = "Maximum additional new compute instances temporarily created during cycling. Supports integer or percentage."
  type        = string
  default     = "25%"
}

variable "node_cycling_maximum_unavailable" {
  description = "Maximum active nodes that can be unavailable during cycling. Supports integer or percentage."
  type        = string
  default     = "0"
}

################
# Tagging      #
################


variable "defined_tags" {
  description = "Defined tags to apply to the cluster and node pools."
  type        = map(string)
  default     = {}
}



