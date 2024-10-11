#!/usr/bin/env bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/_commons.sh"

# This is a dev command so force the environment so combawa doesn't think we
# are on production env by default.
COMBAWA_BUILD_ENV="dev"

# First we need composer to build the sources.
run_composer_install
echo ""

# Then we need to initialize combawa if needed.
echo "Initialize combawa:"
if [[ "" == "$($COMPOSER config extra.combawa 2> /dev/null)" ]]; then
  ./vendor/bin/drush combawa:initialize-build-scripts --generate-env=0
else
  echo "Combawa already initialized."
fi
echo

# Then, we want to generate environment if needed.
echo "Generate environment settings:"
if [[ ! -f ".env" ]]; then
  ./vendor/bin/drush combawa:generate-environment --write-db-settings=0 --build-mode=$($COMPOSER config extra.combawa.build_mode 2> /dev/null)
else
  echo "Environment settings already generated."
fi
echo

# Finally, we want to initialize the profile/themes/modules if needed.
echo "Initialize project sources:"
if [[ $(find web/profiles/ -mindepth 1 -type d | wc -l) == 0 ]]; then
  ./vendor/bin/drush kumquat:generate-project
else
  echo "Project sources already initialized."
fi
echo

echo "Project initialization complete."
