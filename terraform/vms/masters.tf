variable "k3s_master_ip_addresses" {
  description = "List of IP addresses for master node(s)"
  type        = list(string)
  default     = ["192,168.5.201/24", "192.168.5.202/24", "192.168.5.203/24"]
}

variable "k3s_gateway" {
  type    = string
  default = "192.168.5.1"
}

variable "k3s_master_pve_node" {
  description = "The PVE node to target"
  type        = list(string)
  sensitive   = false
  default     = ["pve1", "pve2", "pve3"]
}

resource "proxmox_vm_qemu" "proxmox_vm_master" {
  count = 1
  name  = "k3s-master-${count.index+1}"
  desc  = "K3S Master Node"
  clone      = "homelab-template"
  full_clone = false
  os_type    = "cloud-init"
  ipconfig0   = "gw=${var.k3s_gateway},ip=${var.k3s_master_ip_addresses[count.index]}"
  target_node = var.k3s_master_pve_node[count.index]
}