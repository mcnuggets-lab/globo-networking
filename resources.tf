##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  token      = var.aws_session_token
  region     = var.aws_region
}

##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {}

##################################################################################
# RESOURCES
##################################################################################

module "main" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.prefix
  cidr = var.cidr_block

  azs                     = slice(data.aws_availability_zones.available.names, 0, length(var.public_subnets))
  public_subnets          = [for k, v in var.public_subnets : v]
  public_subnet_names     = [for k, v in var.public_subnets : "${var.prefix}-${var.environment}-${k}"]
  enable_dns_hostnames    = true
  public_subnet_suffix    = ""
  public_route_table_tags = { Name = "${var.prefix}-${var.environment}-public" }
  map_public_ip_on_launch = true

  enable_nat_gateway = false

  tags = local.common_tags
}

resource "aws_security_group" "ingress" {
  description = "Security group with no ingress rule"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress                = []
  name                   = "no-ingress-sg"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags                   = local.common_tags
  tags_all               = {}
  vpc_id                 = module.main.vpc_id
}
