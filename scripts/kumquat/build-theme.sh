#!/usr/bin/env bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/_commons.sh"

NPM="npm"
HAS_NVM=false
if [ command -v nvm &> /dev/null ]; then
  NPM="nvm exec npm"
  HAS_NVM=true
fi

# Build themes assets.
echo "Building themes assets..."
COUNT=`node -e "var themes = require('./composer.json').extra['kumquat-themes'] || []; console.log(themes.length);"`
if [ "$COUNT" -gt "0" ]; then
  for (( i=0; i<=$COUNT; i++)); do
    THEME_DIR=`node -e "console.log(require('./composer.json').extra['kumquat-themes'][$i]);"`
    if [ -d $THEME_DIR ]; then
      echo "Starting $THEME_DIR build..."
      cd $THEME_DIR

      # If we use nvm and the node version has been specified then install it.
      if [ -f "$THEME_DIR/.nvmrc" ] && [ HAS_NVM ]; then
        nvm install
      fi

      # Use clean-install to get precise versions of dependencies.
      if [ -f "$THEME_DIR/package-lock.json" ]; then
        $NPM ci
      else
        $NPM install
      fi

      # Build the theme sources according to the env.
      if [ "$COMBAWA_BUILD_ENV" != 'prod' ]; then
        $NPM run build-dev
      else
        $NPM run build
        # Only keep real dependencies, not dev ones (reduces deployment size).
        NODE_ENV=production $NPM ci
      fi

      cd -
      echo "Done"
    else
      echo "$THEME_DIR directory not found"
    fi
  done
else
  echo "No theme configured in the composer.json extra.kumquat-themes key."
fi
echo "Building themes assets... Done"
echo ""
