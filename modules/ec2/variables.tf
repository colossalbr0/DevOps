variable "ssh-pub" {
  description = "Path to public ssh key"
  type = string
  default = "~/.ssh/id_ed25519.pub"
}

variable "ssh-priv" {
  description = "Path to private ssh key"
  type = string
  default = "~/.ssh/id_ed25519"
}

variable "subnet-id" {
  type = string
}

variable "security-group-id" {
  type = string
}

variable "sh-script-path" {
  type = string
}

variable "playbook-path" {
  
}