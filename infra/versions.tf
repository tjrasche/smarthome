terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    source = "hashicorp/helm"
      version = "1.3.0"
  }
  required_version = ">= 0.13"
}
