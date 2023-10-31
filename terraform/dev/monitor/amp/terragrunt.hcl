terraform {
  source = "terraform-aws-modules/managed-service-prometheus/aws"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  tags = read_terragrunt_config(find_in_parent_folders("tags.hcl"))
}

inputs = {

  workspace_alias = "myworkspace"

  alert_manager_definition = <<-EOT
  alertmanager_config: |
    route:
      receiver: 'default'
    receivers:
      - name: 'default'
  EOT

  rule_group_namespaces = {
    first = {
      name = "myworkspace-01"
      data = <<-EOT
      groups:
        - name: test
          rules:
          - record: metric:recording_rule
            expr: avg(rate(container_cpu_usage_seconds_total[5m]))
      EOT
    }
    second = {
      name = "myworkspace-02"
      data = <<-EOT
      groups:
        - name: test
          rules:
          - record: metric:recording_rule
            expr: avg(rate(container_cpu_usage_seconds_total[5m]))
      EOT
    }
  }

  # tags
  tags = {
    env       = local.tags.locals.env
    managedby = local.tags.locals.managedby
  }

}



