provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster"{
  source = "github.com/syreddy84/syr-modules//services/webserver-cluster?ref=v0.0.1"

  cluster_name = "stg"
  db_remote_state_bucket    = "terraform-state-160692692427"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size = 2
  max_size = 2
}

