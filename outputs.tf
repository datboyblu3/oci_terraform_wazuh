output "vcn_display_name" {
    value       = oci_core_vcn.vcn.vcn_display_name
}

output "public_subnet_names" {
    value       = oci_core_subnet.public_subnet[*].display_name
}

output "private_subnet_names" {
    value       = oci_core_subnet.private_subnet[*].display_name
}

output "route_table_names" {
    value       = {
        route_table_internet = oci_core_route_table.route_table_internet.display_name,
        route_table_nat      = oci_core_route_table.route_table_nat.display_name
    }
}

output "route_table_names" {
    value       = {
        internet_gateway = oci_core_internet_gateway.internet_gateway.display_name,
        route_table_nat      = oci_core_nat_gateway.nat_gateway.display_name
    }
}