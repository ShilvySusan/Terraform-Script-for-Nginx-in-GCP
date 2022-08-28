                           Terraform Script To Provision An Instance In GCP To Run Nginx With SSL And Redirection
                           ______________________________________________________________________________________

This script provisions a VM in which NGINX runs. Firewalls are opened for http, https and ssh access. VM's external ip( which is mapped to a domain) is used to access the webserver using a URL and via SSH. Nginx is configured to support 10000 connections and SSL certificates are enabled with redirection.

Initial Setup
===============

1. Create GCP account and use either the default project or create a new project.
2. Create a Service account and generate the authentication key, which will be stored in the local machine.
3. If you have already installed **gcloud cli** in your machine, authenticate your GCP account using "**gcloud auth login**", otherwise install gcloud cli first and then configure using **gcloud init**.
4. Install Terraform in your local machine.
5. Generate ssh keys using **ssh-keygen** command, if you don't have the keys in the local machine

Run Script
==========

In CLI,

  1. terraform plan : Gives you the detailed outline of the resources going to be installed in GCP and notify you if there are any mismatches in  configuration
  2. terraform validate : Validates your configuration 
  3. terraform apply : Provisions all the resources as mentioned in your script.

Output
======
Check  the output in 2 ways:

 1. Visit https://my.noip.com/dynamic-dns and update A record(IPV4) to the created external IP. This might take a few minutes to propagate the changes.
 2. SSH into the instance using username and ip/domain

NB: If you want to use your personal domain, you can provision cloud dns( which doesn't come under the free tier) and add the namespaces from it as records in your private dns configuration.
