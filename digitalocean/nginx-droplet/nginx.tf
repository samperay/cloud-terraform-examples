# Create a new SSH key
resource "digitalocean_ssh_key" "digiocean" {
  name       = "nginx-ssh"
  public_key = file("C:/Users/sunln/.ssh/digital-ocean/digiocean.pub")
}

# Create a new droplet
resource "digitalocean_droplet" "web" {
    image = "ubuntu-18-04-x64"
    name = "web-1"
    region = "blr1"
    size = "s-1vcpu-1gb"
    ssh_keys = [digitalocean_ssh_key.digiocean.id]

    connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }

    provisioner "remote-exec" {
        inline = [
          "export PATH=$PATH:/usr/bin",
          # install nginx
          "sudo apt-get update",
          "sudo apt-get -y install nginx"
        ]
      }
}
