<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-attribute" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
			<h1><?php echo $heading_title_raw; ?></h1>
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
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-attribute" class="form-horizontal">
					<div class="form-group required">
						<label class="col-sm-2 control-label"><?php echo $entry_name; ?></label>
						<div class="col-sm-10">
							<input class="form-control" type="text" name="name" value="<?php echo isset($name) ? $name : ''; ?>" placeholder="<?php echo $entry_name; ?>" />
							<?php if($error_name) { ?>
							<div class="text-danger"><?php echo $error_name; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group required">
						<label class="col-sm-2 control-label"><?php echo $entry_code_1c; ?></label>
						<div class="col-sm-10">
							<input class="form-control" type="text" name="code_1c" value="<?php echo isset($code_1c) ? $code_1c : ''; ?>" placeholder="<?php echo $entry_code_1c; ?>" />
							<?php if($error_code_1c) { ?>
							<div class="text-danger"><?php echo $error_code_1c; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group required">
						<label class="col-sm-2 control-label"><?php echo $entry_sort_order; ?></label>
						<div class="col-sm-10">
							<input class="form-control" type="text" name="sort_order" value="<?php echo isset($sort_order) ? $sort_order : ''; ?>" placeholder="<?php echo $entry_sort_order; ?>" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label"><?php echo $entry_store; ?></label>
						<div class="col-sm-10">
							<div class="well well-sm" style="height: 150px; overflow: auto;">
								<div class="checkbox">
									<label>
										<?php if (in_array(0, $warehouse_store)) { ?>
										<input type="checkbox" name="warehouse_store[]" value="0" checked="checked" />
										<?php echo $text_default; ?>
										<?php } else { ?>
										<input type="checkbox" name="warehouse_store[]" value="0" />
										<?php echo $text_default; ?>
										<?php } ?>
									</label>
								</div>
								<?php foreach ($stores as $store) { ?>
								<div class="checkbox">
									<label>
										<?php if (in_array($store['store_id'], $warehouse_store)) { ?>
										<input type="checkbox" name="warehouse_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
										<?php echo $store['name']; ?>
										<?php } else { ?>
										<input type="checkbox" name="warehouse_store[]" value="<?php echo $store['store_id']; ?>" />
										<?php echo $store['name']; ?>
										<?php } ?>
									</label>
								</div>
								<?php } ?>
							</div>
						</div>
					</div>
					<ul class="nav nav-tabs" id="language">
						<?php $i=0; foreach ($languages as $language) { ?>
						<li <?php if( $i++ == 0 ) { ?>class="active"<?php } ?>><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
						<?php } ?>
					</ul>
					<div class="tab-content">
						<?php $i=0; foreach ($languages as $language) { ?>

						<div class="tab-pane<?php if( $i++ == 0 ) { ?> active<?php } ?>" id="language<?php echo $language['language_id']; ?>">
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-param1<?php echo $language['language_id']; ?>"><?php echo $entry_param1; ?></label>
								<div class="col-sm-10">
									<textarea id="input-param1<?php echo $language['language_id']; ?>" class="form-control" placeholder="<?php echo $entry_param1; ?>" name="warehouse_description[<?php echo $language['language_id']; ?>][param1]"><?php echo isset($warehouse_description[$language['language_id']]) ? $warehouse_description[$language['language_id']]['param1'] : ''; ?></textarea>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-param2<?php echo $language['language_id']; ?>"><?php echo $entry_param2; ?></label>
								<div class="col-sm-10">
									<textarea id="input-param2<?php echo $language['language_id']; ?>" class="form-control" placeholder="<?php echo $entry_param2; ?>" name="warehouse_description[<?php echo $language['language_id']; ?>][param2]"><?php echo isset($warehouse_description[$language['language_id']]) ? $warehouse_description[$language['language_id']]['param2'] : ''; ?></textarea>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-param3<?php echo $language['language_id']; ?>"><?php echo $entry_param3; ?></label>
								<div class="col-sm-10">
									<textarea id="input-param3<?php echo $language['language_id']; ?>" class="form-control" placeholder="<?php echo $entry_param3; ?>" name="warehouse_description[<?php echo $language['language_id']; ?>][param3]"><?php echo isset($warehouse_description[$language['language_id']]) ? $warehouse_description[$language['language_id']]['param3'] : ''; ?></textarea>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-param4<?php echo $language['language_id']; ?>"><?php echo $entry_param4; ?></label>
								<div class="col-sm-10">
									<textarea id="input-param4<?php echo $language['language_id']; ?>" class="form-control" placeholder="<?php echo $entry_param4; ?>" name="warehouse_description[<?php echo $language['language_id']; ?>][param4]"><?php echo isset($warehouse_description[$language['language_id']]) ? $warehouse_description[$language['language_id']]['param4'] : ''; ?></textarea>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-param5<?php echo $language['language_id']; ?>"><?php echo $entry_param5; ?></label>
								<div class="col-sm-10">
									<textarea id="input-param5<?php echo $language['language_id']; ?>" class="form-control" placeholder="<?php echo $entry_param5; ?>" name="warehouse_description[<?php echo $language['language_id']; ?>][param5]"><?php echo isset($warehouse_description[$language['language_id']]) ? $warehouse_description[$language['language_id']]['param5'] : ''; ?></textarea>
								</div>
							</div>
						</div>
						<?php } ?>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<?php echo $footer; ?>
