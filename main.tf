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
