terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "aws" {
  region = "us-east-1"
  access_key = "AKIAZPPF7Y27UO5TNPVY"
  secret_key = "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"
}
