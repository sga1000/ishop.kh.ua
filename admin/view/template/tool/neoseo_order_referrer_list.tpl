<?php echo $header; ?><?php echo $result_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
                <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-attribute').submit() : false;"><i class="fa fa-trash-o"></i></button>
            </div>
            <img width="36" height="36" style="float:left;margin-right: 10px;" src="view/image/neoseo.png" alt=""> 
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
            <div class="panel-heading" style=" height: 58px;">
                <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
                <div class="pull-right">
                    <form id="import" action="<?php echo $import; ?>"  method="post" enctype="multipart/form-data" class="form-inline">
                        <div class="form-group">
                            <input type="file" name="filename" />   
                        </div>
                        <a onclick="if (confirm('<?php echo $text_import_warning; ?>')) {
                                $('#import').submit()
                                }" class="btn btn-primary"><i class="fa fa-file-excel-o"></i> <span><?php echo $button_import; ?></span></a>
                        <a href="<?php echo $export; ?>" class="btn btn-primary"><i class="fa fa-file-excel-o"></i><span> <?php echo $button_export; ?></span></a> 
                    </form>
                </div>   </div>
            <div class="panel-body">
                <div class="well">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="control-label" for="input-status"><?php echo $entry_name;  ?></label>
                                <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-model" class="form-control" />

                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="control-label" for="input-model"><?php echo $entry_url_param; ?></label>
                                <input type="text" name="filter_url_param" value="<?php echo $filter_url_param; ?>" placeholder="<?php echo $entry_url_param; ?>" id="input-model" class="form-control" />
                            </div>
                        </div>

                        <div class="col-sm-4">
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class=" control-label" for="input-date-available"><?php echo $entry_url_mask; ?></label>

                                <input type="text" name="filter_url_mask" value="<?php echo $filter_url_mask; ?>"  placeholder="<?php echo $entry_url_mask; ?>" id="input-model" class="form-control" />

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
                                    <?php if ($sort == 'name') { ?>
                                        <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_name; ?></a>
                                    <?php } else { ?>
                                        <a href="<?php echo $sort_name; ?>"><?php echo $entry_name; ?></a>
                                    <?php } ?></td>
                                <td class="text-center"><?php if ($sort == 'url_param') { ?>
                                        <a href="<?php echo $sort_url_param; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_url_param; ?></a>
                                    <?php } else { ?>
                                        <a href="<?php echo $sort_url_param; ?>"><?php echo $entry_url_param; ?></a>
                                    <?php } ?></td>
                                <td class="text-center"><?php if ($sort == 'url_mask') { ?>
                                        <a href="<?php echo $sort_url_mask; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_url_mask; ?></a>
                                    <?php } else { ?>
                                        <a href="<?php echo $sort_url_mask; ?>"><?php echo $entry_url_mask; ?></a>
                                    <?php } ?></td>
                                <td class="text-center"><?php echo $column_action; ?></td>
                            </tr>
                            </thead>
                            <tbody>
                            <?php if ($items) { ?>
                                <?php foreach ($items as $item) { ?>
                                    <tr>
                                        <td class="text-center"><?php if (in_array($item['pattern_id'], $selected)) { ?>
                                                <input type="checkbox" name="selected[]" value="<?php echo $item['pattern_id']; ?>" checked="checked" />
                                            <?php } else { ?>
                                                <input type="checkbox" name="selected[]" value="<?php echo $item['pattern_id']; ?>" />
                                            <?php } ?></td>
                                        <td class="text-left"><?php echo $item['name']; ?></td>
                                        <td class="text-left"><?php echo $item['url_param']; ?></td>
                                        <td class="text-left"><?php echo $item['url_mask']; ?></td>
                                        <td class="text-right"><a href="<?php echo $item['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                                    </tr>
                                <?php } ?>
                            <?php } else { ?>
                                <tr>
                                    <td class="text-center" colspan="9"><?php echo $text_no_results; ?></td>
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
        var url = 'index.php?route=tool/neoseo_order_referrer&token=<?php echo $token; ?>';

        var filter_name = $('input[name=\'filter_name\']').val();

        if (filter_name) {
            url += '&filter_name=' + encodeURIComponent(filter_name);
        }
        var filter_url_param = $('input[name=\'filter_url_param\']').val();

        if (filter_url_param) {
            url += '&filter_url_param=' + encodeURIComponent(filter_url_param);
        }

        var filter_url_mask = $('input[name=\'filter_url_mask\']').val();

        if (filter_url_mask) {
            url += '&filter_url_mask=' + encodeURIComponent(filter_url_mask);
        }
        location = url;
    });


</script>
<?php echo $footer; ?>
