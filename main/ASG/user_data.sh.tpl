#!/bin/bash
cd /var/www/html/
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/${db_name}/g" wp-config.php
sed -i "s/username_here/${db_user}/g" wp-config.php
sed -i "s/password_here/${db_password}/g" wp-config.php
sed -i "s/localhost/${db_host}/g" wp-config.php 
chown -R apache:apache /var/www/html/
# systemctl enable httpd
# systemctl start httpd


# sudo yum install httpd wget unzip epel-release mysql -y
# sudo yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
# sudo yum-config-manager --enable remi-php74
# sudo yum install php -y
# sudo yum install php-mysql -y
# # Download latest wordpress
# sudo wget https://wordpress.org/latest.tar.gz
# sudo tar -xf latest.tar.gz -C /var/www/html/
# sudo mv /var/www/html/wordpress/* /var/www/html/
# sudo getenforce
# sudo sed 's/SELINUX=permissive/SELINUX=enforcing/g' /etc/sysconfig/selinux -i
# sudo setenforce 0
# sudo chown -R apache:apache /var/www/html/
# sudo systemctl start httpd
# sudo systemctl enable httpd