terraform {
  required_version = ">= 1.3"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }
}

provider "ocidc" {
  region = var.dc_region
}

provider "ocidr" {
  region = var.dr_region
}