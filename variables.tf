variable "publicDnsRecordsConfig" {
  type        = any
  description = "Values for the public DNS records"
  default     = {}
}

variable "zone_name" {
  type        = string
  description = "Required: Name the public DNS zone"
}

variable "resource_group_name" {
  type        = string
  description = "Required: Name of the resource groups where the zone is located"
}

variable "tags" {
  description = "Tags for the public DNS records"
  type        = map(string)
  default     = {}
}
