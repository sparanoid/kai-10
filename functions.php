<?php
// Override the header width of Twenty Ten
  $custom_header_support_override = array(
  	'width' => apply_filters( 'twentyten_header_image_width', 980 ),
  );
	
  add_theme_support( 'custom-header', $custom_header_support_override );
	
  if ( ! function_exists( 'get_custom_header' ) ) {
  	define( 'HEADER_IMAGE_WIDTH', $custom_header_support_override['width'] );
  }
?>