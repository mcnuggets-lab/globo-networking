##################################################################################
# VARIABLES
##################################################################################

variable "aws_region" {
  type        = string
  description = "(Optional) AWS Region to use. Default: us-east-1"
}

variable "aws_access_key_id" {
  type        = string
  description = "AWS_ACCESS_KEY_ID"
}

variable "aws_secret_access_key" {
  type        = string
  description = "AWS_SECRET_ACCESS_KEY"
}

variable "aws_session_token" {
  type        = string
  description = "AWS_SESSION_TOKEN"
}

variable "prefix" {
  type        = string
  description = "(Optional) Prefix to use for all resources in this module."
}

variable "environment" {
  type        = string
  description = "(Optional) Prefix to use for all resources in this module. Default: dev"
}

variable "cidr_block" {
  type        = string
  description = "(Optional) The CIDR block for the VPC. Default:10.42.0.0/16"
}

variable "public_subnets" {
  type        = map(string)
  description = "(Optional) Map of public subnets to create with CIDR blocks. Key will be used as subnet name with prefix. Default: {subnet-1 ="
}
