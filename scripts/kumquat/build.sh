#!/usr/bin/env bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

source "$DIR/build-composer.sh"
source "$DIR/build-theme.sh"
source "$DIR/build-drupal.sh"
