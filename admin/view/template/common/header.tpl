<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $code; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<script type="text/javascript" src="view/javascript/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="view/javascript/bootstrap/js/bootstrap.min.js"></script>
<link href="view/stylesheet/bootstrap.css" type="text/css" rel="stylesheet" />
<link href="view/javascript/bootstrap/css/bootstrap-toggle.min.css" type="text/css" rel="stylesheet" />

<link href="view/javascript/font-awesome/css/font-awesome.min.css" type="text/css" rel="stylesheet" />
<link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
<script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
<script src="view/javascript/summernote/lang/summernote-<?php echo $lang; ?>.js"></script>
<script src="view/javascript/jquery/datetimepicker/moment.js" type="text/javascript"></script>
<script src="view/javascript/jquery/datetimepicker/locale/<?php echo $code; ?>.js" type="text/javascript"></script>
<script src="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="view/javascript/bootstrap/js/bootstrap-toggle.min.js" type="text/javascript"></script>

<link href="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" media="screen" />
<link type="text/css" href="view/stylesheet/stylesheet.css" rel="stylesheet" media="screen" />
<?php foreach ($styles as $style) { ?>
<link type="text/css" href="<?php echo $style['href']; ?>" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<script src="view/javascript/common.js" type="text/javascript"></script>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
</head>
<body>
<div id="container">
<header id="header" class="navbar navbar-static-top">
  <div class="navbar-header">
    <?php if ($logged) { ?>
    <a type="button" id="button-menu" class="pull-left"><img src="view/image/icon-burger.png" alt=""></a>
    <?php } ?>
    <?php if ($logged) { ?>
        <?php echo $profile; ?>
    <?php }else{ ?>
      <a href="<?php echo $home; ?>" class="navbar-brand"><img style="max-width: 108px;" src="view/image/ishop_logo.png" alt="123<?php echo $heading_title; ?>" title="456<?php echo $heading_title; ?>" /></a>
    <?php } ?>
  </div>
  <?php if ($logged) { ?>


<script type="text/javascript"><!--
$(document).ready(function() {
	$('.clear-dropdown li').on('click', function(e) {
		e.stopPropagation();
	});
});

function getToken() {
	var vars = {};
	var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
		vars[key] = value;
	});
	return vars['token'];
}

