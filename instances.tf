# #############################################
# # Availability Domain (pick first AD)
# #############################################
# data "oci_identity_availability_domains" "ads" {
#   compartment_id = oci_identity_compartment.app_compartment.id
# }

# locals {
#   ad_name = data.oci_identity_availability_domains.ads.availability_domains[var.ad_index].name
# }

# #############################################
# # Image selection (Oracle Linux)
# # You can override with var.image_ocid if desired
# #############################################
# data "oci_core_images" "ol_images" {
#   compartment_id           = var.compartment_id
#   operating_system         = var.image_operating_system
#   operating_system_version = var.image_operating_system_version

#   # Most recent first
#   sort_by    = "TIMECREATED"
#   sort_order = "DESC"
#   state = "AVAILABLE"
#   shape = var.instance_shape

#   # Optional: limit to platform images
#   filter {
#     name   = "state"
#     values = ["AVAILABLE"]
#   }
# }

# locals {
#   selected_image_ocid = data.oci_core_images.ol_images.images[0].id
# }

# #############################################
# # Public Instance (has public IP)
# #############################################
# resource "oci_core_instance" "public_vm" {
#   compartment_id      = oci_identity_compartment.app_compartment.id
#   availability_domain = local.ad_name
#   display_name        = var.career_vm
#   shape               = var.instance_shape
  
  

#   source_details {
#     source_type = "image"
#     source_id   = local.selected_image_ocid
#   }


#  shape_config {
#     ocpus         = var.instance_ocpus
#     memory_in_gbs = var.instance_memory_in_gbs
#   }


#   create_vnic_details {
#     subnet_id        = oci_core_subnet.career_vm_sub.id
#     assign_public_ip = true
#     nsg_ids = [oci_core_network_security_group.nsg_prod_careers.id]
    
#   }

#   metadata = {
#     ssh_authorized_keys = var.ssh_public_key
#   }

#   freeform_tags = var.freeform_tags
# }