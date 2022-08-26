<?php echo $header; ?><?php echo $result_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="button" id="btn_request" data-toggle="tooltip" title="<?php echo $button_request; ?>" class="btn btn-info" ><?php echo $button_request; ?></button>
                <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-attribute').submit() : false;"><i class="fa fa-trash-o"></i></button>
            </div>
            <img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
            <h1><?php echo $heading_title . " " . $text_module_version; ?></h1>
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
                <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
            </div>
            <div class="panel-body">
                <div class="well">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="control-label" for="input-id"><?php echo $entry_number_request;  ?></label>
                                <input type="text" name="filter_id" value="<?php echo $filter_id; ?>" placeholder="<?php echo $entry_number_request; ?>" id="input-model" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="input-date"><?php echo $entry_date; ?></label>
                                <div class="input-group date">
                                    <input type="text" name="filter_date" value="<?php echo $filter_date; ?>" placeholder="<?php echo $entry_date; ?>" data-date-format="YYYY-MM-DD" id="input-date-added" class="form-control" />
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="control-label" for="input-name"><?php echo $entry_name;  ?></label>
                                <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-model" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="input-emaill"><?php echo $entry_email; ?></label>
                                <input type="text" name="filter_email" value="<?php echo $filter_email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-model" class="form-control" />
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="control-label" for="input-order-status"><?php echo $entry_status; ?></label>
                                <select name="filter_status" id="input-status" class="form-control">
                                    <option value="*"></option>
                                    <?php if ($filter_status == '1') { ?>
                                    <option value="1" selected="selected"><?php echo $text_status_new; ?></option>
                                    <?php } else { ?>
                                    <option value="1"><?php echo $text_status_new; ?></option>
                                    <?php } ?>
                                    <?php if ($filter_status == '0') { ?>
                                    <option value="0" selected="selected"><?php echo $text_status_done; ?></option>
                                    <?php } else { ?>
                                    <option value="0"><?php echo $text_status_done; ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="form-group" style=" height: 94px;padding-top: 36px; ">
                                <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
                            </div>
                        </div>
                    </div>
                </div>

                <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-attribute">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                            <tr>
                                <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                                <td class="text-center">
                                    <?php if ($sort == 'id') { ?>
                                    <a href="<?php echo $sort_id; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_number_request; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_id; ?>"><?php echo $entry_number_request; ?></a>
                                    <?php } ?>
                                </td>
                                <td class="text-center">
                                    <?php if ($sort == 'status') { ?>
                                    <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_status; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_status; ?>"><?php echo $entry_status; ?></a>
                                    <?php } ?>
                                </td>
                                <td class="text-center">
                                    <?php if ($sort == 'date') { ?>
                                    <a href="<?php echo $sort_date; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_date; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_date; ?>"><?php echo $entry_date; ?></a>
                                    <?php } ?>
                                </td>
                                <td class="text-center">
                                    <?php if ($sort == 'name') { ?>
                                    <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_name; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_name; ?>"><?php echo $entry_name; ?></a>
                                    <?php } ?></td>
                                <td class="text-center"><?php if ($sort == 'email') { ?>
                                    <a href="<?php echo $sort_email; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_email; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_email; ?>"><?php echo $entry_email; ?></a>
                                    <?php } ?>
                                </td>
                                <td class="text-center"><?php if ($sort == 'product_name') { ?>
                                    <a href="<?php echo $sort_name_product; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_name_product; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_name_product; ?>"><?php echo $entry_name_product; ?></a>
                                    <?php } ?>
                                </td>
                            </tr>
                            </thead>
                            <tbody>
                            <?php if (isset($items)) { ?>
                            <?php foreach ($items as $item) { ?>
                            <tr>
                                <td class="text-center"><?php if (in_array($item['id'], $selected)) { ?>
                                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
                                    <?php } else { ?>
                                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
                                    <?php } ?>
                                </td>
                                <td class="text-left"><?php echo $item['id']; ?></td>
                                <td class="text-left" style="color:<?php echo $item['status']? '#FF3030':'#00CD66' ?>"><?php echo $item['status']? $text_status_new: $text_status_done; ?></td>
                                <td class="text-left"><?php echo date("d-m-Y H:i:s",strtotime($item['date'])); ?></td>
                                <td class="text-left"><?php echo $item['name']; ?></td>
                                <td class="text-left"><?php echo $item['email']; ?></td>
                                <td class="text-left" >
                                    <a href="<?php echo  $item['product_url']; ?>" target="_blank">
                                        <?php echo $item['product_name'].'<br>'; ?> </a>
                                        <?php foreach($item['options'] as $option){ ?>
                                        <?php echo $option['name']. ': '. $option['value']. '<br>'; ?>
                                        <?php } ?>
                                </td>
                            </tr>
                            <?php } ?>
                            <?php } else { ?>
                            <tr>
                                <td class="text-center" colspan="12"><?php echo $text_no_results; ?></td>
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
<script type="text/javascript">
    $('#button-filter').on('click', function () {
        var url = 'index.php?route=sale/neoseo_notify_when_available&token=<?php echo $token; ?>';

        var filter_id = $('input[name=\'filter_id\']').val();

        if (filter_id) {
            url += '&filter_id=' + encodeURIComponent(filter_id);
        }
        var filter_date = $('input[name=\'filter_date\']').val();

        if (filter_date) {
            url += '&filter_date=' + encodeURIComponent(filter_date);
        }
        var filter_name = $('input[name=\'filter_name\']').val();

        if (filter_name) {
            url += '&filter_name=' + encodeURIComponent(filter_name);
        }
        var filter_email = $('input[name=\'filter_email\']').val();

        if (filter_email) {
            url += '&filter_email=' + encodeURIComponent(filter_email);
        }
        var filter_sku_product = $('input[name=\'filter_sku_product\']').val();

        if (filter_sku_product) {
            url += '&filter_sku_product=' + encodeURIComponent(filter_sku_product);
        }
        var filter_name_product = $('input[name=\'filter_name_product\']').val();

        if (filter_name_product) {
            url += '&filter_name_product=' + encodeURIComponent(filter_name_product);
        }
        var filter_status = $('select[name=\'filter_status\']').val();

        if (filter_status != '*') {
            url += '&filter_status=' + encodeURIComponent(filter_status);
        }
        location = url;
    });


</script>
<script type="text/javascript"><!--
    $('#btn_request').click(function(e){
        e.preventDefault();
        $.ajax({
            'type': "GET",
            'url': "<?php echo htmlspecialchars_decode($btn_request) ?>",
            success: function () {
                alert('<?php echo $text_check_request; ?>');
                location.reload();
            }
        });
    });



    $('.date').datetimepicker({
        pickTime: false
    });
    //--></script>
<?php echo $footer; ?>
