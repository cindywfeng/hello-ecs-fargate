variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks that are allowed to access the resources"
  type        = list(string)
  default     = ["0.0.0.0/0"]

}