function clearCache(key) {

	$.ajax({
		url: 'index.php?route=tool/neoseo_clear_cache&token=' + getToken(),
		type: 'post',
		data: 'key=' + key,
		dataType: 'json',
		beforeSend: function() {
			$('#button-cache-' + key).button('loading');
			$('.clear-dropdown').prev('a').children('span').html('<i class=\'fa fa-spinner\'></i>');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		},
		success: function(json) {
			$('.clear-dropdown > .alert-success, .clear-dropdown > .alert-danger').remove();

			if (json['success']) {
				$('#button-cache-' + key).closest('li').addClass('bg-success');
				$('.clear-dropdown').append('<div class="alert alert-success" style="margin: 15px 20px 15px 20px; padding: 5px; font-size: 11px;"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				$('.clear-dropdown').prev('a').children('span').html(json['size']);
			}

			if (json['error']) {
				$('#button-cache-' + key).closest('li').addClass('bg-danger');
				$('.clear-dropdown').append('<div class="alert alert-danger" style="margin: 15px 20px 15px 20px; padding: 5px; font-size: 11px;"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			}
		},
		complete: function() {
			$('#button-cache-' + key).button('reset');
		}
	});
}
    <?php if($is_demo_data_removed != 1) { ?>

function rddYes()
{
    if(!confirm('<?php echo $confirm_delete; ?>')) return;
    $('.rdd').hide();
    $.get('<?php echo $demo_delete_demo_link; ?>', function( data ) {
        location.reload();
    });
}

function rddNo() {
    $('.rdd').click();
}

function rddMute() {
    $('.rdd').hide();
    $.get('<?php echo $demo_mute_demo_link; ?>');
}
<?php } ?>
//--></script>
			
  <ul class="nav pull-right">
<?php if($is_demo_data_removed != 1 ) { ?>
    <li class="dropdown rdd"><a class="dropdown-toggle" data-toggle="dropdown"><?php echo $button_delete_demo_data; ?></a>
      <ul class="dropdown-menu dropdown-menu-right clear-dropdown">
        <li class="dropdown-header"><?php echo $text_demo_data_delete; ?></li>
          <li>
              <button onclick="rddYes()" type="button" data-loading-text="<i class='fa fa-spinner'></i>" class="btn btn-danger btn-xs" id="button-cache-system">
                  <?php echo $text_yes; ?>
                  <i class="fa fa-recycle"></i>
              </button>
              <button onclick="rddNo()" type="button" data-loading-text="<i class='fa fa-spinner'></i>" class="btn btn-danger btn-xs" id="button-cache-image">
                  <?php echo $text_no; ?>
                  <i class="fa fa-remove"></i>
              </button>
              <button onclick="rddMute()" type="button" data-loading-text="<i class='fa fa-spinner'></i>" class="btn btn-danger btn-xs" id="button-cache-image">
                  <?php echo $text_mute; ?>
                  <i class="fa fa-power-off"></i>
              </button>

          </li>
      </ul>
    </li>
<?php } ?>
	<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><img src="view/image/icon-clear.png" alt=""></a>
	  <ul class="dropdown-menu dropdown-menu-right clear-dropdown">
		<li class="dropdown-header"><?php echo $text_cache; ?></li>
		<li><a><?php echo $text_cache_system; ?><button onclick="clearCache('system');" type="button" data-loading-text="<i class='fa fa-spinner'></i>" data-toggle="tooltip" title="<?php echo $text_clear; ?>" class="btn btn-danger btn-xs pull-right" id="button-cache-system"><i class="fa fa-trash-o"></i></button></a></li>
		<li><a><?php echo $text_cache_image; ?><button onclick="clearCache('image');" type="button" data-loading-text="<i class='fa fa-spinner'></i>" data-toggle="tooltip" title="<?php echo $text_clear; ?>" class="btn btn-danger btn-xs pull-right" id="button-cache-image"><i class="fa fa-trash-o"></i></button></a></li>
		<li><a><?php echo $text_cache_filter; ?><button onclick="clearCache('filter');" type="button" data-loading-text="<i class='fa fa-spinner'></i>" data-toggle="tooltip" title="<?php echo $text_clear; ?>" class="btn btn-danger btn-xs pull-right" id="button-cache-image"><i class="fa fa-trash-o"></i></button></a></li>
	  </ul>
	</li>
			
    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><span class="label label-danger pull-left"><?php echo $alerts; ?></span> <img src="view/image/icon-bell.png" alt=""></a>
      <ul class="dropdown-menu dropdown-menu-right alerts-dropdown">
        <li class="dropdown-header"><?php echo $text_order; ?></li>
        <li><a href="<?php echo $processing_status; ?>" style="display: block; overflow: auto;"><span class="label label-warning pull-right"><?php echo $processing_status_total; ?></span><?php echo $text_processing_status; ?></a></li>
        <li><a href="<?php echo $complete_status; ?>"><span class="label label-success pull-right"><?php echo $complete_status_total; ?></span><?php echo $text_complete_status; ?></a></li>
        <li><a href="<?php echo $return; ?>"><span class="label label-danger pull-right"><?php echo $return_total; ?></span><?php echo $text_return; ?></a></li>
        <li class="divider"></li>
        <li class="dropdown-header"><?php echo $text_customer; ?></li>
        <li><a href="<?php echo $online; ?>"><span class="label label-success pull-right"><?php echo $online_total; ?></span><?php echo $text_online; ?></a></li>
        <li><a href="<?php echo $customer_approval; ?>"><span class="label label-danger pull-right"><?php echo $customer_total; ?></span><?php echo $text_approval; ?></a></li>
        <li class="divider"></li>
        <li class="dropdown-header"><?php echo $text_product; ?></li>
        <li><a href="<?php echo $product; ?>"><span class="label label-danger pull-right"><?php echo $product_total; ?></span><?php echo $text_stock; ?></a></li>
        <li><a href="<?php echo $review; ?>"><span class="label label-danger pull-right"><?php echo $review_total; ?></span><?php echo $text_review; ?></a></li>
        <li class="divider"></li>
        <li class="dropdown-header"><?php echo $text_affiliate; ?></li>
        <li><a href="<?php echo $affiliate_approval; ?>"><span class="label label-danger pull-right"><?php echo $affiliate_total; ?></span><?php echo $text_approval; ?></a></li>
      </ul>
    </li>
    <li class="dropdown site-link">
    <?php if(count($stores) == 1){ ?>
        <a href="<?php echo $stores[0]['href']; ?>" target="_blank"><?php echo $text_stores; ?></a>
    <?php }else { ?>
      <a class="dropdown-toggle" data-toggle="dropdown"><?php echo $text_stores; ?></a>
      <ul class="dropdown-menu dropdown-menu-right">
        <li class="dropdown-header"><?php echo $text_store; ?> <i class="fa fa-shopping-cart"></i></li>
        <?php foreach ($stores as $store) { ?>
        <li><a href="<?php echo $store['href']; ?>" target="_blank"><?php echo $store['name']; ?></a></li>
        <?php } ?>
      </ul>
    <?php } ?>
    </li>
    <li class="exit-link"><a href="<?php echo $logout; ?>"><img src="view/image/icon-exit.png" alt=""></a></li>
  </ul>
  <?php } ?>
</header>
