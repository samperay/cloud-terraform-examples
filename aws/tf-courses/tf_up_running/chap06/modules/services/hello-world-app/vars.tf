variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "Ubuntu EC2 instance for ap-south-1"
  type = string
  default = "ami-0c1a7f89451184c8b"
}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "sg_name" {
  description = "The name of the security group"
  type        = string
  default     = "terrafom-up-running"
}

variable "custom_tags" {
  description = "Custom tags to set on the instances in the ASG"
  type        = map(string)
  default     = {}
}

variable "enable_autoscaling" {
  description = "if set true, enable autoscaling"
  type        = bool
}

variable "server_text" {
  description = "The text the web server should return"
  default     = "Hello, World"
  type        = string
}

variable "db_address" {
  description = "RDS end point of the AWS"
  type        = string
  default     = "rdsendpoint.amazonaws.com"
}

variable "db_port" {
  description = "DB port"
  type        = number
  default     = 3306
}