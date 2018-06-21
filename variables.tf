variable "aws_region"  {
  description = "Main AWS Region."
  default = "ap-southeast-2"
}
variable "clientname" {
  description = "Client Name for Naming Tags"
  default = "ALA"
}
variable "creator" {
  description = "Creator of the Stack"
  default = "Adam Lash"
}
variable "aws_key_name" {
  description = "Keypair Name"
  default = "QIL-Int-Prod"
}
variable "aws_az_a" {
  description = "AWS AZ for A"
  default = "ap-southeast-2a"
}
variable "aws_az_b"   {
  description = "AWS AZ for B"
  default = "ap-southeast-2b"
}
variable "aws_az_c"   {
  description = "AWS AZ for C"
  default = "ap-southeast-2c"
}
# Various StackNames, Iterate Per Stack
variable "aws_stackname1"   {
  description = "Stackname 1"
  default = "Alash - Internal Env - Production"
}

variable "aws_vpcstackname1"   {
  description = "VPC StackName 1"
  default = "Alash - Internal Env - VPC - Production"
}
