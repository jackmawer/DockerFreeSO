# This is free and unencumbered software released into the public domain.
# 
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
# 
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
# 
# For more information, please refer to <http://unlicense.org/>

FROM ubuntu:16.04
MAINTAINER Tomas CW

# Add configuration script
ADD mariadb-conf.sh /mariadb-conf.sh
ADD apache-conf.sh /apache-conf.sh
ADD config-server.sh /config-server.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# MySQL environment variables
ENV MYSQL_GS_USER gnusocial
ENV MYSQL_GS_PASSWORD hackme

# Set up server
RUN apt update && \
    apt install git apache2 libapache2-mod-php5 php5 php5-mysql mariadb-server curl -y && \
    apt clean

# Configure server
RUN cd /var/www/html && \ 
    git clone https://git.gnu.io/gnu/gnu-social.git -b 1.2.x && \
    mv htaccess.sample .htaccess && \
    mkdir -p /var/www/html/avatar && \
    mkdir -p /var/www/html/file && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R g+w /var/www/html/ && \
    a2enmod rewrite

# Organize volumes
VOLUME ["/var/www/html/file", "/var/www/html/avatar", "/var/lib/mysql", "/etc/mysql"]
WORKDIR /var/www/html

EXPOSE 80 433

CMD ["/run.sh"]
