#!/bin/bash

sudo yum install httpd php -y
sudo service httpd start
sudo chkconfig httpd on

echo "<?php
  echo gethostname();
?>" | sudo tee /var/www/html/host.php

echo "<?php
for($i = 0; $i < 1000000000; $i++) {
     $a += $i;
}" | sudo tee /var/www/html/stress.php
