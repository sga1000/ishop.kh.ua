<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="button" data-toggle="tooltip" title="<?php echo $button_notify; ?>" class="btn btn-success" data-url="<?php echo $notify_url;?>" data-ajax="false"><i class="fa fa-envelope-o"></i></button>
                <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" data-confirm="<?php echo $text_confirm; ?>" data-url="<?php echo $delete_url;?>"><i class="fa fa-trash-o"></i></button>
            </div>
            <img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
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
            <div class="panel-body">
                <div class="well">
	                <div class="row">
		                <div class="col-sm-4">
			                <div class="form-group">
				                <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
				                <input type="text" name="filter_email" value="<?php echo $filter_email; ?>"
				                       placeholder="<?php echo $entry_email; ?>" id="input-email"
				                       class="form-control"/>
			                </div>
		                </div>
		                <div class="col-sm-4">
			                <div class="form-group">
				                <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
				                <input type="text" name="filter_name" value="<?php echo $filter_name; ?>"
				                       placeholder="<?php echo $entry_name; ?>" id="input-name"
				                       class="form-control"/>
			                </div>
		                </div>
		                <div class="col-sm-4">
			                <div class="form-group">
				                <label class="control-label"
				                       for="input-modified"><?php echo $entry_modified; ?></label>
				                <div class="input-group date">
					                <input type="text" name="filter_modified"
					                       value="<?php echo $filter_modified; ?>"
					                       placeholder="<?php echo $entry_modified; ?>" data-date-format="YYYY-MM-DD"
					                       id="input-modified" class="form-control"/>
					                <span class="input-group-btn">
						                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
					                </span>
				                </div>
			                </div>
			                <button type="button" id="button-filter" class="btn btn-primary pull-right"><i
						                class="fa fa-search"></i> <?php echo $button_filter; ?></button>
		                </div>
	                </div>
                </div>
	            <form action="<?php echo $delete_url; ?>" method="post" enctype="multipart/form-data" id="form-cart">
		            <div class="table-responsive">
			            <table class="table table-bordered table-hover">
				            <thead>
				            <tr>
					            <td style="width: 1px;" class="text-center"><input type="checkbox"
					                                                               onclick="$('input[name*=\'selected\']').prop('checked', this.checked);"/>
					            </td>
					            <td class="text-left">
						            <a href="<?php echo $sort_email; ?>" class="<?php echo ($sort == 'email' ? strtolower($order) : ''); ?>"><?php echo $column_email; ?></a>
					            </td>
					            <td class="text-left">
						            <a href="<?php echo $sort_name; ?>" class="<?php echo ($sort == 'name' ? strtolower($order) : ''); ?>"><?php echo $column_name; ?></a>
					            </td>
					            <td class="text-left">
						            <a href="<?php echo $sort_phone; ?>" class="<?php echo ($sort == 'phone' ? strtolower($order) : ''); ?>"><?php echo $column_phone; ?></a>
					            </td>
					            <td class="text-left">
						            <a href="<?php echo $sort_notification_count; ?>" class="<?php echo ($sort == 'notification_count' ? strtolower($order) : ''); ?>"><?php echo $column_notification_count; ?></a>
					            </td>
					            <td class="text-left">
						            <a href="<?php echo $sort_modified; ?>" class="<?php echo ($sort == 'modified' ? strtolower($order) : ''); ?>"><?php echo $column_modified; ?></a>
					            </td>
					            <td class="text-left">
						            <a href="<?php echo $sort_total; ?>" class="<?php echo ($sort == 'total' ? strtolower($order) : ''); ?>"><?php echo $column_total; ?></a>
					            </td>
                                <td class="text-right"><?php echo $column_action; ?></td>
				            </tr>
				            </thead>
				            <tbody>
				            <?php if ($carts) { ?>
				            <?php foreach ($carts as $cart) { ?>
				            <tr data-id="<?php echo $cart['dropped_cart_id'];?>">
					            <td class="text-center"><?php if (in_array($cart['dropped_cart_id'], $selected)) { ?>
						            <input type="checkbox" name="selected[]" value="<?php echo $cart['dropped_cart_id']; ?>"
						                   checked="checked"/>
						            <?php } else { ?>
						            <input type="checkbox" name="selected[]" value="<?php echo $cart['dropped_cart_id']; ?>"/>
						            <?php } ?>
					            <td class="text-left"><?php echo $cart['email']; ?></td>
					            <td class="text-right"><?php echo $cart['name']; ?></td>
					            <td class="text-left"><?php echo $cart['phone']; ?></td>
					            <td class="text-left notification"><span class="label label-<?php echo ($cart['notification_count']>0?'success':'danger');?>"><?php echo $cart['notification_count']; ?></span></td>
					            <td class="text-left"><?php echo $cart['modified']; ?></td>
					            <td class="text-right"><?php echo (float)$cart['total']; ?></td>
					            <td class="text-right">
						            <a href="<?php echo $cart['notify']; ?>" data-toggle="tooltip" title="<?php echo $button_notify; ?>" class="btn btn-info" data-type="notification">
							            <i class="fa fa-envelope-o"></i>
						            </a>
						            <a href="<?php echo $cart['view']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info">
							            <i class="fa fa-eye"></i>
						            </a>
						            <a type="button" href="<?php echo $cart['delete'];?>" onclick="return confirm('<?php echo $text_confirm; ?>');" id="button-delete<?php echo $cart['dropped_cart_id']; ?>"
						                    data-loading-text="<?php echo $text_loading; ?>" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger">
							            <i class="fa fa-trash-o"></i>
						            </a>
					            </td>
				            </tr>
				            <?php } ?>
				            <?php } else { ?>
				            <tr>
					            <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
				            </tr>
				            <?php } ?>
				            </tbody>
			            </table>
		            </div>
	            </form>
	            <div class="row">
		            <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
		            <div class="col-sm-6 text-right"><?php echo $results; ?></div>
	            </div>
            </div>
		</div>
    </div>
