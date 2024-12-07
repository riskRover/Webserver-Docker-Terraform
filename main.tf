# Create a Security Group with multiple ingress rules
resource "aws_security_group" "websg" {
  name        = "web"
  description = "Security group to allow multiple ingress rules"
  vpc_id      = "vpc-0b2ae0f8442a97dbc"  # Replace with your Default VPC ID

  # Ingress Rule 1: Allow TCP traffic on port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to all IPs (use more restrictive CIDR if needed)
  }

  # Ingress Rule 2: Allow TCP traffic on port 22
  #ingress {
  #  from_port   = 22
  #  to_port     = 22
  #  protocol    = "tcp"
  #  cidr_blocks = ["0.0.0.0/0"]
  #}

  # Ingress Rule 3: Allow custom protocol on port 5000
  ingress {
    from_port   = 80
    to_port     = 5000
    protocol    = "tcp"  # Replace with your custom protocol number
    cidr_blocks = ["0.0.0.0/0"]  # Restrict to specific IP range
  }
  # Allow all outbound traffic (egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 means allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance that uses the above security group
resource "aws_instance" "webec2" {
  ami             = "ami-0e2c8caa4b6378d8c"  # Replace with a valid AMI ID
  instance_type   = "t2.micro"      # Instance type, change as needed
  security_groups = [aws_security_group.websg.name]

  tags = {
    Name = "EC2-Instance-Webserver"
  }
}

# Output the public IP of the EC2 instance
output "instance_public_ip" {
  value = aws_instance.webec2.public_ip
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
