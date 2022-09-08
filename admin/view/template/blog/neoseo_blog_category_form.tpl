<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if ($category_id ) { ?>
						<a href="<?php echo HTTP_CATALOG; ?>index.php?route=blog/neoseo_blog_category&blog_category_id=<?php echo $category_id; ?>" target="_new" data-toggle="tooltip" title="" class="btn btn-success" data-original-title="Перейти к категории на сайте"><i class="fa fa-eye"></i></a>
				<?php } ?>
				<button type="submit" form="form-blog-category" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-blog-category" class="form-horizontal">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
						<li><a href="#tab-data" data-toggle="tab"><?php echo $tab_data; ?></a></li>
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
											<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_name; ?></label>
											<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
												<input type="text" name="category_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['name'] : ''; ?>" class="form-control" />
												<?php if (isset($error_name[$language['language_id']])) { ?>
													<span class="text-danger"><?php echo $error_name[$language['language_id']]; ?></span>
												<?php } ?>
											</div>
										</div>


										<div class="form-group">
											<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_description; ?></label>
											<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
												<textarea name="category_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['description'] : ''; ?></textarea>
											</div>
										</div>


										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-meta-title<?php echo $language['language_id']; ?>"><?php echo $entry_meta_title; ?></label>
											<div class="col-sm-10">
												<input type="text" name="category_description[<?php echo $language['language_id']; ?>][meta_title]" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_title'] : ''; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta-title<?php echo $language['language_id']; ?>" class="form-control" />
												<?php if (isset($error_meta_title[$language['language_id']])) { ?>
												<div class="text-danger"><?php echo $error_meta_title[$language['language_id']]; ?></div>
												<?php } ?>
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-meta-h1<?php echo $language['language_id']; ?>"><?php echo $entry_meta_h1; ?></label>
											<div class="col-sm-10">
												<input type="text" name="category_description[<?php echo $language['language_id']; ?>][meta_h1]" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_h1'] : ''; ?>" placeholder="<?php echo $entry_meta_h1; ?>" id="input-meta-h1<?php echo $language['language_id']; ?>" class="form-control" />
												<?php if (isset($error_meta_h1[$language['language_id']])) { ?>
												<div class="text-danger"><?php echo $error_meta_h1[$language['language_id']]; ?></div>
												<?php } ?>
											</div>
										</div>

										<div class="form-group">
											<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_meta_description; ?></label>
											<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
												<textarea name="category_description[<?php echo $language['language_id']; ?>][meta_description]" class="form-control"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
											</div>
										</div>

										<div class="form-group">
											<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_meta_keyword; ?></label>
											<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
												<textarea name="category_description[<?php echo $language['language_id']; ?>][meta_keyword]" class="form-control"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
											</div>
										</div>

									</div>
								<?php } ?>
							</div> <!-- end of tab-content id -->


						</div>

						<div class="tab-pane" id="tab-data">

							<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_parent; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">

									<select name="parent_id" class="form-control">
										<option value="0"><?php echo $text_none; ?></option>
										<?php foreach ($categories as $category) { ?>
											<?php if ($category['category_id'] == $parent_id) { ?>
												<option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
											<?php } else { ?>
												<option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
											<?php } ?>
										<?php } ?>
									</select>

								</div>
							</div>

							<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><span data-toggle="tooltip" title="<?php echo $help_seo_url; ?>"><?php echo $entry_seo_url; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<input type="text" name="seo_url" value="<?php echo $seo_url; ?>" class="form-control" />
									<?php if ($error_seo_url) { ?>
										<span class="text-danger"><?php echo $error_seo_url; ?></span>
									<?php } ?>   
								</div>
							</div>

							<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_store; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<div class="well well-sm" style="height: 150px; overflow: auto; margin-bottom:0;">
										<div class="checkbox">
											<label>
												<?php if (in_array(0, $category_store)) { ?>
													<input type="checkbox" name="category_store[]" value="0" checked="checked" />
													<?php echo $text_default; ?>
												<?php } else { ?>
													<input type="checkbox" name="category_store[]" value="0" />
													<?php echo $text_default; ?>
												<?php } ?>
											</label>
										</div>

										<?php foreach ($stores as $store) { ?>
											<div class="checkbox">
												<label>
													<?php if (in_array($store['store_id'], $category_store)) { ?>
														<input type="checkbox" name="category_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
														<?php echo $store['name']; ?>
													<?php } else { ?>
														<input type="checkbox" name="category_store[]" value="<?php echo $store['store_id']; ?>" />
														<?php echo $store['name']; ?>
													<?php } ?>
												</label>
											</div>   
										<?php } ?>                                            
									</div>                                        
									<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>                                      
								</div>
							</div>

							<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_image; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<a href="" id="thumb-image" data-toggle="image" class="img-thumbnail">
										<img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $no_image; ?>" /></a>
									<input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" />   
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
											<select name="category_layout[0]" class="form-control">
												<option value=""></option>
												<?php foreach ($layouts as $layout) { ?>
												<?php if (isset($category_layout[0]) && $category_layout[0] == $layout['layout_id']) { ?>
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
											<select name="category_layout[<?php echo $store['store_id']; ?>]" class="form-control">
												<option value=""></option>
												<?php foreach ($layouts as $layout) { ?>
												<?php if (isset($category_layout[$store['store_id']]) && $category_layout[$store['store_id']] == $layout['layout_id']) { ?>
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
<?php } else { ?>
	$('#description<?php echo $language['language_id']; ?>').summernote({height: 300});
<?php } ?>
<?php } ?>

$('#language a:first').tab('show');
$('#option a:first').tab('show');
</script>

<?php echo $footer; ?>