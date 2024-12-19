# Run an NGINX Webserver index page in a Docker Container using Terraform

This provides step-by-step instructions to set up an NGINX webserver in a Docker container using Terraform. These instructions are designed for execution on a local machine.

## Prerequisites

Before starting, ensure you have the following installed on your system:

- [Docker](https://docs.docker.com/get-docker/) (version 20.x or later)
- [Terraform](https://www.terraform.io/downloads) (version 1.5 or later)

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

## Steps to execute on your local machine

### Step 1: Clone the Repository and Navigate to the Project Directory

1. Clone this repository to your local machine:

   ```
   git clone https://github.com/riskRover/Webserver-Docker-Terraform.git
   ```

2. Navigate to the project directory:

   ```
   cd Webserver-Docker-Terraform/
   ```

### Step 2: Configure Terraform Files

Ensure the following Terraform files are present and correctly configured as per above directory structure.

#### 1. **main.tf**

This file defines the Terraform resources for creating the Dockerfile, building the Docker image, and running the container

#### 2. **provider.tf**

This file configures the Docker provider

#### 3. **variables.tf**

This file defines the content of the Dockerfile:

### Step 3: Add Static Files if you want to modify 

1. Verify a folder named `sp` in the root directory if it does not exist.
2. Add the following static files to the `sp` directory:

```plaintext
sp/
├── index.html
├── style.css
└── image.jpg
```

You can replace these files with your own HTML, CSS, and images if desired.

### Step 4: Deploy the Infrastructure

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

   Open a browser like Google chrome and navigate to `http://localhost:5000`. As Docker Conatainer port 80 has been exposed to 5000 of machine.
   Note - Please confirm as Port `5000` is not occupied on your local machine
   ```
   # For Linux OS
   $ sudo netstat -tuln | grep :500

   # For Windows OS
   netstat -ano | findstr :80
   ```
   If it is occupied, You can either kill the respective process running on port `5000` or You can replace with any other port number in main.tf file as below
   ```
   # Run Docker Container
   resource "docker_container" "webserver_container" {
     name  = "webcontainer"
     image = docker_image.webserver_image.name
     ports {
       internal = "80"
       external = "5000" # replace your port number
       }
    }
    ```

### Step 5: Clean Up

To remove the resources created by Terraform, run:

```
terraform destroy
```

Type `yes` to confirm the destruction.

## Notes

- Ensure that the `docker` daemon is running on your machine before executing Terraform commands.
- You can customize the NGINX webserver by modifying the static files in the `sp` folder.

## Troubleshooting

- If the container does not start, ensure that the Docker engine is properly installed and running.
- Use `docker ps` to verify that the container is up and running.
- Check logs with `docker logs webcontainer` if issues persist.

## References

- [NGINX Documentation](https://nginx.org/en/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [Terraform Docker Provider](https://registry.terraform.io/providers/kreuzwerker/docker/latest)
