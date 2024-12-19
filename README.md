# Project Overview

This repository contains the configuration and code for deploying and running a simple web application on both a local machine and an AWS EC2 instance. The application includes an HTML page, a stylesheet, and an image, and it can be deployed and executed using Terraform on AWS EC2 or directly on a local machine.

![Docker](https://img.shields.io/badge/Docker-Available-brightyellow) 

![Terraform](https://img.shields.io/badge/Terraform-v1.9.8%2B-blue)

[![Run Docker Container with Terraform](https://github.com/riskRover/Webserver-Docker-Terraform/actions/workflows/workflow.yml/badge.svg)](https://github.com/riskRover/Webserver-Docker-Terraform/actions/workflows/workflow.yml)

## Repository Structure

```
├── .github/workflow
│   ├── workflow.yml            
│   └── workflowinfo.md         
├── main.tf                     # Terraform main configuration for Docker Container
├── provider.tf                 # Terraform provider configuration for Docker
├── variables.tf                # Terraform variables configuration for creating Dockerfile
├── sp
│   ├── index.html              # Main HTML file for the web application
│   ├── style.css               # CSS stylesheet for the web application
│   └── image.jpg               # Image file used in the web application
├── Execute-on-AWS-Virtual-Machine(EC2).md  
├── Execute-on-local-machine.md  
└── README.md                   
```
### 

#### 1. **main.tf**

This file defines the Terraform resources for creating the Dockerfile, building the Docker image, and running the container: 
```
# Create a Dockerfile Resource
resource "local_file" "webserver_dockerfile" {
  filename = "/actions-runner/_work/Webserver-Docker-Terraform/Webserver-Docker-Terraform/Dockerfile"
  content  = var.dockerfile_content
}

# Build the Docker Image
resource "docker_image" "webserver_image" {
  name = "webserver"
  build {
    context = "/actions-runner/_work/Webserver-Docker-Terraform/Webserver-Docker-Terraform"
    dockerfile = "Dockerfile"
  }
}

# Run Docker Container
resource "docker_container" "webserver_container" {
  name  = "webcontainer"
  image = docker_image.webserver_image.name
  ports {
    internal = "80"
    external = "5000"
  }
}
```

#### 2. **provider.tf**

This file configures the Docker provider:
```
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
```

#### 3. **variables.tf**

This file defines the content of the Dockerfile:
```
# Define the Dockerfile content
variable "dockerfile_content" {
  default = <<EOF
FROM nginx:latest

COPY ./sp/index.html  /usr/share/nginx/html/
COPY ./sp/style.css  /usr/share/nginx/html/
COPY ./sp/image.jpg /usr/share/nginx/html/

EXPOSE 80

EOF
}
```
### Setup and Deployment
#### 1. Deploying on AWS EC2 
You can refer to page for more details [Execute-on-AWS-Virtual-Machine](https://github.com/riskRover/Webserver-Docker-Terraform/blob/main/Execute-on-AWS-Virtual-Machine.md#running-an-nginx-webserver-index-page-in-a-docker-container-using-terraform-on-aws-ec2)

#### 2. Deploying on Local Machine
You can refer to page for more details [Execute-on-local-machine](https://github.com/riskRover/Webserver-Docker-Terraform/blob/main/Execute-on-local-machine.md#run-an-nginx-webserver-index-page-in-a-docker-container-using-terraform)

#### 3. GitHub Actions (CI/CD)
You can refer to page for more details [Workflow Information](https://github.com/riskRover/Webserver-Docker-Terraform/blob/main/.github/workflows/workflowinfo.md#terraform-and-docker-workflow-information)

### Running Containerised Application 
Below Application webpage accesible after succssful running GitHub Actions workflow.

![webpage](https://github.com/user-attachments/assets/7385131b-358c-4c5f-b898-8546f603bf36)

### Conclusion
This repository provides the necessary resources and configurations for deploying a simple web application both on AWS EC2 and local machine. The deployment is managed with Terraform and automated using GitHub Actions for continuous integration and deployment.

✨ Feel free to explore, modify, and contribute to the repository! 🚀 Your contributions are always welcome! 🌟
