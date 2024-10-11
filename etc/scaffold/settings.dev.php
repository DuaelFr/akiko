<?php

/**
 * @file
 * Settings for "dev" environments.
 */

// Add common dev environments to trusted hots patterns.
$settings['trusted_host_patterns'][] = '^.*\.akikofairtrade\.com$';
$settings['trusted_host_patterns'][] = '^.*\.lndo\.site$';
$settings['trusted_host_patterns'][] = '^.*\.local(?:host)?$';
$settings['trusted_host_patterns'][] = '^.*\.dev$';
$settings['trusted_host_patterns'][] = '^.*\.fun$';
$settings['trusted_host_patterns'][] = '^.*\.test$';
$settings['trusted_host_patterns'][] = '^localhost$';

// Default dev settings. See web/sites/example.settings.local.php.
$settings['container_yamls'][] = DRUPAL_ROOT . '/sites/development.services.yml';
$settings['cache']['bins']['render'] = 'cache.backend.null';
$settings['cache']['bins']['discovery_migration'] = 'cache.backend.memory';
$settings['cache']['bins']['page'] = 'cache.backend.null';
$settings['cache']['bins']['dynamic_page_cache'] = 'cache.backend.null';

// Force verbose errors.
$config['system.logging']['error_level'] = 'verbose';

// Enable dev config split.
$config['config_split.config_split.dev']['status'] = TRUE;
