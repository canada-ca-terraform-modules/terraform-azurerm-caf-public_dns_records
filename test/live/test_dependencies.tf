# test_dependencies.tf
# Self-contained dependency resources, owned entirely by this harness.
#
# Deliberately NOT reusing any shared/production resource group or DNS zone:
# writing into a shared RG usually requires elevated, non-sandbox permissions.
# A dedicated throwaway RG + public DNS zone here needs only Contributor on
# the sandbox subscription and can never collide with or affect any production
# resource.
#
# terraform-azurerm-caf-public_dns_records has no virtual_network/subnet
# input, so no vnet is created here - only the RG + a throwaway DNS zone the
# module's records attach to.

resource "azurerm_resource_group" "live_test" {
  # PR-number suffix keeps two concurrently open PRs against this module from
  # colliding on the same sandbox resource group.
  name     = "${var.env}-caf-public-dns-records-live-test-${var.pr_number}-rg"
  location = var.location

  # pr-number tag (ticket 13): lets the nightly orphan sweeper find this RG
  # by tag and match it back to a PR, independent of naming convention.
  tags = {
    "pr-number" = var.pr_number
  }
}

resource "azurerm_dns_zone" "live_test" {
  name                = "live-test-${var.pr_number}.probe-public-dns.internal"
  resource_group_name = azurerm_resource_group.live_test.name
}
