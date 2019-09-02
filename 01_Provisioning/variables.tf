variable "project_id" {
  type    = "string"
  default = "your_project_is_here"
}

variable "region" {
  type  = "string"
  default = "your_region_is_here"
}
variable "zone" {
  type = "string"
  default = "your_zone_is_here"
}
variable "name_master" {
  type  = "string"
  default = "k8s-master"
}

variable "name_worker" {
  type  = "string"
  default = "k8s-worker"
}

variable "type_instance_master" {
  type = "string"
  default = "n1-standard-2"
}
variable "type_instance_workers" {
  type = "string"
  default = "g1-small"
}
variable "image" {
  type = "string"
  default = "ubuntu-os-cloud/ubuntu-1804-lts"
}

#variable "image" {
# type = "string"
# default = "centos-cloud/centos-7"
#}

variable "nome_fw" {
  type = "string"
  default = "k8s-firewall"
}

variable "portas" {
  type = "list"
  default = ["80"]
}