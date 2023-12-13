variable "keyvault_id" {}
variable "tenant_id" {}
# variable "object_id" {}
# TODO: fixed Error: expected "object_id" to be a valid UUID, got
variable "object_id" {
    default = null
}
variable "access_policy" {}
