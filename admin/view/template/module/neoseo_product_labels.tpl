<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_product_labels_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>
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
            <div class="panel-heading" style="height: 55px;">
                <h3 class="panel-title "><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
            </div>
            <div class="panel-body">

                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                    <?php if( !isset($license_error) ) { ?>
                    <li><a href="#tab_label" data-toggle="tab"><?php echo $tab_label; ?></a></li>
                    <li><a href="#tab_special_label" data-toggle="tab"><?php echo $tab_special_label; ?></a></li>
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
                        <div class="tab-pane" id="tab_label">
                            <div class="col-xs-4 col-md-3 col-lg-3 tabs-left">
                                <ul class="nav nav-pills nav-stacked" id="custom-tabs-header">
                                    <?php $first = true; foreach ($labels as $label) { ?>
                                    <li <?php if($first) { $first = false; echo 'class="active"'; }?>>
                                    <a data-toggle="tab" href="#tab-label-<?php echo $label['label_id']; ?>">
                                        <?php echo $label['name'][$config_language_id]; ?>
                                        <button type="button" class="btn btn-xs btn-link delete-tab" rel="tooltip"
                                                data-original-title="Delete this label" data-container="body"
                                                onclick="deleteImport( <?php echo $label['label_id'] ?> )">
                                            <i class="fa fa-trash text-danger"></i>
                                        </button>
                                    </a>
                                    </li>
                                    <?php } ?>
                                    <li>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="new-tab" placeholder="New label name" data-bind="value: newTabName">
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
                                    <?php $first = true; foreach ($labels as $label) { ?>
                                    <?php if (!isset($max_id)) $max_id = $label["label_id"]; ?>
                                    <div class="tab-pane <?php if($first) { $first = false; echo 'active'; }?>" id="tab-label-<?php echo $label['label_id']; ?>">
                                        <?php $widgets->dropdownA('status', 'labels', $label["label_id"], array(  0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <div class="form-group" id="field_labels-class-1" style="display: inline-block; width: 100%;">
                                            <div class="col-sm-5">
                                                <label class="control-label" ><?php echo $entry_name;?></label>
                                                <br>
                                            </div>
                                            <div class="col-sm-7">
                                                <?php foreach ($languages as $language) {  ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                                                    <input class="form-control" name="labels[<?php echo $label['label_id']; ?>][name][<?php echo $language['language_id']; ?>]" value="<?php echo (isset($label['name'][$language['language_id']])) ? $label['name'][$language['language_id']] : ''; ?>"/>
                                                </div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                        <?php $widgets->dropdownA('label_type', 'labels', $label["label_id"], $array_type_label); ?>
                                        <?php $widgets->dropdownA('position', 'labels', $label["label_id"], $array_position); ?>
                                        <?php $widgets->inputA('class', 'labels', $label["label_id"]); ?>
                                        <?php $widgets->inputA('style', 'labels', $label["label_id"]); ?>
                                        <?php $widgets->inputA('priority', 'labels', $label["label_id"]); ?>
                                        <div class="form-group"  style="display: inline-block; width: 100%;">
                                            <div class="col-sm-5">
                                                <label class="control-label" >  <?php echo $entry_color; ?></label>
                                            </div>
                                            <div class='col-sm-7'>
                                                <input id="<?php echo $label['label_id']?>" style="  float: left" type="text" name="labels[<?php echo $label['label_id']; ?>][color]" value="<?php echo $label['color']; ?>" class="pick_color col-sm-3"/>
                                            </div>
                                        </div>
                                        <div class="form-group" style="display: inline-block; width: 100%">
                                            <label class="col-sm-5 control-label" for="input-limit-<?php echo $label['label_id']; ?>"><?php echo $entry_limit; ?></label>
                                            <div class="col-sm-7">
                                                <input type="number" id="input-limit-<?php echo $label['label_id']; ?>" name="labels[<?php echo $label['label_id']?>][product_limit]" value="<?php echo $label['product_limit']; ?>" class="form-control" />
                                            </div>
                                        </div>

                                        <div class="form-group" id="field_labels-type-<?php echo $label['label_id']; ?>" style="display: inline-block; width: 100%;">
                                            <div class="col-sm-5">
                                                <label class="control-label" for="neoseo_product_labels-type-<?php echo $label['label_id']; ?>"><?php echo $entry_type; ?></label>
                                                <br>
                                            </div>
                                            <div class="col-sm-7">
                                                <select name="labels[<?php echo $label['label_id']; ?>][type]" id="neoseo_product_labels-type-<?php echo $label['label_id']; ?>" data-type_id = "<?php echo $label['label_id']; ?>" class="form-control">
                                                    <?php foreach ($array_params as $value => $name) { ?>
                                                    <?php if ($label['type'] == $value) { ?>
                                                    <option value="<?php echo $value; ?>" selected="selected"><?php echo $name; ?></option>
                                                    <?php } else { ?>
                                                    <option value="<?php echo $value; ?>"><?php echo $name; ?></option>
                                                    <?php } ?>
                                                    <?php } ?>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group type-element" id="type-element-<?php echo $label['label_id']; ?>-0" style="display: none">
                                            <label class="col-sm-5 control-label"><?php echo $entry_products; ?></label>
                                            <div class="col-sm-7">
                                                <input type="text" name="label_product" value="" placeholder="<?php echo $entry_products; ?>" id="<?php echo $label['label_id'];?>" class="form-control" />
                                                <div id="label-hand-product-<?php echo $label['label_id']?>" class="well well-sm" style="height: 150px; overflow: auto;">
                                                    <?php if(isset($labels[$label["label_id"]]['prod'])){ ?>
                                                    <?php foreach ($labels[$label["label_id"]]['prod'] as $id_product => $name_product) {  ?>
                                                    <div id="label-hand-product<?php echo $id_product; ?>"><i class="fa fa-minus-circle"></i> <?php echo $name_product; ?>
                                                        <input type="hidden" name="labels[<?php echo $label['label_id']?>][products][]" value="<?php echo $id_product; ?>" />
                                                    </div>
                                                    <?php } ?>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                            <input type="hidden" name="labels[<?php echo $label['label_id']; ?>][label_id]" value="<?php echo $label['label_id']; ?>" />
                                        </div>
                                        <div class="form-group type-element" id="type-element-<?php echo $label['label_id']; ?>-1" style="display: none">
                                            <label class="col-sm-5 control-label"><?php echo $entry_duration_days; ?></label>
                                            <div class="col-sm-7">
                                                <input type="number" name="labels[<?php echo $label['label_id']?>][days]" value="<?php echo $label['days']; ?>" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="form-group type-element" id="type-element-<?php echo $label['label_id']; ?>-2" style="display: none">
                                            <label class="col-sm-5 control-label"><?php echo $entry_view_counts; ?></label>
                                            <div class="col-sm-7">
                                                <input type="number" name="labels[<?php echo $label['label_id']?>][viewes]" value="<?php echo $label['viewes']; ?>" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="form-group type-element" id="type-element-<?php echo $label['label_id']; ?>-3" style="display: none">
                                            <label class="col-sm-5 control-label"><?php echo $entry_sold; ?></label>
                                            <div class="col-sm-7">
                                                <input type="number" name="labels[<?php echo $label['label_id']?>][sold]" value="<?php echo $label['sold']; ?>" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label"><?php echo $entry_store; ?></label>
                                            <div class="col-sm-7">
                                                <div class="well well-sm" style="height: 150px; overflow: auto;">
                                                    <div class="checkbox">
                                                        <label>
                                                            <?php if (in_array(0, $labels[$label["label_id"]]['stores'])) { ?>
                                                            <input type="checkbox" name="labels[<?php echo $label['label_id'] ?>][stores][]" value="0" checked="checked" />
                                                            <?php echo $text_default; ?>
                                                            <?php } else { ?>
                                                            <input type="checkbox" name="labels[<?php echo $label['label_id'] ?>][stores][]" value="0" />
                                                            <?php echo $text_default; ?>
                                                            <?php } ?>
                                                        </label>
                                                    </div>
                                                    <?php foreach ($stores as $store) { ?>
                                                    <div class="checkbox">
                                                        <label>
                                                            <?php if (in_array($store['store_id'],$labels[$label["label_id"]]['stores'])) { ?>
                                                            <input type="checkbox" name="labels[<?php echo $label['label_id']; ?>][stores][]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                                                            <?php echo $store['name']; ?>
                                                            <?php } else { ?>
                                                            <input type="checkbox" name="labels[<?php echo $label['label_id']; ?>][stores][]" value="<?php echo $store['store_id']; ?>" />
                                                            <?php echo $store['name']; ?>
                                                            <?php } ?>
                                                        </label>
                                                    </div>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <?php } ?>
                                </div>
                            </div>

                        </div>
                        <?php } ?>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab_special_label">
                            <?php $widgets->localeInput('special_title', $languages); ?>
                            <?php $widgets->dropdown('special_status', array(  0 => $text_disabled, 1 => $text_enabled )); ?>
                            <?php $widgets->dropdown('special_label_type',  $array_type_label); ?>
                            <?php $widgets->dropdown('special_position',$array_position); ?>
                            <?php $widgets->input('special_class'); ?>
                            <?php $widgets->input('special_style'); ?>
                            <?php $widgets->input('special_priority'); ?>
                            <div class="form-group"  style="display: inline-block; width: 100%;">
                                <div class="col-sm-5">
                                    <label class="control-label" >  <?php echo $entry_color; ?></label>
                                </div>
                                <div class='col-sm-7'>
                                    <input id="label_sale_color" style="  float: left" type="text" name="neoseo_product_labels_special_color" value="<?php echo $neoseo_product_labels_special_color; ?>" class="pick_color col-sm-3"/>
                                </div>
                            </div>
                        </div>
                        <?php } ?>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-logs">
                            <?php $widgets->debug_and_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $button_clear_log ); ?>
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

<script type="text/javascript"><!--
    $('[id^=neoseo_product_labels-type]').each(function () {
        initType($(this).data('type_id'), $(this).val());
    });

    $(document).on('change', '[id^=neoseo_product_labels-type]', function () {
        initType($(this).data('type_id'), $(this).val());
    });

    function initType(type_id, type_val) {
        $('#tab-label-' + type_id +' .type-element').hide();
        if($('#type-element-' + type_id + '-' + type_val).length > 0) {
            $('#type-element-' + type_id + '-' + type_val).show();
        }
        if(type_val == 0) {
            $('#input-limit-' + type_id).closest('.form-group').hide();
        } else {
            $('#input-limit-' + type_id).closest('.form-group').show();
        }
    }

    function deleteImport(label_id) {
        if (!confirm('<?php echo $text_confirm; ?>'))
            return false;
        $('#form').attr('action', '<?php echo str_replace("&amp;","&",$delete); ?>' + '&label_id=' + label_id);
        $('#form').attr('target', '_self');
        $('#form').submit();
        return true;
    }

    var one_touch = false;
    window.token = '<?php echo $token; ?>';
    var template = '<?php echo $label_form; ?>';
    var count_label = <?php echo (isset($max_id) ? $max_id : 0) ?>;
    if (!count_label)
        count = $("#tab-pills a").length; //заменить на максимальный айди фида

    $("#add-new-label").click(function() {
        if (one_touch)
            return false;
        one_touch = true;
        var name = $("#new-tab").val();
        var tmp_template = template.replace("new-label-name", name);
        $(".nav-pills li").removeClass('active');
        $("#tab_label .tab-content .tab-pane").removeClass('active');
        $(".nav-pills ").prepend("<li class='active'><a data-toggle='tab' href='#tab-label-" + count_label + "' >" + name + "</a></li>");
        $("#tab_label .tab-content").append("<div class='tab-pane active' id='tab-label-" + count_label + "'>" + tmp_template + "</div>");
        $(".nav-pills li:last a").trigger('click');
        $.fn.jPicker.defaults.images.clientPath = 'view/image/';
        $('.pick_color-new').jPicker({
            window: {
                title: 'Выбрать цвет'
            },
            color: {
                active: new $.jPicker.Color({
                    ahex: '993300ff'
                })
            }
        });
    });    //--></script>

<script type="text/javascript"><!--
    //Поле Товары для меток
    $('#content').delegate('input[name="label_product"]', 'focus', function() {
        $('input[name="label_product"]').autocomplete({
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
                $('input[name=\'label_product\']').val('');
                var id_elem = this.id;
                $(this).parent().find('#label-hand-product' + item['value']).remove();
                $(this).parent().find('#label-hand-product-' + id_elem).append('<div id="label-hand-product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="labels[' + id_elem + '][products][]" value="' + item['value'] + '" /></div>');
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
                $(this).parent().find('#label-sale-hand-product').append('<div id="label-sale-hand-product"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="neoseo_product_labels_label_products[]" value="' + item['value'] + '" /></div>');
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
<script type="text/javascript">
    $(function() {
        $.fn.jPicker.defaults.images.clientPath = 'view/image/';
        $('.pick_color').jPicker({
            window: {
                title: 'Выбрать цвет'
            },
            color: {
                active: new $.jPicker.Color({
                    ahex: '993300ff'
                })
            }
        });
    });
</script>
<?php echo $footer; ?>