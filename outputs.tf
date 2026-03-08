output "internet_gateway_id" {
  value = oci_core_internet_gateway.igw.id
}

output "nat_gateway_id" {
  value = oci_core_nat_gateway.nat.id
}

output "nat_gateway_reserved_ip" {
  value = oci_core_nat_gateway.nat.nat_ip
}

output "public_route_table_id" {
  value = oci_core_route_table.public_rt.id
}

output "private_route_table_id" {
  value = oci_core_route_table.private_rt.id
}

output "vcn_id" {
  value = oci_core_vcn.terra_vcn.id
}

output "compartment_id" {
  value = var.compartment_id
}

output "vcn_name" {
  value = oci_core_vcn.terra_vcn.display_name
}

output "alert_name" {
  value = oci_ons_notification_topic.network_alert_topic.name
}

output "alert_mail" {
  value = oci_ons_subscription.email_subscription.endpoint
}

