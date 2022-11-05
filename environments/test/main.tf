# Network
# ------------------------------------------------------------------------------
module "network_vpc" {
  source = "../../modules/network/vpc"
  common = var.common
  vpc    = var.vpc
}

module "network_subnet_public" {
  source = "../../modules/network/subnet/public"
  common = var.common
  vpc    = var.vpc
  subnet = var.subnet
  vpc_id = module.network_vpc.vpc_id
}

module "network_subnet_private" {
  source = "../../modules/network/subnet/private"
  common = var.common
  vpc    = var.vpc
  subnet = var.subnet
  vpc_id = module.network_vpc.vpc_id
  subnet_public_ids = module.network_subnet_public.public_ids
}
