#!/bin/bash

if [ ! -f .idea/dataSources.xml ]; then
  echo ".idea/dataSources.xml not found. You need to create the datasource in PHPStorm at least once."
  exit 1
fi

LANDO_INFO=`lando info -s database --format=json`
if [[ "$LANDO_INFO" == "[]" ]]; then
    echo "\"database\" lando service not found"
    exit 2
fi

DB_HOST=$(echo $LANDO_INFO | jq -r '.[0].external_connection.host')
DB_PORT=$(echo $LANDO_INFO | jq -r '.[0].external_connection.port')
DB_NAME=$(echo $LANDO_INFO | jq -r '.[0].creds.database')
DB_USER=$(echo $LANDO_INFO | jq -r '.[0].creds.user')

JDBC_URL="<jdbc-url>jdbc:mysql://$DB_HOST:$DB_PORT/$DB_NAME</jdbc-url>"
JDBC_USER="<user-name>$DB_USER</user-name>"

sed -i "s#<jdbc-url>.*</jdbc-url>#$JDBC_URL#" .idea/dataSources.xml
sed -i "s#<user-name>.*</user-name>#$JDBC_USER#" .idea/dataSources.xml
