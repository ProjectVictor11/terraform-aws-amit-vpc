variable "vpc_config" {
    description = "To get CIDR range of VPC"
    # cidr_block=....., name = ..........
    type = object({
      cidr_block = string
      name = string
    })
    validation {
      error_message = "INVALID CIDR FORMAT - ${var.vpc_config.cidr_block}"
      condition = can(cidrnetmask(var.vpc_config.cidr_block))
    }
}

variable "subnet_config" {
    description = "To get CIDR range of subnet and its AZ"
    # sub1 = {cidr=..., az=....}, sub2 = {cidr=...., az=....}
    type = map(object({
      cidr_block = string
      az = string
      public = optional(bool, false)
    }))

/*
    validation {
      #sub1={cidr=.., az=..}, sub2={..}
      condition = alltrue([for config in var.subnet_config: can(cidrnetmask(var.subnet_config.value.cidr_block))])
      error_message = "INVALID CIDR VALUE"
    }
*/

  
}