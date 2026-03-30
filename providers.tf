terraform {
  required_version = ">= 1.3"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 8.7.0"
    }
  }
}

provider "oci" {
  region = var.home_region
  alias = "home"
}

provider "oci" {
  region = var.target_region
  alias = "target"
}