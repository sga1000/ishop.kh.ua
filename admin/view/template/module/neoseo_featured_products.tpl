<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if( !isset($license_error) ) { ?>
                <button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
                <?php } else { ?>
                <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-default" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
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
                    <li><a href="#tab-module-tabs" data-toggle="tab" id="tab_module"><?php echo $tab_module_tabs; ?></a></li>
                    <li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
                    <?php } ?>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                    <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>

                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                    <div class="tab-content">

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane active" id="tab-general">
                            <?php $widgets->dropdown('status', array(  0 => $text_disabled, 1 => $text_enabled )); ?>
                            <?php $widgets->input('name'); ?>
                            <?php $widgets->dropdown('use_related', $params_use_related); ?>
                            <?php $widgets->localeInput('title', $languages); ?>
                            <?php $widgets->dropdown('template', $templates); ?>
                        </div>
                        <?php } ?>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-module-tabs">
                            <div class="col-xs-4 col-md-3 col-lg-3 tabs-left">
                                <ul class="nav nav-pills nav-stacked" id="custom-tabs-header">
                                    <?php $first = true; foreach ($tabs as $tab) { ?>
                                    <li <?php if($first) { $first = false; echo 'class="active"'; }?>>
                                        <a data-toggle="tab" href="#tab-label-<?php echo $tab['tab_id']; ?>">
                                            <?php echo $tab['name'][$language_id]; ?>
                                            <button type="button" class="btn btn-xs btn-link delete-tab" rel="tooltip"
                                                    data-original-title="Delete this label" data-container="body"
                                                    onclick="deleteTab( <?php echo $tab['tab_id'] ?> )">
                                                <i class="fa fa-trash text-danger"></i>
                                            </button>
                                        </a>
                                    </li>
                                    <?php } ?>
                                    <li>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="new-tab" placeholder="New tab name" data-bind="value: newTabName">
                                            <span class="input-group-btn">
                                                <button type="button" id="add-new-label" class="btn btn-default" rel="tooltip"
                                                        data-original-title="Add a new label" data-container="body">
                                                    <i class="fa fa-plus-circle text-success"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </li>
                                </ul>
                            </div>

                            <div class="col-xs-8 col-md-9 col-lg-9">
                                <div class="tab-content">

                                    <?php $first = true; foreach ($tabs as $tab) { ?>
                                    <?php if (!isset($max_id)) $max_id = $tab['tab_id']; ?>
                                    <div class="tab-pane <?php if($first) { $first = false; echo 'active'; }?>" id="tab-label-<?php echo $tab['tab_id']; ?>">
                                        <?php $widgets->dropdownA('status', 'tabs', $tab['tab_id'], array(  0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->inputA('order', 'tabs', $tab['tab_id']); ?>
                                        <div class="form-group" id="field_tabs-class-1" style="display: inline-block; width: 100%;">
                                            <div class="col-sm-5">
                                                <label class="control-label" ><?php echo $entry_name;?></label>
                                                <br>
                                            </div>
                                            <div class="col-sm-7">
                                                <?php foreach ($languages as $language) {  ?>    
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                                                    <input class="form-control" name="tabs[<?php echo $tab['tab_id']; ?>][name][<?php echo $language['language_id']; ?>]" value="<?php echo (isset($tab['name'][$language['language_id']])) ? $tab['name'][$language['language_id']] : ''; ?>"/>
                                                </div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                        <?php //$widgets->inputA('limit', 'tabs', $tab['tab_id']); ?>
                                        <?php $widgets->inputA('width', 'tabs', $tab['tab_id']); ?>
                                        <?php $widgets->inputA('height', 'tabs', $tab['tab_id']); ?>
                                        <?php $widgets->inputA('url', 'tabs', $tab['tab_id']); ?>
                                        <?php $widgets->inputA('url_text', 'tabs', $tab['tab_id']); ?>
                                        <div class="form-group" id="show_products">
                                            <label class="col-sm-5 control-label" for="input-product"><?php echo $entry_products; ?></label>
                                            <div class="col-sm-7">
                                                <input type="text" name="tab_product" value="" placeholder="<?php echo $entry_products; ?>" id="<?php echo $tab['tab_id'];?>" class="form-control" />
                                                <div id="label-hand-product-<?php echo $tab['tab_id']?>" class="well well-sm" style="height: 150px; overflow: auto;">
                                                <?php if(isset($tabs[$tab['tab_id']]['prod'])){ ?>
                                                    <?php foreach ($tabs[$tab['tab_id']]['prod'] as $id_product => $name_product) {  ?>
                                                    <div id="label-hand-product<?php echo $id_product; ?>"><i class="fa fa-minus-circle"></i> <?php echo $name_product; ?>
                                                        <input type="hidden" name="tabs[<?php echo $tab['tab_id']?>][products][]" value="<?php echo $id_product; ?>" />
                                                    </div>
                                                    <?php } ?>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="tabs[<?php echo $tab['tab_id']; ?>][tab_id]" value="<?php echo $tab['tab_id']; ?>" />
                                    </div>
                                    <?php } ?>
                                </div>
                            </div>

                        </div>
                        <?php } ?>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-logs">
                            <?php $widgets->debug_download_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $download, $button_clear_log, $button_download_log); ?>
                            <textarea style="width: 98%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
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
    $(".nav-tabs li a").click(function() {
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
<script type="text/javascript">
    $(function(){
      changeModeuleTabs($('#neoseo_featured_products_use_related').val());
    });

    $('#neoseo_featured_products_use_related').change(function() {
        changeModeuleTabs($(this).val());
    });

    function changeModeuleTabs(value){
        if (value!=0){
            $('#tab-module-tabs').css('display', 'none');
            $('#tab_module').parent().css('display', 'none');
            $('#field_title').css('display', 'none');
            $('#field_template').css('display', 'none');
        } else{
            $('#tab-module-tabs').css('display', '');
            $('#tab_module').parent().css('display', 'block');
            $('#field_title').css('display', 'inline-block');
            $('#field_template').css('display', 'inline-block');
        }
    }
</script>
<script type="text/javascript"><!--
    function deleteTab(id) {
        if (!confirm('<?php echo $text_confirm; ?>'))
            return false;
            $('#form').attr('action', '<?php echo str_replace("&amp;","&",$delete); ?>' + '&tab_id=' + id);
            $('#form').attr('target', '_self');
            $('#form').submit();
            return true;
        }

        var one_touch = false;
        window.token = '<?php echo $token; ?>';
        var template = '<?php echo $tab_form; ?>';
        var count_label = <?php echo (isset($max_id) ? $max_id : 0) ?> ;
        if (!count_label)
        count = $("#tab-pills a").length; //заменить на максимальный айди фида

        $("#add-new-label").click(function() {
            if (one_touch)
            return false;
            one_touch = true;
            var name = $("#new-tab").val();
            var tmp_template = template.replace("new-tab-name", name);
            $(".nav-pills li").removeClass('active');
            $("#tab-module-tabs .tab-content .tab-pane").removeClass('active');
            $(".nav-pills").prepend("<li class='active'><a data-toggle='tab' href='#tab-label-" + count_label + "' >" + name + "</a></li>");
            $("#tab-module-tabs .tab-content").append("<div class='tab-pane active' id='tab-label-" + count_label + "'>" + tmp_template + "</div>");
            $(".nav-pills li:last a").trigger('click');
        });
//--></script>

<script type="text/javascript"><!--
    //Поле Товары для меток
    $('#content').delegate('input[name="tab_product"]', 'focus', function() {
        $('input[name="tab_product"]').autocomplete({
            source: function(request, response) {
                $.ajax({
                url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                    response($.map(json, function(item) {
                    return {
                    label: item['name'],
                        value: item['product_id']
                    }
                    }));
                    }
                });
            },
            select: function(item) {
                $('input[name=\'tab_product\']').val('');
                    var id_elem = this.id;
                    $(this).parent().find('#label-hand-product' + item['value']).remove();
                    $(this).parent().find('#label-hand-product-' + id_elem).append('<div id="label-hand-product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="tabs[' + id_elem + '][products][]" value="' + item['value'] + '" /></div>');
                }
        });
        $('div[id^="label-hand-product"').delegate('.fa-minus-circle', 'click', function() {
            $(this).parent().remove();
        });
    });
    $('div[id^="label-hand-product-"').delegate('.fa-minus-circle', 'click', function() {
        $(this).parent().remove();
    });
    //Поле товар для Метки для скидки
    $('#content').delegate('input[name="label_sale_product"]', 'focus', function() {
        $('input[name="label_sale_product"]').autocomplete({
            source: function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['product_id']
                            }
                        }));
                    }
                 });
            },
            select: function(item) {
                $('input[name=\'label_sale_product\']').val('');
                $(this).parent().find('#label-sale-hand-product' + item['value']).remove();
                $(this).parent().find('#label-sale-hand-product').append('<div id="label-sale-hand-product"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="soforp_product_modules_label_products[]" value="' + item['value'] + '" /></div>');
            }
        });
        $('div[id="label-sale-hand-product"').delegate('.fa-minus-circle', 'click', function() {
            $(this).parent().remove();
        });
    });
    $('div[id="label-sale-hand-product"').delegate('.fa-minus-circle', 'click', function() {
        $(this).parent().remove();
    });
//--></script>

<?php echo $footer; ?>
