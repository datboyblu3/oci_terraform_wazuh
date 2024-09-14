# Wazuh OCI Terraform Deployment 

![Untitled-2024-06-26-1305](https://github.com/datboyblu3/oci_terraform_wazuh/assets/95729902/f37df0af-fbaf-401b-8ffe-bf5d993814f8)

Using Terraform to automate the deployment of the Wazuh architecture: Indexer, Server and Dashboard in OCI

## Terraform Modules
```
├── 0-providers.tf <- OCI config
├── 1-key_resources.tf <- Creates .pem and .pem.pub generation
├── 2-network.tf <- creates virtual network and subnet
├── 3-security_group.tf <- security groups creation
├── 4-compute.tf <- virtual machines
├── 5-provision.tf <- executes ansible wazuh files
├── 6-outputs.tf <- Ouput options
```

```
├── configure-indexer.yml <- indexer installation process
├── configure-server.yml <- server installation process
├── configure-dashboard.yml <- dashboard installation commands
```

## High Level Diagram

![image](https://github.com/user-attachments/assets/e8b39bc1-c545-47df-8b12-61b8c554582c)



# Usage

This directory is a self contained production ready environment. You can clone
this repository and run terraform from within this directory or copy the files
elsewhere.

### Install OCI CLI

**macOS**
```python
brew update && brew upgrade oci-cli
```

**Linux (Ubuntu, Debian)**
```python
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
```
**Windows**

```python
https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#InstallingCLI__windows
```

# Creating the OCI Key Vault

### Perquisites
- OCI Cli Installed
- OpenSSL
- Master Encryption Keys
- Wrapping Keys

#### Create OCI Key Vault via CLI
``` python
oci kms management vault create --compartment-id  <vault_name> 
```

#### Add Vault Tags
```python
oci kms management vault create --compartment-id ocid1.compartment.oc1..example1example25qrlpo4agcmothkbgqgmuz2zzum45ibplooqtabwk3zz --display-name vault-1 --vault-type VIRTUAL_PRIVATE --defined-tags '{"Operations": {"CostCenter": "42"}}' --freeform-tags '{"Department":"Finance"}'
```

#### Create the Master Encryption Keys
> [!info] 
> Documentation for [MEK commands](https://docs.public.oneportal.content.oci.oraclecloud.com/en-us/iaas/tools/oci-cli/3.47.0/oci_cli_docs/cmdref/kms.html)

``` python
oci kms management key create --compartment-id <target_compartment_id> --display-name <key_name> --key-shape <key_encryption_information> --endpoint <control_plane_url> --is-auto-rotation-enabled <true | false> --auto-key-rotation-details <schedule_interval_information>
```


#### Create Wrapped Key Material
>[!Wrapping Key]
> Before importing key to the OCI Key vault it must be wrapped with a public key content provided by OCI. A wrapping key is included by default with each vault you create. Use the wrapping public key when you need to wrap key material for import into the vault service. Wrapping keys cannot be created, deleted or rotated. 

1. Generat a temp AES Key
``` python
   openssl rand -out <temporary_AES_key_path> 32
```

2. Wrap the temporary AES key with the public wrapping key
``` python
openssl pkeyutl -encrypt -in <temporary_AES_key_path> -inkey <vault_public_wrapping_key_path> -pubin -out <wrapped_temporary_AES_key_file> -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256
```

3. Generate hexadecimal of the temporary AES key material
``` python
temporary_AES_key_hexdump=$(hexdump -v -e '/1 "%02x"' < ${temporary_AES_key_path})
```

4. Wrap your RSA private key with the temporary AES key
```python
openssl enc -id-aes256-wrap-pad -iv A65959A6 -K temporary_AES_key_hexdump -in <your_RSA_private_key_file> -out <wrapped_target_key_file>
```

5. Create the wrapped key material by concatenating both wrapped keys
``` python
cat <wrapped_temporary_AES_key_file> <wrapped_target_key_file> > <wrapped_key_material_file>
```
