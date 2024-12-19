# Running an NGINX Webserver index page in a Docker Container using Terraform on AWS EC2

This provides step-by-step instructions to set up an NGINX webserver in a Docker container using Terraform. These instructions are designed for execution on an AWS EC2 instance.

## Prerequisites

Before starting, ensure you have the following:

- A Free Tier AWS account with permissions to create EC2 instances.
- [AWS CLI](https://aws.amazon.com/cli/) configured on your local machine.
- [Docker](https://docs.docker.com/get-docker/) installed on the EC2 instance.
- [Terraform](https://www.terraform.io/downloads) installed on your EC2 machine.
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) installed on the EC2 instance to clone the repository.

## Directory Structure

```plaintext
.
├── .github/workflow
│   └── workflow.yml
├── main.tf
├── provider.tf
├── variables.tf
├── sp
│   ├── index.html
│   ├── style.css
│   └── image.jpg
└── README.md
```

## Steps to Execute on an AWS EC2 Instance
I had created and used EC2 instance with Ubuntu 24.04 AMI

### Step 1: Launch an EC2 Instance

1. Log in to your AWS Management Console.
2. Launch an EC2 instance with the following specifications:
   - **AMI**: Amazon Linux 2 or Ubuntu 20.04
   - **Instance Type**: t2.micro (or larger, based on your requirements)
   - **Security Group**:
     - Ensure the security group associated with your EC2 instance is configured to allow:
       - **Inbound Traffic** on port 5000 (HTTP) from all sources.
       - **Inbound Traffic** on port 443 (HTTPS) from all sources.
       - **Inbound Traffic** on port 22 (SSH) for administrative access.

3. Connect to the instance via SSH:
   ```
   ssh -i <your-key.pem> ubuntu@<ec2-public-ip>
   ```

4. Install Docker on the EC2 instance:
   ```
   sudo apt-get update -y
   sudo apt-get install docker -y
   sudo systemctl start docker
   sudo systemctl enable docker
   ```
5. Install Git on the EC2 instance:
   ```
   sudo apt-get install git -y
   ```
6. Ensure Docker has the required permissions on the EC2 instance. If not, follow these steps:
   To Verify the Docker socket permissions by using following command
   ```
   ls -l /var/run/docker.sock
   ```
   If Output should show the socket is owned by root and the Docker group
   Now Add trusted users to the Docker group by using following command
   ```
   sudo usermod -aG docker ubuntu 
   ```
   Now restart docker by using following command
   ```
   sudo systemctl restart docker
   ```
   Check the status to ensure Docker is running:
   ```
   sudo systemctl status docker
   ```

### Step 2: Clone the Repository and Navigate to the Project Directory

1. Clone this repository onto the EC2 instance:
   ```
   git clone https://github.com/riskRover/Webserver-Docker-Terraform.git
   ```

2. Navigate to the project directory:
   ```
   cd Webserver-Docker-Terraform/
   ```

### Step 3: Configure Terraform Files

Ensure the following Terraform files are present and correctly configured:

#### 1. **main.tf**

This file defines the Terraform resources for creating the Dockerfile, building the Docker image, and running the container.

#### 2. **provider.tf**

This file configures the Docker provider.

#### 3. **variables.tf**

This file defines the content of the Dockerfile.

### Step 4: Add Static Files

1. Create a folder named `sp` in the root directory if it does not exist.
2. Add the following static files to the `sp` directory:

```plaintext
sp/
├── index.html
├── style.css
└── image.jpg
```

You can replace these files with your own HTML, CSS, and images if desired.

### Step 5: Deploy the Infrastructure

1. Initialize Terraform:
   ```
   terraform init
   ```

2. Plan the Terraform configuration:
   ```
   terraform plan
   ```

3. Apply the configuration:
   ```
   terraform apply
   ```
   Review the proposed changes and type `yes` to confirm.

4. Verify that the NGINX webserver is running:

- Open a browser like Google chrome and navigate to `http://<ec2-public-ip>:5000`. As Docker Conatainer port 80 has been exposed to 5000 of machine.

### Step 6: Clean Up

To remove the resources created by Terraform, run:

```bash
terraform destroy
```

Type `yes` to confirm the destruction.

## Notes

- Ensure the Docker daemon is running on your EC2 instance before executing Terraform commands.
- You can customize the NGINX webserver by modifying the static files in the `sp` folder.

## Troubleshooting

- Ensure the security group associated with your EC2 instance is configured for an inbound rule with port 5000 correctly.
- If the container does not start, ensure the Docker engine is properly installed and running.
- Use `docker ps` to verify that the container is up and running.
- Check logs with `docker logs webcontainer` if issues persist.

## References

- [NGINX Documentation](https://nginx.org/en/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [Terraform Docker Provider](https://registry.terraform.io/providers/kreuzwerker/docker/latest)
- [AWS EC2 Documentation](https://aws.amazon.com/ec2/)
