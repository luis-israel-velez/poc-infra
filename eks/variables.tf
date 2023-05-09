# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}


variable "aws_access_key" {
  type = string 
  description = "AWS Access Key"
}

variable "aws_secret_key" { 
  type = string 
  description = "AWS Secret Key"
}

