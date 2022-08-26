<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right"><a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
                <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-neoseo_testimonials').submit() : false;"><i class="fa fa-trash-o"></i></button>
            </div>
            <h1><?php echo $heading_title; ?></h1>
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
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                                <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-author" class="form-control" />
                            </div>

                            <div class="form-group">
                                <label class="control-label" for="input-description"><?php echo $entry_description; ?></label>
                                <input type="text" name="filter_description" value="<?php echo $filter_description; ?>" placeholder="<?php echo $entry_description; ?>" id="input-author" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="input-store"><?php echo $entry_store;  ?></label>
                                <select placeholder="<?php echo $entry_store;?>" name='filter_store' class='form-control'>
                                    <?php if (!isset($filter_store)) { ?>
                                    <option value="" selected="selected"></option>
                                    <?php }else { ?>
                                    <option value=""></option>
                                    <?php } ?>
                                    <?php foreach ($stores as $store_id => $store_data) { ?>
                                    <?php if (isset($filter_store) && $filter_store == $store_id ) { ?>
                                    <option value="<?php echo $store_id; ?>" selected="selected"><?php echo $store_data['name']; ?></option>
                                    <?php } else { ?>
                                    <option value="<?php echo $store_id; ?>"><?php echo $store_data['name']; ?></option>
                                    <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label" for="input-status"><?php echo $entry_status; ?></label>
                                <select name="filter_status" id="input-status" class="form-control">
                                    <option value="*"></option>
                                    <?php if ($filter_status) { ?>
                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                    <?php } else { ?>
                                    <option value="1"><?php echo $text_enabled; ?></option>
                                    <?php } ?>
                                    <?php if (!$filter_status && !is_null($filter_status)) { ?>
                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="input-date-added"><?php echo $entry_date_added; ?></label>
                                <div class="input-group date">
                                    <input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" placeholder="<?php echo $entry_date_added; ?>" data-date-format="YYYY-MM-DD" id="input-date-added" class="form-control" />
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                    </span></div>
                            </div>
                            <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
                        </div>
                    </div>
                </div>
                <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-neoseo_testimonials">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                            <tr>
                                <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                                <td class="text-left"><?php if ($sort == 't.name') { ?>
                                    <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                                    <?php } ?></td>
                                <td class="text-left"><?php if ($sort == 't.description') { ?>
                                    <a href="<?php echo $sort_description; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_description; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_description; ?>"><?php echo $column_description; ?></a>
                                    <?php } ?></td>
                                <td class="text-left"><?php if ($sort == 't.admin_text') { ?>
                                    <a href="<?php echo $sort_admin_text; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_admin_text; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_admin_text; ?>"><?php echo $column_admin_text; ?></a>
                                    <?php } ?></td>
                                <td class="text-right"><?php if ($sort == 't.rating') { ?>
                                    <a href="<?php echo $sort_rating; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_rating; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_rating; ?>"><?php echo $column_rating; ?></a>
                                    <?php } ?></td>
                                <td class="text-left"><?php if ($sort == 't.status') { ?>
                                    <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                                    <?php } ?></td>
                                <td class="text-left"><?php if ($sort == 't.store_id') { ?>
                                    <a href="<?php echo $sort_store; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_store; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_store; ?>"><?php echo $column_store; ?></a>
                                    <?php } ?></td>
                                <td class="text-left"><?php if ($sort == 't.date_added') { ?>
                                    <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                                    <?php } ?></td>
                                <td class="text-right"><?php echo $column_action; ?></td>
                            </tr>
                            </thead>
                            <tbody>

                            <?php if (isset($testimonials)) { ?>
                            <?php foreach ($testimonials as $neoseo_testimonial) { ?>
                            <tr>
                                <td class="text-center"><?php if (in_array($neoseo_testimonial['testimonial_id'], $selected)) { ?>
                                    <input type="checkbox" name="selected[]" value="<?php echo $neoseo_testimonial['testimonial_id']; ?>" checked="checked" />
                                    <?php } else { ?>
                                    <input type="checkbox" name="selected[]" value="<?php echo $neoseo_testimonial['testimonial_id']; ?>" />
                                    <?php } ?></td>
                                <td class="text-left"><?php echo $neoseo_testimonial['name']; ?></td>
                                <td class="text-left"><?php echo $neoseo_testimonial['description']; ?></td>
                                <td class="text-left"><?php echo $neoseo_testimonial['admin_text']; ?></td>
                                <td class="text-right"><?php echo $neoseo_testimonial['rating']; ?></td>
                                <td class="text-left"><?php echo $neoseo_testimonial['status']; ?></td>
                                <td class="text-left"><?php echo $neoseo_testimonial['store']; ?></td>
                                <td class="text-left"><?php echo $neoseo_testimonial['date_added']; ?></td>
                                <td class="text-right"><a href="<?php echo $neoseo_testimonial['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                            </tr>
                            <?php } ?>
                            <?php } else { ?>
                            <tr>
                                <td class="text-center" colspan="7"><?php echo $text_no_results; ?></td>
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

    <script type="text/javascript"><!--
        $('.date').datetimepicker({
            pickTime: false
        });
        //--></script>
    <script type="text/javascript">
        $(function () {

            $('#button-filter').on('click', function () {
                console.log(1334);
                var url = 'index.php?route=catalog/neoseo_testimonials&token=<?php echo $token; ?>';


                var filter_name = $('input[name=\'filter_name\']').val();

                if (filter_name) {
                    url += '&filter_name=' + encodeURIComponent(filter_name);
                }
                var filter_description = $('input[name=\'filter_description\']').val();

                if (filter_description) {
                    url += '&filter_description=' + encodeURIComponent(filter_description);
                }

                var filter_status = $('select[name=\'filter_status\']').val();
                if (filter_status != '*') {
                    url += '&filter_status=' + encodeURIComponent(filter_status);
                }
                var filter_store = $('select[name=\'filter_store\']').val();
                if (filter_store != '') {
                    url += '&filter_store=' + encodeURIComponent(filter_store);
                }
                var filter_date_added = $('input[name=\'filter_date_added\']').val();
                // console.log(filter_date_start);
                if (filter_date_added) {
                    url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
                }
                location = url;
            });
        });
    </script>
</div>
<?php echo $footer; ?>