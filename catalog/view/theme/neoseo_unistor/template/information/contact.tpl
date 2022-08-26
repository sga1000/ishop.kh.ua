<?php echo $header; ?>
<div class="container">
	<?php if (file_exists(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl')) { ?>
	<?php require_once(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
	<?php } else { ?>
	<?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
	<?php } ?>
	<div class="row">
		<?php echo $column_left; ?>
		<?php if ($column_left && $column_right) { ?>
		<?php $class = 'col-sm-6'; ?>
		<?php } elseif ($column_left || $column_right) { ?>
		<?php $class = 'col-sm-9'; ?>
		<?php } else { ?>
		<?php $class = 'col-sm-12'; ?>
		<?php } ?>
		<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>

			<?php if($section_status) { ?>
			<div class="information-container box-shadow box-corner">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="row">
							<div class="address <?php if ( $map != 'none' ) { ?>col-sm-4<?php } ?>" id="accordion">
								<?php foreach( $sections as $section_id => $section ) { ?>
								<div class="address-block">
									<?php if( $section['title'] ) { ?>
									<h3 class="head" data-toggle="collapse" data-parent="#accordion" href="#point<?php echo $section_id; ?>">
										<?php echo $section['title']; ?><i class="fa fa-caret-down"></i>
									</h3>
									<?php } ?>
									<?php if($section['txt']) { ?>
									<div id="point<?php echo $section_id; ?>" class="description collapse" >
										<?php echo $section['txt']; ?>
									</div>
									<?php } ?>
								</div>
								<?php } ?>
							</div>
							<?php if ( $map != 'none' ) { ?>
							<div class="map col-sm-8">
								<div id="contact-map1" class="contact-map" style="width: 100%; height: 400px"></div>
							</div>
							<?php } ?>
						</div>
					</div>
				</div>
			</div>
			<?php } ?>

			<div>
				<?php if( $form_status) { ?>
				<div class="form-container">
					<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
						<fieldset>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-name">
									<?php echo $entry_name; ?>
								</label>
								<div class="col-sm-10">
									<input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
									<?php if ($error_name) { ?>
									<div class="text-danger">
										<?php echo $error_name; ?>
									</div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-email">
									<?php echo $entry_email; ?>
								</label>
								<div class="col-sm-10">
									<input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />
									<?php if ($error_email) { ?>
									<div class="text-danger">
										<?php echo $error_email; ?>
									</div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-enquiry"><?php echo $entry_enquiry; ?></label>
								<div class="col-sm-10">
									<textarea name="enquiry" rows="10" id="input-enquiry" class="form-control"><?php echo $enquiry; ?></textarea>
									<?php if ($error_enquiry) { ?>
									<div class="text-danger">
										<?php echo $error_enquiry; ?>
									</div>
									<?php } ?>
								</div>
							</div>
							<?php echo $captcha; ?>
						</fieldset>
						<div class="buttons">
							<div class="text-right">
								<input class="btn btn-primary" type="submit" value="<?php echo $button_submit; ?>" />
							</div>
						</div>
					</form>
				</div>

				<?php } ?></div>
			<?php echo $content_bottom; ?>
		</div>
		<?php echo $column_right; ?>
	</div>
</div>
<?php if($section_status) { ?>
<?php if($map == 'yandex') { ?>
<script src="//api-maps.yandex.ru/2.1/?lang=ru_RU"></script>
<script type="text/javascript">
    var mapDiv, map, infobox;
    function initMap(id, coords) {
        myMap = new ymaps.Map(id, {
            center: coords,
            zoom: 15
            //controls: ['zoomControl','geolocationControl']
        });
        myMap.geoObjects.add(
            new ymaps.Placemark(coords));
    }
    function initMaps() {
        initMap("contact-map1", [ <?php echo $latitude; ?> , <?php echo $longitude; ?> ]);
    }
    ymaps.ready(initMaps);
</script>
<?php } else { ?>
<script type="text/javascript" src="//maps.google.com/maps/api/js?key=<?php echo isset($google_api_key) ? $google_api_key : ''; ?>"></script>
<script type="text/javascript">
    function initialize() {
        var myLatlng = new google.maps.LatLng(<?php echo $latitude; ?> , <?php echo $longitude; ?>);
        var myOptions = {
            zoom: 16,
            center: myLatlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        }
        var map = new google.maps.Map(document.getElementById("contact-map1"), myOptions);
        var marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            title: '<?php echo $store_name?>'
        });
    }
    initialize();
</script>

<script>
    $('document').ready(function (){
        $('.address .head').on('click', function (){
            $(this).removeClass('head')
        })
    })
</script>
<?php } ?>
<?php } ?>
<?php echo $footer; ?>