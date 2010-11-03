<?php

// Make theme available for translation
// Translations can be filed in the /languages/ directory
load_theme_textdomain( 'twentyten_kai', TEMPLATEPATH . '/languages' );

$locale = get_locale();
$locale_file = TEMPLATEPATH . "/languages/$locale.php";
if ( is_readable( $locale_file ) )
	require_once( $locale_file );

// The height and width of your custom header. You can hook into the theme's own filters to change these values.
// Add a filter to twentyten_header_image_width and twentyten_header_image_height to change these values.
define( 'HEADER_IMAGE_WIDTH', apply_filters( 'twentyten_header_image_width', 840 ) );
define( 'HEADER_IMAGE_HEIGHT', apply_filters( 'twentyten_header_image_height', 198 ) );

?>
