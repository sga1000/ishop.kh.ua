<?php if (!empty($heading_title)) { ?>
<aside class="side-module box-shadow box-corner">
	<div class="blog-article-short">
		<h3><?php echo $heading_title; ?></h3>
		<?php } ?>
		<div class="wrapps asb-wrap" style="border:none">
	<?php foreach ($articles as $article) { ?>
	<div class="row actik">
		<img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" title="<?php echo $article['name']; ?>" class=""/>
		<a href="<?php echo $article['href']; ?>">
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
	</div>
</aside>