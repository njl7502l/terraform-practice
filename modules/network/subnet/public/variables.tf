variable "common" {
  type = map(any)
}

variable "vpc" {
  type = map(any)
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
}

variable "vpc_id" {
  type = string
}
