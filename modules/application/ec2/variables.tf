variable "common" {
  type = map(any)
}

variable "sg_web_ec2_id" {
  type = string
}

variable "set_public_ids" {
  type = set(string)
}
