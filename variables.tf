variable "region" {
    type = string
}
variable "project" {
    type = string
}

variable "user" {
    type = string
}

variable "email" {
    type = string
}
variable "scriptpath" {
    type = string
}

variable "publickeypath" {
    type = string
    default = "~/.ssh/id_rsa.pub"
}
