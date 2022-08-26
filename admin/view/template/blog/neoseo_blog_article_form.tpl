<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if ($article_id ) { ?>
						<a href="<?php echo HTTP_CATALOG; ?>index.php?route=blog/neoseo_blog_article&article_id=<?php echo $article_id; ?>" target="_new" data-toggle="tooltip" title="" class="btn btn-success" data-original-title="Перейти к статье на сайте"><i class="fa fa-eye"></i></a>
				<?php } ?>
				<button type="submit" form="form-blog-article" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>
			<img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
			<h1><?php echo $heading_title_raw . " " . $text_module_version; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
					<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div> <!-- end of page-header class -->

	<div class="container-fluid">
		<?php if ($error_warning) { ?>
			<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
		<?php } ?>

		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
			</div>

			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-blog-article" class="form-horizontal">

					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
						<li><a href="#tab-data" data-toggle="tab"><?php echo $tab_data; ?></a></li>
						<li><a href="#tab-links" data-toggle="tab"><?php echo $tab_links; ?></a></li>
						<li><a href="#tab-design" data-toggle="tab"><?php echo $tab_design; ?></a></li>
					</ul>

					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">

							<ul class="nav nav-tabs" id="language">
								<?php foreach ($languages as $language) { ?>
									<li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
								<?php } ?>
							</ul>

							<div class="tab-content">
								<?php foreach ($languages as $language) { ?>
									<div class="tab-pane" id="language<?php echo $language['language_id']; ?>">

										<div class="form-group required">
											<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_title; ?></label>
											<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
												<input type="text" name="article_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($article_description[$language['language_id']]['name']) ? $article_description[$language['language_id']]['name'] : ''; ?>" class="form-control" />
												<?php if (isset($error_article_name[$language['language_id']])) { ?>
													<span class="text-danger"><?php echo $error_article_name[$language['language_id']]; ?></span>
												<?php } ?>
											</div>
										</div>


										<div class="form-group">
											<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_teaser; ?></label>
											<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
												<textarea name="article_description[<?php echo $language['language_id']; ?>][teaser]" id="teaser<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($article_description[$language['language_id']]['teaser']) ? $article_description[$language['language_id']]['teaser'] : ''; ?></textarea>
											</div>
										</div>

										<div class="form-group required">
											<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_description; ?></label>
											<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
												<textarea name="article_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($article_description[$language['language_id']]['description']) ? $article_description[$language['language_id']]['description'] : ''; ?></textarea>
												<?php if (isset($error_description[$language['language_id']])) { ?>
													<span class="text-danger"><?php echo $error_description[$language['language_id']]; ?></span>
												<?php } ?>
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-meta-title<?php echo $language['language_id']; ?>"><?php echo $entry_meta_title; ?></label>
											<div class="col-sm-10">
												<input type="text" name="article_description[<?php echo $language['language_id']; ?>][meta_title]" value="<?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['meta_title'] : ''; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta-title<?php echo $language['language_id']; ?>" class="form-control" />
												<?php if (isset($error_meta_title[$language['language_id']])) { ?>
												<div class="text-danger"><?php echo $error_meta_title[$language['language_id']]; ?></div>
												<?php } ?>
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-meta-h1<?php echo $language['language_id']; ?>"><?php echo $entry_meta_h1; ?></label>
											<div class="col-sm-10">
												<input type="text" name="article_description[<?php echo $language['language_id']; ?>][meta_h1]" value="<?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['meta_h1'] : ''; ?>" placeholder="<?php echo $entry_meta_h1; ?>" id="input-meta-h1<?php echo $language['language_id']; ?>" class="form-control" />
												<?php if (isset($error_meta_h1[$language['language_id']])) { ?>
												<div class="text-danger"><?php echo $error_meta_h1[$language['language_id']]; ?></div>
												<?php } ?>
											</div>
										</div>

										<div class="form-group">
											<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_meta_description; ?></label>
											<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
												<textarea name="article_description[<?php echo $language['language_id']; ?>][meta_description]" class="form-control"><?php echo isset($article_description[$language['language_id']]['meta_description']) ? $article_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
											</div>
										</div>

										<div class="form-group">
											<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_meta_keyword; ?></label>
											<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
												<textarea name="article_description[<?php echo $language['language_id']; ?>][meta_keyword]" class="form-control"><?php echo isset($article_description[$language['language_id']]['meta_keyword']) ? $article_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
											</div>
										</div>


									</div>
								<?php } ?>
							</div>

						</div>

						<div class="tab-pane" id="tab-data">

							<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_image; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<a href="" id="thumb-image" data-toggle="image" class="img-thumbnail">
										<img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
									</a>
									<input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" />
								</div>
							</div>

							<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_allow_comment; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<select name="allow_comment" class="form-control">
										<option value="1" <?php echo ($allow_comment == 1) ? "selected='selected'" : ""; ?>><?php echo $text_yes; ?></option>
										<option value="0" <?php echo ($allow_comment == 0) ? "selected='selected'" : ""; ?>><?php echo $text_no; ?></option>
									</select>
								</div>
							</div>   

							<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_seo_url; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<input type="text" name="seo_url" value="<?php echo $seo_url; ?>" class="form-control" />
									<?php if ($error_seo_url) { ?>
									<span class="text-danger"><?php echo $error_seo_url; ?></span>
									<?php } ?>
								</div>
							</div>   

							<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_sort_order; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<input type="text" name="sort_order" value="<?php echo $sort_order; ?>" class="form-control" />
								</div>
							</div>  

							<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_status; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<select name="status" class="form-control">
										<option value="1" <?php echo ($status == 1) ? "selected='selected'" : ""; ?>><?php echo $text_enabled; ?></option>
										<option value="0" <?php echo ($status == 0) ? "selected='selected'" : ""; ?>><?php echo $text_disabled; ?></option>
									</select>
								</div>
							</div> 

							<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_date_added; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<div class="input-group date">
										<input type="text" name="date_added" value="<?php echo $date_added; ?>" placeholder="<?php echo $entry_date_added; ?>" data-date-format="YYYY-MM-DD HH:mm:SS" id="input-date-added" class="form-control" />
										<span class="input-group-btn">
											<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
										</span>
									</div>
								</div>
							</div>

							<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_date_modified; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<div class="input-group date">
										<input type="text" name="date_modified" value="<?php echo $date_modified; ?>" placeholder="<?php echo $entry_date_modified; ?>" data-date-format="YYYY-MM-DD HH:mm:SS" id="input-date-modified" class="form-control" />
										<span class="input-group-btn">
											<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
										</span>
									</div>
								</div>
							</div>

						</div>

						<div class="tab-pane" id="tab-links">

							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-category"><?php echo $entry_main_category; ?></label>
								<div class="col-sm-10">
									<select id="main_category_id" name="main_category_id" class="form-control">
										<option value="0" selected="selected"><?php echo $text_none; ?></option>
										<?php foreach($categories as $category) { ?>
										<?php if ($category['category_id'] == $main_category_id) { ?>
										<option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
										<?php } else { ?>
										<option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
										<?php } ?>
										<?php } ?>
									</select>
								</div>
							</div>


							<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_category; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<div class="well well-sm" style="height: 150px; overflow: auto; margin-bottom:0;">
										<?php foreach ($categories as $category) { ?>
										<div class="checkbox">
											<label>
												<?php if (in_array($category['category_id'], $article_category)) { ?>
												<input type="checkbox" name="article_category[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
												<?php echo $category['name']; ?>
												<?php } else { ?>
												<input type="checkbox" name="article_category[]" value="<?php echo $category['category_id']; ?>" />
												<?php echo $category['name']; ?>
												<?php } ?>
											</label>
										</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
								</div>
							</div>

							<div class="form-group required">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_author_name; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<input type="text" name="author_name" value="<?php echo $author_name; ?>" class="form-control" />
									<input type="hidden" name="author_id" value="<?php echo $author_id; ?>" />
									<?php if ($error_author_name) { ?>
									<span class="text-danger"><?php echo $error_author_name; ?></span>
									<?php } ?>
								</div>
							</div>

							<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_store; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<div class="well well-sm" style="height: 150px; overflow: auto; margin-bottom:0;">
										<div class="checkbox">
											<label>
												<?php if (in_array(0, $article_store)) { ?>
												<input type="checkbox" name="article_store[]" value="0" checked="checked" />
												<?php echo $text_default; ?>
												<?php } else { ?>
												<input type="checkbox" name="article_store[]" value="0" />
												<?php echo $text_default; ?>
												<?php } ?>
											</label>
										</div>

										<?php foreach ($stores as $store) { ?>
										<div class="checkbox">
											<label>
												<?php if (in_array($store['store_id'], $article_store)) { ?>
												<input type="checkbox" name="article_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
												<?php echo $store['name']; ?>
												<?php } else { ?>
												<input type="checkbox" name="article_store[]" value="<?php echo $store['store_id']; ?>" />
												<?php echo $store['name']; ?>
												<?php } ?>
											</label>
										</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
								</div>
							</div>

							<div class="form-group" id="related-products">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_related_products; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<div class="row">
										<div class="col-sm-2"><?php echo $entry_related_products_product; ?></div>
										<div class="col-sm-10">
											<input type="text" name="related_product" value="" class="form-control" />
										</div>
									</div>
									<br />
									<div class="row">
										<div class="col-sm-2"><?php echo $entry_related_products_category; ?></div>
										<div class="col-sm-10">
											<input type="text" name="related_category" value="" class="form-control" />
										</div>
									</div>
									<br />
									<div class="row">
										<div class="col-sm-2"><?php echo $entry_related_products_manufacturer; ?></div>
										<div class="col-sm-10">
											<input type="text" name="related_manufacturer" value="" class="form-control" />
										</div>
									</div>
									<br />
									<div id="products-list" class="well well-sm" style="height: 150px; overflow: auto; margin-bottom:0;">                      
										<?php if (isset($related_products)) { ?>
											<?php foreach ($related_products as $product) { ?>
												<div id="products-list<?php echo $product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product['name']; ?>
													<input type="hidden" name="related_products[]" value="<?php echo $product['product_id']; ?>" />
												</div>
											<?php } ?>
										<?php } ?>
									</div>
								</div>
							</div> 

							<div class="form-group">
								<h3 class="text-center"><?php echo $entry_related_articles; ?></h3>
							</div>

							<table id="related-article" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<td class="text-left"><?php echo $entry_related_article_name; ?></td>
										<td class="text-left"><?php echo $entry_sort_order; ?></td>
										<td class="text-left"><?php echo $entry_status; ?></td>
										<td></td>
									</tr>
								</thead>   

								<?php $article_row = 0; ?>							
								<?php foreach ($related_articles as $related_articles) { ?>
									<tbody id="article-row<?php echo $article_row; ?>">
										<tr>
											<td class="text-left">
												<input type="text" name="related_articles[<?php echo $article_row; ?>][name]" value="<?php echo $related_articles['name']; ?>" id="article-title-<?php echo $article_row; ?>" onkeyup="getArticles(<?php echo $article_row; ?>, this.value);" class="form-control" />
												<input type="hidden" name="related_articles[<?php echo $article_row; ?>][related_id]" value="<?php echo $related_articles['related_id']; ?>" />
											</td>										
											<td class="text-left">
												<input type="text" name="related_articles[<?php echo $article_row; ?>][sort_order]" value="<?php echo $related_articles['sort_order']; ?>" class="form-control" />
											</td>										
											<td class="left">
												<select name="related_articles[<?php echo $article_row; ?>][status]" class="form-control">
												<?php if ($related_articles['status']) { ?>
														<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
														<option value="0"><?php echo $text_disabled; ?></option>
												<?php } else { ?>
														<option value="1"><?php echo $text_enabled; ?></option>
														<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
												<?php } ?>
												</select>
											</td>										
											<td class="text-left">
												<button type="button" onclick="$('#article-row<?php echo $article_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>
											</td>										
										</tr>
									</tbody>
									<?php $article_row++; ?>
									<?php } ?>

								<tfoot>
									<tr>
										<td colspan="3"></td>
										<td class="text-left">
											<button type="button" onclick="addArticles();" data-toggle="tooltip" title="<?php echo $button_add_articles; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
										</td>
									</tr>
								</tfoot>

							</table>

						</div>

						<div class="tab-pane" id="tab-design">
							<div class="table-responsive">
								<table class="table table-bordered table-hover">
									<thead>
									<tr>
										<td class="text-left"><?php echo $entry_store; ?></td>
										<td class="text-left"><?php echo $entry_layout; ?></td>
									</tr>
									</thead>
									<tbody>
									<tr>
										<td class="text-left"><?php echo $text_default; ?></td>
										<td class="text-left">
											<select name="article_layout[0]" class="form-control">
												<option value=""></option>
												<?php foreach ($layouts as $layout) { ?>
												<?php if (isset($article_layout[0]) && $article_layout[0] == $layout['layout_id']) { ?>
												<option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
												<?php } else { ?>
												<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
												<?php } ?>
												<?php } ?>
											</select>
										</td>
									</tr>
									<?php foreach ($stores as $store) { ?>
									<tr>
										<td class="text-left"><?php echo $store['name']; ?></td>
										<td class="text-left">
											<select name="article_layout[<?php echo $store['store_id']; ?>]" class="form-control">
												<option value=""></option>
												<?php foreach ($layouts as $layout) { ?>
												<?php if (isset($article_layout[$store['store_id']]) && $article_layout[$store['store_id']] == $layout['layout_id']) { ?>
												<option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
												<?php } else { ?>
												<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
												<?php } ?>
												<?php } ?>
											</select>
										</td>
									</tr>
									<?php } ?>
									</tbody>
								</table>
							</div>
						</div>
					</div>                        
				</form>
			</div>            
		</div>
	</div>
</div>
<script type="text/javascript">
<?php foreach ($languages as $language) { ?>
<?php if ($ckeditor) { ?>
	ckeditorInit('description<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
	ckeditorInit('teaser<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
<?php } else { ?>
	$('#description<?php echo $language['language_id']; ?>').summernote({height: 300});
	$('#teaser<?php echo $language['language_id']; ?>').summernote({height: 150});
<?php } ?>
<?php } ?>
	$('#language a:first').tab('show');
	$('#option a:first').tab('show');
</script>

<script type="text/javascript">
$('input[name=\'author_name\']').autocomplete({
  'source': function (request, response) {
		$.ajax({
		  url: 'index.php?route=blog/neoseo_blog_author/autocomplete&token=<?php echo $token; ?>&author_name=' +  encodeURIComponent(request) + collectSelectedStores(),
		  dataType: 'json',
		  success: function (json) {
			response($.map(json, function (item) {
			  return {
				label: item['name'],
				value: item['author_id']
			  }
			}));
		  }
		});
	},
	'select': function (item) {
		$('input[name=\'author_name\']').val(item['label']);
		$('input[name=\'author_id\']').val(item['value']);
	}
});    
</script>

<script type="text/javascript">

let collectSelectedStores = function(){
	let stores = $('[name^="article_store"]:checked');

	return stores.length ? '&' + $.param(stores) : '';
};		

$('#products-list').delegate('.fa-minus-circle', 'click', function () {
	$(this).parent().remove();
});

$('input[name=\'related_product\']').autocomplete({
	'source': function (request, response) {
	  $.ajax({
		url: 'index.php?route=blog/neoseo_blog_article/autocompleteProducts&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request) + collectSelectedStores(),
		dataType: 'json',			
		success: function (json) {
		  response($.map(json, function (item) {
			return {
			  label: item['name'],
			  value: item['product_id']
			}
		  }));
		}
	  });
	},
	'select': function (item) {
	  $('input[name=\'related_product\']').val('');

	  $('#products-list' + item['value']).remove();

	  $('#products-list').append('<div id="products-list' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="related_products[]" value="' + item['value'] + '" /></div>');	
	}
});

// Category Products
$('input[name=\'related_category\']').autocomplete({
	source: function (request, response) {
		$.ajax({
			url: 'index.php?route=blog/neoseo_blog_article/autocompleteCategories&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request) + collectSelectedStores(),
			dataType: 'json',
			success: function (json) {
				response($.map(json, function (item) {
					return {
						label: item['name'],
						value: item['category_id']
					}
				}));
			}
		});
	},
	select: function (item) {
	 $.ajax({
			url: 'index.php?route=blog/neoseo_blog_article/autocompleteProducts&token=<?php echo $token; ?>&filter_category_id=' +  encodeURIComponent(item['value']) + collectSelectedStores(),
			dataType: 'json',
			success: function (data) {
			
			  $('input[name=\'related_category\']').val('');
				
				$.each(data, function (index, item) {
				  
			$('#products-list' + item.product_id).remove();

			$('#products-list').append('<div id="products-list' + item.product_id + '"><i class="fa fa-minus-circle"></i> ' + item.name + '<input type="hidden" name="related_products[]" value="' + item.product_id + '" /></div>');	

				});
			}
		});
		
		return false;
	},
});

// Manufacturer Products
$('input[name=\'related_manufacturer\']').autocomplete({
	source: function (request, response) {
		$.ajax({
			url: 'index.php?route=blog/neoseo_blog_article/autocompleteManufacturers&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request) + collectSelectedStores(),
			dataType: 'json',
			success: function (json) {
				response($.map(json, function (item) {
					return {
						label: item['name'],
						value: item['manufacturer_id']
					}
				}));
			}
		});
	},
	select: function (item) {
	 $.ajax({
			url: 'index.php?route=blog/neoseo_blog_article/autocompleteProducts&token=<?php echo $token; ?>&filter_manufacturer_id=' +  encodeURIComponent(item['value']) + collectSelectedStores(),
			dataType: 'json',
			success: function (data) {
			
			  $('input[name=\'related_manufacturer\']').val('');
				
				$.each(data, function (index, item) {
				  
			$('#products-list' + item.product_id).remove();

			$('#products-list').append('<div id="products-list' + item.product_id + '"><i class="fa fa-minus-circle"></i> ' + item.name + '<input type="hidden" name="related_products[]" value="' + item.product_id + '" /></div>');	

				});
			}
		});

		return false;
	},
});
</script>

<script type="text/javascript">
var article_row = <?php echo $article_row; ?>;

function addArticles() {

	html  = '<tbody id="article-row' + article_row + '">';
	html += '	<tr>';
	html += '		<td class="text-left">';
	html += '			<input type="text" name="related_articles[' + article_row + '][name]" value="" id="article-title-' + article_row + '" onkeyup="getArticles(' + article_row + ', this.value);" class="form-control" /> <input type="hidden" name="related_articles[' + article_row + '][related_id]" value="0" />';
	html += '		</td>';			
	html += '		<td class="text-left">';
	html += '			<input type="text" name="related_articles[' + article_row + '][sort_order]" value="" class="form-control" />';
	html += '		</td>';			
	html += '		<td class="text-left">';
	html += '			<select name="related_articles[' + article_row + '][status]" class="form-control">';
	html +='				<option value="1"><?php echo $text_enabled; ?></option>';
	html +='				<option value="0"><?php echo $text_disabled; ?></option>';
	html += '			</select>';
	html += '		</td>';			
	html += '		<td class="text-left"><button type="button" onclick="$(\'#article-row' + article_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '	</tr>';
	html += '</tbody>';

	$('#related-article tfoot').before(html);	

	article_row++;		
}		
</script>

<script type="text/javascript">
function getArticles(article_row, value) {
	$('input[name=\'related_articles[' + article_row + '][name]\']').autocomplete({
	  'source': function (request, response) {
		 $.ajax({
		  url: 'index.php?route=blog/neoseo_blog_article/autocompleteArticles&token=<?php echo $token; ?>&article_id=<?php echo $article_id; ?>&filter_name=' +  encodeURIComponent(request),
		  dataType: 'json',
		  success: function (json) {
			response($.map(json, function (item) {
			  return {
				label: item['name'],
				value: item['article_id']
			  }
			}));
		  }
		});
	  },
	  'select': function (item) {
		$('input[name=\'filter_name\']').val(item['label']);
		$('input[name=\'related_articles[' + article_row + '][name]\']').val(item['label']);
		$('input[name=\'related_articles[' + article_row + '][related_id]\']').val(item['value']);
	  }
	});    
}
</script>


<?php echo $footer; ?>