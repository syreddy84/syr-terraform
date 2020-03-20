provider "aws"{
    region = "us-east-1"
}

terraform {
    backend "s3"{
        bucket = "terraform-state-160692692427"
        key = "testing-workspace/terraform.tfstate"
        region = "us-east-1"

        dynamodb_table = "terraform-locks-160692692427"
        encrypt = true
    }
}

resource "aws_instance" "example"{
    ami = "ami-07ebfd5b3428b6f4d"
    instance_type = "t2.micro"
}