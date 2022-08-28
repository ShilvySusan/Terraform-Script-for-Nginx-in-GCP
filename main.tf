
provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_firewall" "ssh" {
  name    = "sshfirewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] 
  target_tags   = ["sshfw"]
}

resource "google_compute_firewall" "webserver" {
  name    = "wsfirewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80","443"]
  }

  source_ranges = ["0.0.0.0/0"] 
  target_tags   = ["webserverfw"]
}

resource "google_compute_address" "static_ip" {
  name = "website-ip"
}

resource "google_compute_instance" "webinstance" {
  name         = "nginx-instance" 
  machine_type = "e2-micro"
  zone         = "${var.region}-a" 
  tags         = ["sshfw","webserverfw"] 

 
  boot_disk { 
    initialize_params {
      image = "ubuntu-2004-lts"
    }
  }

  
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }

  
  metadata = {
    ssh-keys = "${var.user}:${file(var.publickeypath)}"
  }

  metadata_startup_script = file(var.scriptpath)
  depends_on = [ google_compute_firewall.ssh, google_compute_firewall.webserver ]

  service_account {
    email  = var.email
    scopes = ["compute-ro"]
  }
  
}

output "public_ip_address" {
  value = google_compute_address.static_ip.address
}

output "user_name" {
  value = var.user
}

output "website_address" {
  value = var.website
}

output "ssh_access_via_ip" {
  value = "ssh ${var.user}@${google_compute_address.static_ip.address}"
}
