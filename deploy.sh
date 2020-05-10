#!/bin/bash

source .env

args=()
[[ ! -z $region ]] && args+=("--region") && args+=($region)
[[ ! -z $profile ]] && args+=("--profile") && args+=($profile)

aws cloudformation package --template-file cloudformation.yaml --s3-bucket $project_bucket \
--s3-prefix cloudformation --output-template-file cloudformation.packaged.yaml "${args[@]}"

aws cloudformation deploy --template-file cloudformation.packaged.yaml --stack-name $stack_name \
--capabilities CAPABILITY_NAMED_IAM --parameter-overrides ProjectBucketName=$project_bucket \
Domain=$domain GitOwner=$git_owner GitRepo=$git_repo GitBranch=$git_branch \
AcmCertificateArn=$acm_certificate_arn "${args[@]}"
