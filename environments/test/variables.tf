variable "common" {
  type = map(any)
  default = {
    app_name = "tf-practice"
    env      = "test"
    region   = "ap-northeast-1"
    domain   = "njl7502l.ml"
  }
}

# Network
# ------------------------------------------------------------------------------
variable "vpc" {
  type = map(any)
  default = {
    cidr_block = "10.0.0.0/16"
  }
}

variable "subnet" {
  type = object({
    newbits      = number
    azs          = list(string)
    public_types = list(string)
    public_netnums = map(object({
      a = number
      c = number
    }))
    private_types = list(string)
    private_netnums = map(object({
      a = number
      c = number
    }))
  })

  default = {
    newbits      = 8
    azs          = ["a", "c"]
    public_types = ["web"]
    public_netnums = {
      web = {
        a = 0
        c = 2
      }
    }
    private_types = ["db"]
    private_netnums = {
      db = {
        a = 1
        c = 3
      }
    }
  }
}

# Reference from .tfvars
# ------------------------------------------------------------------------------

variable "route53_zone_id" {}
