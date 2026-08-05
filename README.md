# terraform-azurerm-caf-public_dns_records

Manages public DNS record resources (A, AAAA, CAA, CNAME, MX, NS, PTR, SRV, TXT) within an existing Azure public DNS zone.

## Usage

### ESLZ module block (`ESLZ/public_dns_records.tf`)

```hcl
module "public_dns_records" {
  source   = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-public_dns_records?ref=v1.1.0"
  for_each = var.publicDnsRecordsConfig

  zone_name              = local.public_dns_zones[each.key].name
  resource_group_name    = local.public_dns_resource_group_name[each.value.resource_group_name].name
  publicDnsRecordsConfig = each.value
  tags                   = local.public_dns_global_tags
}
```

### ESLZ tfvars pattern (`ESLZ/public_dns_records_config.tfvars`)

See [ESLZ/public_dns_records_config.tfvars](ESLZ/public_dns_records_config.tfvars) for a fully commented example covering every record type.

## Testing

```bash
terraform fmt -recursive && terraform init -backend=false && terraform validate && terraform test
```

## CI

GitHub Actions workflow at `.github/workflows/terraform-ci.yml` runs fmt, init, validate, test, and tflint on every PR.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_a_record.azurerm_dns_a_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_aaaa_record.azurerm_dns_aaaa_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_aaaa_record) | resource |
| [azurerm_dns_caa_record.azurerm_dns_caa_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_cname_record.azurerm_dns_cname_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_mx_record.azurerm_dns_mx_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_ns_record.azurerm_dns_ns_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ptr_record.azurerm_dns_ptr_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ptr_record) | resource |
| [azurerm_dns_srv_record.azurerm_dns_srv_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_srv_record) | resource |
| [azurerm_dns_txt_record.azurerm_dns_txt_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_publicDnsRecordsConfig"></a> [publicDnsRecordsConfig](#input\_publicDnsRecordsConfig) | Values for the public DNS records | `any` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Required: Name of the resource groups where the zone is located | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the public DNS records | `map(string)` | `{}` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | Required: Name the public DNS zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_dns_a_records"></a> [azurerm\_dns\_a\_records](#output\_azurerm\_dns\_a\_records) | A records DNS objects |
| <a name="output_azurerm_dns_aaaa_records"></a> [azurerm\_dns\_aaaa\_records](#output\_azurerm\_dns\_aaaa\_records) | AAAA records DNS objects |
| <a name="output_azurerm_dns_caa_records"></a> [azurerm\_dns\_caa\_records](#output\_azurerm\_dns\_caa\_records) | CAA records DNS objects |
| <a name="output_azurerm_dns_cname_records"></a> [azurerm\_dns\_cname\_records](#output\_azurerm\_dns\_cname\_records) | CNAME records DNS objects |
| <a name="output_azurerm_dns_mx_records"></a> [azurerm\_dns\_mx\_records](#output\_azurerm\_dns\_mx\_records) | MX records DNS objects |
| <a name="output_azurerm_dns_ns_records"></a> [azurerm\_dns\_ns\_records](#output\_azurerm\_dns\_ns\_records) | NS records DNS objects |
| <a name="output_azurerm_dns_ptr_records"></a> [azurerm\_dns\_ptr\_records](#output\_azurerm\_dns\_ptr\_records) | PTR records DNS objects |
| <a name="output_azurerm_dns_srv_records"></a> [azurerm\_dns\_srv\_records](#output\_azurerm\_dns\_srv\_records) | SRV records DNS objects |
| <a name="output_azurerm_dns_txt_records"></a> [azurerm\_dns\_txt\_records](#output\_azurerm\_dns\_txt\_records) | TXT records DNS objects |
<!-- END_TF_DOCS -->
