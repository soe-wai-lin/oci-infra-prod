resource "oci_identity_compartment" "net_compartment" {
  #Required
  compartment_id = var.compartment_id
  description    = var.compartment_description
  name           = var.net_comp
  enable_delete  = false ## if you destroy, this compartment name will not be delete.
  freeform_tags  = var.freeform_tags
}

resource "oci_identity_compartment" "app_compartment" {
  #Required
  compartment_id = var.compartment_id
  description    = var.compartment_description
  name           = var.app_comp
  enable_delete  = false ## if you destroy, this compartment name will not be delete.
  freeform_tags  = var.freeform_tags
}

resource "oci_identity_compartment" "db_compartment" {
  #Required
  compartment_id = var.compartment_id
  description    = var.compartment_description
  name           = var.db_comp
  enable_delete  = false ## if you destroy, this compartment name will not be delete.
  freeform_tags  = var.freeform_tags
}