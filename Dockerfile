FROM centos:7

#MAINTAINER CrowdStrike
# Install required packages
RUN yum -y update && yum -y install zip vim-common bind-utils ruby httpd php php-fpm

# Create directories
RUN mkdir -p /home/eval/bin/mimipenguin
RUN mkdir /home/menu
COPY bin/ /home/eval/bin/
COPY menu/* /home/menu/
COPY myapp /var/www/html/

COPY test/exec.cgi /var/www/cgi-bin/

EXPOSE 80

# Expose and entrypoint
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh
