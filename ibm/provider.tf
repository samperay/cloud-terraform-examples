terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.21.2"
    }
  }
}

# Configure the IBM Provider
provider "ibm" {
  region = "us-south"
}