</div>
<script src="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<link href="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" media="screen" />
<script type="text/javascript"><!--
	$(document).ready(function (e) {
		$('#button-filter').on('click', function() {
			var url = 'index.php?route=sale/neoseo_dropped_cart&token=<?php echo $token; ?>';

			$('.panel-body .well input').each(function(e) {
				if($(this).val())
					url += '&'+$(this).attr('name')+'='+encodeURIComponent($(this).val());
			});

			location = url;
		});
		$('.date').datetimepicker({
			pickTime: false
		});
		$('.page-header .container-fluid button.btn').bind('click', function (e) {
			if(!$(this).data('confirm') || confirm($(this).data('confirm'))) {
				if((!$(this).data('ajax') || $(this).data('ajax')!=true) && $('#form-cart input[name="selected[]"]:checked')[0]) {
					$('#form-cart').attr('action', $(this).data('url')).submit();
				} else if($(this).data('ajax')) {

				}
			}
		});
		$('a[data-type=notification]').bind('click', function (e) {
			e.preventDefault();
			var el = $(this);
			el.prepend($('<i class="fa fa-refresh fa-spin fa-fw"></i> &nbsp;'));
			$.ajax({
				url: $(this).attr('href'),
				dataType:'json',
				success: function (data) {
					if(!$('.container-fluid .alert')[0]) $('.container-fluid .panel-body').parents('.container-fluid').prepend($('<div class="alert"></div>'));
					var container = $('.container-fluid .alert');
					container.empty();
					if(data.result == 'success') {
						container.attr('class', 'alert alert-success').append($('<i class="fa fa-check-circle"></i>'));
					} else {
						container.attr('class', 'alert alert-danger').append($('<i class="fa fa-exclamation-circle"></i>'));
					}
					var form = $('#form-cart');
					if(data.carts) {
						for(k in data.carts) {
							var span = form.find('table tr[data-id='+data.carts[k]['id']+'] td.notification span');
							span.empty().append(data.carts[k]['notified']);
							if(data.carts[k]['notified']>0) span.attr('class','label label-success');
							else span.attr('class','label label-danger');
						}
					}
					if(data.messages) {
						for(var k in data.messages) {
							container.append($(data.messages[k]+'<br />'))
						}
					}
					if(data.message) container.append(' '+data.message);
					container.delay(4000).slideUp(200, function() {
						$(this).remove();
					});
					el.find('i.fa-refresh').remove();
				}
			});
		})
	});
//--></script>
<?php echo $footer; ?>