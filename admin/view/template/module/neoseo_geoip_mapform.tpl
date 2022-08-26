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
        <div class="panel panel-default">
        <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
            <input type="hidden" name="country" value="<?php echo $country; ?>">
            <div class="panel-heading">
                <h1 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $add_title; ?></h1>
            </div>
        <table id="zone-to-geo-zone" class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <td class="text-left"><?php echo $entry_country; ?></td>
                <td class="text-left"><?php echo $entry_zone; ?></td>
                <td class="text-left"><?php echo $entry_country_oc; ?></td>
                <td class="text-left"><?php echo $entry_zone_oc; ?></td>
                <td></td>
            </tr>
            </thead>
            <tbody>
            <?php $zone_to_geo_zone_row = 0; ?>
            <?php foreach ($mapping as $map) { ?>
            <tr id="zone-to-geo-zone-row<?php echo $zone_to_geo_zone_row; ?>">
                <td class="text-left"><select name="zone_to_geo_zone[<?php echo $zone_to_geo_zone_row; ?>][country_id]" id="country<?php echo $zone_to_geo_zone_row; ?>" class="form-control" onchange="$('#zone<?php echo $zone_to_geo_zone_row; ?>').load('index.php?route=module/neoseo_geoip/zone&token=<?php echo $token; ?>&country_id=' + this.value + '&zone_id=0');">
                        <?php foreach ($geoip_countries as $country) { ?>
                        <?php  if ($country['country_id'] == $map['geoip_country']) { ?>
                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select></td>
                <td class="text-left"><select name="zone_to_geo_zone[<?php echo $zone_to_geo_zone_row; ?>][zone_id]" id="zone<?php echo $zone_to_geo_zone_row; ?>" class="form-control zonesel" onchange="checkdoubles(<?php echo $zone_to_geo_zone_row; ?>)">
                    </select></td>

                <td class="text-left"><select name="zone_to_geo_zone[<?php echo $zone_to_geo_zone_row; ?>][country_id_oc]" id="country<?php echo $zone_to_geo_zone_row; ?>" class="form-control" onchange="$('#zone_oc<?php echo $zone_to_geo_zone_row; ?>').load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=' + this.value + '&zone_id=0');">
                        <?php foreach ($countries as $country) { ?>
                        <?php  if ($country['country_id'] == $map['oc_country']) { ?>
                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select></td>
                <td class="text-left"><select name="zone_to_geo_zone[<?php echo $zone_to_geo_zone_row; ?>][zone_id_oc]" id="zone_oc<?php echo $zone_to_geo_zone_row; ?>" class="form-control">

                    </select></td>
                <td class="text-left"><button type="button" onclick="$('#zone-to-geo-zone-row<?php echo $zone_to_geo_zone_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
            </tr>
            <?php $zone_to_geo_zone_row++; ?>
            <?php } ?>
            </tbody>
            <tfoot>
            <tr>
                <td colspan="4"></td>
                <td class="text-left"><button type="button" onclick="addGeoZone();" data-toggle="tooltip" title="<?php echo $button_geo_zone_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
            </tr>
            </tfoot>
        </table>
        </form>
    </div>
    </div>
    <?php $zone_to_geo_zone_row = 0; ?>
    <?php foreach ($mapping as $map) { ?>
    <script type="text/javascript"><!--
        $('#zone<?php echo $zone_to_geo_zone_row; ?>').load('index.php?route=module/neoseo_geoip/zone&token=<?php echo $token; ?>&country_id=<?php echo $map['geoip_country']; ?>&zone_id=<?php echo $map['geoip_region']; ?>');
        $('#zone_oc<?php echo $zone_to_geo_zone_row; ?>').load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=<?php echo $map['oc_country']; ?>&zone_id=<?php echo $map['oc_region']; ?>');
        //--></script>
    <?php $zone_to_geo_zone_row++; ?>
    <?php } ?>

    <script type="text/javascript"><!--
        var zone_to_geo_zone_row = <?php echo $zone_to_geo_zone_row; ?>;

        function addGeoZone() {
            html  = '<tr id="zone-to-geo-zone-row' + zone_to_geo_zone_row + '">';
            html += '  <td class="text-left"><select name="zone_to_geo_zone[' + zone_to_geo_zone_row + '][country_id]" id="country' + zone_to_geo_zone_row + '" class="form-control" onchange="$(\'#zone' + zone_to_geo_zone_row + '\').load(\'index.php?route=module/neoseo_geoip/zone&token=<?php echo $token; ?>&country_id=\' + this.value + \'&zone_id=0\');">';
        <?php foreach ($geoip_countries as $country) { ?>
                html += '<option value="<?php echo $country['country_id']; ?>"><?php echo addslashes($country['name']); ?></option>';
            <?php } ?>
            html += '</select></td>';
            html += '  <td class="text-left"><select name="zone_to_geo_zone[' + zone_to_geo_zone_row + '][zone_id]" id="zone' + zone_to_geo_zone_row + '" class="form-control zonesel" onchange="checkdoubles('+zone_to_geo_zone_row+')"></select></td>';

            html += '  <td class="text-left"><select name="zone_to_geo_zone[' + zone_to_geo_zone_row + '][country_id_oc]" id="country_oc' + zone_to_geo_zone_row + '" class="form-control" onchange="$(\'#zone_oc' + zone_to_geo_zone_row + '\').load(\'index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=\' + this.value + \'&zone_id=0\');">';
        <?php foreach ($countries as $country) { ?>
                html += '<option value="<?php echo $country['country_id']; ?>"><?php echo addslashes($country['name']); ?></option>';
            <?php } ?>
            html += '</select></td>';

            html += '  <td class="text-left"><select name="zone_to_geo_zone[' + zone_to_geo_zone_row + '][zone_id_oc]" id="zone_oc' + zone_to_geo_zone_row + '" class="form-control"></select></td>';
            html += '  <td class="text-left"><button type="button" onclick="$(\'#zone-to-geo-zone-row' + zone_to_geo_zone_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
            html += '</tr>';

            $('#zone-to-geo-zone tbody').append(html);

            $('#zone' + zone_to_geo_zone_row).load('index.php?route=module/neoseo_geoip/zone&token=<?php echo $token; ?>&country_id=' + $('#country' + zone_to_geo_zone_row).val() + '&zone_id=0');
            $('#zone_oc' + zone_to_geo_zone_row).load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=' + $('#country_oc' + zone_to_geo_zone_row).val() + '&zone_id=0');

            zone_to_geo_zone_row++;
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
            cur = $( "#zone"+id+" option:selected").attr('value');
            $("#zone"+id).css('background-color','');
            c = 0;
            $( ".zonesel option:selected" ).each(function() {
                if ($( this ).attr('value') == cur) c++;
            });
            if(c > 1) $("#zone"+id).css('background-color','#ff00004d');
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