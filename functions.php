<?php
// Override width of Twenty Ten
define( 'HEADER_IMAGE_WIDTH', apply_filters( 'twentyten_header_image_width', 840 ) );
define( 'HEADER_IMAGE_HEIGHT', apply_filters( 'twentyten_header_image_height', 198 ) );

?>

<?php get_avatar( $id_or_email, $size = '96', $default = '<path_to_url>' ); ?>
