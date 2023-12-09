


locals {
    kis_os_auth_url ="https://158.193.152.44:5000/v3/"
    kis_os_region   = "RegionOne"

    

     kis_os_endpoint_overrides = {
    compute = "https://158.193.152.44:8774/v2.1/"
    image   = "https://158.193.152.44:9292/v2.0/"
    network = "https://158.193.152.44:9696/v2.0/"
  }

  kis_os_domain_name = "admin_domain"


  university = {
    network = {
      cidr = "158.193.0.0/16"
    }
  }
}