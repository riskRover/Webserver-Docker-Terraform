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

# Create a Dockerfile Resource
resource "local_file" "webserver_dockerfile" {
  filename = "/usr/local/Docker_TF/Dockerfile"
  content  = var.dockerfile_content
}

# Build the Docker Image
resource "docker_image" "webserver_image" {
  name = "webserver"
  build {
    context = "/usr/local/Docker_TF"
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
