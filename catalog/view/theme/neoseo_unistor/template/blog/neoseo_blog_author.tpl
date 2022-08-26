<?php echo $header; ?>
<div class="container">
	<ul class="breadcrumb box-shadow box-corner">
		<?php $cnt = count($breadcrumbs); $i = 0; foreach ($breadcrumbs as $key => $breadcrumb) { ?>
			<li >
				<?php $i++; if( $i != $cnt ) { ?>
					<a  href="<?php echo $breadcrumb['href']; ?>">
						<span ><?php echo $breadcrumb['text']; ?></span>
					</a>
				<?php } else { ?>
					<a  href="<?php echo $breadcrumb['href']; ?>">
						<span ><?php echo $breadcrumb['text']; ?></span>
					</a>
				<?php } ?>
				<meta  content="<?php echo $key+1; ?>" />
			</li>
		<?php } ?>
	</ul>
	<div class="row">
		<?php echo $column_left; ?>

		<?php
			if ($column_left && $column_right) {
				$class = 'col-sm-6';
			} elseif ($column_left || $column_right) {
				$class = 'col-sm-9';
			} else {
				$class = 'col-sm-12';
			}
		?>
		<div id="content" class="blog-content <?php echo $class; ?>">
			<?php echo $content_top; ?>
			<div class="articles-top box-shadow box-corner">
				<div class="hidden-md hidden-lg"></div>
				<h1><?php echo $heading_title; ?></h1>
				
				<?php if (!empty($thumb) || !empty($description) && !$desc_position) { ?>
					<?php if (!empty($thumb)) { ?>
						<div class="col-sm-2">
							<img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail"/>
						</div>
					<?php }  ?>
					<?php if (!empty($description)) { ?>
						<div>
							<article>
								<?php echo $description; ?>
							</article>
						</div>
					<?php } ?>
					<script>
						$('article').readmore({
							maxHeight: 160,
							moreLink: '<a class="moreLink" href="#"><span><?php echo $text_read_more; ?></span></a>',
							lessLink: '<a class="moreLink" style=" background: none;" href="#"><span><?php echo $text_read_less; ?></span></a>'
						});
					</script>
				<?php } ?>

				<?php echo $sharing_code; ?>
			</div>

			<?php if ($articles) { ?>
				<div class="row articles-content">
				<?php foreach ($articles as $article) { ?>
						<div class="articles-layout article-list col-xs-12">
							<div class="article-thumb box-shadow box-corner">
								<div class="images">
									<a href="<?php echo $article['href']; ?>"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" title="<?php echo $article['name']; ?>" class=""/></a>
								</div>
								<div style="width: 100%">
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

										<p><?php echo $article['description']; ?></p>

										<div class="caption-bottom">
											<div class="_left">
												<a class="button_more" href="<?php echo $article['href']; ?>"><?php echo $text_more ?></a>
											</div>
											<div class="_right">
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
						</div>
					<?php } ?>
				</div>
				<div class="row paginator">
					<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
					<div class="col-sm-6 text-right"><?php echo $results; ?></div>
				</div>
			<?php } else {?>
				<div class="empty-box box-shadow box-corner">
					<p class="empty-title"><?php echo $text_empty; ?></p>
				</div>
			<?php } ?>

			<?php if (!empty($thumb) || !empty($description) && $desc_position) { ?>
				<?php if (!empty($thumb)) { ?>
					<div class="col-sm-2">
						<img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail"/>
					</div>
				<?php }  ?>
				<?php if (!empty($description)) { ?>
					<div class="articles-bottom">
						<article>
							<?php echo $description; ?>
						</article>
					</div>
				<?php } ?>
				<script>
					$('article').readmore({
						maxHeight: 160,
						moreLink: '<a class="moreLink" href="#"><span><?php echo $text_read_more; ?></span></a>',
						lessLink: '<a class="moreLink" style=" background: none;" href="#"><span><?php echo $text_read_less; ?></span></a>'
					});
				</script>
			<?php } ?>

			<?php echo $content_bottom; ?>
		</div>

		<?php echo $column_right; ?>
	</div>
</div>

<?php echo $footer; ?>