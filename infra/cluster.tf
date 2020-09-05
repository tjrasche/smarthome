# main cluster 
resource "digitalocean_kubernetes_cluster" "k8s" {
  name    = "smarthome"
  region  = "fra1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.18.8-do.0"
  node_pool {
    name       = "base-load"
    size       = "s-1vcpu-1gb"
    node_count = 2
  }
}
# k8s namespace for all gateway/ingres related ressources
resource "kubernetes_namespace" "gateway" {
  metadata {
    name = "gateway"
  }
}

# helm release for the gloo gateway
resource "helm_release" "gateway" {
  name       = "gloo"
  repository = "https://storage.googleapis.com/solo-public-helm" 
  chart      = "gloo"
  namespace = kubernetes_namespace.gateway.metadata.name
  set {
    name  = "crds.create"
    value = "true"
  }
  set {
    name = "settings.writeNamespace"
    value: kubernetes_namespace.gateway.metadata.name
  }
}