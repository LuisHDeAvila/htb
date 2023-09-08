# Machine: Pilgrimage [Hacked]
nmap scan
IP_MACHINE: ip of pilgrimage
```
  nmap -sC -sV -p- --min-rate 5000 IP_MACHINE
```
add pilgrimage.htb to /etc/hosts
```
git-dump http://pilgrimage.htb/.git . 
git checkout .
strings *.php
magick # use CVE for exploiting image-magick
```
read /etc/passwd and db/pilgrimage for get user:key 
# in ssh session
```
 ps aux | grep 'sh$' # for discover active scripts on server
```
## exploiting binwalk with png malformed

# CONTINUE...
