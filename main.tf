module "istio_gke" {
  source = "./istio"

  cluster_node_network_tags = []
  private_cluster           = false
  address_name              = "private"
  istio_ingress_configuration = {
    allow_http = false
    hosts = [
      {
        host = "demo.astrafy.online"
      },
      {
        host = "article.astrafy.online"
      },
    ]
  }
  virtual_services = {
    vs-vault = {
      target_namespace = "app"
      hosts            = ["demo.astrafy.online", "article.astrafy.online"]
      target_service   = "ngnix-service"
      port_number      = 80
    }
  }
  use_crds = true
}
