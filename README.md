# cloudformation-sam-react

## Description

- Boilerplate code to launch a cloud-native web application with a ReactJS frontend and Python backend
- Infrastructure described as code using CloudFormation and deployed to Amazon Web Services (AWS)
- Local development environment provided via Docker (and Docker Compose)

## Architecture

| Component      | Notes                                                                                                                                                                                             |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Frontend       | - Bootstrapped by [create-react-app](https://github.com/facebook/create-react-app) <br/> - [Material UI](https://github.com/mui-org/material-ui) Framework <br/> - Deployed via AWS S3/CloudFront |
| Backend        | - [AWS Serverless Application Model](https://aws.amazon.com/serverless/sam/) with Python handlers <br/> - Deployed via AWS Lambda/API Gateway                                                     |
| Authentication | AWS Cognito via [aws-amplify](https://github.com/aws-amplify/amplify-js)                                                                                                                          |
| CI/CD pipeline | AWS CodePipeline + GitHub hook + AWS CodeBuild                                                                                                                                                    |

## Configuration

### CloudFormation

- The following parameters should be provided in `.env`
- Refer to [`.env.dist`](env.dist) for examples

| Parameter           | Required | Description                                                                                                                                                                                                                         |
| ------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| stack_name          | Yes      | - Uniquely identifying name of the project <br/> - The following 3 CloudFormation stacks will be created: <br/> `${stack-name}`, `${stack-name}-api-stage`, `${stack-name}-api-prod`                                                |
| domain              | Yes      | - Domain name of the project (e.g. example.com) <br/> - The following 4 domains are intended to become web-accessible: <br/> `https://${domain}`, `https://api.${domain}`, `https://stage.${domain}`, `https://api.stage.${domain}` |
| project_bucket      | Yes      | Location to store project files (cloudformation packages, api gateway deployments, frontend build files) - **this bucket will be created by CloudFormation**                                                                        |
| git_owner           | Yes      | Username of the GitHub account which owns the GitHub code repository                                                                                                                                                                |
| git_repo            | Yes      | Name of the GitHub code repository                                                                                                                                                                                                  |
| git_branch          | Yes      | Name of the branch to be deployed (commits to this branch will trigger the CI/CD pipeline)                                                                                                                                          |
| acm_certificate_arn | Yes      | The ARN of the ACM certificate created in the [ACM configuration](<###Amazon-Certificate-Manager-(ACM)>)                                                                                                                            |
| region              | No       | The [AWS region](https://docs.aws.amazon.com/general/latest/gr/rande.html#regional-endpoints) to which the CloudFormation stack will be deployed                                                                                    |
| profile             | No       | The [named profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) to use when deploying the CloudFormation stack                                                                                    |

### GitHub Access Token

- [GitHub access token](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line) stored in AWS Secrets Manager with name `GITHUB_TOKEN`
- The CodePipeline source is configured as a GitHub hook that uses this token

### Amazon Certificate Manager (ACM)

- An ACM Certificate must be created in the _us-east-1_ region with at least the following aliases:
  - `${domain}`
  - `*.${domain}`
  - `*.stage.${domain}`
- _us-east-1_ region is required in order for the ACM Certificate to be used by the frontend CloudFront distributions and the edge-optimised API Gateway stages

## Development

1. Configure the project as described in [Configuration](#Configuration)
2. Run `./deploy.sh` in order to deploy the infrastructure for the project
3. Run `docker-compose up --build` to launch the local dev environment
   - Changes to the frontend are hot reloaded
   - The backend is re-built on each function execution
4. Pushing a commit to the `git_repository_branch` will trigger a deployment to stage, and then to prod (after manual approval)
