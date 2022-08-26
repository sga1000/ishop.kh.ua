<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if( !isset($license_error) ) { ?>
				<button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
				<button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
				<?php } else { ?>
				<a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-default" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
				<?php } ?>
				<a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
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
		<div class="alert alert-danger">
			<i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if (isset($success) && $success) { ?>
		<div class="alert alert-success">
			<i class="fa fa-check-circle"></i>
			<?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-body">

				<ul class="nav nav-tabs">
					<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
				</ul>

				<form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">
							<?php if( !isset($license_error) ) { ?>

							<?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->input('name'); ?>
							<?php $widgets->localeInput('title',$full_languages); ?>
							<?php $widgets->input('limit'); ?>
							<?php $widgets->dropdown('type',$types); ?>
							
							<div class="form-group" id="filter_page">
								<label class="col-sm-5 control-label" for="input-filter-pages"><?php echo $entry_filter_pages; ?></label>
								<div class="col-sm-7">
									<input type="text" name="filter_page" value="" placeholder="<?php echo $entry_filter_pages; ?>" id="input-filter-pages" class="form-control" />
									<div id="filter-pages" class="well well-sm" style="height: 150px; overflow: auto;">
										<?php if($filter_pages){ ?>
										<?php foreach ($filter_pages as $filter_page) { ?>
										<div id="filter-page-<?php echo $filter_page['page_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $filter_page['tag_name']; ?>
											<input type="hidden" name="neoseo_filter_tag_filter_pages[]" value="<?php echo $filter_page['page_id']; ?>" />
										</div>
										<?php } ?>
										<?php } ?>
									</div>
								</div>
							</div>
							<?php } else { ?>

							<div><?php echo $license_error; ?></div>

							<?php } ?>
						</div>

					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--	
if (window.location.hash.indexOf('#tab') == 0 && $("[href=" + window.location.hash + "]").length) {
		$(".panel-body > .nav-tabs li").removeClass("active");
		$("[href=" + window.location.hash + "]").parents('li').addClass("active");
		$(".panel-body:first .tab-content:first .tab-pane:first").removeClass("active");
		$(window.location.hash).addClass("active");
	}
	$(".nav-tabs li a").click(function () {
		var url = $(this).prop('href');
		window.location.hash = url.substring(url.indexOf('#'));
	});
	// Специальный фикс системной функции, поскольку даниель понятия не имеет о том что в url может быть еще и hash	
	// и по итогу этот hash становится частью token	
	function getURLVar(key) {
		var value = [];

		var url = String(document.location);
		var url = url.substring(0, url.indexOf('#'));
		var query = url.split('?');

		if (query[1]) {
			var part = query[1].split('&');

			for (i = 0; i < part.length; i++) {
				var data = part[i].split('=');

				if (data[0] && data[1]) {
					value[data[0]] = data[1];
				}
			}

			if (value[key]) {
				return value[key];
			} else {
				return '';
			}
		}
	}
//--></script>
<script type="text/javascript">
function checkType(val){
	if(val == 'hand'){
		$('#filter_page').show();
	}else{
		$('#filter_page').hide();
	}
}

$(function(){
	var val = $('#neoseo_filter_tag_type').val();
	checkType(val);
	
	$('#neoseo_filter_tag_type').on('change',function(){	
		checkType($(this).val());
	});
});

$('input[name=\'filter_page\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=module/neoseo_filter_tag/autocomplete&token=<?php echo $token; ?>&tag_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['tag_name'],
						value: item['page_id']
					}
				}));
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
			
		});
	},
	'select': function(item) {
	
		$('input[name=\'filter_page\']').val('');

		$('#filter-page-' + item['value']).remove();

		$('#filter-pages').append('<div id="filter-page-' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="neoseo_filter_tag_filter_pages[]" value="' + item['value'] + '" /></div>');
	}
});

$('#filter-pages').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});

</script>
<?php echo $footer; ?>