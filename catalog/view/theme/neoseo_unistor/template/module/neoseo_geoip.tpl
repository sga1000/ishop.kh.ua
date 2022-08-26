<div class="btn btn-link"  <?php if($show_popover == 1) { ?>data-placement="bottom" data-toggle="popover" title="<?php echo $text_region_is; ?> &nbsp;&nbsp;&nbsp;&nbsp;<span style='float:right;cursor:pointer;' onclick='fclose()'><i class='fa fa-close'></i></span>" data-html="true" data-content="<?php echo $text_selected_region." ".$detected_region; ?><br><?php if($allow_currency_selector) { echo $currency_notice."<br>"; } ?> <?php if($allow_language_selector) { echo $language_notice."<br>"; } ?><button onclick='fclose()' class='btn btn-success'><?php echo $text_ok; ?></button> <button class='btn btn-primary' data-toggle='modal' data-target='#cityPopup' onclick='fclose()'><?php echo $text_detect; ?></button>" <?php } ?>><span data-toggle="modal" data-target="#cityPopup" style="cursor:pointer; border-bottom: 1px dashed blue;"><?php echo $detected_region; ?></span></div>
<div id="cityPopup" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><i class='fa fa-close'></i></button>
                <h4 class="modal-title"><?php echo $text_select_region; ?></h4>
            </div>
            <div class="modal-body">
                <p><?php echo $select_enother; ?></p>
                <p><input type="text" value="<?php if($detected_region != $text_not_detected) { echo $detected_region; } ?>" id="regionselect" name="regionselect" class="form-control"></p>
                <p onclick="remove_text()"><span  style="cursor: pointer; border-bottom: 1px dashed;"><?php echo $text_region_notice; ?></span></p>
                <input type="hidden" id="zone_id" value="<?php echo $oc_region; ?>">
                <input type="hidden" id="country_id" value="<?php echo $oc_country; ?>">
                <?php if($allow_language_selector) { ?>
                <div>
                    <p><?php echo $text_language_selector; ?></p>
                    <p><?php echo $language_selector; ?></p>
                </div>
                <?php } ?>

                <?php if($allow_currency_selector) { ?>
                <div>
                    <p><?php echo $text_currency_selector; ?></p>
                    <p><?php echo $currency_selector; ?></p>
                </div>
                <?php } ?>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="saveRegion()"><?php echo $text_detect; ?></button>
            </div>
        </div>

    </div>
</div>
<script>
    $('input[name=\'regionselect\']').autocomplete({
        'source': function(request, response) {
            $.ajax({
                url: 'index.php?route=module/neoseo_geoip/autocomplete&filter_name=' +  encodeURIComponent(request),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            label: item['name'],
                            value: item['zone_id'],
                            zone_id: item['zone_id'],
                            country_id: item['country_id'],
                        }
                    }));
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        },
        'select': function(item) {
            $(this).val(item['label']);
            $('input[name="regionselect"]').val(item['label']);
            $('#zone_id').val(item['zone_id']);
            $('#country_id').val(item['country_id'] );

        }
    });

    function saveRegion()
    {
        if($('#zone_id').val() == 0 || $('#country_id').val() == 0){
            remove_text();
            return;
        }
        $.ajax({
            url: 'index.php?route=module/neoseo_geoip/setmanual',
            data: {'zone_id' :$('#zone_id').val(), 'country_id': $('#country_id').val() , 'manual_lang' : $('#geoip_manual_language').val(), 'manual_currency' : $('#geoip_manual_currency').val()},
            success: function (){
                location.reload();
            }
        });
    }

    function remove_text()
    {
        $('#regionselect').val('');
        $('#regionselect').focus();

    }

    $(document).ready(function(){
        $('#cityPopup').appendTo($('body'));
    });

    <?php if($show_popover == 1) { ?>
        $(document).ready(function(){
            $('[data-toggle="popover"]').popover('show');
        });
        function fclose()
        {
            $('[data-toggle="popover"]').popover('hide');
        }
    <?php } ?>
</script>