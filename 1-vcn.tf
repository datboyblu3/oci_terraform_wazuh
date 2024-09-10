resource "oci_core_vcn" "vcn" {
    compartment_id = var.compartment_id
    cidr_blocks    = "10.0.0.0/16"
    display_name   = "purpleteam_vcn"
}

resource "oci_core_subnet" "public_subnet" {
    compartment_id          = var.compartment_id
    cidr_blocks             = "10.0.1.0/24"
    display_name            = "PublicSubnet"
    vcn_id                  = oci_core_vcn.id
    route_table_display_id  = oci_core_route_table.route_table_internet.id
}

resource "oci_core_subnet" "private_subnet"{
    compartment_id          = var.compartment_id
    cidr_blocks             = "10.0.2.0/24"
    display_name            = "PrivataeSubnet"
    vcn_id                  = oci_core_vcn.id
    route_table_display_id  = oci_core_route_table.route_table_internet.id
}

resource "oci_core_route_table" "route_table_internet" {
    compartment_id          = var.compartment_id
    vcn_id                  = oci_core_vcn.id
    display_name            = var.public_route_table_display_name

    route_rules{
        network_entity_id   = oci_core_internet_gateway.internet_gateway.id
        description         = "internet_gateway_rule"
        destination         = "0.0.0.0/0"
        destination_type    = "CIDR_BLOCK"
    }
}

resource "oci_core_route_table" "route_table_nat" {
    compartment_id          = var.compartment_id
    vcn_id                  = oci_core_vcn.id
    display_name            = var.private_route_table_display_name

    route_rules{
        network_entity_id   = oci_core_internet_gateway.internet_gateway.id
        description         = "nat_gateway_rule"
        destination         = "0.0.0.0/0"
        destination_type    = "CIDR_BLOCK"
        network_entity_id   = oci_core_nat_gateway.nat_gateway_id
    }
}

resource "oci_core_internet_gateway" "internet_gateway" {
    compartment_id          = var.compartment_id
    vcn_id                  = oci_core_vcn.id
    display_name            = var.nat_gateway_display_name
    block_traffic           = false
}



