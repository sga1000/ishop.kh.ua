<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <a onclick="location = '<?php echo $clear; ?>'" class="btn btn-primary"><span><?php echo $button_clear_cache; ?></span></a>
                <a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
                <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-attribute').submit() : false;"><i class="fa fa-trash-o"></i></button>
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
                <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3></div>
            <div class="panel-body">
                <div class="well">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="control-label" for="input-model"><?php echo $column_query; ?></label>
                                <input type="text" name="filter_query" value="<?php echo $filter_query; ?>" placeholder="<?php echo $column_query; ?>" id="input-model" class="form-control" />
                            </div>  </div>

                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="control-label" for="input-price"><?php echo $column_keyword; ?></label>
                                <input type="text" name="filter_keyword" value="<?php echo $filter_keyword; ?>"  placeholder="<?php echo $column_keyword; ?>" id="input-price" class="form-control" />
                            </div>   </div>
                        </div>
                     <div class="row">
                        <div class="col-sm-12" style="float:left;">
                            <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
                        </div> </div>
                </div>

                <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-attribute">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <td style="width: 1px;" class="text-center">
                                        <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" />
                                    </td>
                                    <td class="text-center">
                                        <?php if ($sort == 'ua.query') { ?>
                                            <a href="<?php echo $sort_query; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_query; ?></a>
                                        <?php } else { ?>
                                            <a href="<?php echo $sort_query; ?>"><?php echo $column_query; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center">
                                        <?php if ($sort == 'ua.keyword') { ?>
                                            <a href="<?php echo $sort_keyword; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_keyword; ?></a>
                                        <?php } else { ?>
                                            <a href="<?php echo $sort_keyword; ?>"><?php echo $column_keyword; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php echo $column_action; ?></td>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if ($url_aliases) { ?>
                                    <?php foreach ($url_aliases as $url_alias) { ?>
                                        <tr>
                                            <td class="text-center"><?php if ($url_alias['selected']) { ?>
                                                <input type="checkbox" name="selected[]" value="<?php echo $url_alias['url_alias_id']; ?>" checked="checked" />
                                                <?php } else { ?>
                                                <input type="checkbox" name="selected[]" value="<?php echo $url_alias['url_alias_id']; ?>" />
                                                <?php } ?></td>
                                            <td class="text-left"><?php echo $url_alias['query']; ?></td>
                                            <td class="text-left"><?php echo $url_alias['keyword']; ?></td>
                                            <td class="text-right"><a href="<?php echo $url_alias['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
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
    $(function () {
        $('#button-filter').on('click', function () {
            var url = 'index.php?route=tool/neoseo_route_manager&token=<?php echo $token; ?>';
            var filter_query = $('input[name=\'filter_query\']').val();

            if (filter_query) {
                url += '&filter_query=' + encodeURIComponent(filter_query);
            }
            var filter_keyword = $('input[name=\'filter_keyword\']').val();

            if (filter_keyword) {
                url += '&filter_keyword=' + encodeURIComponent(filter_keyword);
            }

            location = url;
        });
    });
</script>

<?php echo $footer; ?>
