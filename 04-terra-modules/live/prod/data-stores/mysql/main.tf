provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-160692692427"
    key    = "prod/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-locks-160692692427"
    encrypt        = true
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine            = "mysql"
  allocated_storage = 10
  instance_class    = "db.t2.micro"
  name              = "example_database"
  username          = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["username"]

  # How should we set the password?
  password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["password"]
  skip_final_snapshot = true
 
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "prod/example-app/mysql"
}
