# Terraform DigitalOcean

The main purpose of this repository is for me to play around with [Terraform](https://www.terraform.io/). And is the first of many repositories to created so that I can get familiar with the different providers available.

This project will focus on the [DigitalOcean](https://github.com/digitalocean/terraform-provider-digitalocean) provider.

## Development

### Dependencies

- [terraform](https://www.terraform.io/)
- [terragrunt](https://terragrunt.gruntwork.io/)
- [pre-commit](https://pre-commit.com/)
- [terraform-docs](https://terraform-docs.io/) this is required for `terraform_docs` hooks.

## Prerequisites

1. Have a [DigitalOcean](https://digitalocean.com) account. 
2. You will need create a DigitalOcean API token [follow instructions](https://www.digitalocean.com/docs/api/create-personal-access-token/).
3. Add an ssh-key to your account as per [instructions](https://docs.digitalocean.com/products/droplets/how-to/add-ssh-keys/to-account/).

## Usage

1. Navigate to the environment you would like to deploy,
2. Plan your changes with `terragrunt plan` to see what changes will be made,
3. If you're happy with the changes `terragrunt apply`

Please note that `.tfstate` files are stored locally on your machine as no backend has been specified. If you would like to properly version control your state files, it is possible to use an S3 bucket to store these files. This will ensure anyone else other than you running a plan/apply will always be using the same state file.

## Accessing resources created

### Droplets

As part of deployment of the droplets, the ssh-key provided will be added to the droplet, this means you can directly ssh into the droplet with `ssh root@XXX.XX.XXX.XX`, replace
`XXX.XX.XXX.XX` with any of the IP Addresses output `server_ipv4_address` after applying the changes.

### Static App

The static app deployed can be accessed on the URL output `static_app_live_domain` after applying your changes.

### Project resources

All project resources created for each environment can be accessed via the DigitalOcean console. Each environment, should have its own project created.
## Pre-Commit hooks

Git hook scripts are very helpful for identifying simple issues before pushing any changes. Hooks will run on every commit automatically pointing out issues in the code e.g. trailing whitespace.

To help with the maintenance of these hooks, [pre-commit](https://pre-commit.com/) is used, along with [pre-commit-hooks](https://pre-commit.com/#install).

Please following [these instructions](https://pre-commit.com/#install) to install `pre-commit` locally and ensure that you have run `pre-commit install` to install the hooks for this project.

Additionally, once installed, the hooks can be updated to the latest available version with `pre-commit autoupdate`.

## Documentation Generation

Code formatting and documentation for `variables` and `outputs` is generated using [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform/releases) hooks that in turn uses [terraform-docs](https://github.com/terraform-docs/terraform-docs) that will insert/update documentation. The following markers have been added to the `README.md`:
```
<!-- {BEGINNING|END} OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.1.7 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | = 2.28.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.28.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_app.static_site_app](https://registry.terraform.io/providers/digitalocean/digitalocean/2.28.1/docs/resources/app) | resource |
| [digitalocean_droplet.droplet](https://registry.terraform.io/providers/digitalocean/digitalocean/2.28.1/docs/resources/droplet) | resource |
| [digitalocean_loadbalancer.droplet](https://registry.terraform.io/providers/digitalocean/digitalocean/2.28.1/docs/resources/loadbalancer) | resource |
| [digitalocean_project.project](https://registry.terraform.io/providers/digitalocean/digitalocean/2.28.1/docs/resources/project) | resource |
| [digitalocean_record.droplet](https://registry.terraform.io/providers/digitalocean/digitalocean/2.28.1/docs/resources/record) | resource |
| [digitalocean_tag.tags](https://registry.terraform.io/providers/digitalocean/digitalocean/2.28.1/docs/resources/tag) | resource |
| [digitalocean_account.account_details](https://registry.terraform.io/providers/digitalocean/digitalocean/2.28.1/docs/data-sources/account) | data source |
| [digitalocean_domain.domain_record_hostname](https://registry.terraform.io/providers/digitalocean/digitalocean/2.28.1/docs/data-sources/domain) | data source |
| [digitalocean_ssh_key.personal_ssh_key](https://registry.terraform.io/providers/digitalocean/digitalocean/2.28.1/docs/data-sources/ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_on_push_static_app"></a> [deploy\_on\_push\_static\_app](#input\_deploy\_on\_push\_static\_app) | Whether to automatically deploy new <br>commits made to the Github repository. | `bool` | n/a | yes |
| <a name="input_do_api_token"></a> [do\_api\_token](#input\_do\_api\_token) | Your digital ocean API Token required for changes<br>Set environment variable `TF_VAR_do_api_token` with value.<br>Or using -var="do\_api\_token=..." CLI option | `string` | n/a | yes |
| <a name="input_droplet_count"></a> [droplet\_count](#input\_droplet\_count) | The amount of droplets to be created<br>in the specified region. | `number` | `1` | no |
| <a name="input_droplet_size"></a> [droplet\_size](#input\_droplet\_size) | The droplet size. | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment of the project's resources. The possible values <br>are: `Development`, `Staging`, `Production`. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Specify the datacenter that the droplet will<br>be located. | `string` | `"lon1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_status"></a> [account\_status](#output\_account\_status) | Return your digitalocean account status |
| <a name="output_loadbalancer"></a> [loadbalancer](#output\_loadbalancer) | Return the IP address of the load balancer. |
| <a name="output_project_resources"></a> [project\_resources](#output\_project\_resources) | Return resources assoicated to the project |
| <a name="output_server_ipv4_addresses"></a> [server\_ipv4\_addresses](#output\_server\_ipv4\_addresses) | Return all droplet ipv4 addresses |
| <a name="output_static_app_live_domain"></a> [static\_app\_live\_domain](#output\_static\_app\_live\_domain) | The live URL of the app. |
| <a name="output_static_app_updated_at"></a> [static\_app\_updated\_at](#output\_static\_app\_updated\_at) | The date and time of when the app was <br>last updated. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
