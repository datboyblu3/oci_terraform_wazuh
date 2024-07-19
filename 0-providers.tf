terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      version = "5.46.0"
    }
  }
}

provider "oci" {
  # Configuration options
  feature{}
}

resource "oci_identity_group" "test_group" {
    #Required
    compartment_id = var.tenancy_ocid
    description = var.group_description
    name = var.group_name

    #Optional
    defined_tags = {"Operations.CostCenter"= "42"}
    freeform_tags = {"Department"= "Finance"}
}