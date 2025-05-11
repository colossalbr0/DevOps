variable "cloudflare-zone-id" {
    type = string
    sensitive = true
}

variable "cloudflare-api-token" {
    type = string
    sensitive = true
}

variable "dmz" {
    type = string
    default = "ops.clbro.com"
}

variable "sub-domain-name" {
    type = string
    default = "public.ops.clbro.com"
}