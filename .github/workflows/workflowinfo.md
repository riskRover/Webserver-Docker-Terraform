# Terraform and Docker Workflow

This repository includes a GitHub Actions workflow that integrates Docker and Terraform to manage and automate Docker container deployments. The workflow consists of two jobs:

1. **Check-Docker-Status**: This job is triggered manually via the `workflow_dispatch` event. It checks the status of the Docker container and manages its lifecycle.
2. **Terraform**: This job is automatically triggered on push events to branches with names starting with `ma**` or tags with the pattern `v*.*.*`. It performs Terraform infrastructure management tasks such as initialization, planning, and application of changes.

## Workflow Overview

### Triggering the Workflow

The workflow can be triggered in two ways:
- **Automatic Trigger**: On a `push` event to branches that match the pattern `ma**` or tags that match the pattern `v*.*.*`.
- **Manual Trigger**: Using the `workflow_dispatch` event, where the user can specify a custom Docker container name.

### Workflow Steps

#### 1. Check-Docker-Status Job (Manual Trigger)

This job runs only when manually triggered using the `workflow_dispatch` event. This is to stop container and destroy infrastructure created by Terraform.

- **Cleanup Build Folder**: Cleans up the build folder by removing all files.
- **Checkout Repository**: Checks out the repository code.
- **Check Working Directory and Prerequisites**: Verifies the current working directory and installs necessary dependencies like Terraform and Docker.
- **Set Container Name**: Sets the Docker container name using the input `container_name` or defaults to `webcontainer`.
- **Check Docker Container Status**: Checks whether the specified Docker container is running or not.
- **Stop Docker Container**: If the container is running, it stops and removes the container.
- **Destroy Existing Terraform Infrastructure**: Runs `terraform destroy` to destroy any existing infrastructure.

#### How to run Check-Docker-Status Job manually :
Please find below attached ss to run workflow manually, click on `Run workflow` dropdown and choose respective branch and update field `Name of the Docker container`.
And click on `Run workflow` button.

![githubeventworkflow](https://github.com/user-attachments/assets/30c29ac3-1877-4243-8be5-4ead20994c1d)


#### 2. Terraform Job (Automatic Trigger)

This job is triggered automatically for push events that match certain branch or tag patterns.

- **Cleanup Build Folder**: Cleans up the build folder by removing all files.
- **Checkout Repository**: Checks out the repository code.
- **Check Working Directory and Prerequisites**: Verifies the current working directory and installs necessary dependencies like Terraform and Docker.
- **Terraform Init**: Initializes Terraform configuration.
- **Terraform Plan**: Creates an execution plan for Terraform to determine the changes.
- **Terraform Apply**: Applies the Terraform plan to provision infrastructure.

## Inputs

- **container_name**: (Optional) The name of the Docker container. This is only used in the `Check-Docker-Status` job. If not provided, it defaults to `webcontainer`.

## Example Usage

1. **Automatic Trigger (push event)**:  
   Push a change to a branch starting with `ma` (e.g., `master`) or tag matching `v*.*.*` (e.g., `v1.0.0`) to trigger the Terraform job.

2. **Manual Trigger**:  
   Manually trigger the workflow via GitHub Actions, providing an optional `container_name` input.

## Requirements for Runner

- Docker must be installed and running.
- Terraform must be installed and configured.
- GitHub Self-hosted runners should be configured. You can follow [this guide](https://docs.github.com/en/actions/hosting-your-own-runners/configuring-and-adding-self-hosted-runners) to configure a GitHub self-hosted runner.

## Setting up GitHub Self-Hosted Runner on AWS EC2

- To configure a GitHub self-hosted runner on an AWS EC2 instance with the required permissions, you can follow the detailed guide provided in this [GitHub repository](https://github.com/machulav/ec2-github-runner) or refer to the [AWS Blog for best practices](https://aws.amazon.com/blogs/devops/best-practices-working-with-self-hosted-github-action-runners-at-scale-on-aws/).
- Also, you can refer page for setting above requirements for Runner while setting up EC2 instance as runner [Setup Docker on EC2 Instance](https://github.com/riskRover/Webserver-Docker-Terraform/blob/feature/updates-mdfiles/Execute-on-AWS-Virtual-Machine(EC2).md#step-1-launch-an-ec2-instance)
