# Store remote state file to S3. Use 'terraform env' to decouple state files per env.
terraform {
  backend "s3" {
    encrypt = true
  }
}
