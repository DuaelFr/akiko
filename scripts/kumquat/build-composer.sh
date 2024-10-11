#!/usr/bin/env bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/_commons.sh"

# Check prerequisites.
if [[ "" == "$($COMPOSER config extra.combawa 2> /dev/null)" ]]; then
  echo "The project has not been initialized. You might want to run ""composer project:init"" first."
  exit 1
fi

# Build dependencies.
run_composer_install
