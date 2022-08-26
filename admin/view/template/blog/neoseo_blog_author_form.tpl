<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if ($author_id ) { ?>
						<a href="<?php echo HTTP_CATALOG; ?>index.php?route=blog/neoseo_blog_author&author_id=<?php echo $author_id; ?>" target="_new" data-toggle="tooltip" title="" class="btn btn-success" data-original-title="Перейти к автору на сайте"><i class="fa fa-eye"></i></a>
				<?php } ?>
				<button type="submit" form="form-blog-author" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-blog-author" class="form-horizontal">

					<div class="form-group required">
						<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><span data-toggle="tooltip" title="<?php echo $help_name; ?>"><?php echo $entry_name; ?></label>
						<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
							<input type="text" name="name" value="<?php echo $name; ?>" class="form-control" />
							<?php if ($error_name) { ?>
								<span class="text-danger"><?php echo $error_name; ?></span>
							<?php } ?>    
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
						<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_image; ?></label>
						<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
							<a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $no_image; ?>" /></a>
							<input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" />
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

					<ul class="nav nav-tabs" id="language">
<?php foreach ($languages as $language) { ?>
							<li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
						<?php } ?>
					</ul>

					<div class="tab-content">
			<?php foreach ($languages as $language) { ?>
							<div class="tab-pane" id="language<?php echo $language['language_id']; ?>">

								<div class="form-group">
									<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_teaser; ?></label>
									<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
										<textarea name="category_description[<?php echo $language['language_id']; ?>][teaser]" id="teaser<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($category_description[$language['language_id']]['teaser']) ? $category_description[$language['language_id']]['teaser'] : ''; ?></textarea>
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_description; ?></label>
									<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
										<textarea name="author_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($author_description[$language['language_id']]) ? $author_description[$language['language_id']]['description'] : ''; ?></textarea>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="input-meta-title<?php echo $language['language_id']; ?>"><?php echo $entry_meta_title; ?></label>
									<div class="col-sm-10">
										<input type="text" name="author_description[<?php echo $language['language_id']; ?>][meta_title]" value="<?php echo isset($author_description[$language['language_id']]) ? $author_description[$language['language_id']]['meta_title'] : ''; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta-title<?php echo $language['language_id']; ?>" class="form-control" />
										<?php if (isset($error_meta_title[$language['language_id']])) { ?>
										<div class="text-danger"><?php echo $error_meta_title[$language['language_id']]; ?></div>
										<?php } ?>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="input-meta-h1<?php echo $language['language_id']; ?>"><?php echo $entry_meta_h1; ?></label>
									<div class="col-sm-10">
										<input type="text" name="author_description[<?php echo $language['language_id']; ?>][meta_h1]" value="<?php echo isset($author_description[$language['language_id']]) ? $author_description[$language['language_id']]['meta_h1'] : ''; ?>" placeholder="<?php echo $entry_meta_h1; ?>" id="input-meta-h1<?php echo $language['language_id']; ?>" class="form-control" />
										<?php if (isset($error_meta_h1[$language['language_id']])) { ?>
										<div class="text-danger"><?php echo $error_meta_h1[$language['language_id']]; ?></div>
										<?php } ?>
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_meta_description; ?></label>
									<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
										<textarea name="author_description[<?php echo $language['language_id']; ?>][meta_description]" class="form-control"><?php echo isset($author_description[$language['language_id']]) ? $author_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_meta_keyword; ?></label>
									<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
										<textarea name="author_description[<?php echo $language['language_id']; ?>][meta_keyword]" class="form-control"><?php echo isset($author_description[$language['language_id']]) ? $author_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
									</div>
								</div>

							</div>
			<?php } ?>
					</div> <!-- end of tab-content class -->

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

<?php echo $footer; ?>