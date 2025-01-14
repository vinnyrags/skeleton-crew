<?php

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/** Authentication Unique Keys and Salts. */
define( 'AUTH_KEY', 'yBlglFfBmdiKrtDfoCnhNWQRmUgunOMUXpNNPareBbLAYDlIpqCkqqbuPDPGdmyi' );
define( 'SECURE_AUTH_KEY', 'FEdpuolldUsnKvifZCAFxCrEkaUPlStfpkAzAabXOCUbplCGrTWkPilruJgwpfVz' );
define( 'LOGGED_IN_KEY', 'FajtZQZszzkYJtKofPEKaGqvLGvZFkyDSUutIMoOKfWcZOuVHMfiOjHSMJyHuJEI' );
define( 'NONCE_KEY', 'PzoWsLSzZGbXgOuWjBpoyCrugBsFEBioDPqYNdQZismXNTagtEYhqKLxDtfoMUJJ' );
define( 'AUTH_SALT', 'JpKmbGZGHUuhlfKXIexhwSQqyxIbdYenXqjeBqCoYDmToggPFMMXNqUMmwUAueSY' );
define( 'SECURE_AUTH_SALT', 'TTSmnnaYEjiKLgEJjbxhWByChrkjxjDjhhOsvDKOqqCpgvMvaVmiiZHZqIZjwJBX' );
define( 'LOGGED_IN_SALT', 'ejwCbrzaFdzGfoZQFItqBJjBnqdCZYZJgDfdLbyhZRivycxElstWnprjfwIHWkLc' );
define( 'NONCE_SALT', 'QrkXwbxEpsIjKlIrrGeDgOKVZiARhNUsLkaeTRFwlWRphrvGLqtRJcoqHvSIYZon' );

/* Add any custom values between this line and the "stop editing" line. */

define('WP_CONTENT_DIR', __DIR__ . '/wp-content');
define('WP_CONTENT_URL', 'https://' . $_SERVER['HTTP_HOST'] . '/wp-content');

// Load Composer's autoloader
if (file_exists(__DIR__ . '/vendor/autoload.php')) {
    require_once __DIR__ . '/vendor/autoload.php';
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
defined( 'ABSPATH' ) || define( 'ABSPATH', dirname( __FILE__ ) . '/wp' );

// Include for settings managed by ddev.
$ddev_settings = __DIR__ . '/wp-config-ddev.php';
if ( ! defined( 'DB_USER' ) && getenv( 'IS_DDEV_PROJECT' ) == 'true' && is_readable( $ddev_settings ) ) {
    require_once( $ddev_settings );
}

/** Include wp-settings.php */
if ( file_exists( ABSPATH . '/wp-settings.php' ) ) {
    require_once ABSPATH . '/wp-settings.php';
}
