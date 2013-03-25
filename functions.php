<?php
// Override the header width of Twenty Ten
$custom_header_support_override = array(
  'width' => apply_filters( 'twentyten_header_image_width', 980 ),
);

add_theme_support( 'custom-header', $custom_header_support_override );

if ( ! function_exists( 'get_custom_header' ) ) {
  define( 'HEADER_IMAGE_WIDTH', $custom_header_support_override['width'] );
}

/**
 * Override Twenty Ten stylesheet loading behavier and load Kai 10 stylesheet
 *
 * @since Kai 10 2.2.2
 */
function twentyten_scripts_styles_override() {
   wp_enqueue_style( 'twentyten-style', get_template_directory_uri() . '/style.css' );
   wp_enqueue_style( 'kai-10-style', get_stylesheet_directory_uri() . '/core.css' );
 }
add_action( 'wp_enqueue_scripts', 'twentyten_scripts_styles_override' );

/**
 * Override default Jetpack Infinite Scroll footer
 *
 * @since Kai 10 2.2.3
 */
function kai_10_infinite_scroll_credit() {
  return '<a href="http://postholic.com/rsrc/kai-10/">Kai 10</a>';
}

add_filter( 'infinite_scroll_credit', 'kai_10_infinite_scroll_credit' );


/**
 * Initialize the update checker
 *
 * @since Kai 10 2.2.3
 */
require 'includes/theme-update-checker.php';
$kai_10_update_checker = new ThemeUpdateChecker(
  'kai-10',
  'http://sparanoid.com/lab/wordpress/kai-10.json'
);
?>