variable "instance_profile" {
  description = "The name of the instance profile"
  default     = ""
}

variable "account_id" {
  description = "The AWS account ID"
  default     = ""
}

variable "env" {
  description = "The environment name (e.g., dev, prod)"
  default     = "dev"
}

variable "region" {
  description = "The AWS region to deploy resources"
  default     = "us-west-2"
}

variable "azone1" {
  description = "The first availability zone"
  default     = "us-west-2a"
}

variable "azone2" {
  description = "The second availability zone"
  default     = "us-west-2b"
}

variable "node_instance_type" {
  description = "The instance type for the EKS worker nodes"
  default     = "t3a.medium"
}

variable "ami_name" {
  description = "The name of the AMI to use for the EKS nodes"
  default     = ""
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

# Subnet variables
variable "public_subnet_cidr_az1" {
  description = "CIDR block for the public subnet in availability zone 1"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr_az1" {
  description = "CIDR block for the private subnet in availability zone 1"
  default     = "10.0.2.0/24"
}

variable "public_subnet_cidr_az2" {
  description = "CIDR block for the public subnet in availability zone 2"
  default     = "10.0.3.0/24"
}

variable "private_subnet_cidr_az2" {
  description = "CIDR block for the private subnet in availability zone 2"
  default     = "10.0.4.0/24"
}

variable "key_name" {
  description = "The name of the SSH key to use for the EKS nodes"
  default     = ""
}

variable "private_ip_ingress_cidr" {
  description = "The CIDR block for allowing SSH access to the bastion host"
  default     = ""
  type        = string
}