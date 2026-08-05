output "azurerm_dns_a_records" {
  description = "A records DNS objects"
  value       = resource.azurerm_dns_a_record.azurerm_dns_a_records
  sensitive   = true
}

output "azurerm_dns_cname_records" {
  description = "CNAME records DNS objects"
  value       = resource.azurerm_dns_cname_record.azurerm_dns_cname_records
  sensitive   = true
}

output "azurerm_dns_aaaa_records" {
  description = "AAAA records DNS objects"
  value       = resource.azurerm_dns_aaaa_record.azurerm_dns_aaaa_records
  sensitive   = true
}

output "azurerm_dns_caa_records" {
  description = "CAA records DNS objects"
  value       = resource.azurerm_dns_caa_record.azurerm_dns_caa_records
  sensitive   = true
}

output "azurerm_dns_mx_records" {
  description = "MX records DNS objects"
  value       = resource.azurerm_dns_mx_record.azurerm_dns_mx_records
  sensitive   = true
}

output "azurerm_dns_ns_records" {
  description = "NS records DNS objects"
  value       = resource.azurerm_dns_ns_record.azurerm_dns_ns_records
  sensitive   = true
}

output "azurerm_dns_ptr_records" {
  description = "PTR records DNS objects"
  value       = resource.azurerm_dns_ptr_record.azurerm_dns_ptr_records
  sensitive   = true
}

output "azurerm_dns_srv_records" {
  description = "SRV records DNS objects"
  value       = resource.azurerm_dns_srv_record.azurerm_dns_srv_records
  sensitive   = true
}

output "azurerm_dns_txt_records" {
  description = "TXT records DNS objects"
  value       = resource.azurerm_dns_txt_record.azurerm_dns_txt_records
  sensitive   = true
}
