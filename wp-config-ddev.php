<?php

if ( getenv( 'IS_DDEV_PROJECT' ) == 'true' ) {
    /** The name of the database for WordPress */
    defined( 'DB_NAME' ) || define( 'DB_NAME', 'db' );

    /** MySQL database username */
    defined( 'DB_USER' ) || define( 'DB_USER', 'db' );

    /** MySQL database password */
    defined( 'DB_PASSWORD' ) || define( 'DB_PASSWORD', 'db' );

    /** MySQL hostname */
    defined( 'DB_HOST' ) || define( 'DB_HOST', 'ddev-test-project-shanks-db' );

    /** WP_HOME URL */
    defined( 'WP_HOME' ) || define( 'WP_HOME', 'https://test-project-shanks.ddev.site' );

    /** WP_SITEURL location */
    defined( 'WP_SITEURL' ) || define( 'WP_SITEURL', WP_HOME . '/wp' );

    /** Enable debug */
    defined( 'WP_DEBUG' ) || define( 'WP_DEBUG', true );

    /** WordPress environment type. */
    defined( 'WP_ENVIRONMENT_TYPE' ) || define( 'WP_ENVIRONMENT_TYPE', 'local' );

    /**
     * Set WordPress Database Table prefix if not already set.
     *
     * @global string $table_prefix
     */
    if ( ! isset( $table_prefix ) || empty( $table_prefix ) ) {
        // phpcs:disable WordPress.WP.GlobalVariablesOverride.Prohibited
        $table_prefix = 'wp_';
        // phpcs:enable
    }
}
