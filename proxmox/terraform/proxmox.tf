variable "pm_api_url" {
  description = "Proxmox API"
  type        = string
  sensitive   = true
  default     = ""
}

variable "pm_api_token_id" {
  description = "pm_api_token_id"
  type        = string
  sensitive   = true
  default     = ""
}

variable "pm_api_token_secret" {
  description = "pm_api_token_id"
  type        = string
  sensitive   = true
  default     = ""
}

provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_log_enable       = true
  pm_log_file         = "terraform-plugin-proxmox.log"
  pm_parallel         = 1
  pm_timeout          = 600
}

terraform {
  required_providers {
    proxmox = {
      source  = "localhost/telmate/proxmox"
      version = "=2.9.14"
    }
  }
}
