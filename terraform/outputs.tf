output "vm_name" {
  description = "OpenStack VM:"
  value       = libvirt_domain.openstack_vm.name
}

output "vm_ip_addresses" {
  description = "OpenStack VM IP"
  value       = libvirt_domain.openstack_vm.network_interface.0.addresses
}

