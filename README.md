# Terraform for IBM Kubernetes Service Platform

> **Please note that this module is currently under development.**

The overall flow for this module is pretty simple:

* Create IBM object storage account to store Terraform state
* Create IBM IKS Platform configuration in a modular manner
* Deploy the infrastructure incrementally

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependencies

* [terraform-kubernetes-iks](https://github.com/canada-ca-terraform-modules/terraform-kubernetes-iks)

## Workflow

1. Create terraform.tfvars based on example template provider.

2. Generate HMAC credentials for your Object Storage account: https://cloud.ibm.com/docs/services/cloud-object-storage/iam?topic=cloud-object-storage-service-credentials#service-credential-endpoints

```sh
export AWS_ACCESS_KEY_ID=<access_key>
export AWS_SECRET_ACCESS_KEY=<secret>
```

3. Initialize and set the Terraform backend configuration parameters for the AzureRM provider.

```sh
terraform init \
  -backend-config="endpoint=s3.tor01.cloud-object-storage.appdomain.cloud" \
  -backend-config="region=tor01" \
  -backend-config="bucket=tfstate" \
  -backend-config="key=${prefix}-iks-platform.tfstate"
```

4. Create an execution plan and save the generated plan to a file.

```sh
terraform plan -out plan
```

5. Apply the changes required to reach desired state.

```sh
terraform apply plan
```

> Note: You might have to run terraform plan and apply a few times due to dependency issues.

## History

| Date     | Release    | Change      |
| -------- | ---------- | ----------- |
| 20190930 | 20190930.1 | 1st release |
