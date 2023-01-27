terraform {
  backend "s3" {
    profile = "root2"
    bucket = "alex-tfstate-test-bucket"
    key    = "global/s3/terraform.tfstate"
    region = "eu-central-1"

    dynamodb_table = "alex-tfstate-locks"
    encrypt        = true
  }
}