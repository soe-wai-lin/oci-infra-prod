output "internet_gateway_id" {
  value = oci_core_internet_gateway.igw.id
}

output "nat_gateway_id" {
  value = oci_core_nat_gateway.nat.id
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
  value = var.compartment_id.id
}

output "vcn_name" {
  value = oci_core_vcn.terra_vcn.display_name
}