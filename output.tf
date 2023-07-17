output "odoo_server_domains" {
  value = keys(var.certbot_cert)
}