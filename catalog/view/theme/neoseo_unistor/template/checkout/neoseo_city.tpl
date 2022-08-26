<!-- country selection - begin -->
<?php if ( $neoseo_checkout_shipping_country_select ) { ?>

<div class="row country field form-group required shipping_hider" style="<?php if(isset($hide_city_block) && $hide_city_block) { ?> display:none; <?php } ?>">
	<div class="col-sm-4">
		<label for="city" class="control-label"><?php echo $text_country; ?></label>
	</div>
	<div class="col-sm-8">
		<select name="country_id" id="country_id" >
			<?php foreach( $countries as $country ) { ?><option value="<?php echo $country['country_id']; ?>" <?php if ($country_id == $country['country_id']) { ?> selected="selected" <?php } ?> ><?php echo $country['name']; ?></option><?php } ?>
		</select>
	</div>
</div>


<script type="text/javascript"><!--
	$('#country_id').on('change', function() {
		$.ajax({
			url: 'index.php?route=soforp_checkout/checkout/country&country_id=' + this.value,
			dataType: 'json',
			beforeSend: function() {
				$('#country_id').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
			},
			complete: function() {
				$('.fa-spin').remove();
			},
			success: function(json) {

				html = '<option value=""><?php echo $text_select; ?></option>';

				if (json['zone'] && json['zone'] != '') {
					for (i = 0; i < json['zone'].length; i++) {
						html += '<option value="' + json['zone'][i]['zone_id'] + '"';

						if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
							html += ' selected="selected"';
						}

						html += '>' + json['zone'][i]['name'] + '</option>';
					}
				} else {
					html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
				}

				$('#zone_id').html(html);
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});

	$('#country_id').trigger('change');
//--></script>

<?php } else { ?>

<input type="hidden" id="country_id" name="country_id" value="<?php echo $country_id; ?>"/>

<?php } ?>

<!-- country selection - end -->

<!-- zone selection - begin -->

<?php if ( $neoseo_checkout_shipping_city_select == "default" ) { ?>


	<div class="row zone field form-group required shipping_hider" style="<?php if(isset($hide_city_block) && $hide_city_block) { ?> display:none; <?php } ?>">
		<div class="col-sm-4">
			<label for="zone_id" class="control-label"><?php echo $text_region; ?></label>
		</div>
		<div class="col-sm-8">
			<select name="zone_id" id="zone_id" class="form-control">
				<?php foreach( $zones as $zone ) { ?><option value="<?php echo $zone['zone_id']; ?>" <?php if ($zone_id == $zone['zone_id']) { ?> selected="selected" <?php } ?> ><?php echo $zone['name']; ?></option><?php } ?>
			</select>
		</div>
	</div>

<?php } else { ?>

<input type="hidden" id="zone_id" name="zone_id" value="<?php echo $zone_id; ?>"/>

<?php } ?>

<!-- zone selection - end -->

<!-- city selection - begin -->
<?php if ( $neoseo_checkout_shipping_city_select == "default" ) { ?>
	<div class="row address field form-group required shipping_hider" style="<?php if(isset($hide_city_block) && $hide_city_block) { ?> display:none; <?php } ?>">
		<div class="col-sm-4">
			<label for="city" class="control-label"><?php echo $text_city; ?></label>
		</div>
		<div class="col-sm-8">
			<input type="text" id="city" value="<?php echo $city; ?>" name="city" class="form-control"/>
		</div>
	</div>

<script>
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$('#city').autocomplete({
		source: function( request, response ) {
			$.ajax({
				url: language + "/index.php?route=checkout/neoseo_checkout/autocomplete_city",
				dataType: "json",
				data: {
					country_id: $('#country_id').val(),
					zone_id: $('#zone_id option:selected').val(),
					name: request,
				},
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['value'],
							value: item['value'],
							country_id: item['country_id'],
							zone_id: item['zone_id'],
							city: item['city'],
						}
					}));
				}
			});
		},
		minLength: 2,
		select: function (item) {
			if( item ) {
				$("#city").val(item.city);
				changeCity(item.city,item.zone_id,item.country_id,function(){
					reloadCheckout();
				});
			}
		},
	});
</script>

<?php } else if ( $neoseo_checkout_shipping_city_select == "cities" ) { ?>


	<input type="hidden" id="city" value="<?php echo $city; ?>" name="city" class="large-field"/>

	<div class="address field shipping_hider" style="<?php if(isset($hide_city_block) && $hide_city_block) { ?> display:none; <?php } ?>">
		<div class="row field form-group required">
			<div class="col-sm-4">
				<label for="cityselect" class="control-label"><?php echo $text_city; ?></label>
			</div>
			<div class="col-sm-8">
				<input type="text" id="cityselect" value="<?php echo $city; ?>" class="form-control"/>
			</div>
		</div>
	</div>

	<script>
		jQuery.fn.extend({
			propAttr: $.fn.prop || $.fn.attr
		});
		$('#cityselect').autocomplete({
			source: function( request, response ) {
				$.ajax({
					url: "/index.php?route=checkout/neoseo_checkout/autocomplete",
					dataType: "json",
					data: { term: request, language_id: <?php echo $language_id ?> },
					success: function(json) {
						response($.map(json, function(item) {
							return {
								label: item['value'],
								value: item['value'],
								country_id: item['country_id'],
								zone_id: item['zone_id'],
								city: item['city']
							}
						}));
					}
				});
			},
			minLength: 2,
			select: function (item) {
				if( item ) {
					$("#zone_id").val(item.zone_id);
					$("#country_id").val(item.country_id);
					$("#city").val(item.city);
					$("#cityselect").val(item.city);
					changeCity(item.city,item.zone_id,item.country_id,null,function(){
						reloadCheckout();
					});
				}
			},
		});
	</script>

<?php } else { ?>

	<input type="hidden" id="city" name="city" value="<?php echo $city; ?>"/>

<?php } ?>

