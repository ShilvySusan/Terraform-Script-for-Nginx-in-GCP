**# Steps to perform:**

1. If you have already **gcloud cli** installed in your machine please authenticate your gcp account using "**gcloud auth login**", otherwise please install gcloud cli first and then authenticate.

2. Update vars in terraform.tfstate

3. terraform init

4. terraform plan -out 1.tfplan

5. terraform apply "1.tfplan". Check if http:{external-ip-address} shows the default nginx page

6. Visit https://my.noip.com/dynamic-dns and update A record(IPV4) to the created external IP. This might take few minutes to propage the changes. 

7. SSH into the instance and run the following to generate SSL cert for the domain. Replace the domain and email with yours

````
```
sudo certbot --nginx -n -d valhalla23.ddns.net --redirect --agree-tos --email kailaashbnair@test.com
```
```
sudo service nginx reload
```
````

8. Visit https version of your site. 
