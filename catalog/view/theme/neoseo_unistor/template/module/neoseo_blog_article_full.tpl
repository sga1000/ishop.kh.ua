<div class="module">
	<h3><?php echo $heading_title; ?></h3>
	<?php if (!empty($heading_title)) { ?>
	<?php } ?>
	<div class="row article-block arbful <?php if ($limit >= 5 ) { ?> module-grid-5 <?php } ?>" style="margin-bottom:25px;">
		<?php foreach ($articles as $article) { ?>
		<div itemscope="" class="article-layout <?php if ($limit < 5 ) { ?> col-lg-3 col-md-3 col-sm-6 col-xs-12 <?php } ?>">
			<div class="news box-shadow box-corner article-layout">

				<div class="image">
					<a href="<?php echo $article['href']; ?>" title="<?php echo $article['name']; ?>"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" title="<?php echo $article['name']; ?>" class="img-responsive" width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" /></a>
				</div>

				<div class="caption">
					<div class="entry-meta">
					<span class="entry-date published">
					   <?php echo $article['date_modified']; ?>
					</span>
						<?php if ($article['rating']) { ?>
						<div class="rating-container">
							<span class="rating">
							<?php if ($article['rating']) { ?>
							<meta  content="<?php echo $article['total_comments']; ?>">
							<meta  content="<?php echo $article['rating']; ?>">
							<?php for ($i = 1; $i <= 5; $i++) { ?>
							<?php if ($article['rating'] < $i) { ?>
							<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
							<?php } else { ?>
							<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
							<?php }?>
							<?php } ?>
							<?php } ?>
							</span>
						</div>
						<?php }?>
					</div>

					<h4><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></h4>



					<p class="descripts"><?php echo $article['description']; ?></p>
					<div class="post-info">
					<span class="entry-views">
						<i class="fa fa-eye"></i>
						<?php echo $article['viewed']; ?>
					</span>
						<span class="entry-comments-link">
						<i class="fa fa-commenting" aria-hidden="true"></i>
							<?php echo $article['total_comments']; ?>
					</span>
					</div>

				</div>
			</div>
		</div>
		<?php } ?>
	</div>
</div>
