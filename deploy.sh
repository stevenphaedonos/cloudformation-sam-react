#!/bin/bash

source .env

aws cloudformation package --template-file cloudformation.yaml --s3-bucket $project_bucket \
--s3-prefix cloudformation --output-template-file cloudformation.packaged.yaml

aws cloudformation deploy --template-file cloudformation.packaged.yaml --stack-name $stack_name \
--capabilities CAPABILITY_NAMED_IAM --parameter-overrides ProjectBucketName=$project_bucket \
Domain=$domain GitOwner=$git_owner GitRepo=$git_repo GitBranch=$git_branch \
AcmCertificateArn=$acm_certificate_arn
