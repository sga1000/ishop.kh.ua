<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-attribute" data-toggle="tooltip" title="<?php echo $button_save; ?>"
					class="btn btn-primary"><i class="fa fa-save"></i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>"
				   class="btn btn-default"><i class="fa fa-reply"></i></a></div>
			<img width="36" height="36" style="float:left;margin-right: 10px;" src="view/image/neoseo.png" alt="">
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
						<label class="col-sm-4"><?php echo $entry_name; ?></label>
						<div class="col-sm-8">
							<input name="note[title]" class="form-control" value="<?php echo $note['title'];?>">
							<?php if($error_title) { ?>
							<div class="text-danger"><?php echo $error_title; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4"><?php echo $entry_color; ?></label>
						<div class="col-sm-8">
							<div class="input-group colorpicker-component colorpicker-element">
								<input name="note[color]" id="neoseo_notes_widget_color" value="<?php echo $note['color'];?>" class="form-control">
								<span class="input-group-addon"><i style="background-color: rgb(255, 255, 255);"></i></span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4"><?php echo $entry_font_color; ?></label>
						<div class="col-sm-8">
							<div class="input-group colorpicker-component colorpicker-element">
								<input name="note[font_color]" id="neoseo_notes_widget_color" value="<?php echo $note['font_color'];?>" class="form-control">
								<span class="input-group-addon"><i style="background-color: rgb(255, 255, 255);"></i></span>
							</div>
						</div>
					</div>
					<div class="form-group required">
						<label class="col-sm-4"><?php echo $entry_text; ?></label>
						<div class="col-sm-8">
							<textarea id="sql_code_before" rows="3" style="width:100%" name="note[text]" class="form-control"><?php echo $note['text']; ?></textarea>
							<?php if($error_text) { ?>
							<div class="text-danger"><?php echo $error_text; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4"><?php echo $entry_show_dashboard; ?></label>
						<div class="col-sm-8">
							<select name="note[show_dashboard]" class="form-control">
								<option value="0"
									<?php if( !$note['show_dashboard'] ) echo 'selected="selected"';?>><?php echo $text_disabled; ?></option>
								<option value="1" <?php if( $note['show_dashboard'] ) echo 'selected="selected"';?>><?php echo $text_enabled; ?></option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4"><?php echo $entry_sort_order; ?></label>
						<div class="col-sm-8">
							<input name="note[sort_order]" class="form-control" value="<?php echo $note['sort_order'];?>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4"><?php echo $entry_use_notification; ?></label>
						<div class="col-sm-8">
							<select id="use_notification" name="note[use_notification]" class="form-control">
								<option value="0"
									<?php if( !$note['use_notification'] ) echo 'selected="selected"';?>><?php echo $text_disabled; ?></option>
								<option value="1" <?php if( $note['use_notification'] ) echo 'selected="selected"';?>><?php echo $text_enabled; ?></option>
							</select>
						</div>
					</div>
					<div class="form-group notification">
						<label class="col-sm-4"><?php echo $entry_date_notification; ?></label>
						<div class="col-sm-8">
							<div class="input-group date">
								<input type="text" name="note[date_notification]" <?php if (isset($note['note_id'])) { ?>value="<?php echo $note['date_notification'] ?>"<?php } ?> placeholder="<?php echo $entry_date_notification; ?>" data-date-format="YYYY-MM-DD HH:mm:ss" id="input-date-available" class="form-control" />
								<span class="input-group-btn">
									<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
								</span></div>
						</div>
					</div>
					<div class="form-group notification">
						<span class="col-sm-4">
							<label class="control-label"><?php echo $entry_text_notification; ?></label>
							<br><?php echo $entry_text_notification_desc; ?>
						</span>
						<div class="col-sm-8">
							<input name="note[text_notification]" class="form-control" value="<?php echo $note['text_notification'];?>">
						</div>
					</div>

					<input type="hidden" name="<?php echo isset($note['note_id'])? 'note[note_id]': '';?>" value="<?php echo isset($note['note_id'])?$note['note_id']: '';?>"/>
					<input type="hidden" name="<?php echo isset($note['notification'])? 'note[notification]': 0;?>" value="<?php echo isset($note['notification'])?$note['notification']: '';?>"/>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function () {
		$(".colorpicker-component").colorpicker();
		showNotification($('#use_notification').val());
	});

	$('.date').datetimepicker({
		// pickTime: true,
		defaultDate: new Date()
	});

	$('#use_notification').change(function () {
		showNotification($(this).val());
	});

	function showNotification(value) {
		if (value == 0) {
			$('.notification').hide();
		} else {
			$('.notification').show();
		}
	}
</script>
<?php echo $footer; ?>
