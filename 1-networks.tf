######################################################################################
# Create a Network for Wazuh to Operate In the Selecte Resource Group.
# This will also create a Subnet into the Virtual Network.
# The subnet will be deployed separately from the Virtual Network for ease of 
# maintenance.
######################################################################################

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