

# Define the compartment where the Key Vault will be created
resource "oci_identity_compartment" "my_compartment" {
  name          = "my-compartment"
  description   = "My compartment for Key Vault"
  compartment_id = "ocid1.compartment.oc1..exampleuniqueID"  # Your parent compartment OCID
}

# Define the Key Vault
resource "oci_keymanagement_vault" "my_vault" {
  compartment_id = oci_identity_compartment.my_compartment.id
  display_name    = "my-key-vault"
  description     = "My key vault for managing secrets"

  # Optional - you can specify the vault's protection level
  protection_level = "HSM" # or "SOFTWARE"

  # Optional - specify tags for the vault
  freeform_tags = {
    "Environment" = "Dev"
    "Project"     = "Terraform"
  }
}

# Optional - Define a Key in the Key Vault
resource "oci_keymanagement_key" "my_key" {
  compartment_id = oci_identity_compartment.my_compartment.id
  vault_id        = oci_keymanagement_vault.my_vault.id
  display_name     = "my-key"
  key_shape {
    algorithm = "AES"
    length    = 32
  }
  key_usage = "ENCRYPT_DECRYPT"  # Possible values: ENCRYPT_DECRYPT, SIGN_VERIFY
  protection_level = "HSM" # or "SOFTWARE"

  # Optional - specify tags for the key
  freeform_tags = {
    "Environment" = "Dev"
    "Project"     = "Terraform"
  }
}
