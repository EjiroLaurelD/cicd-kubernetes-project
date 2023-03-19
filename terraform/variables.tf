variable "name" {
  description = "The name of the networked environment. Example region-dev-eks"
  type        = string
  default = "altschool-eks"
}

variable "region" {
  type        = string
  description = "The AWS region for the provider to deploy resources into."
  default = "us-east-1"
}

variable "cidr_block" {
  type        = string
  description = "The IP address range of the environment in CIDR notation."
  default = "10.0.0.0/16"
}

variable "public_cidr_block" {
  type        = list(string)
  description = "The CIDR block for 'public network'"
  default = ["10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]

}

variable "private_cidr_block" {
  type        = list(string)
  description = "The CIDR block for private network"
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]

}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "The tags for the resources in the environment."
}

variable "availability_zones" {
  type        = list(any)
  description = "The availability zones for the environment. Examples: eu-west-1a, eu-west-1b"
  default = [ "us-east-1a", "us-east-1b", "us-east-1c"  ]
}

variable "num_nat_gateways" {
  type        = number
  description = "The number of NAT Gateways required for the environment. For dev and test this should not be more than 1. For Production, this should equal the number of availability zones. Only appliable for VPCs with an internet gateway"
  default = 1
}

variable "cluster_version" {
  type        = string
  description = "The version of the EKS cluster."
  default = "1.24"
}

variable "group_instance_type" {
  type        = list(string)
  description = "The instance type of the worker group nodes. Must be large enough to support the amount of NICS assigned to pods."
  default = [ "t2.medium", "t3.medium", "t3.large" ]
}

variable "group_min_size" {
  type        = number
  description = "The minimum number of nodes"
  default = 1
}

variable "group_desired_size" {
  type        = number
  description = "The desired number of nodes"
  default = 4
}

variable "group_max_size" {
  type        = number
  description = "The maximum number of nodes"
  default = 8
}

variable "group_capacity_type" {
  type        = string
  description = "The instance capacity type, it could be spot, on-demand or dedicated"
  default = "ON_DEMAND"
}
variable "jenkins_admin_password" {
  type = string
  description = "jenkins username"
}
variable "jenkins_admin_user" {
  type = string
  description = "jenkins user password"
}
#variable "honeycomb_api_key"{
 # type = string
  #description = "PAi key to access honeycomb.io"
#}
