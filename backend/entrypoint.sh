#!/bin/bash

args=()
[[ ! -z $region ]] && args+=("--region") && args+=($region)
[[ ! -z $profile ]] && args+=("--profile") && args+=($profile)

output=$(aws cloudformation describe-stacks "${args[@]}" --stack-name $stack_name --query "Stacks[0].Outputs")
user_pool_arn=$(jq -nr "$output | .[] | select(.OutputKey==\"CognitoUserPoolArn\") | .OutputValue")

sam local start-api --docker-volume-basedir $basedir --template-file /backend/template.yaml "${args[@]}" \
--host 0.0.0.0 --port 5000 --parameter-overrides ParameterKey=FrontendUrl,ParameterValue=$frontend_url \
ParameterKey=UserPoolArn,ParameterValue=$user_pool_arn
