FROM centos:7

#MAINTAINER CrowdStrike
RUN yum -y update && yum -y install zip vim-common bind-utils-9.11.4-9.P2.el7.x86_64 ruby

# Webserver stuff
RUN yum -y install httpd httpd-tools

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
 && rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# Install PHP
RUN yum -y install php72w php72w-cli php72w-common php72w-gd php72w-intl

RUN mkdir -p /home/eval/bin/mimipenguin
RUN mkdir /home/menu
COPY bin/ /home/eval/bin/
COPY menu/* /home/menu/

# Update Apache Configuration
RUN sed -E -i -e '/<Directory "\/var\/www\/html">/,/<\/Directory>/s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
RUN sed -E -i -e 's/DirectoryIndex (.*)$/DirectoryIndex index.php \1/g' /etc/httpd/conf/httpd.conf

EXPOSE 80

COPY myapp /var/www/html/
RUN chmod 753 /var/www/html/uploads

# Expose and entrypoint
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Create a fake mysqldump command to trigger a detection with
RUN cp /bin/cat /bin/mysqldump
RUN chmod +x /bin/mysqldump

ENTRYPOINT /entrypoint.sh
