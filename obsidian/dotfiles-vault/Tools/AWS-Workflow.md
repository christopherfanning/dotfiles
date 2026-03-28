# AWS Workflow

> Local-first: develop and test locally → build a machine image with Packer → provision infra with OpenTofu → deploy.

## Toolchain

| Tool | Role |
|------|------|
| **aws-cli-v2** | Interact with all AWS services from the terminal |
| **aws-vault** | Store AWS credentials securely (system keychain, never plaintext) |
| **Packer** | Build AMIs (machine images) from code |
| **OpenTofu** | Provision AWS infrastructure (Lightsail, EC2, S3, etc.) |

## Workflow

```
Local Docker Compose  →  Multipass VM  →  Packer build AMI  →  OpenTofu deploy
(develop fast)           (test image)      (codify image)        (provision infra)
```

## aws-vault setup (do this first)

```bash
aws-vault add my-profile         # stores in system keychain
aws-vault exec my-profile -- aws s3 ls    # run any aws-cli command
aws-vault exec my-profile -- tofu apply   # run opentofu with creds injected
```

Never put credentials in `~/.aws/credentials` plaintext again.

## Packer — build an AMI

```bash
cd iac/packer
packer init .
packer validate wordpress-ami.pkr.hcl
aws-vault exec my-profile -- packer build wordpress-ami.pkr.hcl
```

## OpenTofu — provision infra

OpenTofu is a drop-in replacement for Terraform. Binary is `tofu`, HCL syntax is identical.

```bash
cd iac/opentofu
tofu init
tofu plan
aws-vault exec my-profile -- tofu apply
```

### Migrating from Terraform

```bash
# Just change the binary — everything else is the same
terraform plan  →  tofu plan
terraform apply →  tofu apply
```

## aws-cli useful commands

```bash
aws lightsail get-instances
aws lightsail get-bundles               # list instance sizes + prices
aws ec2 describe-images --owners self   # list your AMIs
aws s3 ls s3://your-bucket
```

## Templates

See `~/code/wordpress-starter/iac/` for ready-to-use Packer + OpenTofu templates.
