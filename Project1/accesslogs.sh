#! /bin/sh
# Unique IP addresses from apache2 access logs

cut -d- -f1 /var/log/apache2/access.log | sort | uniq >> accesslogs.txt

## 127.0.0.1 
## 192.168.43.1 

# 200 OK requests

cat /var/log/apache2/access.log | grep 200 | wc -l >> accesslogs.txt

##4
