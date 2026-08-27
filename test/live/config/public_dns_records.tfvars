# config/public_dns_records.tfvars
# Tracked, ready-to-run fixture for the test/live harness - one representative
# real-usage instance, not a two-code-path engineered fixture and not a
# dormant "_" template.
#
# Mirrors what an actual landing-zone consumer deploys today: a single map
# entry exercising the A-record common path. No for_each fan-out - one
# instance is enough to prove a breaking-change gate.
#
# Maintained by whoever adds a new optional input to the module: update this
# file in the same PR if you want live coverage of it, same discipline as
# updating tests/dns_records.tftest.hcl.

env = "livetest"

public_dns_records = {
  probe = {
    azurerm_dns_a_records = [
      {
        name    = "probe-a"
        ttl     = "60"
        records = ["10.0.0.1"]
      }
    ]
  }
}
