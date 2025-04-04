#!/bin/bash
# Action to run after the main and shared deployment actions.
# It can be useful to enable specific modules for instance.

case $COMBAWA_BUILD_ENV in
  dev)
    # Update translations.
    $DRUSH locale:check
    $DRUSH locale:update

    # Import deployment and test related content.
    # $DRUSH en MYPROJECT_NAME_content_deploy
    # $DRUSH en MYPROJECT_NAME_content_test

    # Use config import to disable modules that should not be enabled in this
    # environment.
    $DRUSH config:import

    # Rebuild search indexes.
    $DRUSH sapi-r
    $DRUSH sapi-i

    # Rebuild permissions
    # $DRUSH php-eval 'node_access_rebuild();'

    # Connect.
    $DRUSH uli
    ;;
  testing)
    # Update translations.
    $DRUSH locale:check
    $DRUSH locale:update

    # Import deployment and test related content.
    # $DRUSH en MYPROJECT_NAME_content_deploy
    # $DRUSH en MYPROJECT_NAME_content_test

    # Use config import to disable modules that should not be enabled in this
    # environment.
    $DRUSH config:import

    # Rebuild search indexes.
    $DRUSH sapi-r
    $DRUSH sapi-i

    # Rebuild permissions
    # $DRUSH php-eval 'node_access_rebuild();'
    ;;
  prod)
    # Update translations.
    $DRUSH locale:check
    $DRUSH locale:update

    # Import deployment related content.
    # $DRUSH en MYPROJECT_NAME_content_deploy

    # Use config import to disable modules that should not be enabled in this
    # environment.
    $DRUSH config:import

    # Rebuild search indexes.
    $DRUSH sapi-r
    $DRUSH sapi-i

    # Rebuild permissions
    # $DRUSH php-eval 'node_access_rebuild();'
    ;;
  *)
    notify_fatal "Unknown environment: $COMBAWA_BUILD_ENV. Please check your name."
esac

# Disable the maintenance mode.
set +x
if [[ $COMBAWA_BUILD_MODE == "update" ]]; then
  echo ""
  echo ""
  echo "Deployment is over."
  echo "Do not forget to turn off the maintenance mode if needed."
#  $DRUSH sset system.maintenance_mode 0
fi
