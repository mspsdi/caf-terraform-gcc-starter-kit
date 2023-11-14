
private_dns = {
  dns1 = {
    name               = "project.rsaf.gov.sg"
    resource_group_key = "networking_spoke_internet_re1"

    records = {
      a_records = {
        ingress = {
          name    = "aks"
          ttl     = 3600
          records = ["100.2.0.95"] # TODO: set the ingress controller private ip address
        }
      }
    }

    vnet_links = {
      project_internet_vnet_link = {
        name = "vnet-link-internet"
        vnet_key = "vnet_spoke_internet_re1"
      }
    }
  }
}