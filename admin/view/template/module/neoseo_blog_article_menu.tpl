<?php if ($heading_title) { ?>
<img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
<h3><?php echo $heading_title_raw . " " . $text_module_version; ?></h3>
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