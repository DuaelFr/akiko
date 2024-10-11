
# ------------------------------------------------------------------------------
# Appended by the scaffolding.
# ------------------------------------------------------------------------------

// Salt for one-time login links, cancel links, form tokens, etc.
$settings['hash_salt'] = 'YPcSNuNGtO20vEVtxWZazYbGX33XkypclgPagXusalWaG6Tb8iLQOQlSAPCcwPVjg05glXZ4';

// Environment variables are defined in the .env file at the project root.
$databases['default']['default'] = [
  'host' => $_SERVER['COMBAWA_DB_HOSTNAME'],
  'port' => $_SERVER['COMBAWA_DB_PORT'],
  'database' => $_SERVER['COMBAWA_DB_DATABASE'],
  'password' => $_SERVER['COMBAWA_DB_PASSWORD'],
  'username' => $_SERVER['COMBAWA_DB_USER'],
  'prefix' => '',
  'driver' => 'mysql',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
];

// Skip file system permissions hardening to prevent version control issues.
$settings['skip_permissions_hardening'] = TRUE;

// Define configuration storage directory.
$settings['config_sync_directory'] = '../config/sync';

// Load default environment override configuration, if available.
if (($build_env = $_SERVER['COMBAWA_BUILD_ENV']) && file_exists($app_root . '/' . $site_path . '/settings.' . $build_env . '.php')) {
  include $app_root . '/' . $site_path . '/settings.' . $build_env . '.php';
}

// Load local development override configuration, if available.
if (file_exists($app_root . '/' . $site_path . '/settings.local.php')) {
  include $app_root . '/' . $site_path . '/settings.local.php';
}
