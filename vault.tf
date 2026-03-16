# resource "oci_kms_vault" "vault" {
#   compartment_id = oci_identity_compartment.app_compartment.id
#   display_name   = var.vault_name
#   vault_type     = var.vault_type
#   freeform_tags = var.freeform_tags
# }

# data "oci_kms_vault" "vault" {
#   vault_id = oci_kms_vault.vault.id
# }

# resource "oci_kms_key" "secret_key" {
#   compartment_id      = oci_identity_compartment.app_compartment.id
#   display_name        = "${var.vault_name}-secret-key"
#   management_endpoint = data.oci_kms_vault.vault.management_endpoint
# #   protection_mode     = "HSM"

#   key_shape {
#     algorithm = "AES"
#     length    = 32
#   }
# is_auto_rotation_enabled = true

#  auto_key_rotation_details {
#     rotation_interval_in_days = 7
#     time_of_schedule_start    = "2026-03-20T00:00:00Z"
# }


#   freeform_tags = var.freeform_tags
# }

# data "oci_kms_key" "secret_key" {
#     #Required
#     key_id = oci_kms_key.secret_key.id
#     management_endpoint = data.oci_kms_vault.vault.management_endpoint
# }

# resource "oci_vault_secret" "secret" {
#   compartment_id = oci_identity_compartment.app_compartment.id
#   vault_id       = oci_kms_vault.vault.id
#   key_id         = oci_kms_key.secret_key.id
#   secret_name    = var.secret_name
#   freeform_tags = var.freeform_tags

#   secret_content {
#     content_type = "BASE64"
#     content      = base64encode(jsonencode(var.secret_value))
#     name         = var.secret_version_name
#     stage        = var.secret_stage
#   }
# }
