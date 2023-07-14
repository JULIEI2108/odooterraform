resource "tls_private_key" "odoo_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

