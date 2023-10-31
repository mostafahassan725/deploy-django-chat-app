terraform {
  source = "cloudposse/elasticache-redis/aws"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  tags = read_terragrunt_config(find_in_parent_folders("tags.hcl"))
}

inputs = {

  availability_zones               = var.availability_zones
  zone_id                          = []
  vpc_id                           = dependency.vpc.vpc_id
  allowed_security_groups          = [module.vpc.vpc_default_security_group_id]
  subnets                          = dependency.vpc.private_subnets_ids
  cluster_size                     = 
  instance_type                    = "t2.micro"
  apply_immediately                = true
  automatic_failover_enabled       = false
  engine_version                   = 
  family                           = 
  at_rest_encryption_enabled       = true
  transit_encryption_enabled       = true
  cloudwatch_metric_alarms_enabled = true

  security_group_create_before_destroy = true
  security_group_name                  = []

  parameter = [
    {
      name  = "notify-keyspace-events"
      value = "lK"
    }
  ]

  security_group_delete_timeout = "5m"


  # tags
  tags = {
    env       = local.tags.locals.env
    managedby = local.tags.locals.managedby
  }

}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs = {
    vpc_id = "fakeid"
    private_subnets_ids = ["subnet-fake1", "subnet-fake2"]
  }
}
