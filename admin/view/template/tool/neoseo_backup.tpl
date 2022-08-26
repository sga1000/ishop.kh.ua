<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<a href="<?php echo $backup; ?>" data-toggle="tooltip" title="<?php echo $button_backup; ?>" class="btn btn-primary"><i class="fa fa-plus"></i> <?php echo $button_backup; ?></a>
				<a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if ($success) { ?>
		<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-body">
				<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-user">
					<div class="table-responsive">
						<table class="table table-bordered table-hover">
							<thead>
							<tr>
								<td class="text-left"><?php echo $column_id; ?></td>
								<td class="text-left"><?php echo $column_name; ?></td>
								<td class="text-right"><?php echo $column_action; ?></td>
							</tr>
							</thead>
							<tbody>
							<?php if ($backups) { ?>
							<?php foreach ($backups as $backup) { ?>
							<tr>
								<td class="text-left"><?php echo $backup['id']; ?></td>
								<td class="text-left"><?php echo $backup['name']; ?> | <?php echo $backup['filename']; ?></td>
								<td class="text-right">
									<a href="<?php echo $download.'&filename='.$backup['filename']; ?>" data-toggle="tooltip" target="_blank" title="<?php echo $button_download; ?>" class="btn btn-primary"><i class="fa fa-download"></i></a>
									<a href="<?php echo $restore.'&filename='.$backup['filename']; ?>" data-toggle="tooltip" title="<?php echo $button_restore; ?>" class="btn btn-primary backup-restore"><i class="fa fa-cog"></i></a>
									<a href="<?php echo $delete.'&filename='.$backup['filename']; ?>" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-primary backup-delete"><i class="fa fa-trash"></i></a>
								</td>
							</tr>
							<?php } ?>
							<?php } else { ?>
							<tr>
								<td class="text-center" colspan="3"><?php echo $text_no_results; ?></td>
							</tr>
							<?php } ?>
							</tbody>
						</table>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		$('a.backup-restore').click(function() {
			if (!confirm("<?php echo $text_confirm_restore; ?>")) {
				return false;
			}
		});
		$('a.backup-delete').click(function() {
			if (!confirm("<?php echo $text_confirm_delete; ?>")) {
				return false;
			}
		});
	});
</script>
<?php echo $footer; ?>