terraform {
  required_version = ">= 1.3"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }
}

provider "oci" {
  region = var.dc_region
  alias = "dc"
}

provider "oci" {
  region = var.dr_region
  alias = "dr"
}