provider "aws"{
    region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state"{
    bucket = "terraform-state-160692692427"
    lifecycle{
        prevent_destroy = true
    }

    versioning{
        enabled = true
    }

    server_side_encryption_configuration{
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }

    }
}

resource "aws_dynamodb_table" "terraform_locks"{
    name = "terraform-locks-160692692427"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}


terraform {
    backend "s3"{
        bucket = "terraform-state-160692692427"
        key = "global/s3/terraform.tfstate"
        region = "us-east-1"

        dynamodb_table = "terraform-locks-160692692427"
        encrypt = true

    }
}

output "s3_bucket_arn" {
    value = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_table_arn" {
    value = aws_dynamodb_table.terraform_locks.name
}