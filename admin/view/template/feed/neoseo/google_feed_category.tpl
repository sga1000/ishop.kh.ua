<div class="panel panel-default">
    <div class="panel-heading">
        <img width="18" height="18" style="float:left" src="view/image/neoseo.png" alt=""/>
        <h4><?php echo $heading_title_raw . " " . $text_module_version; ?></h4>
    </div>
    <div class="panel-body">
        <div class="tab-content">
            <?php if( !isset($license_error) ) { ?>

            <div class="form-group">
                <label class="col-sm-2 control-label" for="google-category-name"><?php echo $entry_google_category_id; ?></label>
                <input type="hidden" name="google_category_id" value="<?php echo $google_category_id; ?>" id="google-category-id" class="form-control" />
                <div class="col-sm-10">
                    <input type="text" name="google_category_name" value="<?php echo $google_category_name; ?>" id="google-category-name" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="input-google-feeded"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                    <select name="google_feeded" id="input-google-feeded" class="form-control">
                        <?php if ($google_feeded) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                    </select>
                </div>
            </div>

            <?php } else { ?>
            <?php echo $license_error; ?>
            <?php } ?>
        </div>
    </div>
    <script type="text/javascript"><!--
        $('input[name=\'google_category_name\']').autocomplete({
            'source': function(request, response) {
                $.ajax({
                    url: 'index.php?route=feed/neoseo/google_feed/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['category_id']
                            }
                        }));
                    }
                });
            },
            'select': function(item) {
                $('input[name=\'google_category_name\']').val(item['label']);
                $('input[name=\'google_category_id\']').val(item['value']);
            }
        });
        //--></script>
</div>
