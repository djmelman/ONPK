# --- main.tf---
resource "openstack_networking_network_v2" "main" {
  name           = var.username
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  name = "subnet_1"
  network_id = openstack_networking_network_v2.main.id
  cidr       = "192.168.0.0/24"
  ip_version = 4
}



resource "openstack_networking_secgroup_v2" "security_group" {
  name        = "secgroup"
  description = "Managed by Terraform!"
}

# Allow ICMP from University network
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_university_icmp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = local.university.network.cidr
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

# Allow UDP from University network
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_university_udp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  remote_ip_prefix  = local.university.network.cidr
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

# Allow TCP from University network
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_university_tcp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = local.university.network.cidr
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

# Allow ICMP from your public IP address
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_icmp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "158.193.154.180/32"
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

# Allow UDP from your public IP address
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_udp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  remote_ip_prefix  = "158.193.154.180/32"
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

# Allow ALL TCP from your public IP address
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_tcp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = "158.193.154.180/32"
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}





resource "openstack_compute_keypair_v2" "keypair" {
  name = "klucik_keypair"
}

resource "local_file" "private_key" {
  filename = "my_key.pem" 
  content  = openstack_compute_keypair_v2.keypair.private_key
}

output "private_key_file" {
  value = local_file.private_key.filename
}



resource "openstack_compute_instance_v2" "public_server" {
  name            = "public_server"
  image_name        = "ubuntu-22.04-kis"
  flavor_name       = "1c05r8d"
  key_pair        = "klucik_keypair"
  security_groups = ["secgroup"]
  metadata = {
    this = "that"
  }

  network {
    name = "ext-net-154"
  }
  network {
    name = "stud10"
  }
}

resource "openstack_compute_instance_v2" "private_server" {
  name            = "private"
  image_name        = "ubuntu-22.04-kis"
  flavor_name       = "1c05r8d"
  key_pair        = "klucik_keypair"
  security_groups = ["secgroup"]

  metadata = {
    this = "that"
  }

  network {
    name = "stud10"
  }
  
  user_data = "${file("test.sh")}"
}

