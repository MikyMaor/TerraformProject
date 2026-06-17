variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_id" {
  type    = string
  default = "vpc-044604d0bfb707142"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "Your public IP in CIDR notation, e.g. 1.2.3.4/32"
  default     = "0.0.0.0/0"
}

variable "ami_id" {
  type    = string
  default = "ami-0c7217cdde317cfec" # Amazon Linux 2023 us-east-1
}
