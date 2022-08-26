<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <a href="<?php echo $export; ?>" class="btn btn-primary"><i class="fa fa-file-excel-o"></i><span> <?php echo $button_export; ?></span></a> 
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
            <div class="panel-heading" >
                <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
            </div>
                <div class="panel-body">
                    <div class="well">
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label class=" control-label" for="input-date-available"><?php echo $entry_date; ?></label>
                                    <div class="input-group date">
                                        <input type="text" name="filter_date" value="<?php echo $filter_date; ?>"  placeholder="<?php echo $entry_date; ?>" data-date-format="YYYY-MM-DD" id="input-date-available" class="form-control" />
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label class="control-label" for="input-model"><?php echo $entry_email; ?></label>
                                    <input type="text" name="filter_email" value="<?php echo $filter_email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-model" class="form-control" />
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label class="control-label" for="store_id"><?php echo $entry_store; ?></label>
                                    <select name="store_id" id="store_id" class="form-control">
                                        <option><?php echo $entry_all_stores; ?></option>
                                        <option value="0" <?php if (empty($store_id)) echo 'selected' ?>><?php echo $text_default ?></option>
                                        <?php 
                                            foreach($stores as $store){
                                                echo '<option value="' . $store['store_id'] . '" ' . ((int)$store_id == (int)$store['store_id'] ? 'selected' : '') .' >' . $store['name'] . '  </option>';
                                            }
                                        ?>
                                    </select>
                                </div>
                            </div>                            
                            <div class="col-sm-2">
                                <button style="margin-top: 34px;" type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
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
                                        <td class="text-center"><?php if ($sort == 'email') { ?>
                                            <a href="<?php echo $sort_email; ?>" class="<?php echo strtolower($order); ?>"><?php echo $entry_email; ?></a>
                                            <?php } else { ?>
                                            <a href="<?php echo $sort_email; ?>"><?php echo $entry_email; ?></a>
                                            <?php } ?></td>
                                        <td class="text-center"><?php echo $entry_name; ?></td>
                                        <td class="text-center"><?php echo $entry_store; ?></td>
                                        <td class="text-center"><?php echo $entry_action; ?></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if ($subscribe) { ?>
                                    <?php foreach ($subscribe as $subsc) { ?>
                                    <tr>
                                        <td class="text-center"><?php if (in_array($subsc['subscribe_id'], $selected)) { ?>
                                            <input type="checkbox" name="selected[]" value="<?php echo $subsc['subscribe_id']; ?>" checked="checked" />
                                            <?php } else { ?>
                                            <input type="checkbox" name="selected[]" value="<?php echo $subsc['subscribe_id']; ?>" />
                                            <?php } ?></td>
                                        <td class="text-left"><?php echo $subsc['date']; ?></td>
                                        <td class="text-left"><?php echo $subsc['email']; ?></td>
                                        <td class="text-left"><?php echo $subsc['name']; ?></td>
                                        <td class="text-left"><?php echo (!empty($subsc['store']) ? $subsc['store'] : $text_default ); ?></td>
                                        <td class="text-right"><a href="<?php echo $subsc['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                                    </tr>
                                    <?php } ?>
                                    <?php } else { ?>
                                    <tr>
                                        <td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
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
        $(function () {
            $('#button-filter').on('click', function () {
                var url = 'index.php?route=customer/neoseo_subscribe&token=<?php echo $token; ?>';

                var filter_date = $('input[name=\'filter_date\']').val();
                if (filter_date) {
                    url += '&filter_date=' + encodeURIComponent(filter_date);
                }
                var filter_email = $('input[name=\'filter_email\']').val();
                if (filter_email) {
                    url += '&filter_email=' + encodeURIComponent(filter_email);
                }

                var store_id = $('select#store_id').val();
                if (store_id) {
                    url += '&store_id=' + encodeURIComponent(store_id);
                }

                location = url;
            });
        });
    </script>
    <script>$('.date').datetimepicker({
            pickTime: false
        });</script>
    <?php echo $footer; ?>
