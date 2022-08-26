<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<a href="<?php echo $return; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default">
					<i class="fa fa-reply"></i>
				</a>
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
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if ($success) { ?>
		<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><?php echo $heading_title; ?></h3>
				<table class="table-condensed">
					<?php if($cart['name']) { ?><tr>
						<td><?php echo $entry_name; ?>:</td>
						<td><?php echo $cart['name'];?></td>
					</tr><?php } ?>
					<tr>
						<td><?php echo $entry_email; ?>:</td>
						<td><a href="<?php echo $email_send_restore;?>"><i class="fa fa-envelope"></i> <?php echo $cart['email'];?></a></td>
					</tr><?php if($cart['phone']) { ?>
					<tr>
						<td><?php echo $entry_phone; ?>:</td>
						<td><?php echo $cart['phone'];?></td>
					</tr><?php } ?>
					<tr>
						<td><?php echo $entry_modified; ?>:</td>
						<td><?php echo $cart['modified'];?></td>
					</tr>
					<tr>
						<td><?php echo $entry_total; ?>:</td>
						<td><?php echo $cart['total'];?></td>
					</tr>
				</table>
				<div>
					<a href="<?php echo $button_send_notification_url;?>" class="btn btn-primary" data-ajax="true"><?php echo $button_send_notification;?></a>
				</div>
			</div>
			<div class="panel-body">
				<table class="table table-bordered">
					<thead>
					<tr>
						<td><?php echo $column_name; ?></td>
						<td><?php echo $column_options; ?></td>
						<td><?php echo $column_quantity; ?></td>
						<td><?php echo $column_price; ?></td>
						<td><?php echo $column_subtotal; ?></td>
					</tr>
					</thead>
					<tbody><?php foreach($products as $product) { ?>
					<tr>
						<td><a href="<?php echo $product['view'];?>" target="_blank"><?php echo $product['name'];?></a></td>
						<td><?php echo $product['options'];?></td>
						<td><?php echo $product['quantity'];?></td>
						<td><?php echo $product['price'];?></td>
						<td><?php echo $product['subtotal'];?></td>
					</tr><?php } ?>
					<tr>
						<td colspan="3"></td>
						<td><?php echo $entry_total; ?></td>
						<td><?php echo $cart['total'];?></td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function (e) {
		$('a[data-ajax=true]').bind('click', function (e) {
			e.preventDefault();
			var el = $(this);
			el.prepend($('<i class="fa fa-refresh fa-spin fa-fw"></i> &nbsp;'));
			$.ajax({
				url: $(this).attr('href'),
				dataType: 'json',
				success: function (data) {
					if(!$('.container-fluid .alert')[0]) $('.container-fluid .panel-body').parents('.container-fluid').prepend($('<div class="alert"></div>'));
					var container = $('.container-fluid .alert');
					container.empty();
					if(data.result == 'success') {
						container.attr('class', 'alert alert-success').append($('<i class="fa fa-check-circle"></i>'));
					} else {
						container.attr('class', 'alert alert-danger').append($('<i class="fa fa-exclamation-circle"></i>'));
					}
					if(data.messages) {
						for(var k in data.messages) {
							container.append(' '+$(data.messages[k]+'<br />'))
						}
					}
					if(data.message) container.append(' '+data.message);
					container.delay(4000).slideUp(200, function() {
						$(this).remove();
					});
					el.find('i').remove();
				},
				error: function (response) {
					if(!$('.container-fluid .alert')[0]) $('.container-fluid .panel-body').parents('.container-fluid').prepend($('<div class="alert"></div>'));
					var container = $('.container-fluid .alert');
					container.attr('class', 'alert alert-danger')
						.empty()
						.append($('<i class="fa fa-exclamation-circle"></i>'))
						.append(' '+$(response.responseText));
					container.delay(4000).slideUp(200, function() {
						$(this).remove();
					});
					el.find('i').remove();
				}
			});
		})
	});
</script>
<?php echo $footer; ?>