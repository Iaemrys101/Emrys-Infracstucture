resource "random_string" "sfx" {
  length  = 5
  upper   = false
  special = false
}

locals {
  # Strip everything except a-z and 0-9, then lower-case for name-constrained services
  name_base = lower(replace(var.project_name, "/[^a-z0-9]/", ""))

  rg_name  = "${local.name_base}-rg"
  aks_name = "${local.name_base}-aks"
  acr_name = "${local.name_base}acr${random_string.sfx.result}"
  sa_name  = "${local.name_base}sa${random_string.sfx.result}"
  kv_name  = "${local.name_base}kv${random_string.sfx.result}"
}