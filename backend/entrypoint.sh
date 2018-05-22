#!/bin/sh
PATH=$PATH:/usr/local/openresty/luajit/bin/:/usr/local/openresty/nginx/sbin/:/usr/local/openresty/bin/:/usr/local/bin

export SOCKEXEC_SOCKET="/var/tmp/sockexec.socket"

rm -rf ${SOCKEXEC_SOCKET}
nohup sh -c 'sockexec $SOCKEXEC_SOCKET &'
while ! test -S $SOCKEXEC_SOCKET; do
  echo -n .
  sleep 1
done
chmod a+rw $SOCKEXEC_SOCKET
/usr/local/openresty/bin/openresty -g "daemon off;"
