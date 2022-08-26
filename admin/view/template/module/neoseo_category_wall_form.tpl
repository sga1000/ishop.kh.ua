<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/soforp_view.php' );
$widgets = new SoforpWidgets('neoseo_category_wall_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>
<?php
function getCategory($item, $current_lang) {
    global $languages;
    $placeholder = "/image/cache/no_image-24x24.png"; //todo: можно передать через переменную, нужно подумать
    $entry_label = "Название";
    $entry_url = "Ссылка";
    $entry_params = "Тип меню";
	$entry_class = "Дополнительный класс";
	$entry_style = "Дополнительный стиль";
	$entry_icon = "Дополнительная иконка";
    $entry_max_width = "Максимальная ширина";
    $entry_bg_color = "Цвет фона";
    $entry_hover_bg_color = "Цвет фона при наведении";
    $entry_font_color = "Цвет шрифта";
    $entry_hover_font_color = "Цвет шрифта при наведении";

    foreach ($item as $category) { ?>
		<li class='dd-item' data-id="<?php echo $category['id']; ?>">
			<div class='dd-handle'>
				<div class='bar'>
					<span class='title'><?php echo $category['title'][$current_lang];?></span>
				</div>
			</div>
			<div class='panel panel-default info hide'>
				<div class='panel-body'>
					<input type="hidden" class="type" name="type[]" value="<?php echo $category['type'];?>"/>
					<input type="hidden" class="parent_id" name="parent_id[]" value="<?php echo $category['parent_id'];?>"/>
					<input type="hidden" class="type_id" name="type_id[]" value="<?php echo $category['type_id'];?>"/>
					<div class="row"><div class="col-sm-12"><div class='form-group'>
						<label><?php echo $entry_label; ?></label>
<?php foreach ($languages as $language) {
if(!$language['status']) continue; ?>
						<div class="input-group input-item">
							<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
							<input class="form-control" type='text' name='title[<?php echo $language['language_id']; ?>][]' value='<?php echo isset($category['title'][$language['language_id']]) ? $category['title'][$language['language_id']] : '';?>' />
						</div>
<?php } ?>
					</div>
						</div>
                    </div>
                    <div class="row">
						<div class="col-sm-12">
					<div class='form-group'>
<?php if($category['type']=='custom') { ?>
						<label><?php echo $entry_url; ?></label>
<?php } else { ?>
						<label><?php echo $category['type'];?></label>
<?php } ?>
<?php foreach ($languages as $language) { if(!$language['status']) continue; ?>
<?php if($category['type']=='custom') { ?>
						<div class="input-group input-item">
							<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
							<input class="input-item form-control" type='text' name='url[<?php echo $language['language_id']; ?>][]' value='<?php echo $category['url'][$language['language_id']] ; ?>'/>
						</div>
<?php } else { ?>
						<input type="hidden" class="url" name="url[<?php echo $language['language_id']; ?>][]" value=""/>
<?php } ?>
<?php } ?>
</div>
						</div>
                    </div>
						<div class="row">
						<div class="col-sm-4">
						<div class='form-group'>
							<label><?php echo $entry_style; ?>: </label>
							<input class="form-control" type='text' name='style[]' value='<?php echo isset($category['style']) ? $category['style'] : '';?>' />
						</div>
							</div>
						<div class="col-sm-4">
						<div class='form-group'>
							<label><?php echo $entry_class; ?>: </label>
							<input class="form-control" type='text' name='class[]' value='<?php echo isset($category['class']) ? $category['class'] : '';?>' />
						</div>
						</div>
						<div class="col-sm-4">
							<div class='form-group'>
								<label><?php echo $entry_max_width; ?>: </label>
								<input class="form-control" type='text' name='max_width[]' value='<?php echo isset($category['max_width']) ? $category['max_width'] : '';?>' />
							</div>
						</div>
                        </div>
						<div class="row">
						<div class="col-sm-6">
							<div class='form-group'>
							<label><?php echo $entry_params; ?>: </label>
							<select class="form-control" name='params[]'  value='<?php echo isset($category['params']) ? $category['params'] : '';?>'>
							<option <?php if ($category['params']) {?> selected = "selected" <?php } ?> value="mega">Обычное (Вертикально)</option>
							<option <?php if (!$category['params']) {?> selected = "selected" <?php } ?> value="">Мега (Горизонтально)</option>
							</select>
						</div>
						</div>
						<div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label" for="input-image-<?php echo $category['item_id'] ?>"><?php echo $entry_icon; ?></label>
                                <br>
                                <a href="" id="thumb-image-<?php echo $category['item_id']; ?>" data-toggle="image" class="img-thumbnail" ><img style="max-width:24px; max-height: 24px;" src="<?php echo $category['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                                <input type="hidden" name="icon[]" value="<?php echo $category['icon']; ?>" id="input-image-<?php echo $category['item_id'] ?>" />

                            </div>
						</div>
                        </div>
                        <div class="row">
					<div class="col-sm-6">
						<label><?php echo $entry_bg_color; ?>: </label>
                        <div class='input-group colorpicker-component colorpicker-element'>
                            <input class="form-control" type='text' name='bg_color[]' value='<?php echo isset($category['bg_color']) ? $category['bg_color'] : '';?>' />
							<span class="input-group-addon"><i style="background-color: rgb(94, 142, 228);"></i></span>
						</div>
						
						<label><?php echo $entry_hover_bg_color; ?>: </label>
                        <div class='input-group colorpicker-component colorpicker-element'>
                            <input class="form-control" type='text' name='hover_bg_color[]' value='<?php echo isset($category['hover_bg_color']) ? $category['hover_bg_color'] : '';?>' />
							<span class="input-group-addon"><i style="background-color: rgb(94, 142, 228);"></i></span>
						</div>
					</div><div class="col-sm-6">
						<label><?php echo $entry_font_color; ?>: </label>
                        <div class='input-group colorpicker-component colorpicker-element'>
                            <input class="form-control" type='text' name='font_color[]' value='<?php echo isset($category['font_color']) ? $category['font_color'] : '';?>' />
							<span class="input-group-addon"><i style="background-color: rgb(94, 142, 228);"></i></span>
						</div>

						<label><?php echo $entry_hover_font_color; ?>: </label>
                        <div class='input-group colorpicker-component colorpicker-element'>
                            <input class="form-control" type='text' name='hover_font_color[]' value='<?php echo isset($category['hover_font_color']) ? $category['hover_font_color'] : '';?>' />
							<span class="input-group-addon"><i style="background-color: rgb(94, 142, 228);"></i></span>
						</div>
						</div>
                        </div>
				</div>
			</div>
			<a class='btn btn-xs btn-danger remove' onclick="remove_item(this);"><i class="fa fa-trash-o"></i></a>
			<a class='btn btn-xs btn-default explane' onclick='explane(this)'><i class="fa fa-chevron-down" aria-hidden="true"></i></a>
<?php if ($category['child']) { ?>
	<ol class='dd-list'>
<?php getCategory($category['child'], $current_lang, 1); ?>
	</ol>
<?php } ?>
        </li>
<?php } ?>
<?php } ?>

<div id="content">

	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if( !isset($license_error) ) { ?>
					<a onclick="$('#form').attr('action', '<?php echo $save; ?>'); megacategorySubmit(); $('#form').submit();" class="btn btn-primary"><i class="fa fa-save"></i><span>&nbsp;<?php echo $button_save; ?></a>
					<a onclick="$('#form').attr('action', '<?php echo $save_and_close; ?>'); megacategorySubmit(); $('#form').submit();" class="btn btn-primary"><i class="fa fa-save"></i>&nbsp;<?php echo $button_save_and_close; ?></a>
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
				<form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">

							<?php if( !isset($license_error) ) { ?>
								<?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
								<?php $widgets->input('title'); ?>
								<div id="column_category_1" class="container_mega_category">
									<div class="col-sm-4">
										<ul class="nav nav-tabs" >
											<li class="active"><a href="#tab-category-category" data-toggle="tab"><?php echo $tab_category_category; ?></a></li>
											<li><a href="#tab-category-information" data-toggle="tab"><?php echo $tab_category_information; ?></a></li>
											<li><a href="#tab-category-manufacturer" data-toggle="tab"><?php echo $tab_category_manufacturer; ?></a></li>
											<li><a href="#tab-category-blog" data-toggle="tab"><?php echo $tab_category_blog; ?></a></li>
											<li><a href="#tab-category-landing" data-toggle="tab"><?php echo $tab_category_landing; ?></a></li>
											<li><a href="#tab-category-system" data-toggle="tab"><?php echo $tab_category_system; ?></a></li>
											<li><a href="#tab-category-custom" data-toggle="tab"><?php echo $tab_category_custom; ?></a></li>
										</ul>
										<div class="tab-content" >

											<div class="tab-pane active" id="tab-category-category">
												<input class="form-control filter" placeholder="Введите название">
												<div class="well well-sm" style="min-height: 150px;max-height: 400px;overflow: auto;">
													<?php $class = 'odd'; ?>
													<?php foreach( $categories as $category) { ?>
														<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
														<div class="<?php echo $class; ?>">
															<label><input class="category" type="checkbox"
																		value="<?php echo $category['category_id'];?>"
																		data="<?php echo $category['name'];?>"/>
																<?php echo $category['name'];?></label>
														</div>
													<?php } ?>
												</div>
												<a onclick="$(this).parent().find(':checkbox:visible').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a> <br><br><a class="button add-to-category btn btn-primary" href="javascript:void(0);"><span>Добавить в меню</span></a>
											</div>

											<div class="tab-pane" id="tab-category-information">

												<input class="form-control filter" placeholder="Введите название">
												<div class="well well-sm" style="min-height: 150px;max-height: 400px;overflow: auto;">
													<?php $class = 'odd'; ?>
													<?php foreach( $informations as $information) { ?>
														<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
														<div class="<?php echo $class; ?>">
															<label><input class="information" type="checkbox"
																		value="<?php echo $information['id'];?>"
																		data="<?php echo $information['title'];?>"/>
																<?php echo $information['title'];?></label>
														</div>
													<?php } ?>
												</div>
												<a onclick="$(this).parent().find(':checkbox:visible').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a> <br><br><a class="button add-to-category btn btn-primary" href="javascript:void(0);"><span>Добавить в меню</span></a>
											</div>

											<div class="tab-pane" id="tab-category-manufacturer">
												<input class="form-control filter" placeholder="Введите название">
												<div class="well well-sm" style="min-height: 150px;max-height: 400px;overflow: auto;">
													<?php $class = 'odd'; ?>
													<?php foreach( $manufacturers as $manufacturer) { ?>
														<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
														<div class="<?php echo $class; ?>">
															<label><input class="manufacturer" type="checkbox"
																		value="<?php echo $manufacturer['id'];?>"
																		data="<?php echo $manufacturer['name'];?>"/>
																<?php echo $manufacturer['name'];?></label>
														</div>
													<?php } ?>
												</div>
												<a onclick="$(this).parent().find(':checkbox:visible').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a> <br><br>
												<a class="button add-to-category btn btn-primary" href="javascript:void(0);"><span>Добавить в меню</span></a>
											</div>

											<div class="tab-pane" id="tab-category-blog">
												<input class="form-control filter" placeholder="Введите название">
												<div class="well well-sm" style="min-height: 150px;max-height: 400px;overflow: auto;">
													<?php $class = 'odd'; ?>
													<?php foreach( $blog_categories as $blog_category) { ?>
														<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
														<div class="<?php echo $class; ?>">
															<label>
																<input class="blog_category" type="checkbox" value="<?php echo $blog_category['id'];?>" data="<?php echo $blog_category['name'];?>"/>
																<?php echo $blog_category['name'];?>
															</label>
														</div>
													<?php } ?>
												</div>
												<a onclick="$(this).parent().find(':checkbox:visible').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a> <br><br>
												<a class="button add-to-category btn btn-primary" href="javascript:void(0);"><span>Добавить в меню</span></a>
											</div>

											<div class="tab-pane" id="tab-category-landing">
												<input class="form-control filter" placeholder="Введите название">
												<div class="well well-sm" style="min-height: 150px;max-height: 400px;overflow: auto;">
													<?php $class = 'odd'; ?>
													<?php foreach( $landing_pages as $landing_page) { ?>
														<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
														<div class="<?php echo $class; ?>">
															<label>
																<input class="landing_page" type="checkbox" value="<?php echo $landing_page['id'];?>" data="<?php echo $landing_page['name'];?>"/>
																<?php echo $landing_page['name'];?></label>
														</div>
													<?php } ?>
												</div>
												<a onclick="$(this).parent().find(':checkbox:visible').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a> <br><br>
												<a class="button add-to-category btn btn-primary" href="javascript:void(0);"><span>Добавить в меню</span></a>
											</div>


											<div class="tab-pane" id="tab-category-system">
												<input class="form-control filter" placeholder="Введите название">
												<div class="well well-sm" style="min-height: 150px;max-height: 400px;overflow: auto;">
													<?php $class = 'odd'; ?>
													<?php foreach( $system_pages as $system_page_route => $system_page_name ) { ?>
														<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
														<div class="<?php echo $class; ?>">
															<label>
																<input class="<?php echo $system_page_route; ?>" type="checkbox" value="0" data="<?php echo $system_page_name;?>"/>
																<?php echo $system_page_name;?></label>
														</div>
													<?php } ?>
												</div>
												<a onclick="$(this).parent().find(':checkbox:visible').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a> <br><br>
												<a class="button add-to-category btn btn-primary" href="javascript:void(0);"><span>Добавить в меню</span></a>
											</div>

											<div class="tab-pane" id="tab-category-custom" >
												<div>
													<p><label><?php echo $entry_title; ?> : </label><input class="form-control title" type="text" value="<?php echo $entry_title; ?>" placeholder="<?php echo $entry_title; ?>"/></p>
													<p><label><?php echo $entry_url; ?>: </label><input class="form-control url" type="text" value="" placeholder="<?php echo $entry_url; ?>"/></p>
                                                </div>
												</ul>
												<a class="button add-to-category_custom btn btn-primary" href="javascript:void(0);">Добавить в меню</a>
											</div>


										</div>
									</div>
									<div class="col-sm-8 right">
										<div class="dd category_area">
											<ol class='dd-list' id='area_column_category_1'>
												<?php if (isset($item)) {
													getCategory($item, $current_lang);
												} ?>
											</ol>
										</div>
									</div>
								</div>
							<?php } else { ?>

								<?php echo $license_error; ?>

							<?php } ?>

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
	$(".tab-content .filter").keyup(function () {
		var filter = $(this).val();
		var items = $(this).parent().find(".well");
		if( !filter ) {
			$("> div",items).show();
		} else {
			$("> div:contains(" + filter + ")",items).show();
			$("> div:not(:contains(" + filter + "))",items).hide();
		}
		console.log(filter);
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

	var langs = [{
		<?php $i=0; foreach ($languages as $language) { $i++; ?>
		<?php if($i>1) { ?>
	},{
		<?php } ?>
		id: '<?php echo $language["language_id"]; ?>',
		name: '<?php echo $language["name"]; ?>',
		image: '<?php echo $language["image"]; ?>'
		<?php } ?>
	}];
	
	
	//-->
	$(document).ready(function () {
		$(".colorpicker-component").colorpicker();
	});
</script>

<?php echo $footer; ?>