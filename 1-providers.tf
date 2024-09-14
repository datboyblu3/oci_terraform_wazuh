terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      version = "6.9.0"
    }
  }
}

# Create variables for the below
provider "oci" { 
  tenancy_ocid     = var.oci_tenancy
  user_ocid        = var.oci_user
  fingerprint      = var.oci_fingerprint
  private_key_path = var.oci_key
  region           = var.oci_region
}

resource "oci_identity_compartment" "" {
    # Required
    compartment_id = var.oci_tenancy
    description    = "Compartment for Terraform resources."
    name           = var.compartment_name
    enable_delete  = true
}