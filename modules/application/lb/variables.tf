variable "common" {
  type = map(any)
}

variable "vpc_id" {
  type = string
}

variable "instance_ids" {
  type = set(string)
}

variable "set_public_ids" {
  type = set(string)
}

variable "sg_web_ec2_id" {
  type = string
}
