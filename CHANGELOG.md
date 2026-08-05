# Changelog

All notable changes to this module are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.1.0] - 2026-08-04

### Added

- `providers.tf` pinning `azurerm` to `~> 5.0` (previously unpinned — "No requirements" in README).
- Outputs for all remaining record resources: `azurerm_dns_aaaa_records`, `azurerm_dns_caa_records`, `azurerm_dns_mx_records`, `azurerm_dns_ns_records`, `azurerm_dns_ptr_records`, `azurerm_dns_srv_records`, `azurerm_dns_txt_records`. Only A and CNAME records were previously exposed.
- `.tflint.hcl` (`call_module_type = "local"`), `.gitignore`, `.gitattributes` (`eol=lf`).
- `tests/dns_records.tftest.hcl` covering every resource type and optional argument (records vs. target_resource_id, dynamic record blocks, tags merge, naming).
- `tests/upgrade_compat.tftest.hcl` proving the existing `ESLZ/public_dns_records_config.tfvars` shape produces no forced replacements on the `azurerm ~> 5.0` upgrade.
- `.github/workflows/terraform-ci.yml` running fmt/init/validate/test/tflint on every PR.
- `.github/workflows/release.yml` creating a GitHub release on merge to `main`, tagged from the version pinned in `ESLZ/public_dns_records.tf`'s `?ref=`.

### Changed

- All outputs now set `sensitive = true` since they expose full resource objects.
- Fixed a copy-paste artifact: the `tags` variable description referenced "Private DNS Zone" in this public DNS records module.
- `ESLZ/public_dns_records.tf` module `source` changed from a developer's local filesystem path to `github.com/canada-ca-terraform-modules/terraform-azurerm-caf-public_dns_records?ref=v1.1.0`.
- Bumped `actions/checkout` (`v4.1.7` → `v7.0.1`) and `terraform-docs/gh-actions` (`v1.2.0` → `v1.4.1`) in `.github/workflows/documentation.yml`.
- README static content (title/description) confirmed to live above `<!-- BEGIN_TF_DOCS -->`; regenerated the generated section with `terraform-docs`.

### Known blockers

- None. The `azurerm_dns_*_record` resource family (A/AAAA/CAA/CNAME/MX/NS/PTR/SRV/TXT) has no breaking changes between the provider versions the module previously supported (unpinned) and `~> 5.0` — only the sibling `azurerm_private_dns_*_record` resources changed in v5.0 (removed `resource_group_name`/`zone_name` in favour of `private_dns_zone_id`), which this module does not use.

## [1.0.0] - prior release

- Initial module supporting A, AAAA, CAA, CNAME, MX, NS, PTR, SRV, and TXT public DNS record resources.
