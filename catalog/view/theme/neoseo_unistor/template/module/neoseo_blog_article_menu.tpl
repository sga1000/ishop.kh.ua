<?php if ($heading_title) { ?>
<aside class="side-module box-shadow box-corner">
<h3><?php echo $heading_title; ?></h3>
<?php } ?>

<div class="list-group">
	<?php foreach ($articles as $article) { ?>
	<?php if ($article['article_id'] == $article_id) { ?>
	<a href="<?php echo $article['href']; ?>" class="list-group-item active"><?php echo $article['name']; ?></a>
	<?php } else { ?>
	<a href="<?php echo $article['href']; ?>" class="list-group-item"><?php echo $article['name']; ?></a>
	<?php } ?>
	<?php } ?>
</div>
</aside>