resource "proxmox_vm_qemu" "vm1" {

  # Параметры и расположение ВМ
  depends_on = [proxmox_pool.pool]
  vmid       = var.vm1_conf.id       # id ВМ
  name       = var.vm1_conf.name     # Название новой ВМ
  clone      = var.vm1_conf.template # Имя шаблона
  full_clone = true
  agent      = 1 # Запуск тулзы prox
  hotplug    = 1 # Поддержка горячей замены памяти и CPU
  balloon    = 0 # Динамическое управление RAM

  # Расположение ВМ
  target_node = "prox"             # Нода Proxmox
  pool        = var.pool_conf.name # Пул

  # Настройка CPU, RAM
  cpu_type = "x86-64-v2-AES"
  cores    = var.vm1_conf.cores         # Количество ядер
  sockets  = var.vm1_conf.sockets       # Количество сокетов
  memory   = var.vm1_conf.memory * 1024 # ОЗУ (преобразование Gb в MB)

  # графического интерфейса
  vga {
    type = "std"
  }

  # Настройка диска
  scsihw = "virtio-scsi-single" # Настройки SCSI контроллера

  disks {
    scsi {
      scsi0 {
        disk {
          size    = var.vm1_conf.size # Размер диска
          storage = "storage-1tb"    # Хранилище для размещения в prox (например, local-lvm)
        }
      }
    }

    # Диск Cloud-Init
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm" # Хранилище для диска Cloud-Init
        }
      }
    }
  }

  # Настройка сети
  network {
    model  = "virtio"
    bridge = "vmbr0" # Сеть моста
    id     = 0       # Индекс сетевого адаптера
  }

  # Cloud-init параметры
  os_type   = "cloud-init"
  # ciupgrade = true   # Обновление
  ciuser    = "root" # Пользователь, создаваемый в виртуальной машине
  # cipassword = "Aa123364"		# Пароль для пользователя (можно сделать сгенерированным или более сложным)
  ipconfig0  = "ip=${var.vm1_conf.ip}/24,gw=192.168.3.1" # Настройка статического IP
  nameserver = "77.88.8.8 8.8.8.8"                      # DNS-сервер
  sshkeys    = var.vm1_conf.sshkey                       # SSH-ключ

}

