<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
                <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-attribute').submit() : false;"><i class="fa fa-trash-o"></i></button>
                <a href="<?php echo $price_import; ?>" data-toggle="tooltip" title="<?php echo $button_price_import; ?>" class="btn btn-primary"><i class="fa fa-undo" aria-hidden="true"></i> <?php echo $button_price_import;?></a>
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
                                <label class="control-label" for="input-code"><?php echo $entry_code; ?></label>
                                <input type="text" name="filter_code" value="<?php echo $filter_code; ?>" placeholder="<?php echo $entry_code; ?>" id="input-code" class="form-control" />
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                                <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="control-type" for="input-code"><?php echo $entry_type; ?></label>
                                <select name="filter_type"  class="form-control">
                                    <option value="*"></option>
                                    <?php foreach (range(0, 2) as $i) { ?>
                                    <option value="<?php echo $i;?>"  <?php echo (!is_null($filter_type) && $filter_type==$i)? "selected='selected'": '' ; ?>> <?php echo $type_data_processing[$i]; ?></option>
                                    <?php } ?>
                                </select>
                            </div> 
                            <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
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
                                        <?php if ($sort == 'code') { ?>
                                        <a href="<?php echo $sort_code; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_code; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_code; ?>"><?php echo $entry_code; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php if ($sort == 'name') { ?>
                                        <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_name; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_name; ?>"><?php echo $entry_name; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php if ($sort == 'list') { ?>
                                        <a href="<?php echo $sort_list; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_list; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_list; ?>"><?php echo $entry_list; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php if ($sort == 'column_quantity') { ?>
                                        <a href="<?php echo $sort_column_quantity; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_column_quantity; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_column_quantity; ?>"><?php echo $entry_column_quantity; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php if ($sort == 'column_price') { ?>
                                        <a href="<?php echo $sort_column_price; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_column_price; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_column_price; ?>"><?php echo $entry_column_price; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php if ($sort == 'column_price_opt') { ?>
                                        <a href="<?php echo $sort_column_price_opt; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_column_price_opt; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_column_price_opt; ?>"><?php echo $entry_column_price_opt; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php if ($sort == 'column_barcode') { ?>
                                        <a href="<?php echo $sort_column_barcode; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_barcode; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_column_barcode; ?>"><?php echo $entry_barcode; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php if ($sort == 'column_sku') { ?>
                                        <a href="<?php echo $sort_column_sku; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_sku; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_column_sku; ?>"><?php echo $entry_sku; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php if ($sort == 'type') { ?>
                                        <a href="<?php echo $sort_type; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_type; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_type; ?>"><?php echo $entry_type; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php echo $entry_action; ?></td>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if ($vendor) { ?>
                                <?php foreach ($vendor as $provider) { ?>
                                <tr>
                                    <td class="text-center"><?php if (in_array($provider['id'], $selected)) { ?>
                                        <input type="checkbox" name="selected[]" value="<?php echo $provider['id']; ?>" checked="checked" />
                                        <?php } else { ?>
                                        <input type="checkbox" name="selected[]" value="<?php echo $provider['id']; ?>" />
                                        <?php } ?></td>
                                    <?php if($provider['type']==301){$response_code_provider='301 Перемещено навсегда';}elseif($provider['type']==302){$response_code_provider='302 Временное перемещение';}elseif($provider['type']==307){$response_code_provider='307 Перемещено временно';}?>
                                    <td class="text-left"><?php echo $provider['code']; ?></td>
                                    <td class="text-left"><?php echo $provider['name']; ?></td>
                                    <td class="text-left"><?php echo $provider['list']; ?></td>
                                    <td class="text-left"><?php echo $provider['column_quantity']; ?></td>
                                    <td class="text-left"><?php echo $provider['column_price']; ?></td>
                                    <td class="text-left"><?php echo $provider['column_price_opt']; ?></td>
                                    <td class="text-left"><?php echo $provider['column_barcode']; ?></td>
                                    <td class="text-left"><?php echo $provider['column_sku']; ?></td>
                                    <td class="text-left">                        
                                        <?php foreach (range(0, 2) as $i) { ?>
                                        <?php echo ($provider['type']==$i)? $type_data_processing[$i]: '' ; ?>
                                        <?php } ?></td>
                                    <td class="text-right"><a href="<?php echo $provider['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                                </tr>
                                <?php } ?>
                                <?php } else { ?>
                                <tr>
                                    <td class="text-center" colspan="11"><?php echo $text_no_results; ?></td>
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
        var url = 'index.php?route=tool/neoseo_price_import_vendor&token=<?php echo $token; ?>';

        var filter_type = $('select[name=\'filter_type\']').val();
        if (filter_type !== '*') {
            url += '&filter_type=' + encodeURIComponent(filter_type);
        }
        var filter_code = $('input[name=\'filter_code\']').val();

        if (filter_code) {
            url += '&filter_code=' + encodeURIComponent(filter_code);
        }
        var filter_name = $('input[name=\'filter_name\']').val();

        if (filter_name) {
            url += '&filter_name=' + encodeURIComponent(filter_name);
        }
        location = url;
    });
</script>
<script>$('.date').datetimepicker({
        pickTime: false
    });</script>
<?php echo $footer; ?>
