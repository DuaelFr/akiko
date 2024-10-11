#!/usr/bin/env bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/_commons.sh"

# Build Drupal project.
echo "Building Drupal project..."
./vendor/bin/combawa.sh $*
echo "Building Drupal project... Done"
