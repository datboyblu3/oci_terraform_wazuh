########################
# VCN Variables
########################

variable "public_route_display_name"{
    description = "public-route-table"
    type        = string
    default     = "public-route-table"
}

variable "private_route_display_name"{
    description = "private-route-table"
    type        = string
    default     = "private-route-table"
}

variable "internet_gateway_display_name"{
    description = "test-vcn-igw"
    type        = string
    default     = "internet-gateway"
}

variable "nat_gateway_display_name"{
    description = "test-vcn-ng"
    type        = string
    default     = "nat-gateway"
}

variable "internet_gateway_enabled"{
    type        = bool
    defeault    = true
}


########################
# Compartment Variables
########################

variable "compartment_id" {
    description = "The OCID of the parent compartment where the resources will be created"
    type = string
}

variable "compartment_name" {
    description = "name of compartment"
    type        = string
}


########################
# Provider Variables
########################

variable "oci_tenancy" {
  type = string
  description = "OCI tenancy identifier"
}

variable "oci_user" {
  type = string
  description = "OCI user identifier"
}

variable "oci_fingerprint" {
  type = string
  description = "OCI fingerprint for the key pair"
}

variable "oci_key" {
  type = string
  description = "OCI key pair"
}

variable "oci_region" {
  type = string
  description = "OCI region"
}



########################
# Compute Variables
########################