
# ############################################
# # Bastion host (compute instance)        ###
# ############################################

# data "oci_identity_availability_domains" "ads" {
#   compartment_id = oci_identity_compartment.app_compartment.id
# }

# locals {
#   ad_name = data.oci_identity_availability_domains.ads.availability_domains[var.bastion_ad_index].name
# }

# locals {
#   selected_image_ocid = data.oci_core_images.ol_images.images[0].id
# }

# data "oci_core_vnic_attachments" "bastion_vnic_attachments" {
#   compartment_id = oci_identity_compartment.app_compartment.id
#   instance_id    = oci_core_instance.bastion.id
# }

# data "oci_core_vnic" "bastion_primary_vnic" {
#   vnic_id = data.oci_core_vnic_attachments.bastion_vnic_attachments.vnic_attachments[0].vnic_id
# }

# #############################################
# # Image selection (Oracle Linux)
# # You can override with var.image_ocid if desired
# #############################################
# data "oci_core_images" "ol_images" {
#   compartment_id           = var.compartment_id
#   operating_system         = var.bastion_image_operating_system
#   operating_system_version = var.bastion_image_operating_system_version

#   # Most recent first
#   sort_by    = "TIMECREATED"
#   sort_order = "DESC"
#   state = "AVAILABLE"
#   shape = var.bastion_instance_shape

#   # Optional: limit to platform images
#   filter {
#     name   = "state"
#     values = ["AVAILABLE"]
#   }
# }


resource "oci_core_instance" "bastion" {
  compartment_id      = oci_identity_compartment.app_compartment.id
  availability_domain = var.bastion_availability_domain
  display_name        = "${var.vcn_display_name}-bastion-host"
  shape               = var.bastion_instance_shape

  create_vnic_details {
    subnet_id        = oci_core_subnet.lb_subnet.id
    assign_public_ip = true
    nsg_ids          = [oci_core_network_security_group.nsg_prod_bastion.id]
    # hostname_label   = var.bastion_hostname_label
  }

  source_details {
    source_type             = "image"
    source_id               = var.bastion_node_source_image_id
    boot_volume_size_in_gbs = var.bastion_boot_volume_size_in_gbs
  }

  metadata = {
    ssh_authorized_keys = var.bastion_ssh_public_keys
  }

  freeform_tags = merge(var.freeform_tags, {
    role = "bastion"
  })

  shape_config {
    ocpus         = var.bastion_shape_ocpus
    memory_in_gbs = var.bastion_shape_memory_in_gbs
  }
}

#   dynamic "shape_config" {
#     for_each = var.bastion_shape_is_flex ? [1] : []
#     content {
#       ocpus         = var.bastion_shape_ocpus
#       memory_in_gbs = var.bastion_shape_memory_in_gbs
#     }
#   }




