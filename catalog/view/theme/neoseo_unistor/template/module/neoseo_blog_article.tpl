<div class="module">
<?php if (!empty($heading_title)) { ?>
<h3><?php echo $heading_title; ?></h3>
<?php } ?>
<div class="row article-block articles-content-main">
	<?php foreach ($articles as $article) { ?>

	<div class="articles-layout article-list col-lg-6 col-xs-12">
		<div class="article-thumb box-shadow box-corner">
			<div class="images">
				<a href="<?php echo $article['href']; ?>"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" title="<?php echo $article['name']; ?>" class=""/></a>
			</div>
			<div class="caption">
				<?php if (!empty($blog_meta['date']) || !empty($blog_meta['author']) || !empty($blog_meta['comments']) || !empty($blog_meta['category'])) { ?>
				<div class="entry-meta">
					<?php if (!empty($blog_meta['date'])) { ?>
					<span class="entry-date published">
														<?php echo $article['date_modified']; ?>
													</span>
					<?php } ?>
					<?php if (!empty($blog_meta['author'])) { ?>
					<span class="entry-author">
														<?php echo $text_author ?>
						<a href="<?php echo $article['author']['href']; ?>"><?php echo $article['author']['name']; ?></a>
													</span>
					<?php } ?>
					<?php if (!empty($blog_meta['comments']) && $article['total_comments']) { ?>
					<span class="entry-comments-link">
														<i class="fa fa-commenting" aria-hidden="true"></i>
														<a href="<?php echo $article['href']; ?>#comments"><?php echo $article['total_comments']; ?></a>
													</span>
					<?php } ?>
					<?php if (!empty($blog_meta['category']) && $article['category']) { ?>
					<span class="entry-category-link">
														<i class="fa fa-folder-open-o"></i>
														<a href="<?php echo $article['category']['href']; ?>" rel="category tag"><?php echo $article['category']['name']; ?></a>
													</span>
					<?php } ?>
				</div>
				<?php } ?>

				<h4><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></h4>

				<div class="entry-meta">
					<?php if ($article['date_modified']) { ?>
					<span class="entry-date published">
													<?php echo $article['date_modified'];?>
												</span>
					<?php } ?>
					<?php if ($article['author']) { ?>
					<span class="entry-author">
													<?php echo $text_author ?>
						<a href="<?php echo $article['author']['href'];?>"><?php echo $article['author']['name'];?></a>
												</span>
					<?php } ?>
				</div>

				<p><?php echo utf8_substr($article['description'], 0 , 153) . '..'; ?></p>

				<div class="caption-bottom">
					<div class="_left">
						<a class="button_more" href="<?php echo $article['href']; ?>"><?php echo $text_more ?></a>
					</div>
					<div class="_right" <?php if (!$article['rating']) { ?>style="width:auto;"<?php } ?>>
						<div class="rating-container">
							<span class="rating"<?php if ($article['rating']) { ?> <?php }?>>
							<?php if ($article['rating']) { ?>
							<meta  content="<?php echo $article['md_review_count']; ?>">
							<meta  content="<?php echo $article['rating']; ?>">
							<?php for ($i = 1; $i <= 5; $i++) { ?>
							<?php if ($article['rating'] < $i) { ?>
							<span class="fa fa-stack">
																	<i class="fa fa-star-o fa-stack-2x"></i>
																</span>
							<?php } else { ?>
							<span class="fa fa-stack">
																	<i class="fa fa-star fa-stack-2x"></i>
																	<i class="fa fa-star-o fa-stack-2x"></i>
																</span>
							<?php }?>
							<?php } ?>
							<?php } ?>
						</div>

						<?php if ($article['viewed']) { ?>
						<span class="entry-views">
														<i class="fa fa-eye"></i>
							<?php echo $article['viewed'];?>
													</span>
						<?php } ?>
						<?php if ($article['total_comments']) { ?>
						<span class="entry-comments-link">
														<i class="fa fa-commenting" aria-hidden="true"></i>
							<?php echo $article['total_comments'];?>
													</span>
						<?php } ?>
					</div>
				</div>
			</div>
		</div>
	</div>
	<?php } ?>
</div>
</div>
