<div class="module">
<?php if (!empty($heading_title)) { ?>
<h3><?php echo $heading_title; ?></h3>
<?php } ?>
<div class="row article-block arbs">
	<?php foreach ($articles as $article) { ?>

	<div class="product-layout col-lg-4 col-md-4 col-sm-4 col-xs-12">
		<div class="article-thumb box-shadow box-corner">

			<div class="image">
				<a href="<?php echo $article['href']; ?>"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" title="<?php echo $article['name']; ?>" class="img-responsive"/></a>
			</div>

			<div class="caption">

				<h4><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></h4>

				<div class="entry-meta">
										<span class="entry-date published">
										<i class="fa fa-calendar"></i> <?php echo $article['date_modified']; ?>
										</span>
										<span class="entry-author">
										<i class="fa fa-user"></i>
										<a href="<?php echo $article['author']['href']; ?>"><?php echo $article['author']['name']; ?></a>
										</span>
										</span><span class="entry-views">
										<i class="fa fa-eye"></i> <?php echo $text_viewed; ?> <?php echo $article['viewed']; ?>
										</span>
										<span class="entry-comments-link">
										<i class="fa fa-comment-o"></i> <?php echo $text_comments; ?> <?php echo $article['total_comments']; ?>
										</span>
				</div>

				<p class="descripts"><?php echo $article['description']; ?></p>

			</div>
		</div>
	</div>
	<?php } ?>
</div>
</div>
