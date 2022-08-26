<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">

    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if( !isset($license_error) ) { ?>
                <button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
                <?php } else { ?>
                <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
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
                    <li><a href="#tab-mapping" data-toggle="tab"><?php echo $tab_mapping; ?></a></li>
                    <li><a href="#tab-customer-groups" data-toggle="tab"><?php echo $tab_customer_groups; ?></a></li>
                    <li><a href="#tab-customer-localization" data-toggle="tab"><?php echo $tab_localization; ?></a></li>
                    <?php if( !isset($license_error) ) { ?>
                    <li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
                    <?php } ?>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                    <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>

                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">

                            <?php if( !isset($license_error) ) { ?>
                            <?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->input('api_key'); ?>
                            <div class="form-group" id="field_update" style="display: inline-block; width: 100%;">
                                <div class="col-sm-5">
                                    <label class="control-label" for="field_update"><?php echo $button_update; ?></label>
                                    <p><?php echo $text_geoip_update_help; ?></p>
                                    <br>
                                </div>
                                <div class="col-sm-7">
                                    <a href='<?php echo $update_link; ?>' class="btn btn-primary" id="field_update"><?php echo $button_update; ?></a>
                                </div>
                            </div>

                            <?php } else { ?>
                            <?php echo $license_error; ?>
                            <?php } ?>
                        </div>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-logs">
                            <?php $widgets->debug_download_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $download, $button_clear_log, $button_download_log); ?>
                            <textarea style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
                        </div>
                        <?php } ?>
                        <div class="tab-pane" id="tab-mapping">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <td class="text-left"><?php echo $entry_country; ?></td>
                                        <td class="text-left"><?php echo $entry_map; ?></td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php foreach ($geoip_countries as $country) { ?>
                                    <tr>
                                        <td><?php echo $country['name']; ?></td>
                                        <td><a href="<?php echo $country['edit']; ?>" data-toggle="tooltip"
                                           title="<?php echo $button_edit; ?>" class="btn btn-primary"><i
                                                    class="fa fa-pencil"></i></a></td>
                                    </tr>
                                    <?php } ?>
                                    </tbody>
                                </table>

                        </div>
                        <div class="tab-pane" id="tab-customer-groups">
                            <table id="zone-to-group" class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <td class="text-left"><?php echo $entry_country_oc; ?></td>
                                    <td class="text-left"><?php echo $entry_zone_oc; ?></td>
                                    <td class="text-left"><?php echo $entry_customer_group; ?></td>
                                    <td></td>
                                </tr>
                                </thead>
                                <tbody>
                                <?php $zone_to_group_row = 0; ?>
                                <?php foreach ($groups_mapping as $map) { ?>
                                <tr id="zone-to-group-row<?php echo $zone_to_group_row; ?>">
                                    <td class="text-left"><select name="zone_to_group[<?php echo $zone_to_group_row; ?>][country_id]" id="country_ztg<?php echo $zone_to_group_row; ?>" class="form-control" onchange="$('#zone_ztg<?php echo $zone_to_group_row; ?>').load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=' + this.value + '&zone_id=0');">
                                            <?php foreach ($countries as $country) { ?>
                                            <?php  if ($country['country_id'] == $map['country_id']) { ?>
                                            <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                            <?php } else { ?>
                                            <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                            <?php } ?>
                                            <?php } ?>
                                        </select></td>
                                    <td class="text-left"><select name="zone_to_group[<?php echo $zone_to_group_row; ?>][zone_id]" id="zone_ztg<?php echo $zone_to_group_row; ?>" class="form-control zonesel" onchange="checkdoubles(<?php echo $zone_to_group_row; ?>)">
                                        </select></td>
                                    <td class="text-left"><select name="zone_to_group[<?php echo $zone_to_group_row; ?>][group_id]" id="group_id<?php echo $zone_to_group_row; ?>" class="form-control">
                                            <?php foreach ( $customer_groups as $group) { ?>
                                            <?php  if ($group['customer_group_id'] == $map['group_id']) { ?>
                                            <option value="<?php echo $group['customer_group_id']; ?>" selected="selected"><?php echo $group['name']; ?></option>
                                            <?php } else { ?>
                                            <option value="<?php echo $group['customer_group_id']; ?>"><?php echo $group['name']; ?></option>
                                            <?php } ?>
                                            <?php } ?>
                                        </select></td>
                                    <td class="text-left"><button type="button" onclick="$('#zone-to-group-row<?php echo $zone_to_group_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                </tr>
                                <?php $zone_to_group_row++; ?>
                                <?php } ?>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="3"></td>
                                    <td class="text-left"><button type="button" onclick="addGeoZoneGroup();" data-toggle="tooltip" title="<?php echo $button_geo_zone_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                                </tr>
                                </tfoot>
                            </table>

                        </div>

                        <div class="tab-pane" id="tab-customer-localization">
                            <?php $widgets->dropdown('allow_change_language',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('allow_change_currency',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <table id="zone-to-localization" class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <td class="text-left"><?php echo $entry_country_oc; ?></td>
                                    <td class="text-left"><?php echo $entry_language; ?></td>
                                    <td class="text-left"><?php echo $entry_currency; ?></td>
                                    <td></td>
                                </tr>
                                </thead>
                                <tbody>
                                <?php $zone_to_localization_row = 0; ?>
                                <?php foreach ($localization_map as $map) { ?>
                                <tr id="zone-to-localization-row<?php echo $zone_to_localization_row; ?>">
                                    <td class="text-left"><select name="zone_to_localization[<?php echo $zone_to_localization_row; ?>][country_id]" id="country_ztl<?php echo $zone_to_localization_row; ?>" class="form-control zonelsel"  onchange="checkLdoubles(<?php echo $zone_to_localization_row; ?>)">
                                            <?php foreach ($countries as $country) { ?>
                                            <?php  if ($country['country_id'] == $map['country_id']) { ?>
                                            <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                            <?php } else { ?>
                                            <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                            <?php } ?>
                                            <?php } ?>
                                        </select></td>
                                    <td class="text-left"><select name="zone_to_localization[<?php echo $zone_to_localization_row; ?>][lang_id]" id="zone_ztl<?php echo $zone_to_localization_row; ?>" class="form-control zonesel">
                                            <?php foreach ( $languages as $language) { ?>
                                            <?php if(!($language['status'])) continue; ?>
                                            <?php  if ($language['code'] == $map['lang_id']) { ?>
                                            <option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                                            <?php } else { ?>
                                            <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
                                            <?php } ?>
                                            <?php } ?>
                                        </select></td>
                                    <td class="text-left"><select name="zone_to_localization[<?php echo $zone_to_localization_row; ?>][currency_id]" id="localization_id<?php echo $zone_to_localization_row; ?>" class="form-control">
                                            <?php foreach ( $currencies as $currency) { ?>
                                            <?php if(!($currency['status'])) continue; ?>
                                            <?php  if ($currency['code'] == $map['currency_id']) { ?>
                                            <option value="<?php echo $currency['code']; ?>" selected="selected"><?php echo $currency['title']; ?></option>
                                            <?php } else { ?>
                                            <option value="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?></option>
                                            <?php } ?>
                                            <?php } ?>
                                        </select></td>
                                    <td class="text-left"><button type="button" onclick="$('#zone-to-localization-row<?php echo $zone_to_localization_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                </tr>
                                <?php $zone_to_localization_row++; ?>
                                <?php } ?>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="3"></td>
                                    <td class="text-left"><button type="button" onclick="addGeoZonelocalization();" data-toggle="tooltip" title="<?php echo $button_geo_zone_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                                </tr>
                                </tfoot>
                            </table>

                        </div>

                        <div class="tab-pane" id="tab-support">
                            <?php echo $mail_support; ?>
                        </div>

                        <div class="tab-pane" id="tab-license">
                            <?php echo $module_licence; ?>
                        </div>

                    </div>

                </form>

            </div>

        </div>

    </div>
</div>
<?php $zone_to_group_row = 0; ?>
<?php foreach ($groups_mapping as $map) { ?>
<script type="text/javascript"><!--
    $('#zone_ztg<?php echo $zone_to_group_row; ?>').load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=<?php echo $map['country_id']; ?>&zone_id=<?php echo $map['zone_id']; ?>');
    //--></script>
<?php $zone_to_group_row++; ?>
<?php } ?>


<script type="text/javascript"><!--
    var zone_to_group_row = <?php echo $zone_to_group_row; ?>;
    var zone_to_localization_row = <?php echo $zone_to_localization_row; ?>;

    function addGeoZoneGroup()
    {
        html  = '<tr id="zone-to-group-row' + zone_to_group_row + '">';

        html += '  <td class="text-left"><select name="zone_to_group[' + zone_to_group_row + '][country_id]" id="country_ztg' + zone_to_group_row + '" class="form-control" onchange="$(\'#zone_ztg' + zone_to_group_row + '\').load(\'index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=\' + this.value + \'&zone_id=0\');">';
    <?php foreach ($countries as $country) { ?>
        html += '<option value="<?php echo $country['country_id']; ?>"><?php echo addslashes($country['name']); ?></option>';
    <?php } ?>
        html += '</select></td>';

        html += '  <td class="text-left"><select name="zone_to_group[' + zone_to_group_row + '][zone_id]" id="zone_ztg' + zone_to_group_row + '" class="form-control zonesel" onchange="checkdoubles('+zone_to_group_row+')"></select></td>';
        html += '  <td class="text-left"><select name="zone_to_group[' + zone_to_group_row + '][group_id]" id="group_ztg' + zone_to_group_row + '" class="form-control">';
        <?php foreach( $customer_groups as $group){ ?>
            html += '<option value="<?php echo $group['customer_group_id']; ?>"><?php echo addslashes($group['name']); ?></option>';
        <?php } ?>
        html += '</select></td>';
        html += '  <td class="text-left"><button type="button" onclick="$(\'#zone-to-group-row' + zone_to_group_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
        html += '</tr>';

        $('#zone-to-group tbody').append(html);

        $('#zone_ztg' + zone_to_group_row).load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=' + $('#country_ztg' + zone_to_group_row).val() + '&zone_id=0');

        zone_to_group_row++;
    }
    
    function addGeoZonelocalization()
    {
        html  = '<tr id="zone-to-localization-row' + zone_to_localization_row + '">';

        html += '  <td class="text-left"><select name="zone_to_localization[' + zone_to_localization_row + '][country_id]" id="country_ztl' + zone_to_localization_row + '" class="form-control zonelsel" onchange="checkLdoubles(' + zone_to_localization_row + ')">';
    <?php foreach ($countries as $country) { ?>
        html += '<option value="<?php echo $country['country_id']; ?>"><?php echo addslashes($country['name']); ?></option>';
    <?php } ?>
        html += '</select></td>';

        html += '  <td class="text-left"><select name="zone_to_localization[' + zone_to_localization_row + '][lang_id]" id="zone_ztl' + zone_to_localization_row + '" class="form-control zonesel">';
        <?php foreach ( $languages as $language) { ?>
        <?php if(!($language['status'])) continue; ?>
            html += '<option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>';
        <?php } ?>
        html += '</select></td>';
        html += '  <td class="text-left"><select name="zone_to_localization[' + zone_to_localization_row + '][currency_id]" id="localization_ztl' + zone_to_localization_row + '" class="form-control">';
        <?php foreach ( $currencies as $currency) { ?>
        <?php if(!($currency['status'])) continue; ?>
            html += '<option value="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?></option>';
        <?php } ?>
        html += '</select></td>';
        html += '  <td class="text-left"><button type="button" onclick="$(\'#zone-to-localization-row' + zone_to_localization_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
        html += '</tr>';

        $('#zone-to-localization tbody').append(html);

        zone_to_localization_row++;
    }
    //--></script>

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
    function checkdoubles(id)
    {
        cur = $( "#zone_ztg"+id+" option:selected").attr('value');
        $("#zone_ztg"+id).css('background-color','');
        c = 0;
        $( ".zonesel option:selected" ).each(function() {
            if ($( this ).attr('value') == cur) c++;
        });
        if(c > 1) $("#zone_ztg"+id).css('background-color','#ff00004d');
    }

    function checkLdoubles(id)
    {
        cur = $( "#country_ztl"+id+" option:selected").attr('value');
        $("#country_ztl"+id).css('background-color','');
        c = 0;
        $( ".zonelsel option:selected" ).each(function() {
            if ($( this ).attr('value') == cur) c++;
        });
        if(c > 1) $("#country_ztl"+id).css('background-color','#ff00004d');
    }

	// Специальный фикс системной функции, поскольку даниель понятия не имеет о том что в url может быть еще и hash
	// и по итогу этот hash становится частью token
	function getURLVar(key) {
		var value = [];

		var url = String(document.location);
		if( url.indexOf('#') != -1 ) {
			url = url.substring(0, url.indexOf('#'));
		}
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
<?php echo $footer; ?>