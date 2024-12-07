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