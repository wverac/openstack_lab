provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "vm_img" {
  name   = "ubuntu-${var.ubuntu_codename}.qcow2"
  pool   = "default"
  source = "https://cloud-images.ubuntu.com/${var.ubuntu_codename}/current/${var.ubuntu_codename}-server-cloudimg-amd64.img"
  format = "qcow2"
}

resource "libvirt_volume" "vm_disk" {
  name           = "${var.vm_name}.qcow2"
  pool           = "default"
  base_volume_id = libvirt_volume.vm_img.id
  format         = "qcow2"
  size           = 107374182400
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.cfg")
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "${var.vm_name}-cloudinit.iso"
  pool      = "default"
  user_data = data.template_file.user_data.rendered
}

resource "libvirt_domain" "openstack_vm" {
  name   = var.vm_name
  memory = var.vm_memory
  vcpu   = var.vm_vcpus

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.vm_disk.id
  }

  graphics {
    type        = "vnc"
    listen_type = "address"
    autoport    = true
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
}

