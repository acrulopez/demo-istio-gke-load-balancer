variable "private_cluster" {
  description = "Indicate if installing on a private cluster or not. Required for additional firewall rules"
  type        = bool
}

variable "vpc_network_id" {
  description = "VPC network ID to use to add additional firewall rules in private cluster. Required when `private_cluster` is `true`"
  type        = string
  default     = null
}

variable "cluster_node_network_tags" {
  description = "Network tags of the nodes. Used in private cluster to add additional firewall rules. Required when `private_cluster` is `true`"
  type        = list(string)
  default     = null
}

variable "istio_ingress_configuration" {
  description = "Istio Ingress configuration"
  type = object({
    allow_http = bool
    hosts = list(object({
      host            = string
      backend_service = optional(string)
    }))
  })
}

variable "use_crds" {
  description = "Use CRDs. Set to false during initial installation to prevent CRDs to be used when they don't exist"
  type        = bool
  default     = true
}

variable "virtual_services" {
  description = "Virtual Services to create"
  type = map(object({
    target_namespace = string
    hosts            = list(string)
    target_service   = string
    port_number      = number
  }))
  default = {}
}

variable "address_name" {
  description = "Suffix to add to the address. Used to be able to deploy this module in the same project several times."
  type        = string
  default     = ""
}

variable "shared_vpc_project_id" {
  description = "Shared VPC project ID. Only used if `private_cluster` is `true`"
  type        = string
  default     = null
}
