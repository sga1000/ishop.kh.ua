<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">

    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if (!isset($license_error)) { ?>
                <button class="btn btn-primary" data-toggle="tooltip" form="form" name="action"
                        title="<?php echo $button_save; ?>"
                        type="submit" value="save"><i
                        class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <button class="btn btn-default" data-toggle="tooltip" form="form" name="action"
                        title="<?php echo $button_save_and_close; ?>"
                        type="submit" value="save_and_close"><i
                        class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
                <?php } else { ?>
                <a class="btn btn-primary" data-toggle="tooltip" href="<?php echo $recheck; ?>"
                   title="<?php echo $button_recheck; ?>"/><i
                   class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
                <?php } ?>
                <a class="btn btn-default" data-toggle="tooltip" href="<?php echo $close; ?>"
                   title="<?php echo $button_close; ?>"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
            </div>

            <img alt="" height="36" src="view/image/neoseo.png" style="float:left" width="36"/>
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
            <button class="close" data-dismiss="alert" type="button">&times;</button>
        </div>
        <?php } ?>

        <?php if (isset($success) && $success) { ?>
        <div class="alert alert-success">
            <i class="fa fa-check-circle"></i>
            <?php echo $success; ?>
            <button class="close" data-dismiss="alert" type="button">&times;</button>
        </div>
        <?php } ?>

        <div class="panel panel-default">
            <div class="panel-body">

                <ul class="nav nav-tabs">

                    <li class="active"><a data-toggle="tab" href="#tab-general"><?php echo $tab_general; ?></a></li>
                    <?php if (!isset($license_error)) { ?>
                    <li><a data-toggle="tab" href="#tab-logs"><?php echo $tab_logs; ?></a></li>
                    <?php } ?>
                    <li><a data-toggle="tab" href="#tab-support"><?php echo $tab_support; ?></a></li>
                    <li><a data-toggle="tab" href="#tab-usefull"><?php echo $tab_usefull; ?></a></li>
                    <li><a data-toggle="tab" href="#tab-license"><?php echo $tab_license; ?></a></li>
                </ul>

                <form action="<?php echo $save; ?>" enctype="multipart/form-data" id="form" method="post">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">

                            <?php if (!isset($license_error)) { ?>

                            <?php $widgets->dropdown('status', array(0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('status_more_btn_enable', array(0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('status_pagination', array(0 => $text_disabled, 1 => $text_enabled)); ?>

                            <?php } else { ?>

                            <?php echo $license_error; ?>

                            <?php } ?>

                        </div>

                        <?php if (!isset($license_error)) { ?>
                        <div class="tab-pane" id="tab-logs">
                            <?php $widgets->debug_download_logs('debug', array(0 => $text_disabled, 1 => $text_enabled), $clear, $download, $button_clear_log, $button_download_log); ?>
                            <textarea
                                style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
                        </div>

                        <div class="tab-pane" id="tab-support">
                            <?php echo $mail_support; ?>
                        </div>
                        <div class="tab-pane" id="tab-usefull">
                            <?php $widgets->usefullLinks(); ?>
                        </div>
                        <div class="tab-pane" id="tab-license">
                            <?php echo $module_licence; ?>
                        </div>
                        <?php } ?>

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
        if (url.indexOf('#') != -1) {
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

    //--></script>
<?php echo $footer; ?>