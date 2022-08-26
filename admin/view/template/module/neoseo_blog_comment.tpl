<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-blog_article" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary">
					<i class="fa fa-save"></i></button>
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
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-blog_article" class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
						<div class="col-sm-10">
							<input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control"/>
							<?php if ($error_name) { ?>
							<div class="text-danger"><?php echo $error_name; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-title"><?php echo $entry_title; ?></label>
						<div class="col-sm-10">
							<?php foreach ($languages as $language) { ?>
							<div class="input-group">
									<span class="input-group-btn">
										<button class="btn btn-default" id="test" type="button" data-toggle="tooltip" title="" data-original-title="<?php echo $button_clear;?>" onclick="$('#input-title<?php echo $language['language_id']; ?>').val('');">
											<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"/>
										</button>
									</span>
								<input type="text" name="title[<?php echo $language['language_id']; ?>]" value="<?php echo $title[$language['language_id']]; ?>" placeholder="<?php echo $entry_title; ?>" id="input-title<?php echo $language['language_id']; ?>" class="form-control"/>
							</div>
							<?php if (count($languages) > 1) { ?>
							<br/>
							<?php } ?>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-category"><?php echo $entry_type; ?></label>
						<div class="col-sm-10">
							<select name="type" class="form-control">
								<option value=""><?php echo $text_select; ?></option>
								<option value="latest"
								<?php echo $type == 'latest' ? "selected='selected'" : ""; ?>>
								<?php echo $text_latest; ?>
								</option>
								<option value="popular"
								<?php echo $type == 'popular' ? "selected='selected'" : ""; ?>>
								<?php echo $text_popular; ?>
								</option>
							</select>
						</div>
					</div>
					<div class="form-group" id="category">
						<label class="col-sm-2 control-label" for="input-category"><?php echo $entry_category; ?></label>
						<div class="col-sm-10">
							<select name="blog_category_id" class="form-control">
								<option value=""><?php echo $text_select; ?></option>
								<?php foreach ($categories as $category) { ?>
								<option value="<?php echo $category['category_id']; ?>" <?php echo $category['category_id'] == $blog_category_id ? "selected='selected'" : ""; ?>><?php echo $category['name']; ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group" id="root_category">
						<label class="col-sm-2 control-label" for="input-category"><?php echo $entry_root_category; ?></label>
						<div class="col-sm-10">
							<select name="root_category_id" class="form-control">
								<option value=""><?php echo $text_select; ?></option>
								<?php foreach ($categories as $category) { ?>
								<option value="<?php echo $category['category_id']; ?>"<?php echo $category['category_id'] == $root_category_id ? "selected='selected'" : ""; ?>><?php echo $category['name']; ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-template"><?php echo $entry_template; ?></label>
						<div class="col-sm-10">
							<select name="template" class="form-control">
								<?php foreach ($templates as $_template) { ?>
								<option value="<?php echo $_template; ?>" <?php if ($template == $_template ) {?>selected="selected"<?php } ?>><?php echo $_template; ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-limit"><?php echo $entry_limit; ?></label>
						<div class="col-sm-10">
							<input type="text" name="limit" value="<?php echo $limit; ?>" placeholder="<?php echo $entry_limit; ?>" id="input-limit" class="form-control"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-width"><?php echo $entry_width; ?></label>
						<div class="col-sm-10">
							<input type="text" name="width" value="<?php echo $width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-width" class="form-control"/>
							<?php if ($error_width) { ?>
							<div class="text-danger"><?php echo $error_width; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-height"><?php echo $entry_height; ?></label>
						<div class="col-sm-10">
							<input type="text" name="height" value="<?php echo $height; ?>" placeholder="<?php echo $entry_height; ?>" id="input-height" class="form-control"/>
							<?php if ($error_height) { ?>
							<div class="text-danger"><?php echo $error_height; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
						<div class="col-sm-10">
							<select name="status" id="input-status" class="form-control">
								<?php if ($status) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript"><!--
		$('input[name=\'product\']').autocomplete({
			source: function (request, response) {
				$.ajax({
					url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
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
			select: function (item) {
				$('input[name=\'product\']').val('');

				$('#blog_article-product' + item['value']).remove();

				$('#blog_article-product').append('<div id="blog_article-product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product[]" value="' + item['value'] + '" /></div>');
			}
		});

		$('#blog_article-product').delegate('.fa-minus-circle', 'click', function () {
			$(this).parent().remove();
		});
		//--></script>
</div>
<?php echo $footer; ?>