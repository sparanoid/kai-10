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

/**
 * Add theme support for infinity scroll
 *
 * @since Twenty Ten Kai 2.2.2
 */
function twenty_ten_kai_infinite_scroll_init() {
  add_theme_support( 'infinite-scroll', array(
    'container' => 'content',
    'render'    => 'twenty_ten_kai_infinite_scroll_render',
    'footer'    => 'wrapper'
  ) );
}
add_action( 'init', 'twenty_ten_kai_infinite_scroll_init' );

/**
 * Set the code to be rendered on for calling posts,
 * hooked to template parts when possible.
 *
 * Note: must define a loop.
 */
function twenty_ten_kai_infinite_scroll_render() {
  get_template_part( 'loop' );
}

/**
 * Do we have footer widgets?
 */
function twenty_ten_has_footer_widgets( $has_widgets ) {
  if ( is_active_sidebar( 'first-footer-widget-area' ) || is_active_sidebar( 'second-footer-widget-area' ) || is_active_sidebar( 'third-footer-widget-area'  ) || is_active_sidebar( 'fourth-footer-widget-area' ) )
    $has_widgets = true;

  return $has_widgets;
}
add_filter( 'infinite_scroll_has_footer_widgets', 'twenty_ten_has_footer_widgets' );
?>