variable "region" {
  type        = string
  description = "Cloud Region"
}

variable "resource_group_name" {
  type        = string
  description = "Name of Resource Group"
}

variable "environment" {
  type        = string
  description = "Name of Resource Group"
  default     = "dev"
}
#
variable "common_tags" {
  description = "Tags to set for all resources"
  type        = list(string)
  default = ["env=testing",
    "region=us-south-1"
  ]
}
