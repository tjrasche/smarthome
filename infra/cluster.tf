# all providers must be configured via env variables
# main cluster 
resource "digitalocean_kubernetes_cluster" "k8s" {
  name    = "smarthome"
  region  = "fra1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.18.8-do.0"
  node_pool {
    name       = "base-load"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}
provider "kubernetes" {
  
}
# k8s namespace for all gateway/ingres related ressources
resource "kubernetes_namespace" "gateway" {
  metadata {
    name = "gateway"
  }
}

# helm release for the gloo gateway
