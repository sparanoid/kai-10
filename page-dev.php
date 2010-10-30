<?php
/**
 * @package WordPress
 * @subpackage Default_Theme
 */
/*
Template Name: 开发首页
*/
?>

<?php get_header(); ?>

<div id="content" class="narrowcolumn" role="main">

<h2>关于 nio2 开发</h2>
<p>这里是关于 nio2 的开发日志，包括更新升级、服务器状态，活动等信息</p>

<h2>文章列表</h2>
<ul>
<?php query_posts('showposts=50000');
if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
<li class="post-title"><a href="<?php the_permalink() ?>" title="<?php the_title_attribute(); ?>"><?php the_title(); ?></a></li>
<?php endwhile; else: ?>
<li>这里什么都没有!</li>
<?php endif; ?>
<?php wp_reset_query(); ?>
</ul>

</div>

<?php get_sidebar(); ?>

<?php get_footer(); ?>
