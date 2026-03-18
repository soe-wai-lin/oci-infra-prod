# resource "oci_ons_notification_topic" "network_alert_topic" {
#   compartment_id = oci_identity_compartment.net_compartment.id
#   name           = "network_changes_alert"
# }

# resource "oci_ons_subscription" "email_subscription" {
#   depends_on = [ oci_ons_notification_topic.network_alert_topic ]
#   compartment_id = oci_identity_compartment.net_compartment.id
#   endpoint       = var.alert_email
#   protocol       = "EMAIL"
#   topic_id       = oci_ons_notification_topic.network_alert_topic.id
# }
 
# resource "oci_events_rule" "network_security_change_rule" {

#   compartment_id = oci_identity_compartment.net_compartment.id
#   display_name   = "network-Infra-change-detection"
#   is_enabled     = true

#   condition = jsonencode({
#     "eventType": [
#       "com.oraclecloud.virtualnetwork.addnetworksecuritygroupsecurityrules",
#       "com.oraclecloud.virtualnetwork.updatenetworksecuritygroupsecurityrules",
#       "com.oraclecloud.virtualnetwork.updatenetworksecuritygroup",
#       "com.oraclecloud.virtualnetwork.createnetworksecuritygroup",
#       "com.oraclecloud.virtualnetwork.deletenetworksecuritygroup",
#       "com.oraclecloud.virtualnetwork.updatesubnet",
#       "com.oraclecloud.virtualnetwork.createsubnet",
#       "com.oraclecloud.virtualnetwork.deletesubnet",
#       "com.oraclecloud.virtualnetwork.updateroutetable",
#       "com.oraclecloud.virtualnetwork.deleteroutetable",
#       "com.oraclecloud.virtualnetwork.createroutetable",
#       "com.oraclecloud.virtualnetwork.updatesecuritylist",
#       "com.oraclecloud.virtualnetwork.deletesecuritylist",
#       "com.oraclecloud.virtualnetwork.createsecuritylist"
#     ]
#   })

#   actions {
#     actions {
#       action_type = "ONS"
#       topic_id    = oci_ons_notification_topic.network_alert_topic.id
#       is_enabled  = true
#     }
#   }
# }