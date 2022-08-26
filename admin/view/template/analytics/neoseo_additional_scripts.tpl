<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_additional_scripts_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>
    <div id="content">
        <div class="page-header">
            <div class="container-fluid">
                <div class="pull-right">
                    <?php if( !isset($license_error) ) { ?>
                        <button type="submit" name="action" id='save_form' value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                        <button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
                    <?php } else { ?>
                        <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
                    <?php } ?>
                    <a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
                </div>
                <img width="36" height="36" style="float:left;margin-right: 10px;" src="view/image/neoseo.png" alt=""> 
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
                <div class="panel-heading">
                    <h3 class="panel-title "><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
                </div>

                <div class="panel-body">

                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                        <?php if( !isset($license_error) ) { ?>
                            <li><a href="#tab-scripts" data-toggle="tab"><?php echo $tab_scripts; ?></a></li>
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
                                <?php } else { ?>

                                    <div><?php echo $license_error; ?></div>

                                <?php } ?>
                            </div>

                            <?php if( !isset($license_error) ) { ?>
                                <div class="tab-pane" id="tab-scripts">
                                    <div class="col-xs-4 col-md-3 col-lg-3 tabs-left">
                                        <ul class="nav nav-pills nav-stacked" id="custom-tabs-header">
                                            <?php $first = true; foreach ($neoseo_additional_scripts_code as $key => $script) { ?>
                                                <li <?php if($first) { $first = false; echo 'class="active"'; }?>>
                                                    <a data-toggle="pill" href="#tab-script-<?php echo $key; ?>" id="nav_script_<?php echo $key; ?>">
                                                        <?php echo $script['name']; ?>
                                                        <button type="button" class="btn btn-xs btn-link delete-tab" rel="tooltip"
                                                                data-original-title="Delete this import" data-container="body"
                                                                onclick="deleteScript( <?php echo $key ?> )">
                                                            <i class="fa fa-trash text-danger"></i>
                                                        </button>
                                                    </a>
                                                </li>
                                            <?php } ?>
                                            <li>
                                                <div class="input-group">
                                                    <input type="text" class="form-control" id="new-tab" placeholder="New script name" data-bind="value: newTabName">
                                                    <span class="input-group-btn">
                                                        <button type="button" id="add-new-script" class="btn btn-default" rel="tooltip"
                                                                data-original-title="Add a new import" data-container="body">
                                                            <i class="fa fa-plus-circle text-success"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>

                                    <div class="col-xs-8 col-md-9 col-lg-9">
                                        <div class="tab-content">
                                            <?php $first = true; foreach ($neoseo_additional_scripts_code as $key => $script) { ?>
                                                <?php if (!isset($max_id)) $max_id = $key; ?>
                                                <div class="tab-pane <?php if($first) { $first = false; echo 'active'; }?>" id="tab-script-<?php echo $key; ?>">

                                                    <?php $widgets->dropdownA('status', 'neoseo_additional_scripts_code',$key, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
                                                    <?php $widgets->inputA('name', 'neoseo_additional_scripts_code',$key); ?>
                                                    <?php $widgets->localeTextareaA('script', 'neoseo_additional_scripts_code',$key,$languages, 12); ?>

                                                </div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>
                            <?php } ?>

                            <?php if( !isset($license_error) ) { ?>
                                <div class="tab-pane" id="tab-logs">
                                    <?php $widgets->debug_download_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $download, $button_clear_log, $button_download_log); ?>
                                    <textarea class="form-control" rows="10"><?php echo $logs; ?></textarea>
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

        $(function() {

            // Обработка хеш-тегов для табов
            var tabs = [];
            $('.panel-body:first > .nav-tabs li').each(function(index) {
                var obj = $(this).children().prop('href');
                tabs.push(obj.substring(obj.indexOf('#')));
            });
            if (window.location.hash.indexOf('#tab') == 0 && $("[href=" + window.location.hash + "]").length) {
                $(".panel-body > .nav-tabs li").removeClass("active");
                $("[href=" + window.location.hash + "]").parents('li').addClass("active");
                $(".panel-body:first .tab-content:first .tab-pane:first").removeClass("active");
                $(window.location.hash).addClass("active");
            }
            $(".panel-body").delegate(".nav-tabs li a", 'click', function() {
                var url = $(this).prop('href');
                var tab = url.substring(url.indexOf('#'));

                if ($.inArray(tab, tabs) != -1) {
                    window.location.hash = tab;
                }
            });
        });
//--></script>
    <script type="text/javascript"><!--
        function deleteScript(id) {
            if (!confirm('<?php echo $text_confirm; ?>'))
                return false;
            $('#nav_script_' + id).remove();
            $('#tab-script-' + id).remove();
            $('#save_form').click();
            return true;
        }
        var one_touch = false;
        window.token = '<?php echo $token; ?>';
        var template = '<?php echo $script_form; ?>';
        var count_script = <?php echo (isset($max_id) ? $max_id : 0) ?>;
        if (!count_script)
            count = $("#tab-pills a").length; //заменить на максимальный айди фида

        $("#add-new-script").click(function() {
            if (one_touch)
                return false;
            one_touch = true;
            var name = $("#new-tab").val();
            var tmp_template = template.replace("new-script-name", name);
            $(".nav-pills li").removeClass('active');
            $("#tab-scripts .tab-content:first .tab-pane:first").removeClass('active');
            $(".nav-pills").prepend("<li class='active'><a data-toggle='tab' href='#tab-script-" + count_script + "' id='nav_script_" + count_script + "'>" + name + "</a></li>");
            $("#tab-scripts .tab-content:first").append("<div class='tab-pane active' id='tab-script-" + count_script + "'>" + tmp_template + "</div>");
            $(".nav-pills li:last a").trigger('click');
        });
        //--></script>
<?php echo $footer; ?>