<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_import_yml_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if( !isset($license_error) ) { ?>
                <button type="submit" name="action" value="save" form="form" data-toggle="tooltip"
                        title="<?php echo $button_save; ?>" class="btn btn-primary"><i
                            class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip"
                        title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i
                            class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
                <?php } else { ?>
                <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"
                   class="btn btn-default"/><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
                <?php } ?>
                <a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>"
                   class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
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
            <div class="panel-heading" style="height: 55px;">
                <h3 class="panel-title "><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
                <div class='pull-right'>
                    <a href="<?php echo $imports_all; ?>" class="btn btn-primary"><i class="fa fa-files-o"
                                                                                     aria-hidden="true"></i>&nbsp;<span><?php echo $button_imports; ?></span></a>
                    <a href="<?php echo $clear_database; ?>" onclick="return checkBeforeClearDB();" class="btn btn-primary"><i class="fa fa-trash-o"
                                                                                        aria-hidden="true"></i>&nbsp;<span><?php echo $button_clear_database; ?></span></a>
                </div>
            </div>
            <div class="panel-body">

                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                    <?php if( !isset($license_error) ) { ?>
                    <li><a href="#tab_import" data-toggle="tab"><?php echo $tab_import; ?></a></li>
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
                            <?php $widgets->textarea('sql_before'); ?>
                            <?php $widgets->textarea('sql_after'); ?>
                            <?php $widgets->text('cron'); ?>
                            <?php } else { ?>
                            <div><?php echo $license_error; ?></div>
                            <?php } ?>
                        </div>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab_import">
                            <div class="col-xs-4 col-md-3 col-lg-3 tabs-left">
                                <ul class="nav nav-pills nav-stacked" id="custom-tabs-header">
                                    <?php $first = true; foreach ($imports as $import) { ?>
                                    <li
                                    <?php if($first) { $first = false; echo 'class="active"'; }?>>
                                    <a data-toggle="tab" href="#tab-import-<?php echo $import['import_id']; ?>">
                                        <?php echo $import['import_name']; ?>
                                        <button type="button" class="btn btn-xs btn-link delete-tab" rel="tooltip"
                                                data-original-title="Delete this import" data-container="body"
                                                onclick="deleteImport( <?php echo $import['import_id'] ?> )">
                                            <i class="fa fa-trash text-danger"></i>
                                        </button>
                                    </a>
                                    </li>
                                    <?php } ?>
                                    <li>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="new-tab"
                                                   placeholder="New import name" data-bind="value: newTabName">
                                            <span class="input-group-btn">
                                                <button type="button" id="add-new-import" class="btn btn-default"
                                                        rel="tooltip"
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
                                    <?php $first = true; foreach ($imports as $import) { ?>
                                    <?php if (!isset($max_id)) $max_id = $import["import_id"]; ?>
                                    <div class="tab-pane <?php if($first) { $first = false; echo 'active'; }?>"
                                         id="tab-import-<?php echo $import['import_id']; ?>">

                                        <a onclick="$('#form').attr('action', '<?php echo $import_one; ?>' + '&import_id=<?php echo $import['import_id']; ?>'); $('#form').attr('target', '_self'); $('#form').submit();"
                                           class="btn btn-primary pull-right">
                                            <i class="fa fa-file-o"
                                               aria-hidden="true"></i>&nbsp;<span><?php echo $button_import; ?></span>
                                        </a>

                                        <?php $widgets->dropdownA('import_status', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->inputA('import_name', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->inputA('import_url', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->inputA('import_ftp_server', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->inputA('import_ftp_login', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->inputA('import_ftp_password', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->inputA('import_ftp_path', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->dropdownA('parent_category', 'imports', $import["import_id"], $categories); ?>
                                        <?php $widgets->dropdownA('inner_tag', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->inputA('main_tag', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->inputA('item_tag', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->inputA('price_tag', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->inputA('price_charge', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->inputA('price_gradation', 'imports',$import["import_id"]); ?>
                                        <?php $widgets->dropdownA('import_currency', 'imports', $import["import_id"],$currencies); ?>
                                        <?php $widgets->inputA('import_convert_currency', 'imports',$import["import_id"]); ?>
                                        <?php $widgets->dropdownA('generate_url', 'imports', $import["import_id"], array( 0 => $text_generate_common, 1 => $text_generate_field )); ?>
                                        <?php $widgets->dropdownA('stock_status_true', 'imports',$import["import_id"], $stock_statuses); ?>
                                        <?php $widgets->dropdownA('stock_status_false', 'imports',$import["import_id"], $stock_statuses); ?>
                                        <?php $widgets->inputA('field_sync', 'imports',$import["import_id"]); ?>
                                        <?php $widgets->inputA('sku_prefix', 'imports',$import["import_id"]); ?>
                                        <?php $widgets->inputA('sku_tag', 'imports',$import["import_id"]); ?>
                                        <?php $widgets->dropdownA('update_name', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->inputA('name_tag', 'imports',$import["import_id"]); ?>
                                        <?php $widgets->dropdownA('update_description', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled, 2 => $text_only_empty )); ?>
                                        <?php $widgets->inputA('description_tag', 'imports',$import["import_id"]); ?>
                                        <?php $widgets->dropdownA('update_attribute', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->dropdownA('update_additions', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->dropdownA('update_image', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->dropdownA('reload_image', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->dropdownA('update_manufacturer', 'imports',  $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->dropdownA('update_price', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->inputA('create_price_action', 'imports',$import["import_id"]); ?>
                                        <?php $widgets->dropdownA('create_discount_price', 'imports',$import["import_id"], array(  0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->inputA('discount_price_percent', 'imports',$import["import_id"]); ?>
                                        <?php $widgets->dropdownA('update_category', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->dropdownA('fill_parent_categories', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->dropdownA('update_category_skip', 'imports', $import["import_id"], array(  0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->dropdownA('update_model', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled )); ?>
                                        <?php $widgets->dropdownA('update_meta_tag', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled, 2 => $text_only_empty)); ?>
                                        <?php $widgets->dropdownA('add_category', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->dropdownA('only_update_product', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->dropdownA('available_control', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->dropdownA('set_miss_quantity', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->inputA('use_quantity', 'imports',$import["import_id"]); ?>
                                        <?php $widgets->inputA('use_quantity_tag', 'imports',$import["import_id"]); ?>
                                        <?php $widgets->textareaA('available_status_via_stock', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->textareaA('import_categories', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->dropdownA('switch_category', 'imports', $import["import_id"], array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->textareaA('exclude_by_name', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->textareaA('ignore_attributes', 'imports', $import["import_id"]); ?>
                                        <?php $widgets->textareaA('route_attributes', 'imports', $import["import_id"]); ?>
                                        <input type="hidden"
                                               name="imports[<?php echo $import['import_id']; ?>][import_id]"
                                               value="<?php echo $import['import_id']; ?>"/>
                                    </div>
                                    <?php } ?>
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
	function  checkBeforeClearDB(){
		if (confirm("Вы уверены, что хотите очистить базу данных?"))
			return true;
		else
			return false;
	}
	//--></script>
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
<script type="text/javascript"><!--
	function deleteImport(id) {
		if (!confirm('<?php echo $text_confirm; ?>'))
			return false;
		$('#form').attr('action', '<?php echo str_replace("&amp;","&",$delete); ?>' + '&import_id=' + id);
		$('#form').attr('target', '_self');
		$('#form').submit();
		return true;
	}

	var one_touch = false;
	window.token = '<?php echo $token; ?>';
	var template = '<?php echo $import_form; ?>';

	var count_import = <?php echo (isset($max_id) ? $max_id : 0) ?> ;
	if (!count_import)
		count = $("#tab-pills a").length; //заменить на максимальный айди фида

	$("#add-new-import").click(function () {
		if (one_touch)
			return false;
		one_touch = true;
		var name = $("#new-tab").val();
		var tmp_template = template.replace("new-import-name", name);
		$(".nav-pills li").removeClass('active');
		$("#tab_import .tab-content .tab-pane").removeClass('active');
		$(".nav-pills ").prepend("<li class='active'><a data-toggle='tab' href='#tab-import-" + count_import + "'>" + name + "</a></li>");
		$("#tab_import .tab-content").append("<div class='tab-pane active' id='tab-import-" + count_import + "'>" + tmp_template + "</div>");
		$(".nav-pills li:last a").trigger('click');
	});
	//--></script>

<script type="text/javascript"><!--
$(document).ready(function(){
    $('.exclude_by_name textarea').css('white-space','nowrap');
     });
//--></script>
<?php echo $footer; ?>