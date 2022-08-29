                           Terraform Script To Provision An Instance In GCP To Run Nginx With SSL And Redirection
                           ______________________________________________________________________________________

This script provisions a VM in which NGINX runs. Firewalls are opened for http, https and ssh. VM's external ip( which is mapped to a domain) is used to access the webserver using a URL and via SSH. Nginx is configured to support 10000 connections and SSL certificates are enabled with redirection.

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
  
After VM is provisioned :-

   1. Make sure the startup script, which was given as metadata_start_up script, has been successfully run.
      It updates and installs nginx, certbot and supporting packages. Then ports are opened for ssh, nginx http&https.
      And Nginx configuration has been changed to support 10000 connections.
      Check both your website domain and generated static ip works with 80/http. If yes, follow the below steps.
   2. Visit https://my.noip.com/dynamic-dns and update A record(IPV4) to the created external IP for free. This might take a few minutes to propagate the changes.
   3. Create ssl certificates with the help of letsencrypt:
       ***certbot --nginx -n -d <your_domain> --redirect --agree-tos --email shilvysamuel@gmail.com***
       ***service nginx reload***
       Here --redirect redirects 80 to 443 automatically 

Output
======
Check  the output in 2 ways:

 1. Open a browser tab and search your domain
 2. In Cli, execute ssh <username>@<domain/static_ip>

NB: If you want to use your personal domain, you can provision cloud dns( which doesn't come under the free tier) and add the namespaces from it as records in your private dns configuration.
