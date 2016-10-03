#!/bin/bash

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

if [ ! -f /mysql_configured ]; then
    echo "=> MySQL not configured yet, configuring MySQL ..."

    echo "=> Setting MySQL bind address to have access from the Docker host"
    sed -i 's/^bind-address\s*=.*$/bind-address = "0.0.0.0"/' /etc/mysql/my.cnf

    echo "=> Starting MySQL"
    /etc/init.d/mysql start &

    echo "=> Waiting till MySQL is started"
    mysqladmin --wait=30 ping > /dev/null 2>&1

    echo "=> Creating database"
    mysqladmin create $MYSQL_FSO_DATABASE

    echo "=> Creating database user and granting external access";
    mysql -uroot -e "CREATE USER '$MYSQL_FSO_USER'@'%' IDENTIFIED BY '$MYSQL_FSO_PASSWORD';"
    mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_FSO_USER'@'%' WITH GRANT OPTION;"

    touch /mysql_configured
else
    echo "=> MySQL is already configured"

    echo "=> Starting MySQL"
    /etc/init.d/mysql start
fi
