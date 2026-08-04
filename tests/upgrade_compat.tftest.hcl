# Purpose: prove the existing ESLZ/public_dns_records_config.tfvars shape produces
# no forced replacement under the azurerm ~> 5.0 upgrade (no schema changes touched
# azurerm_dns_a_record between the previously unpinned provider and 5.0).
mock_provider "azurerm" {}

variables {
  zone_name           = "example.com"
  resource_group_name = "rg-test"
  tags                = { environment = "test" }
}

run "baseline_apply" {
  command = apply
  variables {
    publicDnsRecordsConfig = {
      azurerm_dns_a_records = [
        { name = "informatica", ttl = "60", records = ["20.48.132.250"] }
      ]
    }
  }
  assert {
    condition     = azurerm_dns_a_record.azurerm_dns_a_records["informatica"].name == "informatica"
    error_message = "Baseline apply: unexpected resource name"
  }
}

run "upgrade_plan_no_replacement" {
  command = plan
  variables {
    publicDnsRecordsConfig = {
      azurerm_dns_a_records = [
        { name = "informatica", ttl = "60", records = ["20.48.132.250"] }
      ]
    }
  }
  assert {
    condition     = azurerm_dns_a_record.azurerm_dns_a_records["informatica"].name == "informatica"
    error_message = "Resource name must be unchanged after the azurerm ~> 5.0 upgrade"
  }
  assert {
    condition     = tolist(azurerm_dns_a_record.azurerm_dns_a_records["informatica"].records)[0] == "20.48.132.250"
    error_message = "Existing tfvars records must still plan identically after the upgrade"
  }
}
