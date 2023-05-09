# Learn Terraform - Provision a GKE Cluster

This repo is a companion repo to the [Provision a GKE Cluster tutorial](https://developer.hashicorp.com/terraform/tutorials/kubernetes/gke), containing Terraform configuration files to provision an GKE cluster on GCP.

This sample repo also creates a VPC and subnet for the GKE cluster. This is not
required but highly recommended to keep your GKE cluster isolated.



# Terraform Configuring Providers 

Remember to configure your local terraform instance to work with the provider we want. 

For google: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started


For AWS: https://registry.terraform.io/providers/hashicorp/aws/latest/docs

This just needs to be done once to ensure the executing environment has the proper access to deletate to terraform to perform the resource operations in the right place. 
