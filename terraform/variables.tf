variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks that are allowed to access the resources"
  type        = list(string)
  default     = ["0.0.0.0/0"]

}

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-west-2"

}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  default     = "303981612052"

}
