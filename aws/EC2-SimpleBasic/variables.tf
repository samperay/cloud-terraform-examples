variable "ami_id" {
  description  = "AMI ID"
  type = string
}

variable "inst_type" {
  description = "instance type"
  type = string
}

variable "inst_counts" {
  description = "# of servers"
  type  = number
}
