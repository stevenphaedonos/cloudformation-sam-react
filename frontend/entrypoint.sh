#!/bin/bash

args=()
[[ ! -z $region ]] && args+=("--region") && args+=($region)
[[ ! -z $profile ]] && args+=("--profile") && args+=($profile)

output=$(aws cloudformation describe-stacks "${args[@]}" --stack-name $stack_name --query "Stacks[0].Outputs")
export REACT_APP_REGION=$(jq -nr "$output | .[] | select(.OutputKey==\"Region\") | .OutputValue")
export REACT_APP_USER_POOL_ID=$(jq -nr "$output | .[] | select(.OutputKey==\"CognitoUserPoolId\") | .OutputValue")
export REACT_APP_USER_POOL_CLIENT=$(jq -nr "$output | .[] | select(.OutputKey==\"CognitoUserPoolClientId\") | .OutputValue")
export REACT_APP_IDENTITY_POOL_ID=$(jq -nr "$output | .[] | select(.OutputKey==\"CognitoIdentityPoolId\") | .OutputValue")

npm start
