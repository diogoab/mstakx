#Connect to provider
provider "google" {
    credentials = "${file("terraform_key.json")}"
    project     = "${var.project_id}"
    region      = "${var.region}"
}

# Create VM
resource "google_compute_instance" "k8s-master" {
  name         = "${var.name_master}"
  machine_type = "${var.type_instance_master}"
  zone         = "${var.zone}"


boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

# Install the cluster
# metadata_startup_script = "curl https://raw.githubusercontent.com/diogoab/mstakx_leve1/debian/install.sh | bash"
metadata = {
    ssh-keys = "ubuntu:${file("../00_Keys/id_rsa.pub")}"
}

# Enable network for public access
network_interface {
    network = "default"
    access_config {
    }
  }
// allow Terrform to connect via ssh
connection {
    user = "ubuntu"
    type = "ssh"
    private_key = "${file("../00_Keys/id_rsa.pem")}"
    timeout = "2m"
}

  // run all necessary commands via remote shell 
provisioner "remote-exec" {
    inline = [

        # steps to setup docker ce
        "apt update",
        "apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common",
        "curl -LO https://git.io/get_helm.sh",
        "chmod 700 get_helm.sh"      
    ]
  }
}
output "k8s_master" {
  value = "${google_compute_instance.k8s-master.network_interface.0.access_config.0.nat_ip}"
}

resource "google_compute_instance" "k8s-workers" {
  count        = "2"
  name         = "${var.name_worker}-${count.index + 1}"
  machine_type = "${var.type_instance_workers}"
  zone         = "${var.zone}"


boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

# Install the Keys
metadata = {
    ssh-keys = "ubuntu:${file("../00_Keys/id_rsa.pub")}"
}

# Enable network for public access
network_interface {
    network = "default"
    access_config {
    }
  }
}

resource "google_compute_firewall" "k8s-firewall" {
  name   = "${var.nome_fw}"
  network  = "default"

  allow {
    protocol = "tcp"
    ports    = "${var.portas}"
  }
}


output "k8s_workers" {
  value = "${google_compute_instance.k8s-workers.*.network_interface.0.access_config.0.nat_ip}"
}