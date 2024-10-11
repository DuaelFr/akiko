<?php

/**
 * @file
 * Settings for "testing" environments.
 */

// Add common testing environments to trusted hots patterns.
$settings['trusted_host_patterns'][] = '^.*\.akikofairtrade\.com$';

// Enable testing config split.
$config['config_split.config_split.testing']['status'] = TRUE;
