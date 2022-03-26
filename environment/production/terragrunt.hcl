# Terragrunt will copy the Terraform files from the locations specified into this directory
terraform {
  source = "../.."
}

# These are inputs that need to be passed for the terragrunt configuration
inputs = {
  environment   = "Production"
  droplet_count = 4
}