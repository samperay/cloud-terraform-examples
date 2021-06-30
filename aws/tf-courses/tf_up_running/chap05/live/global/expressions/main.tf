terraform {
  required_version = ">=0.12, <0.13"
}

provider "aws" {
  region = "ap-south-1"
}

# strings
variable "names" {
  description = "List of names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

output "upper_names" {
  value = [for names in var.names : upper(names)]
}

output "shortnames" {
  value = [for shortnames in var.names : shortnames if length(shortnames) < 5]
}

# maps 
variable "hero_thousand_faces" {
  description = "map"
  type        = map(string)
  default = {
    neo      = "hero"
    trinity  = "love interest"
    morpheus = "mentor"
  }
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

output "upper_roles" {
  value = { for name, role in var.hero_thousand_faces : upper(name) => upper(role) }
}