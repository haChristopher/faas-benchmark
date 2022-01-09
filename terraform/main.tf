
// Configure the Google Cloud provider
provider "google" {
  credentials = file("/Users/Christopher/Uni/CSB/csb-kubeless-benchmark-d4a5ced18bab.json")
  project     = "csb-kubeless-benchmark"
  region      = var.instance_region
}


// Setup instance startup script with injected variables.
data "template_file" "init" {
  template = file("${path.module}/startup.tpl")
  vars = {
    endpoint = var.target_function_endpoint
  }
}

// Create a key pair for ssh access to the instance.
// resource "tls_private_key" "ssh" {
//  algorithm = "RSA"
//  rsa_bits  = "4096"
//}

// Save private key to local file
//resource "local_file" "private_key" {
//  content         = tls_private_key.ssh.private_key_pem
//  filename        = "benchmark.pem"
//  file_permission = "0600"
//}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
  byte_length = 8
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
  name                      = "benchmark-client-vm-${random_id.instance_id.hex}"
  machine_type              = var.instance_type
  zone                      = var.instance_region
  count                     = var.instance_count
  allow_stopping_for_update = "false"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Add startup script to instance.
  metadata_startup_script = data.template_file.init.rendered

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_key_path_public)}"
  }

  // Copy benchmark client jar to the instance
  provisioner "file" {
    source      = "../benchmark-client/target/benchmark-client-1.0-SNAPSHOT.jar"
    destination = "benchmark-client.jar"

    connection {
      type        = "ssh"
      host        = self.network_interface.0.access_config.0.nat_ip
      user        = var.ssh_user
      private_key = file(var.ssh_key_path_private)
      agent       = "false"
      timeout     = "30s"
    }
  }

  //metadata = {
  //  ssh-keys       = "provisioner:${tls_private_key.ssh.public_key_openssh}"
  //  enable-oslogin = "true"
  //}

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

}
