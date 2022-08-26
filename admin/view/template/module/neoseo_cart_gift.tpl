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

        <?php if ($error_warning) { ?>
        <div class="alert alert-danger">
            <i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>

        <?php if (isset($success) && $success) { ?>
        <div class="alert alert-success">
            <i class="fa fa-check-circle"></i>
            <?php echo $success; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>

        <div class="panel panel-default">
            <div class="panel-body">

                <ul class="nav nav-tabs">

                    <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                    <?php if( !isset($license_error) ) { ?>
                    <li><a href="#tab-gifts" data-toggle="tab"><?php echo $tab_gifts; ?></a></li>
                    <li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
                    <?php } ?>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                    <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>

                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">
                            <?php if( !isset($license_error) ) { ?>

                            <?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->localeInput('title', $languages); ?>
                            <?php $widgets->localeInput('gift_title', $languages); ?>
                            <?php $widgets->dropdown('show_gifts',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('allow_on_empty_cart',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->localeInput('empty_cart_text', $languages); ?>
                            <?php $widgets->dropdown('new_user', $help_gifts); ?>
                            <?php $widgets->input('image_width'); ?>
                            <?php $widgets->input('image_height'); ?>
                            <?php $widgets->checklist('product_statuses', $stock_statuses); ?>

                            <?php } else { ?>

                            <?php echo $license_error; ?>

                            <?php } ?>

                        </div>

                        <div class="tab-pane" id="tab-gifts">

                            <?php if( !isset($license_error) ) { ?>
                            <div class="container-fluid page-header">
                                <div class="pull-right"><a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
                                    <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? deleteGifts() : false;"><i class="fa fa-trash-o"></i></button>
                                </div>
                            </div>
                            <form>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                        <tr>
                                            <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                                            <td class="text-left"><?php if ($sort == 'name') { ?>
                                                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_gift_name; ?></a>
                                                <?php } else { ?>
                                                <a href="<?php echo $sort_name; ?>"><?php echo $column_gift_name; ?></a>
                                                <?php } ?></td>
                                            <td class="text-left"><?php if ($sort == 'min_price') { ?>
                                                <a href="<?php echo $sort_min_price; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_min_price; ?></a>
                                                <?php } else { ?>
                                                <a href="<?php echo $sort_min_price; ?>"><?php echo $column_min_price; ?></a>
                                                <?php } ?></td>
                                            <td class="text-left"><?php if ($sort == 'status') { ?>
                                                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                                                <?php } else { ?>
                                                <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                                                <?php } ?></td>
                                            <td class="text-right"><?php echo $column_action; ?></td>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <?php if ($gifts) { ?>
                                        <?php foreach ($gifts as $gift) { ?>
                                        <tr>
                                            <td class="text-center">
                                                <?php if (in_array($gift['gift_id'], $selected)) { ?>
                                                <input type="checkbox" name="selected[]" value="<?php echo $gift['gift_id']; ?>" checked="checked" />
                                                <?php } else { ?>
                                                <input type="checkbox" name="selected[]" value="<?php echo $gift['gift_id']; ?>" />
                                                <?php } ?></td>
                                            <td class="text-left"><?php echo $gift['name']; ?></td>
                                            <td class="text-left"><?php echo $gift['min_price']; ?></td>
                                            <td class="text-left"><?php $statuses = [0=>$text_disabled, 1=>$text_enabled]; echo $statuses[$gift['status']]; ?></td>
                                            <td class="text-right">
                                                <a href="<?php echo $gift['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
                                                <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? location = '<?php echo $gift['delete']; ?>' : false;"><i class="fa fa-trash-o"></i></button>
                                            </td>
                                        </tr>
                                        <?php } ?>
                                        <?php } else { ?>
                                        <tr>
                                            <td class="text-center" colspan="5"><?php echo $text_no_results; ?></td>
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
                            <?php } else { ?>

                            <?php echo $license_error; ?>

                            <?php } ?>

                        </div>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-logs">
                            <?php $widgets->debug_download_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $download, $button_clear_log, $button_download_log); ?>
                            <textarea style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
                        </div>
                        <?php } ?>

                        <div class="tab-pane" id="tab-support">
                            <?php echo $mail_support; ?>
                        </div>

                        <div class="tab-pane" id="tab-license">
                            <?php echo $module_licence; ?>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

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

    function deleteGifts() {
        var giftsId = [];
        $("input[name='selected[]']").each(function () {
            if ($(this)[0].checked) giftsId.push($(this).val());
        })
        var data = {
            selected : giftsId
        }
        var URL = 'index.php?route=module/neoseo_cart_gift/deleteGifts&token=<?php echo $token; ?>';
        $.post(URL,data,function (response) {
            if (response.success) window.location.reload();
        });
    }
    //--></script>
<?php echo $footer; ?>