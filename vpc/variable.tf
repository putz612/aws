variable "AWS_REGION" {
  description = "What region are we going to use"
  default = "us-west-2"
}
variable "az" {
  description = "List of az we are going to use"
  type = list(tuple([string]))
  default = [
    ["a"],
    ["b"],
    ["c"]
  ]
}