<?php echo $header; ?><?php echo $result_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
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
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
            </div>
            <div class="panel-body">
                <div class="well">
                    <div class="row">
                        <div class="col-sm-2">
                            <div class="form-group">
                                <label class="control-label" for="input-date"><?php echo $entry_date; ?></label>
                                <div class="input-group date">
                                    <input type="text" name="filter_date" value="<?php echo $filter_date; ?>" placeholder="<?php echo $entry_date; ?>" data-date-format="YYYY-MM-DD" id="input-date-added" class="form-control" />
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                    </span></div>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="input-order-status"><?php echo $entry_status; ?></label>
                                <select name="filter_status" id="input-status" class="form-control">
                                    <option value="*"></option>
                                    <?php if (!$filter_status && !is_null($filter_status)) { ?>
                                    <option value="0" selected="selected"><?php echo $text_status_new; ?></option>
                                    <?php } else { ?>
                                    <option value="0"><?php echo $text_status_new; ?></option>
                                    <?php } ?>
                                    <?php if ($filter_status) { ?>
                                    <option value="1" selected="selected"><?php echo $text_status_done; ?></option>
                                    <?php } else { ?>
                                    <option value="1"><?php echo $text_status_done; ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group">
                                <label class="control-label" for="input-phone"><?php echo $entry_phone; ?></label>
                                <input type="text" name="filter_phone" value="<?php echo $filter_phone; ?>" placeholder="<?php echo $entry_phone; ?>" id="input-phone" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
                                <input type="text" name="filter_email" value="<?php echo $filter_email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="control-label" for="input-name"><?php echo $entry_name;  ?></label>
                                <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label class=" control-label" for="input-manager"><?php echo $entry_manager; ?></label>
                                <input type="text" name="filter_manager" value="<?php echo $filter_manager; ?>"  placeholder="<?php echo $entry_manager; ?>" id="input-manager" class="form-control" />
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="control-label" for="input-comment"><?php echo $entry_comment; ?></label>
                                <input type="text" name="filter_comment" value="<?php echo $filter_comment; ?>" placeholder="<?php echo $entry_comment; ?>" id="input-comment" class="form-control" />
                            </div>
                            <div class="form-group">
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
                                    <?php if ($sort == 'date') { ?>
                                    <a href="<?php echo $sort_date; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_date; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_date; ?>"><?php echo $entry_date; ?></a>
                                    <?php } ?></td>
                                <td class="text-center">
                                    <?php if ($sort == 'name') { ?>
                                    <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_name; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_name; ?>"><?php echo $entry_name; ?></a>
                                    <?php } ?></td>
                                <td class="text-center"><?php if ($sort == 'phone') { ?>
                                    <a href="<?php echo $sort_phone; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_phone; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_phone; ?>"><?php echo $entry_phone; ?></a>
                                    <?php } ?></td>
                                <td class="text-center"><?php if ($sort == 'email') { ?>
                                    <a href="<?php echo $sort_email; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_email; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_email; ?>"><?php echo $entry_email; ?></a>
                                    <?php } ?></td>
                                <td class="text-center"><?php if ($sort == 'message') { ?>
                                    <a href="<?php echo $sort_message; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_message; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_message; ?>"><?php echo $entry_message; ?></a>
                                    <?php } ?></td>
                                <td class="text-center"><?php if ($sort == 'time_from') { ?>
                                    <a href="<?php echo $sort_time_from; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_time.' '.$entry_time_from; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_time_from; ?>"><?php echo $entry_time.' '.$entry_time_from; ?></a>
                                    <?php } ?></td>
                                <td class="text-center"><?php if ($sort == 'time_to') { ?>
                                    <a href="<?php echo $sort_time_to; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_time.' '.$entry_time_to; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_time_to; ?>"><?php echo $entry_time.' '.$entry_time_to; ?></a>
                                    <?php } ?></td>
                                <td class="text-center"><?php if ($sort == 'comment') { ?>
                                    <a href="<?php echo $sort_comment; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_comment; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_comment; ?>"><?php echo $entry_comment; ?></a>
                                    <?php } ?></td>
                                <td class="text-center"><?php if ($sort == 'manager') { ?>
                                    <a href="<?php echo $sort_manager; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_manager; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_manager; ?>"><?php echo $entry_manager; ?></a>
                                    <?php } ?></td>
                                <td class="text-center"><?php if ($sort == 'status') { ?>
                                    <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_status; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_status; ?>"><?php echo $entry_status; ?></a>
                                    <?php } ?></td>
                                <td class="text-center"><?php echo $column_action; ?></td>
                            </tr>
                            </thead>
                            <tbody>
                            <?php if (isset($items)) { ?>
                            <?php foreach ($items as $item) { ?>
                            <tr>
                                <td class="text-center"><?php if (in_array($item['callback_id'], $selected)) { ?>
                                    <input type="checkbox" name="selected[]" value="<?php echo $item['callback_id']; ?>" checked="checked" />
                                    <?php } else { ?>
                                    <input type="checkbox" name="selected[]" value="<?php echo $item['callback_id']; ?>" />
                                    <?php } ?></td>
                                <td class="text-left"><?php echo $item['date']; ?></td>
                                <td class="text-left"><?php echo $item['name']; ?></td>
                                <td class="text-left"><?php echo $item['phone']; ?></td>
                                <td class="text-left"><?php echo $item['email']; ?></td>
                                <td class="text-left"><?php echo $item['message']; ?></td>
                                <td class="text-left"><?php echo $item['time_from']; ?></td>
                                <td class="text-left"><?php echo $item['time_to']; ?></td>
                                <td class="text-left"><?php echo $item['comment']; ?></td>
                                <td class="text-left"><?php echo $item['manager']; ?></td>
                                <td class="text-left"><?php echo ($item['status']==0)? '<span class="label label-danger">'.$text_status_new.'</label>' : '<span class="label label-success">'.$text_status_done.'</label>'; ?></td>
                                <td class="text-right"><a href="<?php echo $item['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
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
        var url = 'index.php?route=sale/neoseo_callback&token=<?php echo $token; ?>';

        var filter_date = $('input[name=\'filter_date\']').val();

        if (filter_date) {
            url += '&filter_date=' + encodeURIComponent(filter_date);
        }
        var filter_name = $('input[name=\'filter_name\']').val();

        if (filter_name) {
            url += '&filter_name=' + encodeURIComponent(filter_name);
        }
        var filter_phone = $('input[name=\'filter_phone\']').val();

        if (filter_phone) {
            url += '&filter_phone=' + encodeURIComponent(filter_phone);
        }

        var filter_email = $('input[name=\'filter_email\']').val();

        if (filter_email) {
            url += '&filter_email=' + encodeURIComponent(filter_email);
        }

        var filter_comment = $('input[name=\'filter_comment\']').val();

        if (filter_comment) {
            url += '&filter_comment=' + encodeURIComponent(filter_comment);
        }
        var filter_manager = $('input[name=\'filter_manager\']').val();

        if (filter_manager) {
            url += '&filter_manager=' + encodeURIComponent(filter_manager);
        }

        var filter_status = $('select[name=\'filter_status\']').val();

        if (filter_status != '*') {
            url += '&filter_status=' + encodeURIComponent(filter_status);
        }
        location = url;
    });


</script>
<script type="text/javascript"><!--
    $('.date').datetimepicker({
        pickTime: false
    });
    //--></script>
<?php echo $footer; ?>
