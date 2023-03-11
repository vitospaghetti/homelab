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

variable "ssh_key" {
  description = "SSH Public Key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "mac_prefix" {
  description = "MAC address prefix"
  type        = string
  sensitive   = false
  default     = "00:00:00:00:02:0"
}

resource "proxmox_vm_qemu" "proxmox_vm_master" {
  count = 1
  name  = "k3s-master-${count.index+1}"
  target_node = var.k3s_master_pve_node[count.index]

  desc  = "k3s Master Node"
  clone      = "bullseye-template"
  full_clone = false

  agent = 1
  os_type    = "cloud-init"
  cores = 4
  memory = 8192
  cpu = "qemu64"
  numa = false
  scsihw = "virtio-scsi-single"
  bootdisk = "scsi0"


}
