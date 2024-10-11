#!/usr/bin/env bash

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
APP_ROOT="$SCRIPTS_PATH/../.."

cd $APP_ROOT
COMBAWA_BUILD_ENV="prod"
if [ -f "$APP_ROOT/.env" ]; then
  source $APP_ROOT/.env
fi

COMPOSER="composer"
if [ ! -z ${COMPOSER_BINARY:-} ]; then
  COMPOSER=$COMPOSER_BINARY
fi

run_composer_install () {
  echo "Downloading dependencies..."
  if [ "$COMBAWA_BUILD_ENV" != 'prod' ]; then
    $COMPOSER install --no-interaction
  else
    $COMPOSER install --no-interaction --no-dev --apcu-autoloader
  fi
  echo "Downloading dependencies... Done"
  echo ""
}
