#!/bin/sh
set -eu

if [ -n "${PORT:-}" ]; then
  sed -i "s/port=\"8080\" protocol=\"HTTP\/1.1\"/port=\"${PORT}\" protocol=\"HTTP\/1.1\"/" /usr/local/tomcat/conf/server.xml
fi

exec catalina.sh run
