#!/bin/bash

# Catch all errors.
set -euo pipefail

# Working directory.
# Helper to let you run the install script from anywhere.
currentscriptpath () {
  SOURCE="${BASH_SOURCE[0]}"
  # resolve $SOURCE until the file is no longer a symlink
  while [ -h "$SOURCE" ]; do

    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  done
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  echo $DIR
}

# Binary variables.
SCRIPTS_PATH=$(currentscriptpath)

# App variables.
APP_ROOT="$SCRIPTS_PATH/../.."
CONFIG_DIR="$APP_ROOT/etc"

cd $APP_ROOT
if [ -f "$APP_ROOT/.env" ]; then
  source $APP_ROOT/.env
fi

# Clean previous file.
rm -f dumps/sanitized-dump.sql

# Generate sanitized dump.
MKT_DUMP="$APP_ROOT/vendor/bin/mtk-dump_linux_amd64"
$MKT_DUMP \
  --config="$CONFIG_DIR/dump.yml" \
  --host="$COMBAWA_DB_HOSTNAME" \
  --port="$COMBAWA_DB_PORT" \
  --user="$COMBAWA_DB_USER" \
  --password="$COMBAWA_DB_PASSWORD" \
  "$COMBAWA_DB_DATABASE" > dumps/tmp-dump.sql

# Allow to insert 0 in autoincremented fields (user.uid).
echo "SET sql_mode='NO_AUTO_VALUE_ON_ZERO';" > dumps/sanitized-dump.sql
cat dumps/tmp-dump.sql >> dumps/sanitized-dump.sql
rm -f dumps/tmp-dump.sql

gzip -f dumps/sanitized-dump.sql
