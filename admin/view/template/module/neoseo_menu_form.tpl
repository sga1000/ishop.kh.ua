<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_menu_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;

?>
<?php
function getMenu($item, $current_lang) {
    global $languages;
    $placeholder = "/image/cache/no_image-24x24.png"; //todo: можно передать через переменную, нужно подумать
    $placeholder_image = "/image/cache/no_image-100x100.png"; //todo: можно передать через переменную, нужно подумать
    $entry_label = "Название";
    $entry_url = "Ссылка";
    $entry_params = "Тип меню";
	$entry_class = "Дополнительный класс";
	$entry_style = "Дополнительный стиль";
	$entry_icon = "Дополнительная иконка";
	$entry_image = "Изображение в меню";
	$entry_image_width = 'Ширина изображения: ';
	$entry_image_height = 'Высота изображения: ';
    $entry_max_width = "Максимальная ширина";
    $entry_bg_color = "Цвет фона";
    $entry_hover_bg_color = "Цвет фона при наведении";
    $entry_font_color = "Цвет шрифта";
    $entry_hover_font_color = "Цвет шрифта при наведении";
    $text_infoblock = "Инофрмационный блок при открытии меню";
	$entry_infoblock_status = "Использовать инфоблок";
	$entry_infoblock_title = "Заголовок инфоблока";
	$entry_infoblock_link = "Ссылка инфоблока";
	$entry_infoblock_image = "Изображение инфоблока";
	$entry_infoblock_show_by_button = "Показывать кнопку купить";
	$entry_infoblock_product_id = "Связанный продукт";
	$entry_infoblock_main_class = "Класс для элементов инфоблока";
	$entry_infoblock_position = "Положение информационного блока";
	$entry_infoblock_image_width = "Ширина изображения информационного блока";
	$entry_infoblock_image_height = "Высота изображения информационного блока";
	$text_left = "Слева";
	$text_right = "Справа";
	$text_enable = "Включено";
	$text_disable = "Отключено";

    foreach ($item as $menu) { ?>
		<li class='dd-item' data-id="<?php echo $menu['id']; ?>">
			<div class='dd-handle'>
				<div class='bar'>
					<span class='title'><?php echo $menu['title'][$current_lang];?></span>
				</div>
			</div>
			<div class='panel panel-default info hide'>
				<div class='panel-body'>
					<input type="hidden" class="type" name="type[]" value="<?php echo $menu['type'];?>"/>
					<input type="hidden" class="parent_id" name="parent_id[]" value="<?php echo $menu['parent_id'];?>"/>
					<input type="hidden" class="type_id" name="type_id[]" value="<?php echo $menu['type_id'];?>"/>
					<div class="row"><div class="col-sm-12"><div class='form-group'>
						<label><?php echo $entry_label; ?></label>
<?php foreach ($languages as $language) {
if(!$language['status']) continue; ?>
						<div class="input-group input-item">
							<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
							<input class="form-control" type='text' name='title[<?php echo $language['language_id']; ?>][]' value='<?php echo isset($menu['title'][$language['language_id']]) ? $menu['title'][$language['language_id']] : '';?>' />
						</div>
<?php } ?>
					</div>
						</div>
                    </div>
                    <div class="row">
						<div class="col-sm-12">
					<div class='form-group'>
<?php if($menu['type']=='custom') { ?>
						<label><?php echo $entry_url; ?></label>
<?php } else { ?>
						<label><?php echo $menu['type'];?></label>
<?php } ?>
<?php foreach ($languages as $language) { if(!$language['status']) continue; ?>
<?php if($menu['type']=='custom') { ?>
						<div class="input-group input-item">
							<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
							<input class="input-item form-control" type='text' name='url[<?php echo $language['language_id']; ?>][]' value='<?php echo $menu['url'][$language['language_id']] ; ?>'/>
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
							<input class="form-control" type='text' name='style[]' value='<?php echo isset($menu['style']) ? $menu['style'] : '';?>' />
						</div>
							</div>
						<div class="col-sm-4">
						<div class='form-group'>
							<label><?php echo $entry_class; ?>: </label>
							<input class="form-control" type='text' name='class[]' value='<?php echo isset($menu['class']) ? $menu['class'] : '';?>' />
						</div>
						</div>
						<div class="col-sm-4">
							<div class='form-group'>
								<label><?php echo $entry_max_width; ?>: </label>
								<input class="form-control" type='text' name='max_width[]' value='<?php echo isset($menu['max_width']) ? $menu['max_width'] : '';?>' />
							</div>
						</div>
                        </div>
					<div class="row">
						<div class="col-sm-4">
							<div class="form-group image-position">
								<label class="control-label" for="input-image-main-<?php echo $menu['item_id'] ?>"><?php echo $entry_image; ?></label>
								<br>
								<a href="" id="thumb-image-main-<?php echo $menu['item_id'] ?>" data-toggle="image" class="img-thumbnail" ><img style="max-width:100px; max-height: 100px;" src="<?php echo $menu['main_image']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder_image; ?>" /></a>
								<input type="hidden" name="image[]" value="<?php echo $menu['image']; ?>" id="input-image-main-<?php echo $menu['item_id'] ?>" />
								<select name="image_position[]" id="image-position">
									<option value="image_background" <?php if ($menu['image_position'] == 'image_background') { ?> selected="selected" <?php } ?>>Изображение фоном</option>
									<option value="image_box" <?php if ($menu['image_position'] == 'image_box') { ?> selected="selected" <?php } ?>>Изображение в меню</option>
								</select>
							</div>
						</div>
						<div class="col-sm-4">
							<div class='form-group'>
								<label><?php echo $entry_image_width; ?> </label>
								<input class="form-control" type='text' name='image_width[]' value='<?php echo isset($menu['image_width']) ? $menu['image_width'] : '';?>' />
							</div>
						</div>
						<div class="col-sm-4">
							<div class='form-group'>
								<label><?php echo $entry_image_height; ?> </label>
								<input class="form-control" type='text' name='image_height[]' value='<?php echo isset($menu['image_height']) ? $menu['image_height'] : '';?>' />
							</div>
						</div>
					</div>
						<div class="row">
						<div class="col-sm-6">
							<div class='form-group'>
							<label><?php echo $entry_params; ?>: </label>
							<select class="form-control" name='params[]'  value='<?php echo isset($menu['params']) ? $menu['params'] : '';?>'>
							<option <?php if ($menu['params']) { ?> selected = "selected" <?php } ?> value="mega">Обычное (Вертикально)</option>
							<option <?php if (!$menu['params']) { ?> selected = "selected" <?php } ?> value="">Мега (Горизонтально)</option>
							</select>
						</div>
						</div>
						<div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label" for="input-image-<?php echo $menu['item_id'] ?>"><?php echo $entry_icon; ?></label>
                                <br>
                                <a href="" id="thumb-image-<?php echo $menu['item_id']; ?>" data-toggle="image" class="img-thumbnail" ><img style="max-width:24px; max-height: 24px;" src="<?php echo $menu['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                                <input type="hidden" name="icon[]" value="<?php echo $menu['icon']; ?>" id="input-image-<?php echo $menu['item_id'] ?>" />

                            </div>
						</div>
                        </div>
                        <div class="row">
					<div class="col-sm-6">
						<label><?php echo $entry_bg_color; ?>: </label>
                        <div class='input-group colorpicker-component colorpicker-element'>
                            <input class="form-control" type='text' name='bg_color[]' value='<?php echo isset($menu['bg_color']) ? $menu['bg_color'] : '';?>' />
							<span class="input-group-addon"><i style="background-color: rgb(94, 142, 228);"></i></span>
						</div>
						
						<label><?php echo $entry_hover_bg_color; ?>: </label>
                        <div class='input-group colorpicker-component colorpicker-element'>
                            <input class="form-control" type='text' name='hover_bg_color[]' value='<?php echo isset($menu['hover_bg_color']) ? $menu['hover_bg_color'] : '';?>' />
							<span class="input-group-addon"><i style="background-color: rgb(94, 142, 228);"></i></span>
						</div>
					</div><div class="col-sm-6">
						<label><?php echo $entry_font_color; ?>: </label>
                        <div class='input-group colorpicker-component colorpicker-element'>
                            <input class="form-control" type='text' name='font_color[]' value='<?php echo isset($menu['font_color']) ? $menu['font_color'] : '';?>' />
							<span class="input-group-addon"><i style="background-color: rgb(94, 142, 228);"></i></span>
						</div>

						<label><?php echo $entry_hover_font_color; ?>: </label>
                        <div class='input-group colorpicker-component colorpicker-element'>
                            <input class="form-control" type='text' name='hover_font_color[]' value='<?php echo isset($menu['hover_font_color']) ? $menu['hover_font_color'] : '';?>' />
							<span class="input-group-addon"><i style="background-color: rgb(94, 142, 228);"></i></span>
						</div>
						</div>
                        </div>
					<div class="panel panel-default" style="margin-top: 15px;">
						<div class="panel-heading"><?php echo $text_infoblock; ?></div>
						<div class="panel-body">
							<div class="row"><div class="col-sm-12">
										<label><?php echo $entry_infoblock_status; ?></label>
											<select name="infoblock_status[]" class="form-control">
												<?php if(isset($menu['infoblock_status']) && $menu['infoblock_status'] == 1 ) { ?>
												<option value="1" selected><?php echo $text_enable; ?></option>
												<option value="0"><?php echo $text_disable; ?></option>
												<?php } else { ?>
												<option value="1"><?php echo $text_enable; ?></option>
												<option value="0" selected><?php echo $text_disable; ?></option>
												<?php } ?>
											</select>
								</div>
							</div>

							<div class="row"><div class="col-sm-12">
									<label><?php echo $entry_infoblock_position; ?></label>
									<select name="infoblock_position[]" class="form-control">
										<?php if(isset($menu['infoblock_position']) && $menu['infoblock_position'] == 'left' ) { ?>
										<option value="left" selected><?php echo $text_left; ?></option>
										<option value="right"><?php echo $text_right; ?></option>
										<?php } else { ?>
										<option value="left"><?php echo $text_left; ?></option>
										<option value="right" selected><?php echo $text_right; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>

							<div class="row"><div class="col-sm-12"><div class='form-group'>
										<label><?php echo $entry_infoblock_title; ?></label>
										<?php foreach ($languages as $language) {
if(!$language['status']) continue; ?>
										<div class="input-group input-item">
											<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input class="form-control" type='text' name='infoblock_title[<?php echo $language['language_id']; ?>][]' value='<?php echo isset($menu['infoblock_title'][$language['language_id']]) ? $menu['infoblock_title'][$language['language_id']] : '';?>' />
										</div>
										<?php } ?>
									</div>
								</div>
							</div>

							<div class="row"><div class="col-sm-12"><div class='form-group'>
										<label><?php echo $entry_infoblock_link; ?></label>
										<?php foreach ($languages as $language) {
if(!$language['status']) continue; ?>
										<div class="input-group input-item">
											<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input class="form-control" type='text' name='infoblock_link[<?php echo $language['language_id']; ?>][]' value='<?php echo isset($menu['infoblock_link'][$language['language_id']]) ? $menu['infoblock_link'][$language['language_id']] : '';?>' />
										</div>
										<?php } ?>
									</div>
								</div>
							</div>

							<div class="row"><div class="col-sm-12">
									<label><?php echo $entry_infoblock_main_class; ?></label>
									<input name="infoblock_main_class[]" class="form-control" value="<?php echo isset($menu['infoblock_main_class'])?$menu['infoblock_main_class']:""; ?>" >
								</div>
							</div>

							<div class="col-sm-12">
									<label class="control-label" for="input-infoblock-image-<?php echo $menu['item_id'] ?>"><?php echo $entry_infoblock_image; ?></label>
									<br>
									<a href="" id="infoblock-image-<?php echo $menu['item_id']; ?>" data-toggle="image" class="img-thumbnail" ><img style="max-width:100px; max-height: 100px;" src="<?php echo isset($menu['infoblock_image_pic'])?$menu['infoblock_image_pic']:$placeholder_image; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
									<input type="hidden" name="infoblock_image[]" value="<?php echo isset($menu['infoblock_image'])?$menu['infoblock_image']:$placeholder_image; ?>" id="input-infoblock-image-<?php echo $menu['item_id'] ?>" />
							</div>

							<div class="row"><div class="col-sm-12">
									<label><?php echo $entry_infoblock_image_width; ?></label>
									<input name="infoblock_image_width[]" class="form-control" value="<?php echo isset($menu['infoblock_image_width'])?$menu['infoblock_image_width']:"100"; ?>" >
								</div>
							</div>

							<div class="row"><div class="col-sm-12">
									<label><?php echo $entry_infoblock_image_height; ?></label>
									<input name="infoblock_image_height[]" class="form-control" value="<?php echo isset($menu['infoblock_image_height'])?$menu['infoblock_image_height']:"100"; ?>" >
								</div>
							</div>

							<div class="row"><div class="col-sm-12">
									<label><?php echo $entry_infoblock_show_by_button; ?></label>
									<select name="infoblock_show_by_button[]" class="form-control">
										<?php if(isset($menu['infoblock_show_by_button']) && $menu['infoblock_show_by_button'] == 1 ) { ?>
										<option value="1" selected><?php echo $text_enable; ?></option>
										<option value="0"><?php echo $text_disable; ?></option>
										<?php } else { ?>
										<option value="1"><?php echo $text_enable; ?></option>
										<option value="0" selected><?php echo $text_disable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>

							<div class="row"><div class="col-sm-12">
									<label><?php echo $entry_infoblock_product_id; ?></label>
									<input name="infoblock_product_name[]" data-pid="<?php echo $menu['item_id']; ?>" class="form-control products-ac" value="<?php echo isset($menu['infoblock_product_name'])?$menu['infoblock_product_name']:""; ?>" >
									<input name="infoblock_product_id[]" id="infoblock_product_id_<?php echo $menu['item_id']; ?>" class="form-control" type="hidden" value="<?php echo isset($menu['infoblock_product_id'])?$menu['infoblock_product_id']:""; ?>" >
								</div>
							</div>

						</div><!-- -->
					</div>
				</div>

			</div>
			<a class='btn btn-xs btn-danger remove' onclick="remove_item(this);"><i class="fa fa-trash-o"></i></a>
			<a class='btn btn-xs btn-default explane' onclick='explane(this)'><i class="fa fa-chevron-down" aria-hidden="true"></i></a>
<?php if ($menu['child']) { ?>
	<ol class='dd-list'>
<?php getMenu($menu['child'], $current_lang, 1); ?>
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
					<a onclick="$('#form').attr('action', '<?php echo $save; ?>'); megamenuSubmit(); $('#form').submit();" class="btn btn-primary"><i class="fa fa-save"></i><span>&nbsp;<?php echo $button_save; ?></a>
					<a onclick="$('#form').attr('action', '<?php echo $save_and_close; ?>'); megamenuSubmit(); $('#form').submit();" class="btn btn-primary"><i class="fa fa-save"></i>&nbsp;<?php echo $button_save_and_close; ?></a>
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
								<?php $widgets->input('title', $params); ?>
								<div id="column_menu_1" class="container_mega_menu">
									<div class="col-sm-4">
										<ul class="nav nav-tabs" >
											<li class="active"><a href="#tab-menu-category" data-toggle="tab"><?php echo $tab_menu_category; ?></a></li>
											<li><a href="#tab-menu-information" data-toggle="tab"><?php echo $tab_menu_information; ?></a></li>
											<li><a href="#tab-menu-manufacturer" data-toggle="tab"><?php echo $tab_menu_manufacturer; ?></a></li>
											<li><a href="#tab-menu-blog" data-toggle="tab"><?php echo $tab_menu_blog; ?></a></li>
											<li><a href="#tab-menu-landing" data-toggle="tab"><?php echo $tab_menu_landing; ?></a></li>
											<li><a href="#tab-menu-system" data-toggle="tab"><?php echo $tab_menu_system; ?></a></li>
											<li><a href="#tab-menu-custom" data-toggle="tab"><?php echo $tab_menu_custom; ?></a></li>
										</ul>
										<div class="tab-content" >

											<div class="tab-pane active" id="tab-menu-category">
												<input class="form-control filter" placeholder="Введите название">
												<div class="well well-sm category-block" style="min-height: 150px;max-height: 400px;overflow: auto;">
													<?php $class = 'odd'; ?>
													<?php foreach( $categories as $category) { ?>
														<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
														<div class="<?php echo $class; ?>">
															<label><input class="category" type="checkbox"
																		value="<?php echo $category['category_id'];?>"
																		<?php if( $category['parent_id'] ) { ?>
																		parent="<?php echo $category['parent_id'] ?>"
																		<?php } ?>
																		  data="<?php echo $category['name'];?>"/>
																<?php echo $category['name'];?></label>
														</div>
													<?php } ?>
												</div>
												<a onclick="$(this).parent().find(':checkbox:visible').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a> <br><br><a class="button add-to-menu btn btn-primary" href="javascript:void(0);"><span>Добавить в меню</span></a> <a class="button generate-menu-category btn btn-primary" href="javascript:void(0);"><span>Сгенерировать меню категорий</span></a>
											</div>

											<div class="tab-pane" id="tab-menu-information">

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
												<a onclick="$(this).parent().find(':checkbox:visible').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a> <br><br><a class="button add-to-menu btn btn-primary" href="javascript:void(0);"><span>Добавить в меню</span></a>
											</div>

											<div class="tab-pane" id="tab-menu-manufacturer">
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
												<a class="button add-to-menu btn btn-primary" href="javascript:void(0);"><span>Добавить в меню</span></a>
											</div>

											<div class="tab-pane" id="tab-menu-blog">
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
												<a class="button add-to-menu btn btn-primary" href="javascript:void(0);"><span>Добавить в меню</span></a>
											</div>

											<div class="tab-pane" id="tab-menu-landing">
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
												<a class="button add-to-menu btn btn-primary" href="javascript:void(0);"><span>Добавить в меню</span></a>
											</div>


											<div class="tab-pane" id="tab-menu-system">
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
												<a class="button add-to-menu btn btn-primary" href="javascript:void(0);"><span>Добавить в меню</span></a>
											</div>

											<div class="tab-pane" id="tab-menu-custom" >
												<div>
													<p><label><?php echo $entry_title; ?> : </label><input class="form-control title" type="text" value="<?php echo $entry_title; ?>" placeholder="<?php echo $entry_title; ?>"/></p>
													<p><label><?php echo $entry_url; ?>: </label><input class="form-control url" type="text" value="" placeholder="<?php echo $entry_url; ?>"/></p>
                                                </div>
												</ul>
												<a class="button add-to-menu_custom btn btn-primary" href="javascript:void(0);">Добавить в меню</a>
											</div>


										</div>
									</div>
									<div class="col-sm-8 right">
										<div class="dd menu_area">
											<ol class='dd-list' id='area_column_menu_1'>
												<?php if (isset($item)) {
													getMenu($item, $current_lang);
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

	$('.products-ac').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
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
		'select': function(item) {
			$(this).val(item['label']);
			$('#infoblock_product_id_' + $(this).attr('data-pid')).val(item['value']);

		}
	});

</script>

<?php echo $footer; ?>