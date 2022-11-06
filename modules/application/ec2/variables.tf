variable "common" {
  type = map(any)
}

variable "subnet_azs" {
  type = list(string)
}

variable "sg_web_ec2_id" {
  type = string
}

variable "subnet_public_ids" {
  type = map(any)
}
