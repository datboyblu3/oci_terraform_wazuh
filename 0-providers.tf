terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      version = "5.46.0"
    }
  }
}

provider "oci" {
  # Your OCI credentials and region
  tenancy_ocid     = "ocid1.tenancy.oc1..exampleuniqueID"
  user_ocid        = "ocid1.user.oc1..exampleuniqueID"
  fingerprint      = "your_fingerprint"
  private_key_path = "path/to/your/private_key.pem"
  region           = "us-phoenix-1" # Example region, update as necessary
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