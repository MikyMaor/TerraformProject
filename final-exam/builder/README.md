# Final exam: builder EC2 in existing VPC

Provisions the `builder` EC2 instance required by the exam in VPC `vpc-044604d0bfb707142`.

## What this creates

- EC2 instance named `builder` (t3.medium)
- SSH key pair (`builder_key.pem` saved locally)
- Security group: SSH (22) + HTTP app (5001)

## Before apply

1. Configure AWS credentials (`aws configure` or env vars).
2. Set your public IP in `terraform.tfvars`:

```hcl
allowed_ssh_cidr = "YOUR.IP.ADDRESS/32"
```

## Run

```bash
cd final-exam/builder
terraform init
terraform plan
terraform apply
```

## After apply

```bash
ssh -i builder_key.pem ec2-user@<builder_public_ip>
# Install Docker manually (exam section 2) or add remote-exec (bonus)
```

## Outputs

- `builder_public_ip`
- `ssh_private_key_path` (sensitive)
- `ssh_key_name`
- `security_group_id`
