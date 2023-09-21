# Machine: Keeper [Hacked]
This is the twelfth machine that I have solved from hackthebox, I also used it to test the script machines, on my Markov machine, a Linux distribution that I made for pentesting. but I will indicate the common steps to follow without the [machines](https://github.com/LuisHDeAvila/htb/blob/main/machines) script. IP_MACHINE is the IP address of the keeper machine.
```
  nmap -sC -sV -p- --min-rate 5000 IP_MACHINE -vvv
```
We discover the domain keeper.htb on port 80 and add it to /etc/hosts, then we enter that domain from the web browser and a message appears to redirect us to the tickets.keeper.htb subdomain, we add it to /etc/hosts next to the domain keeper.htb, We see a login page for the RT 4.4.4 administration panel, querying default credentials
```
 NOTE: The default credentials for RT are: User: **root** Pass: password Not changing the root password from the default is a **SECURITY** risk!
```
### to be continued
