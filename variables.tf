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



variable "common_freeform_tags" {
  type = map(string)
  default = {
    Department = "Prod"
  }
}


