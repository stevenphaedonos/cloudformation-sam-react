#!/bin/bash

user_pool_arn=$(aws cloudformation describe-stacks --stack-name $stack_name --query "Stacks[0].Outputs[?OutputKey=='UserPoolArn'].OutputValue" --output text)

sam local start-api --docker-volume-basedir $basedir --template-file /backend/template.yaml \
--host 0.0.0.0 --port 5000 --parameter-overrides ParameterKey=FrontendUrl,ParameterValue=$frontend_url \
ParameterKey=UserPoolArn,ParameterValue=$user_pool_arn
