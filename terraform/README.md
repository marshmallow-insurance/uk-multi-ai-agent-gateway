# Requirements

```bash
$ brew install terraform
```

```bash
$ brew update
$ brew upgrade terraform
```

```
[profile terraform-staging]
sso_start_url = https://marshmallow.awsapps.com/start#/
sso_region = eu-west-1
sso_account_id = 545209064596
sso_role_name = terraform-management
region = eu-west-1
output = json
```
This config needs to  be added to your .aws/config if not already present.

```bash
export DD_HOST=https://api.datadoghq.eu/
export DD_APP_KEY= # available in 1Password
export DD_API_KEY= # available in 1Password
export AWS_PROFILE= # depends on environment
```
Then need to login to the profile via:
```bash
$ aws sso login --profile terraform-staging && export AWS_PROFILE="terraform-staging"
```

# Execution

```bash
$ terraform init -backend-config environments/<ENVIRONMENT>/backend.tf -reconfigure
```

```bash
$ terraform plan -var-file environments/staging/staging.tfvars -var image_tag=<IMAGE_VERSION> -out staging.plan
```

```bash
$ terraform apply staging.plan
```
