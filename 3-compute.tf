######################################################################################
# Create the compute instances
######################################################################################


resource "oci_core_instance" "ubuntu_instance" {
    # Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = data.oci_identity_compartment.id
    shape = "VM.Standard3.Flex"
    source_details {
        source_id = data.source_id
        source_type = "image"
    }

    # Optional
    display_name = "TEST-VM"
    create_vnic_details {
        assign_public_ip = true
        subnet_id = "<subnet-ocid>"
    }
    metadata = {
        ssh_authorized_keys = file("<ssh-public-key-path>")
    } 
    preserve_boot_volume = false
}