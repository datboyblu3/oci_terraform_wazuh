######################################################################################
# Create a Network for Wazuh to Operate In the Selecte Resource Group.
# This will also create a Subnet into the Virtual Network.
# The subnet will be deployed separately from the Virtual Network for ease of 
# maintenance.
######################################################################################

resource "oci_core_public_ip" "test_public_ip" {
    #Required
    compartment_id = var.compartment_id
    lifetime = var.public_ip_lifetime

    #Optional
    defined_tags = {"Operations.CostCenter"= "42"}
    display_name = var.public_ip_display_name
    freeform_tags = {"Department"= "Finance"}
    private_ip_id = oci_core_private_ip.test_private_ip.id
    public_ip_pool_id = oci_core_public_ip_pool.test_public_ip_pool.id
}



resource "oci_core_private_ip" "test_private_ip" {

    #Optional
    defined_tags = {"Operations.CostCenter"= "42"}
    display_name = var.private_ip_display_name
    freeform_tags = {"Department"= "Finance"}
    hostname_label = var.private_ip_hostname_label
    ip_address = var.private_ip_ip_address
    vlan_id = oci_core_vlan.test_vlan.id
    vnic_id = oci_core_vnic_attachment.test_vnic_attachment.vnic_id
}

resource "oci_core_vcn" "test_vcn" {
    #Required
    compartment_id = var.compartment_id

    #Optional
    byoipv6cidr_details {
        #Required
        byoipv6range_id = oci_core_byoipv6range.test_byoipv6range.id
        ipv6cidr_block = var.vcn_byoipv6cidr_details_ipv6cidr_block
    }
    cidr_block = var.vcn_cidr_block
    cidr_blocks = var.vcn_cidr_blocks
    defined_tags = {"Operations.CostCenter"= "42"}
    display_name = var.vcn_display_name
    dns_label = var.vcn_dns_label
    freeform_tags = {"Department"= "Finance"}
    ipv6private_cidr_blocks = var.vcn_ipv6private_cidr_blocks
    is_ipv6enabled = var.vcn_is_ipv6enabled
    is_oracle_gua_allocation_enabled = var.vcn_is_oracle_gua_allocation_enabled
}

resource "oci_core_route_table" "route_table_internet" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.test_vcn.id

    #Optional
    defined_tags = {"Operations.CostCenter"= "42"}
    display_name = var.route_table_display_name
    freeform_tags = {"Department"= "Finance"}
    route_rules {
        #Required
        network_entity_id = oci_core_internet_gateway.test_internet_gateway.id

        #Optional
        cidr_block = var.route_table_route_rules_cidr_block
        description = var.route_table_route_rules_description
        destination = var.route_table_route_rules_destination
        destination_type = var.route_table_route_rules_destination_type
    }
}

resource "oci_core_route_table" "route_table_nat" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.test_vcn.id

    #Optional
    defined_tags = {"Operations.CostCenter"= "42"}
    display_name = var.route_table_display_name
    freeform_tags = {"Department"= "Finance"}
    route_rules {
        #Required
        network_entity_id = oci_core_internet_gateway.test_internet_gateway.id

        #Optional
        cidr_block = var.route_table_route_rules_cidr_block
        description = var.route_table_route_rules_description
        destination = var.route_table_route_rules_destination
        destination_type = var.route_table_route_rules_destination_type
    }
}

resource "oci_core_internet_gateway" "test_internet_gateway" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.test_vcn.id

    #Optional
    enabled = var.internet_gateway_enabled
    defined_tags = {"Operations.CostCenter"= "42"}
    display_name = var.internet_gateway_display_name
    freeform_tags = {"Department"= "Finance"}
    route_table_id = oci_core_route_table.test_route_table.id
}