mock_provider "azurerm" {}

variables {
  zone_name           = "example.com"
  resource_group_name = "rg-test"
  tags                = { environment = "test" }
}

run "default_values" {
  command = plan
  variables {
    publicDnsRecordsConfig = {}
  }
  assert {
    condition     = length(azurerm_dns_a_record.azurerm_dns_a_records) == 0
    error_message = "No A records must be created when publicDnsRecordsConfig is empty"
  }
}

run "naming_convention" {
  command = plan
  variables {
    publicDnsRecordsConfig = {
      azurerm_dns_a_records = [
        { name = "www", ttl = "60", records = ["10.0.0.1"] }
      ]
    }
  }
  assert {
    condition     = azurerm_dns_a_record.azurerm_dns_a_records["www"].name == "www"
    error_message = "A record must be keyed and named by the caller-supplied name"
  }
  assert {
    condition     = azurerm_dns_a_record.azurerm_dns_a_records["www"].zone_name == "example.com"
    error_message = "A record must use var.zone_name"
  }
  assert {
    condition     = azurerm_dns_a_record.azurerm_dns_a_records["www"].resource_group_name == "rg-test"
    error_message = "A record must use var.resource_group_name"
  }
}

run "a_record_target_resource_id" {
  command = plan
  variables {
    publicDnsRecordsConfig = {
      azurerm_dns_a_records = [
        { name = "alias", ttl = "60", target_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/publicIPAddresses/pip1" }
      ]
    }
  }
  assert {
    condition     = azurerm_dns_a_record.azurerm_dns_a_records["alias"].records == null
    error_message = "records must be null when target_resource_id is used"
  }
}

run "a_record_tags_merge" {
  command = plan
  variables {
    publicDnsRecordsConfig = {
      azurerm_dns_a_records = [
        { name = "tagged", ttl = "60", records = ["10.0.0.2"], tags = { extra = "yes" } }
      ]
    }
  }
  assert {
    condition     = azurerm_dns_a_record.azurerm_dns_a_records["tagged"].tags["environment"] == "test"
    error_message = "Record tags must merge var.tags"
  }
  assert {
    condition     = azurerm_dns_a_record.azurerm_dns_a_records["tagged"].tags["extra"] == "yes"
    error_message = "Record tags must merge record-level tags"
  }
}

run "cname_record" {
  command = plan
  variables {
    publicDnsRecordsConfig = {
      azurerm_dns_cname_records = [
        { name = "app", ttl = "60", record = "app.contoso.com" }
      ]
    }
  }
  assert {
    condition     = azurerm_dns_cname_record.azurerm_dns_cname_records["app"].record == "app.contoso.com"
    error_message = "CNAME record must set record"
  }
}

run "aaaa_record" {
  command = plan
  variables {
    publicDnsRecordsConfig = {
      azurerm_dns_aaaa_records = [
        { name = "v6", ttl = "60", records = ["2001:db8::1"] }
      ]
    }
  }
  assert {
    condition     = tolist(azurerm_dns_aaaa_record.azurerm_dns_aaaa_records["v6"].records)[0] == "2001:db8::1"
    error_message = "AAAA record must set records"
  }
}

run "caa_record" {
  command = plan
  variables {
    publicDnsRecordsConfig = {
      azurerm_dns_caa_records = [
        {
          name = "@"
          ttl  = "60"
          records = [
            { flags = "0", tag = "issue", value = "letsencrypt.org" },
            { flags = "0", tag = "issuewild", value = ";" }
          ]
        }
      ]
    }
  }
  assert {
    condition     = length(azurerm_dns_caa_record.azurerm_dns_caa_records["@"].record) == 2
    error_message = "CAA record must emit one dynamic record block per configured entry"
  }
}

run "mx_record" {
  command = plan
  variables {
    publicDnsRecordsConfig = {
      azurerm_dns_mx_records = [
        {
          name = "mail"
          ttl  = "60"
          records = [
            { preference = "10", exchange = "mail1.contoso.com" },
            { preference = "20", exchange = "mail2.contoso.com" }
          ]
        }
      ]
    }
  }
  assert {
    condition     = length(azurerm_dns_mx_record.azurerm_dns_mx_records["mail"].record) == 2
    error_message = "MX record must emit one dynamic record block per configured entry"
  }
}

run "ns_record" {
  command = plan
  variables {
    publicDnsRecordsConfig = {
      azurerm_dns_ns_records = [
        { name = "ns", ttl = "60", records = ["ns1-01.azure-dns.com", "ns2-01.azure-dns.com"] }
      ]
    }
  }
  assert {
    condition     = length(azurerm_dns_ns_record.azurerm_dns_ns_records["ns"].records) == 2
    error_message = "NS record must set records"
  }
}

run "ptr_record" {
  command = plan
  variables {
    publicDnsRecordsConfig = {
      azurerm_dns_ptr_records = [
        { name = "ptr", ttl = "60", records = ["ptr.contoso.com"] }
      ]
    }
  }
  assert {
    condition     = tolist(azurerm_dns_ptr_record.azurerm_dns_ptr_records["ptr"].records)[0] == "ptr.contoso.com"
    error_message = "PTR record must set records"
  }
}

run "srv_record" {
  command = plan
  variables {
    publicDnsRecordsConfig = {
      azurerm_dns_srv_records = [
        {
          name = "srv"
          ttl  = "60"
          records = [
            { priority = "10", weight = "20", port = "5060", target = "sip.contoso.com" }
          ]
        }
      ]
    }
  }
  assert {
    condition     = length(azurerm_dns_srv_record.azurerm_dns_srv_records["srv"].record) == 1
    error_message = "SRV record must emit one dynamic record block per configured entry"
  }
}

run "txt_record" {
  command = plan
  variables {
    publicDnsRecordsConfig = {
      azurerm_dns_txt_records = [
        { name = "txt", ttl = "60", records = ["txt.contoso.com", "txt2.contoso.com"] }
      ]
    }
  }
  assert {
    condition     = length(azurerm_dns_txt_record.azurerm_dns_txt_records["txt"].record) == 2
    error_message = "TXT record must emit one dynamic record block per configured record value"
  }
}
