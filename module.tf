resource "azurerm_dns_a_record" "azurerm_dns_a_records" {
  for_each = local.azurerm_dns_a_record_deployList

  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  records             = try(each.value.records, null)
  target_resource_id  = try(each.value.target_resource_id, null)
  tags                = merge(var.tags, try(each.value.tags, {}))
}

resource "azurerm_dns_cname_record" "azurerm_dns_cname_records" {
  for_each = local.azurerm_dns_cname_record_deployList

  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  record              = try(each.value.record, null)
  target_resource_id  = try(each.value.target_resource_id, null)
  tags                = merge(var.tags, try(each.value.tags, {}))
}

resource "azurerm_dns_aaaa_record" "azurerm_dns_aaaa_records" {
  for_each = local.azurerm_dns_aaaa_record_deployList

  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  records             = try(each.value.records, null)
  target_resource_id  = try(each.value.target_resource_id, null)
  tags                = merge(var.tags, try(each.value.tags, {}))
}

resource "azurerm_dns_caa_record" "azurerm_dns_caa_records" {
  for_each = local.azurerm_dns_caa_record_deployList

  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      flags = record.value.flags
      tag   = record.value.tag
      value = record.value.value
    }
  }
  tags = merge(var.tags, try(each.value.tags, {}))
}

resource "azurerm_dns_mx_record" "azurerm_dns_mx_records" {
  for_each = local.azurerm_dns_mx_record_deployList

  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      preference = record.value.preference
      exchange   = record.value.exchange
    }
  }
  tags = merge(var.tags, try(each.value.tags, {}))
}

resource "azurerm_dns_ns_record" "azurerm_dns_ns_records" {
  for_each = local.azurerm_dns_ns_record_deployList

  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = merge(var.tags, try(each.value.tags, {}))
}

resource "azurerm_dns_ptr_record" "azurerm_dns_ptr_records" {
  for_each = local.azurerm_dns_ptr_record_deployList

  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = merge(var.tags, try(each.value.tags, {}))
}

resource "azurerm_dns_srv_record" "azurerm_dns_srv_records" {
  for_each = local.azurerm_dns_srv_record_deployList

  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      priority = record.value.priority
      weight   = record.value.weight
      port     = record.value.port
      target   = record.value.target
    }
  }
  tags = merge(var.tags, try(each.value.tags, {}))
}

resource "azurerm_dns_txt_record" "azurerm_dns_txt_records" {
  for_each = local.azurerm_dns_txt_record_deployList

  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value
    }
  }
  tags = merge(var.tags, try(each.value.tags, {}))
}
