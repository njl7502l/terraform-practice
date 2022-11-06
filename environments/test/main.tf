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
  source            = "../../modules/network/subnet/private"
  common            = var.common
  vpc               = var.vpc
  subnet            = var.subnet
  vpc_id            = module.network_vpc.vpc_id
  subnet_public_ids = module.network_subnet_public.public_ids
}

module "network_sg" {
  source = "../../modules/network/sg"
  common = var.common
  vpc_id = module.network_vpc.vpc_id
}

# Application
# ------------------------------------------------------------------------------
module "application_s3" {
  source = "../../modules/application/s3"
  common = var.common
}

module "application_ec2" {
  source            = "../../modules/application/ec2"
  common            = var.common
  subnet_azs        = var.subnet.azs
  subnet_public_ids = module.network_subnet_public.public_ids
  sg_web_ec2_id     = module.network_sg.sg_web_ec2_id
}
