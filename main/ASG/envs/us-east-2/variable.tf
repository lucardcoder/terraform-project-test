variable "region" {
  description = "Please provide a region name"
  type        = string
}

variable "tags" {
  description = "Please provide a tag for resources"
  type        = map(any)
  default     = {}
}

# variable "access_key" {
#   type = "string"
# }

# variable "secret_key" {
#   type = "string"
# }