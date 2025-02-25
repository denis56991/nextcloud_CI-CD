terraform {
  backend "http" {
    address = "https://gitlab.com/api/v4/projects/ID/terraform/state/nextcloud"
    lock_address = "https://gitlab.com/api/v4/projects/ID/terraform/state/nextcloud/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/ID/terraform/state/nextcloud/lock"
    username = "Login"
    password = ""
    lock_method = "POST"
    unlock_method = "DELETE"
    retry_wait_min = 5
  }
}