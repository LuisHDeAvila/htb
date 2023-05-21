 #!/bin/bash
 # metaprograma
 echo '#!/bin/bash' >program
 for ((I=1; I<=992; I++)); do
     echo "echo $I" >>program
 done
 chmod +x program
