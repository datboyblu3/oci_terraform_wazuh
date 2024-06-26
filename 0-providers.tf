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
