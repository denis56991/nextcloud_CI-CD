variable "connect" {
  type = object({
    api-url          = string
    api-token-id     = string
    api-token-secret = string
  })
  default = {
    api-url          = "https://my-proxmox.ru/api2/json"
    api-token-id     = "user@pve!token-1"
    api-token-secret = "******-*******-*******"
  }
}

# Конфигурация пула
variable "pool_conf" {
  type = object({
    name    = string
    comment = string
  })
  default = {
    name    = "file-srv"
    comment = "Fileserver"
  }

}

# Конвигурация ВМ
variable "vm1_conf" {
  type = object({
    id       = number
    name     = string
    template = string
    cores    = number
    sockets  = number
    memory   = number
    size     = string
    ip       = string
    sshkey   = string

  })
  default = {
    id       = 321
    name     = "nc-srv"
    template = "ubuntu24-template"

    cores   = 2
    sockets = 1
    memory  = 4 # значкние указано в Гб, оно в ресурсе преобразовывается в МБ

    size = "20G"

    ip     = "192.168.3.164"
    sshkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLVOERViEspFTnkNcnlfncWSMKB+N7YMvZ1Ult+I+w7 miron"

  }

}
