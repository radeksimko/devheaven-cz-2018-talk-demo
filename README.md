# devheaven-cz-2018-talk-demo

This is code for a demo presented during my talk at [DevHeaven 2018](https://devheaven.cz/).

## How to

### `00-terraform`

This directory contains initial Terraform configs to resolve the :chicken: & :egg: problem. It creates S3 buckets for tfstate & Lambda deployments and IAM user & policy for CircleCI (see below).

```
terraform apply
```

### `10-lambda`

This directory contains the Go code for Lambda function we can deploy in the next step.

### `20-terraform`

This directory contains API Gateway & Lambda & IAM resources required to deploy the demo.

```
terraform apply -var=s3_bucket=$(terraform output -state=../00-terraform/terraform.tfstate lambda_bucket_name)
```

### CI via CircleCI

CircleCI is used to continuously build, package & upload any new revisions to S3. For that reason it is necessary to [set up AWS credentials in Circle](https://circleci.com/docs/2.0/deployment-integrations/#aws) we generated in the first step. It just needs to be decrypted using your GPG key.

```
cd 00-terraform
terraform output aws_access_key_id
terraform output aws_access_key_secret | base64 -D - | gpg -d; echo
```

## Next Steps

This demo is a minimalistic & simple demo which can be improved, e.g. we could only ever upload new revisions to S3 if a tag is pushed.
