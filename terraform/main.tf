terraform {
  required_providers {
    databricks = {
      source = "databrickslabs/databricks"
      version = "0.3.5"
    }
  }
}

variable "host" {
  type = string
}

variable "token" {
  type = string
}


provider "databricks" {
   host  = var.host
  token =  var.token
}



data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

resource "databricks_cluster" "mlops_tiny" {
  cluster_name            = "mlops_tiny"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = "m4.large"
  driver_node_type_id     = "m4.large"
  autotermination_minutes = 10
  autoscale {
    min_workers = 1
    max_workers = 2
  }
  aws_attributes {
        first_on_demand = 1
        availability = "SPOT_WITH_FALLBACK"
        zone_id = "us-west-2b"
        instance_profile_arn = "arn:aws:iam::112437402463:instance-profile/databricks_instance_role_s3"
        spot_bid_price_percent = 100
        ebs_volume_type = "GENERAL_PURPOSE_SSD"
        ebs_volume_count = 3
        ebs_volume_size = 100
    }
}