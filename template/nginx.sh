#!/bin/bash
set -e
echo "*****    Installing Nginx    *****"
sudo apt-get update -y
sudo apt-get install -y nginx certbot python3-certbot-nginx
sudo ufw --force enable
sudo ufw allow "Nginx Full"
sudo ufw allow ssh
sudo certbot --nginx -n -d devopsfuture.ddns.net --redirect --agree-tos --email shilvysamuel@gmail.com
sudo service nginx reload
sudo sh -c "echo 'shilvy soft nofile 30000' >> /etc/security/limits.conf"
sudo sh -c "echo 'shilvy hard nofile 30000' >> /etc/security/limits.conf"
sysctl -p
sudo sh -c "echo 'worker_rlimit_nofile 40000;' >> /etc/nginx/nginx.conf"
sudo sed -i 's/worker_connections 768;/worker_connections 20000;/g' /etc/nginx/nginx.conf
sudo service nginx restart
sudo su - 
cat > /var/www/html/index*.html << EOF
<html>
<head> 
<title> My Challenge </title> 
</head> 
<body style="background-color:powderblue;"> 
<h1 style="font-family:verdana; text-align:center;"> Welcome to Google Cloud Instance </h1>
<p style="text-align:center; color:MediumSeaGreen; font-size: 50px;">This webserver is provisioned using a Terraform Script </p> 
</body>
</html>
EOF