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
}
