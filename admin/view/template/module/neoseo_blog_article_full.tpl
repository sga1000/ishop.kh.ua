<?php if (!empty($heading_title_raw)) { ?>
<div class="title">
	<div class="title-inner">
		<i class="icon-newspaper-folded"></i><span class="title-text"><?php echo $heading_title_raw; ?></span>
		<div class="customNavigation" style=" width:80px"></div>
	</div>
</div>
<?php } ?>
<div class="row article-block arbful" style="margin-bottom:25px;">
	<?php foreach ($articles as $article) { ?>
	<div class="product-layout col-lg-4 col-md-4 col-sm-6 col-xs-12">
		<div class="news">

			<div class="image">
				<a href="<?php echo $article['href']; ?>"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" title="<?php echo $article['name']; ?>" class="img-responsive"/></a>
			</div>

			<div class="caption">

				<h4><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></h4>

				<p><?php echo $article['description']; ?></p>

			</div>
		</div>
	</div>
	<?php } ?>
</div>
