#!/bin/bash

export REACT_APP_REGION=$(aws cloudformation describe-stacks --stack-name $stack_name --query "Stacks[0].Outputs[?OutputKey=='Region'].OutputValue" --output text)
export REACT_APP_USER_POOL_ID=$(aws cloudformation describe-stacks --stack-name $stack_name --query "Stacks[0].Outputs[?OutputKey=='CognitoUserPoolId'].OutputValue" --output text)
export REACT_APP_USER_POOL_CLIENT=$(aws cloudformation describe-stacks --stack-name $stack_name --query "Stacks[0].Outputs[?OutputKey=='CognitoUserPoolClientId'].OutputValue" --output text)
export REACT_APP_IDENTITY_POOL_ID=$(aws cloudformation describe-stacks --stack-name $stack_name --query "Stacks[0].Outputs[?OutputKey=='CognitoIdentityPoolId'].OutputValue" --output text)

npm start
