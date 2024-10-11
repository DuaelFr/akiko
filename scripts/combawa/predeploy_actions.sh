#!/bin/bash
# Actions to run before the main and shared deployment actions.
# It can be useful to backup, import databases or doing something similar.

# Example to clean files to avoid keeping old stuff.

# Enable the maintenance mode.
if [[ $COMBAWA_BUILD_MODE == "update" ]]; then
  $DRUSH sset system.maintenance_mode 1
fi

case $COMBAWA_BUILD_ENV in
  dev)
    ;;
  testing)
    ;;
  prod)
    ;;
  *)
    notify_fatal "Unknown environment: $COMBAWA_BUILD_ENV. Please check your name."
esac
