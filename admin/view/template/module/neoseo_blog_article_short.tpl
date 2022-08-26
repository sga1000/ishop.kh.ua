<?php if (!empty($heading_title_raw)) { ?>
<img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
<h1><?php echo $heading_title_raw . " " . $text_module_version; ?></h1>
<?php } ?>
<div class="wrapps asb-wrap" style="border:none">
	<?php foreach ($articles as $article) { ?>
	<div class="row actik" style="margin-bottom: 15px">

		<a href="<?php echo $article['href']; ?>">
			<img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" title="<?php echo $article['name']; ?>" class=""/>

			<?php echo $article['name']; ?></a>
		<?php if (!empty($blog_meta['date'])) { ?>
		<div class="entry-date published">
			<i class="fa fa-calendar"></i>
			<?php echo $article['date_modified']; ?>
		</div>
		<?php } ?>
		<?php if (!empty($blog_meta['author'])) { ?>
		<div class="entry-author">
			<i class="fa fa-user"></i>
			<a href="<?php echo $article['author']['href']; ?>"><?php echo $article['author']['name']; ?></a>
		</div>
		<?php } ?>
		<?php if (!empty($blog_meta['comments']) && $article['total_comments']) { ?>
		<div class="entry-comments-link">
			<i class="fa fa-comment-o"></i>
			<a href="<?php echo $article['href']; ?>#comments"><?php echo $article['total_comments']; ?></a>
		</div>
		<?php } ?>

	</div>


	<?php } ?>
</div>
