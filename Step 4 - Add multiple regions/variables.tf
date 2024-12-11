variable "linode_token" {
  default = ""
  type = string
  sensitive   = true
}

variable "userid" {
  default = "cerX"
}

variable "specified_regions" {
  description = "List of regions to deploy instances"
  type        = list(string)
  default     = ["de-fra-2"] # Define your desired regions here  
  #default     = ["de-fra-2", "jp-osa", "us-lax", "us-mia"] # Define your desired regions here
}
