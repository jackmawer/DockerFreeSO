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

FROM resin/rpi-raspbian:jessie-20160831
MAINTAINER Tomas CW

# Add configuration script
ADD mariadb-conf.sh /mariadb-conf.sh
ADD config-server.sh /config-server.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# MySQL environment variables
ENV MYSQL_FSO_DATABASE fsodb
ENV MYSQL_FSO_USER freeso
ENV MYSQL_FSO_PASSWORD hackme

# Set up server
RUN apt update && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list && \
    apt update && \
    apt install git mono-complete mariadb-server -y && \
    apt clean

# Configure server


# Organize volumes
VOLUME ["/var/lib/mysql"]

# EXPOSE 80 433

# CMD ["/run.sh"]
