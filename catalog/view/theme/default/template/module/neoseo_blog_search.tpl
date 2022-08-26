<?php if ($title) { ?>
<h3><?php echo $title; ?></h3>
<?php } ?>
<div class="">
<div id="blog-search" class="input-group">
	<input type="text" name="blog_search" value="<?php echo $blog_search; ?>" placeholder="<?php echo $text_keyword; ?>" class="form-control">
	<span class="input-group-btn">
	<button type="button" id="button-search" class="btn btn-default"><i class="fa fa-search"></i></button>
  </span>
</div>
<br/>
</div>
<script type="text/javascript">
	$('input[name=\'blog_search\']').keydown(function (e) {
		if (e.keyCode == 13) {
			$('#button-search').trigger('click');
		}
	});

	$('#button-search').bind('click', function () {
		url = 'index.php?route=blog/neoseo_blog_search';
		<?php if ($root_category_id) { ?>
			url += '&blog_category_id=<?php echo $root_category_id; ?>';
		<?php } ?>

		var blog_search = $('input[name=\'blog_search\']').val();

		if (blog_search) {
			url += '&blog_search=' + encodeURIComponent(blog_search);
			location = url;
		}

	});
</script> 
