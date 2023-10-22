terraform {
  source = "github.com/mostafahassan725/terraform-modules//mgmt/jenkins?ref=jenkins-v0.0.2"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  tags = read_terragrunt_config(find_in_parent_folders("tags.hcl"))
}

inputs = {

  #ec2 specific variables

  az        = "eu-west-3a"
  subnet_id = dependency.vpc.outputs.public_subnets_ids[0]

  #security groups specific variables

  vpc_id = dependency.vpc.outputs.vpc_id

  #tags

  tags = {
    env       = local.tags.locals.env
    managedby = local.tags.locals.managedby
  }

}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs = {
    public_subnets_ids = ["subnet-fakeid1", "subnet-fakeid2"]
    vpc_id             = "fakevpcid"
  }
}
