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
 * Override Twenty Ten stylesheet loading behavier and load Twenty Ten Kai stylesheet
 *
 * @since Twenty Ten Kai 2.2.2
 */
function twentyten_scripts_styles_override() {
   wp_enqueue_style( 'twentyten-style', get_template_directory_uri() . '/style.css' );
   wp_enqueue_style( 'twentyten-kai-style', get_stylesheet_directory_uri() . '/core.css' );
 }
add_action( 'wp_enqueue_scripts', 'twentyten_scripts_styles_override' );
?>