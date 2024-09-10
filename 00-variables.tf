variable "compartment_id" {
    description = "compartment id"
    type = string
}

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