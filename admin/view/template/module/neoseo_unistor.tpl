<?php echo $header; ?><?php echo $column_left; ?>
<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_unistor_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if( !isset($license_error) ) { ?>
				<a onclick="$('#form').attr('action', '<?php echo $save; ?>'); $('#form').submit();" class="btn btn-primary"><i class="fa fa-save"></i><span>&nbsp;<?php echo $button_save; ?></a>
				<a onclick="$('#form').attr('action', '<?php echo $save_and_close; ?>'); $('#form').submit();" class="btn btn-primary"><i class="fa fa-save"></i>&nbsp;<?php echo $button_save_and_close; ?></a>
				<?php } else { ?>
				<a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>" class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
				<?php } ?>
				<a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
			</div>
			<img width="36" height="36" style="float:left;margin-right: 10px;" src="view/image/logo.png" alt="">
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
					<li><a href="#tab-header" data-toggle="tab"><?php echo $tab_header; ?></a></li>
					<li><a href="#tab-footer" data-toggle="tab"><?php echo $tab_footer; ?></a></li>
					<li><a href="#tab-contact" data-toggle="tab"><?php echo $tab_contact; ?></a></li>
					<li><a href="#tab-category" data-toggle="tab"><?php echo $tab_category; ?></a></li>
					<li><a href="#tab-products" data-toggle="tab"><?php echo $tab_products; ?></a></li>
					<li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
					<?php } ?>
					<li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
					<li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
				</ul>
				<form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">
							<?php if( !isset($license_error) ) { ?>
							<div class="panel-group accordion">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse001">
												<i class="indicator fa fa-chevron-down"></i> Основные настройки
											</a>
										</h4>
									</div>
									<div id="collapse001" class="panel-collapse collapse">
										<div class="panel-body">
											<div class="form-group" id="field_neoseo_unistor_logo" style="display: inline-block; width: 100%;">
												<div class="col-sm-5">
													<label class="control-label" for="neoseo_unistor_logo"><?php echo $entry_logo; ?></label>
												</div>
												<div class="col-sm-7">
													<ul class="nav nav-tabs">
														<?php foreach ($languages as $language) { ?>
														<li class="<?php echo $language['language_id']==1? 'active': '';?>"><a href="#column-neoseo_unistor_logo<?php echo $language['language_id']; ?>" data-toggle="tab">
																<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>">
																<?php echo $language['name'];?>
															</a>
														</li>
														<?php } ?>
													</ul>
													<div class="tab-content">
														<?php foreach ($languages as $language) { ?>
														<div class="tab-pane <?php echo $language['language_id']==1? 'active': '';?>" id="column-neoseo_unistor_logo<?php echo $language['language_id']; ?>">
															<a href="" id="thumb-image-logo-<?php echo $language['language_id']?>" data-toggle="image" class="img-thumbnail">
																<img src="<?php echo $neoseo_unistor_logo_img[$language['language_id']]; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
															</a>
															<input type="hidden" name="neoseo_unistor_logo[<?php echo $language['language_id'];?>]" value="<?php echo $neoseo_unistor_logo[$language['language_id']]; ?>" id="input-image-logo-<?php echo $language['language_id']?>" />
														</div>
														<?php } ?>
													</div>
												</div>
											</div>
											<?php $widgets->dropdown('body_font',$fonts); ?>
											<?php $widgets->dropdown('scheme_style',$schemes); ?>
											<?php $widgets->dropdown('use_wide_style',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
											<?php $widgets->dropdown('module_preview_count',array( 4 => 4, 5 => 5)); ?>
											<?php $widgets->dropdown('template_prefix',$template_prefix); ?>
											<?php $widgets->inputColor('general_background_color'); ?>
											<?php $widgets->inputImage('general_background_image',$placeholder, $general_background_image_thumb); ?>
											<?php $widgets->localeTextarea('general_sharing_code',$languages); ?>
											<?php $widgets->textarea('personal_css'); ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse002">
												<i class="indicator fa fa-chevron-down"></i> Настройки модулей
											</a>
										</h4>
									</div>
									<div id="collapse002" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->inputColor('module_title_color'); ?>
											<?php $widgets->inputGradientColor('module_background_color'); ?>
											<?php $widgets->inputColor('module_border_color'); ?>
											<?php $widgets->inputColor('module_border_color_hover'); ?>
											<?php $widgets->inputColor('title_color'); ?>
											<?php $widgets->inputColor('text_color'); ?>
										</div>
									</div>
								</div>

								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse003">
												<i class="indicator fa fa-chevron-down"></i> Кнопки
											</a>
										</h4>
									</div>
									<div id="collapse003" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->inputGradientColor('button_color'); ?>
											<?php $widgets->inputColor('button_color_text'); ?>
											<?php $widgets->inputGradientColor('button_color_hover'); ?>
											<?php $widgets->inputColor('button_color_text_hover'); ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse0003">
												<i class="indicator fa fa-chevron-down"></i> Кнопки превью товара
											</a>
										</h4>
									</div>
									<div id="collapse0003" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->inputGradientColor('preview_button_color'); ?>
											<?php $widgets->inputColor('preview_button_color_text'); ?>
											<?php $widgets->inputGradientColor('preview_button_color_hover'); ?>
											<?php $widgets->inputColor('preview_button_color_text_hover'); ?>
											<?php $widgets->inputColor('product_thumb_icon_color'); ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse0004">
												<i class="indicator fa fa-chevron-down"></i> Кнопка в карточке товара
											</a>
										</h4>
									</div>
									<div id="collapse0004" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->inputGradientColor('product_button_color'); ?>
											<?php $widgets->inputColor('product_button_color_text'); ?>
											<?php $widgets->inputGradientColor('product_button_color_hover'); ?>
											<?php $widgets->inputColor('product_button_color_text_hover'); ?>
										</div>
									</div>
								</div>

								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse0031">
												<i class="indicator fa fa-chevron-down"></i> Кнопка наверх
											</a>
										</h4>
									</div>
									<div id="collapse0031" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->inputGradientColor('go_top_background'); ?>
											<?php $widgets->inputColor('go_top_color'); ?>
											<?php $widgets->inputGradientColor('go_top_background_hover'); ?>
											<?php $widgets->inputColor('go_top_color_hover'); ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse006">
												<i class="indicator fa fa-chevron-down"></i> Настройки пагинации
											</a>
										</h4>
									</div>
									<div id="collapse006" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->inputGradientColor('pagination_background'); ?>
											<?php $widgets->inputColor('pagination_color'); ?>
											<?php $widgets->inputGradientColor('pagination_background_hover'); ?>
											<?php $widgets->inputColor('pagination_color_hover'); ?>
											<?php $widgets->inputGradientColor('pagination_background_active'); ?>
											<?php $widgets->inputColor('pagination_color_active'); ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse004">
												<i class="indicator fa fa-chevron-down"></i> Настройки ссылок
											</a>
										</h4>
									</div>
									<div id="collapse004" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->inputColor('link_color'); ?>
											<?php $widgets->inputColor('link_hover_color'); ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse005">
												<i class="indicator fa fa-chevron-down"></i> Настройки табов
											</a>
										</h4>
									</div>
									<div id="collapse005" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->inputGradientColor('tab_color'); ?>
											<?php $widgets->inputColor('tab_text_color'); ?>
											<?php $widgets->inputGradientColor('tab_color_active'); ?>
											<?php $widgets->inputColor('tab_text_color_active'); ?>
											<?php $widgets->inputGradientColor('tab_color_hover'); ?>
											<?php $widgets->inputColor('tab_text_color_hover'); ?>
										</div>
									</div>
								</div>
							</div>
							<?php } else { ?>
							<?php echo $license_error; ?>
							<?php } ?>
						</div>
						<?php if( !isset($license_error) ) { ?>
						<div class="tab-pane" id="tab-header">
							<div class="panel-group accordion">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse0">
												<i class="indicator fa fa-chevron-down"></i> Липкое меню
											</a>
										</h4>
									</div>
									<div id="collapse0" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->dropdown('sticky_menu',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
											<?php $widgets->dropdown('sticky_menu_type',
											array( 'sticky.type-1' => $text_sticky_menu_type_1, 'sticky.type-2' => $text_sticky_menu_type_2)
											); ?>
											<?php $widgets->inputGradientColor('sticky_menu_background'); ?>
											<?php $widgets->inputColor('sticky_phones_color'); ?>
											<?php $widgets->inputColor('sticky_cart_total_color'); ?>
											<?php $widgets->inputImage('sticky_menu_image',$placeholder, $sticky_box_background_thumb); ?>
											<?php $widgets->inputColor('sticky_menu_icon_color'); ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse"  href="#collapse1">
												<i class="indicator fa fa-chevron-down"></i> Верхний банер
											</a>
										</h4>
									</div>
									<div id="collapse1" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->dropdown('top_banner',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
											<?php $widgets->input('top_banner_height'); ?>
											<?php $widgets->inputGradientColor('top_banner_background'); ?>
											<div class="form-group" style="display: inline-block; width: 100%;">
												<div class="col-sm-5">
													<label class="control-label" for="neoseo_unistor_banner"><?php echo $entry_top_banner_image; ?></label>
												</div>
												<div class="col-sm-7">
													<ul class="nav nav-tabs">
														<?php foreach ($languages as $language) { ?>
														<li class="<?php echo $language['language_id']==1? 'active': '';?>"><a href="#column-neoseo_unistor_top_banner_image<?php echo $language['language_id']; ?>" data-toggle="tab">
																<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>">
																<?php echo $language['name'];?>
															</a>
														</li>
														<?php } ?>
													</ul>
													<div class="tab-content">
														<?php foreach ($languages as $language) { ?>
														<div class="tab-pane <?php echo $language['language_id']==1? 'active': '';?>" id="column-neoseo_unistor_top_banner_image<?php echo $language['language_id']; ?>">
															<a href="" id="thumb-image-banner-<?php echo $language['language_id']?>" data-toggle="image" class="img-thumbnail">
																<img src="<?php echo $neoseo_unistor_banner_img[$language['language_id']]; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
															</a>
															<input type="hidden" name="neoseo_unistor_top_banner_image[<?php echo $language['language_id'];?>]" value="<?php echo $neoseo_unistor_top_banner_image[$language['language_id']]; ?>" id="input-image-top-banner-image-<?php echo $language['language_id']?>" />
														</div>
														<?php } ?>
													</div>
												</div>
											</div>
											<?php $widgets->localeInput('top_banner_link',$languages); ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse2">
												<i class="indicator fa fa-chevron-down"></i> Верхнее меню
											</a>
										</h4>
									</div>
									<div id="collapse2" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->dropdown('top_menu_items', $menus); ?>
											<?php $widgets->dropdown('top_currency_status', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
											<?php $widgets->dropdown('top_menu_icon_position', array( 'left' => $text_left, 'right' => $text_right )); ?>
											<?php $widgets->inputGradientColor('top_menu_background'); ?>
											<?php $widgets->inputColor('top_menu_color'); ?>
											<?php $widgets->inputColor('top_menu_hover_color'); ?>
											<?php $widgets->inputColor('top_menu_border_color'); ?>
											<?php $widgets->inputColor('top_menu_account_bg'); ?>
											<?php $widgets->inputColor('top_menu_account_color'); ?>
											<?php $widgets->input('top_menu_height'); ?>
											<?php $widgets->input('top_menu_font_size'); ?>
											<?php $widgets->inputGradientColor('currency_bg'); ?>
											<?php $widgets->inputColor('currency_color'); ?>
											<?php $widgets->inputColor('currency_color_hover'); ?>
											<?php $widgets->inputColor('currency_active_color'); ?>
											<?php $widgets->inputGradientColor('language_active_bg'); ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse3">
												<i class="indicator fa fa-chevron-down"></i> Основной контент
											</a>
										</h4>
									</div>
									<div id="collapse3" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->dropdown('header_type', $header_type); ?>
											<?php $widgets->localeInput('header_information',$languages); ?>
											<?php $widgets->dropdown('header_checkout_hide', [0 => 'Нет', 1 => 'Да'] ) ?>
											<?php $widgets->input('top_header_height'); ?>
											<?php $widgets->inputColor('header_background_color'); ?>
											<?php $widgets->inputImage('header_background_image',$placeholder, $header_background_thumb); ?>
											<?php $widgets->inputColor('header_icon_color'); ?>
											<?php $widgets->inputColor('header_cart_total_color'); ?>
											<?php $widgets->inputColor('header_phones_color'); ?>
											<?php $widgets->input('phone1'); ?>
											<?php $widgets->input('phone2',$languages); ?>
											<?php $widgets->input('phone3'); ?>
											<?php $widgets->inputColor('header_worktime_color'); ?>
											<?php $widgets->localeTextarea('work_time',$languages); ?>
											<?php $widgets->localeTextarea('header_recent_search', $languages); ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse4">
												<i class="indicator fa fa-chevron-down"></i> Основное меню
											</a>
										</h4>
									</div>
									<div id="collapse4" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->dropdown('menu_main_items',$menus) ?>
											<?php $widgets->dropdown('menu_main_type', $menus_type); ?>
											<?php $widgets->dropdown('menu_main_icon_position', array( 'top' => $text_top, 'right' => $text_right, 'bottom' => $text_bottom, 'left' => $text_left)); ?>
											<?php $widgets->input('menu_main_height'); ?>
											<?php $widgets->inputColor('menu_border_color'); ?>
											<?php $widgets->inputGradientColor('menu_main_bg_color'); ?>
											<?php $widgets->inputColor('menu_main_text_color'); ?>
											<?php $widgets->inputGradientColor('menu_main_bg_hover_color'); ?>
											<?php $widgets->inputColor('menu_main_text_hover_color'); ?>
											<?php $widgets->inputGradientColor('menu_main_bg_active_color'); ?>
											<?php $widgets->inputGradientColor('menu_border_link_color'); ?>
											<?php $widgets->inputColor('menu_main_text_active_color'); ?>
											<?php $widgets->input('menu_main_font_family'); ?>
											<?php $widgets->input('menu_main_font_size'); ?>
											<?php $widgets->input('menu_main_icon_height'); ?>
											<?php $widgets->inputGradientColor('menu_sub_bg_color'); ?>
											<?php $widgets->inputColor('menu_sub_text_color'); ?>
											<?php $widgets->inputGradientColor('menu_sub_bg_hover_color'); ?>
											<?php $widgets->inputColor('menu_sub_text_hover_color'); ?>
											<?php $widgets->inputGradientColor('menu_sub_bg_active_color'); ?>
											<?php $widgets->inputColor('menu_sub_text_active_color'); ?>
											<?php $widgets->input('menu_sub_font_family'); ?>
											<?php $widgets->input('menu_sub_font_size'); ?>
											<?php $widgets->input('menu_sub_icon_height'); ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#collapse5">
												<i class="indicator fa fa-chevron-down"></i> Мобильный вид
											</a>
										</h4>
									</div>
									<div id="collapse5" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->dropdown('header_mobile_type', $header_mobile_types); ?>
											<?php $widgets->inputColor('mobile_header_bg_color'); ?>
											<?php $widgets->inputColor('mobile_header_icon_color'); ?>
											<?php $widgets->inputColor('mobile_header_total_color'); ?>
											<?php $widgets->inputColor('mobile_header_menu_currency_color'); ?>
											<?php $widgets->inputColor('mobile_header_menu_currency_active_color'); ?>
											<?php $widgets->inputColor('mobile_header_menu_text_color'); ?>
											<?php $widgets->inputColor('mobile_header_menu_icon_color'); ?>
											<?php $widgets->inputColor('mobile_header_menu_total_color'); ?>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="tab-pane" id="tab-footer">
							<div class="panel-group accordion">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#footer-1">
												<i class="indicator fa fa-chevron-down"></i> Верхняя часть
											</a>
										</h4>
									</div>
									<div id="footer-1" class="panel-collapse collapse">
										<div class="panel-body">
											<?php foreach( range(1,2) as $section_id ) { ?>
											<div class='form-group' style="display: inline-block; width: 100%;">
												<h3>Секция №<?php echo $section_id; ?></h3>
											</div>
											<div class='form-group'>
												<div id="section_<?php echo $section_id; ?>" class="htabs">
													<ul class="nav nav-tabs">
														<?php foreach ($languages as $language) { ?>
														<li class="<?php echo $language['language_id']==1? 'active': '';?>"><a href="#section-<?php echo $section_id; ?>-<?php echo $language['language_id']; ?>" data-toggle="tab">
																<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>">
																<?php echo $language['name'];?></a>
														</li>
														<?php } ?>
													</ul>
												</div>
												<div class="tab-content">
													<?php foreach ($languages as $language) { ?>
													<div class="tab-pane <?php echo $language['language_id']==1? 'active': '';?>" id="section-<?php echo $section_id; ?>-<?php echo $language['language_id']; ?>">
														<textarea class="form-control"  rows="6" name="neoseo_unistor_footer_sections[<?php echo $section_id; ?>][<?php echo $language['language_id']; ?>]"><?php echo (isset($neoseo_unistor_footer_sections[$section_id][$language['language_id']]) ? $neoseo_unistor_footer_sections[$section_id][$language['language_id']] : ''); ?></textarea>
													</div>
													<?php } ?>
												</div>
											</div>
											<?php } ?>
											<?php $widgets->inputColor('footer_top_background'); ?>
											<?php $widgets->inputColor('footer_top_color'); ?>
											<?php $widgets->inputColor('footer_top_link_hover_color'); ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#footer-2">
												<i class="indicator fa fa-chevron-down"></i> Средняя часть
											</a>
										</h4>
									</div>
									<div id="footer-2" class="panel-collapse collapse">
										<div class="panel-body">
											<?php foreach( range(1,4) as $column_id ) { ?>
											<div class="form-group">
												<h2>Колонка №<?php echo $column_id; ?></h2>
											</div>
											<div class="form-group" style="display: inline-block; width: 100%;">
												<div class="col-sm-5">
													<label class="control-label">Название колонки №<?php echo $column_id; ?></label>
												</div>
												<div class="col-sm-7">
													<?php foreach ($languages as $language) {  ?>
													<div class="input-group">
														<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
														<input class="form-control" name="neoseo_unistor_footer_column_names[<?php echo $column_id; ?>][<?php echo $language['language_id']; ?>]" value="<?php echo (isset($neoseo_unistor_footer_column_names[$column_id][$language['language_id']]) ? $neoseo_unistor_footer_column_names[$column_id][$language['language_id']] : ''); ?>"/>
													</div>
													<?php } ?>
												</div>
											</div>
											<div class="form-group" style="display: inline-block; width: 100%;">
												<div class="col-sm-5 content-type column_<?php echo $column_id; ?>">
													<label>Данные колонки №<?php echo $column_id; ?>: </label>
													<label>
														<input type="radio" target="<?php echo $column_id; ?>" id="column_type_<?php echo $column_id; ?>_0" name="neoseo_unistor_footer_column_types[<?php echo $column_id; ?>]"<?php if( empty($neoseo_unistor_footer_column_types[$column_id])) { ?> checked<?php } ?> value="0">Текст
													</label>
													<label>
														<input type="radio" target="<?php echo $column_id; ?>" id="column_type_<?php echo $column_id; ?>_1" name="neoseo_unistor_footer_column_types[<?php echo $column_id; ?>]"<?php if( isset($neoseo_unistor_footer_column_types[$column_id]) && $neoseo_unistor_footer_column_types[$column_id] == 1 ) { ?> checked<?php } ?> value="1">Меню
													</label>
													<label>
														<input type="radio" target="<?php echo $column_id; ?>" id="column_type_<?php echo $column_id; ?>_2" name="neoseo_unistor_footer_column_types[<?php echo $column_id; ?>]"<?php if( isset($neoseo_unistor_footer_column_types[$column_id]) && $neoseo_unistor_footer_column_types[$column_id] == 2 ) { ?> checked<?php } ?> value="2">Форма подписки
													</label>
												</div>
												<div id="column_text_<?php echo $column_id; ?>" class='col-sm-7'>
													<div id="column_text_<?php echo $column_id; ?>_tabs" class="htabs">
														<ul class="nav nav-tabs">
															<?php foreach ($languages as $language) { ?>
															<li class="<?php echo $language['language_id']==1? 'active': '';?>"><a href="#column_text-<?php echo $column_id; ?>-<?php echo $language['language_id']; ?>" data-toggle="tab">
																	<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>">
																	<?php echo $language['name'];?></a>
															</li>
															<?php } ?>
														</ul>
													</div>
													<div class="tab-content">
														<?php foreach ($languages as $language) { ?>
														<div class="tab-pane <?php echo $language['language_id']==1? 'active': '';?>" id="column_text-<?php echo $column_id; ?>-<?php echo $language['language_id']; ?>">
															<textarea class='form-control' rows="6" name="neoseo_unistor_footer_column_texts[<?php echo $column_id; ?>][<?php echo $language['language_id']; ?>]"><?php echo (isset($neoseo_unistor_footer_column_texts[$column_id][$language['language_id']]) ? $neoseo_unistor_footer_column_texts[$column_id][$language['language_id']] : ''); ?></textarea>
														</div>
														<?php } ?>
													</div>
												</div>
												<div id="column_menu_<?php echo $column_id; ?>" class='col-sm-7'>
													<select name="neoseo_unistor_footer_column_menu[<?php echo $column_id; ?>]" class="form-control">
														<?php foreach ($menus as $menu_id => $menu_name) { ?>
														<?php if (isset($neoseo_unistor_footer_column_menu[$column_id]) && $neoseo_unistor_footer_column_menu[$column_id] == $menu_id) { ?>
														<option value="<?php echo $menu_id; ?>" selected="selected"><?php echo $menu_name; ?></option>
														<?php } else { ?>
														<option value="<?php echo $menu_id; ?>"><?php echo $menu_name; ?></option>
														<?php } ?>
														<?php } ?>
													</select>
												</div>
												<div id="column_subscribe_<?php echo $column_id; ?>" class='col-sm-7'>
													Будут использованы данные из шаблона
												</div>
											</div>
											<?php } ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#footer-3">
												<i class="indicator fa fa-chevron-down"></i> Нижняя часть
											</a>
										</h4>
									</div>
									<div id="footer-3" class="panel-collapse collapse">
										<div class="panel-body">
											<?php foreach( range(3,3) as $section_id ) { ?>
											<div class='form-group'>
												<h3><?php echo ${'entry_footer_section_' . $section_id}; ?></h3>
												<p style="margin: 15px 0 0;" class="text-danger">Не пробуйте убрать подпись на neoseo.com.ua самостоятельно (поломаете сайт). Чтобы убрать ссылку на нас, как на Разработчика данного продукта, пожалуйста, купите данную опцию (услугу) в Личном кабинете.</p>
											</div>
											<div class='form-group'>
												<div id="section_<?php echo $section_id; ?>" class="htabs">
													<ul class="nav nav-tabs">
														<?php foreach ($languages as $language) { ?>
														<li class="<?php echo $language['language_id']==1? 'active': '';?>"><a href="#section-<?php echo $section_id; ?>-<?php echo $language['language_id']; ?>" data-toggle="tab">
																<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>">
																<?php echo $language['name'];?></a>
														</li>
														<?php } ?>
													</ul>
												</div>
												<div class="tab-content">
													<?php foreach ($languages as $language) { ?>
													<div class="tab-pane <?php echo $language['language_id']==1? 'active': '';?>" id="section-<?php echo $section_id; ?>-<?php echo $language['language_id']; ?>">
														<textarea class="form-control"  rows="6" name="neoseo_unistor_footer_sections[<?php echo $section_id; ?>][<?php echo $language['language_id']; ?>]"><?php echo (isset($neoseo_unistor_footer_sections[$section_id][$language['language_id']]) ? $neoseo_unistor_footer_sections[$section_id][$language['language_id']] : ''); ?></textarea>
													</div>
													<?php } ?>
												</div>
											</div>
											<?php } ?>
											<?php foreach( range(4,5) as $section_id ) { ?>
											<div class='form-group'>
												<h3><?php echo ${'entry_footer_section_' . $section_id}; ?></h3>
											</div>
											<div class='form-group'>
												<div id="section_<?php echo $section_id; ?>" class="htabs">
													<ul class="nav nav-tabs">
														<?php foreach ($languages as $language) { ?>
														<li class="<?php echo $language['language_id']==1? 'active': '';?>"><a href="#section-<?php echo $section_id; ?>-<?php echo $language['language_id']; ?>" data-toggle="tab">
																<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>">
																<?php echo $language['name'];?></a>
														</li>
														<?php } ?>
													</ul>
												</div>
												<div class="tab-content">
													<?php foreach ($languages as $language) { ?>
													<div class="tab-pane <?php echo $language['language_id']==1? 'active': '';?>" id="section-<?php echo $section_id; ?>-<?php echo $language['language_id']; ?>">
														<textarea class="form-control"  rows="6" name="neoseo_unistor_footer_sections[<?php echo $section_id; ?>][<?php echo $language['language_id']; ?>]"><?php echo (isset($neoseo_unistor_footer_sections[$section_id][$language['language_id']]) ? $neoseo_unistor_footer_sections[$section_id][$language['language_id']] : ''); ?></textarea>
													</div>
													<?php } ?>
												</div>
											</div>
											<?php } ?>
											<?php $widgets->inputColor('footer_bottom_background'); ?>
											<?php $widgets->inputColor('footer_bottom_color'); ?>
											<?php $widgets->inputColor('footer_bottom_link_hover_color'); ?>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-contact">
							<div class="panel-group accordion">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#contact-1">
												<i class="indicator fa fa-chevron-down"></i> Секции
											</a>
										</h4>
									</div>
									<div id="contact-1" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->dropdown('contact_sections_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
											<?php foreach( range(1,4) as $section_id ) { ?>
											<div class="form-group">
												<h2>Секция №<?php echo $section_id; ?></h2>
											</div>
											<div class="form-group" style="display: inline-block; width: 100%;">
												<div class="col-sm-5">
													<label class="control-label">Название секции №<?php echo $section_id; ?></label>
												</div>
												<div class="col-sm-7">
													<?php foreach ($languages as $language) {  ?>
													<div class="input-group">
														<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
														<input class="form-control" name="neoseo_unistor_contact_section_names[<?php echo $section_id; ?>][<?php echo $language['language_id']; ?>]" value="<?php echo (isset($neoseo_unistor_contact_section_names[$section_id][$language['language_id']]) ? $neoseo_unistor_contact_section_names[$section_id][$language['language_id']] : ''); ?>"/>
													</div>
													<?php } ?>
												</div>
											</div>
											<div class="form-group" style="display: inline-block; width: 100%;">
												<div class="col-sm-5 content-type">
													<label>Данные секции №<?php echo $section_id; ?>: </label>
												</div>
												<div id="contact_section_text_<?php echo $section_id; ?>" class='col-sm-7'>
													<div id="contact_section_text_<?php echo $section_id; ?>_tabs" class="htabs">
														<ul class="nav nav-tabs">
															<?php foreach ($languages as $language) { ?>
															<li class="<?php echo $language['language_id']==1? 'active': '';?>"><a href="#contact_section_text-<?php echo $section_id; ?>-<?php echo $language['language_id']; ?>" data-toggle="tab">
																	<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>">
																	<?php echo $language['name'];?></a>
															</li>
															<?php } ?>
														</ul>
													</div>
													<div class="tab-content">
														<?php foreach ($languages as $language) { ?>
														<div class="tab-pane <?php echo $language['language_id']==1? 'active': '';?>" id="contact_section_text-<?php echo $section_id; ?>-<?php echo $language['language_id']; ?>">
															<textarea class='form-control' rows="6" name="neoseo_unistor_contact_section_texts[<?php echo $section_id; ?>][<?php echo $language['language_id']; ?>]"><?php echo (isset($neoseo_unistor_contact_section_texts[$section_id][$language['language_id']]) ? $neoseo_unistor_contact_section_texts[$section_id][$language['language_id']] : ''); ?></textarea>
														</div>
														<?php } ?>
													</div>
												</div>
											</div>
											<?php } ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#contact-2">
												<i class="indicator fa fa-chevron-down"></i> Карта
											</a>
										</h4>
									</div>
									<div id="contact-2" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->dropdown('contact_map', $maps); ?>
											<?php $widgets->input('contact_google_api_key'); ?>
											<?php $widgets->input('contact_latitude'); ?>
											<?php $widgets->input('contact_longitude'); ?>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" href="#contact-3">
												<i class="indicator fa fa-chevron-down"></i> Форма связи
											</a>
										</h4>
									</div>
									<div id="contact-3" class="panel-collapse collapse">
										<div class="panel-body">
											<?php $widgets->dropdown('contact_form_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-category">
							<?php $widgets->dropdown('category_view_count',array( 3 => 3, 4 => 4, 5 => 5)); ?>
							<?php $widgets->dropdown('category_view_type',array( 'grid' => $text_cat_grid, 'list' => $text_cat_list, 'table' =>$text_cat_table)); ?>
							<?php $widgets->dropdown('category_description_position',array( 0 => $text_top, 1 => $text_bottom)); ?>
							<?php $widgets->dropdown('hover_image',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->dropdown('subcategories_show',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->input('subcategories_image_height'); ?>
							<?php $widgets->input('subcategories_image_width'); ?>
							<?php $widgets->input('product_short_description_length'); ?>
							<?php $widgets->dropdown('product_attributes_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<div id="product_show_selected_attributes" style="display:none;">
								<?php $widgets->checklist('product_selected_attributes',$attributes); ?>
								<?php $widgets->input('product_selected_attributes_custom_divider'); ?>
								<?php $widgets->dropdown('product_show_manufacturer',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
								<?php $widgets->dropdown('product_show_model',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
								<?php $widgets->dropdown('product_show_sku',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
								<?php $widgets->dropdown('product_show_weight',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							</div>
						</div>
						<?php } ?>
						<?php if( !isset($license_error) ) { ?>
						<div class="tab-pane" id="tab-products">
							<?php $widgets->dropdown('prev_next_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->dropdown('prev_next_link_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->dropdown('product_zoom',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->checklist('attributes_title',$attributes); ?>
							<div class="form-group" id="field_color_slave_shadow" style="display: inline-block; width: 100%;">
								<div class="col-sm-5">
									<label class="control-label" for="neoseo_unistor_color_status"><?php echo $entry_colors_status; ?></label>
								</div>
								<div class="col-sm-7">
									<div class="form-group" id="field_color_slave_shadow" style="display: inline-block; width: 100%;">
										<div class="col-sm-3">
											<label class="control-label" for="neoseo_unistor_color_status"><?php echo $entry_instock; ?></label>
											<br><?php echo $entry_instock_desc; ?>
										</div>
										<div class="col-sm-9">
											<div class="col-sm-3">
												<label class="control-label" for="neoseo_unistor_color_status"><?php echo $entry_font_color; ?></label>
											</div>
											<div class="col-sm-9">
												<div class="input-group colorpicker-component colorpicker-element">
													<input name="neoseo_unistor_colors_status[0][font_color]" id="neoseo_unistor_colors_status_font_0"  value="<?php echo isset($neoseo_unistor_colors_status[0]) ? $neoseo_unistor_colors_status[0]['font_color'] : '#14a128';?>" class="form-control"/>
													<span class="input-group-addon"><i style="background-color: rgb(20,161,40);"></i></span>
												</div>
											</div>
											<div class="col-sm-3 hidden">
												<label class="control-label" for="neoseo_unistor_color_status"><?php echo $entry_background_color; ?></label>
											</div>
											<div class="col-sm-9 hidden">
												<div class="input-group colorpicker-component colorpicker-element">
													<input name="neoseo_unistor_colors_status[0][background_color]" id="neoseo_unistor_colors_status_background_0"  value="<?php echo isset($neoseo_unistor_colors_status[0]) ? $neoseo_unistor_colors_status[0]['background_color'] : '#14a128';?>" class="form-control"/>
													<span class="input-group-addon"><i style="background-color: rgb(20,161,40);"></i></span>
												</div>
											</div>
											<div class="col-sm-3 hidden">
												<label class="control-label" for="neoseo_unistor_color_status"><?php echo $entry_border_color; ?></label>
											</div>
											<div class="col-sm-9 hidden">
												<div class="input-group colorpicker-component colorpicker-element">
													<input name="neoseo_unistor_colors_status[0][border_color]" id="neoseo_unistor_colors_status_border_0"  value="<?php echo isset($neoseo_unistor_colors_status[0]) ? $neoseo_unistor_colors_status[0]['border_color'] : '#14a128';?>" class="form-control"/>
													<span class="input-group-addon"><i style="background-color: rgb(20,161,40);"></i></span>
												</div>
											</div>
										</div>
									</div>
									<?php foreach($stock_statuses as $status_key => $status) { ?>
									<div class="form-group" id="field_color_slave_shadow" style="display: inline-block; width: 100%;">
										<div class="col-sm-3">
											<label class="control-label" for="neoseo_unistor_color_status"><?php echo $status; ?></label>
										</div>
										<div class="col-sm-9">
											<div class="col-sm-3">
												<label class="control-label" for="neoseo_unistor_color_status"><?php echo $entry_font_color; ?></label>
											</div>
											<div class="col-sm-9">
												<div class="input-group colorpicker-component colorpicker-element">
													<input name="neoseo_unistor_colors_status[<?php echo $status_key?>][font_color]" id="neoseo_unistor_colors_status_font_<?php echo $status_key?>"  value="<?php echo isset($neoseo_unistor_colors_status[$status_key]) ? $neoseo_unistor_colors_status[$status_key]['font_color'] : '';?>" class="form-control"/>
													<span class="input-group-addon"><i style="background-color: rgb(94, 142, 228);"></i></span>
												</div>
											</div>
											<div class="col-sm-3 hidden">
												<label class="control-label" for="neoseo_unistor_color_status"><?php echo $entry_background_color; ?></label>
											</div>
											<div class="col-sm-9 hidden">
												<div class="input-group colorpicker-component colorpicker-element">
													<input name="neoseo_unistor_colors_status[<?php echo $status_key?>][background_color]" id="neoseo_unistor_colors_status_background_<?php echo $status_key?>"  value="<?php echo isset($neoseo_unistor_colors_status[$status_key]) ? $neoseo_unistor_colors_status[$status_key]['background_color'] : '';?>" class="form-control"/>
													<span class="input-group-addon"><i style="background-color: rgb(94, 142, 228);"></i></span>
												</div>
											</div>
											<div class="col-sm-3 hidden">
												<label class="control-label" for="neoseo_unistor_color_status"><?php echo $entry_border_color; ?></label>
											</div>
											<div class="col-sm-9 hidden">
												<div class="input-group colorpicker-component colorpicker-element">
													<input name="neoseo_unistor_colors_status[<?php echo $status_key?>][border_color]" id="neoseo_unistor_colors_status_border_<?php echo $status_key?>"  value="<?php echo isset($neoseo_unistor_colors_status[$status_key]) ? $neoseo_unistor_colors_status[$status_key]['border_color'] : '';?>" class="form-control"/>
													<span class="input-group-addon"><i style="background-color: rgb(94, 142, 228);"></i></span>
												</div>
											</div>
										</div>
									</div>
									<?php } ?>
								</div>
							</div>
							<?php $widgets->localeTextarea('delivery',$languages); ?>
							<?php $widgets->localeTextarea('payment',$languages); ?>
							<?php $widgets->localeTextarea('guarantee',$languages); ?>
						</div>
						<?php } ?>
						<?php if( !isset($license_error) ) { ?>
						<div class="tab-pane" id="tab-logs">
							<?php $widgets->debug_download_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $download, $button_clear_log, $button_download_log); ?>
							<textarea class="form-control" style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
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

<script>
	if ($('#neoseo_unistor_header_type').val() === 'header' || $('#neoseo_unistor_header_type').val() === 'header.type-3'){
		$('#field_header_information').removeClass('active');
	} else {
		$('#field_header_information').addClass('active');
		$('#neoseo_unistor_menu_main_type option').removeAttr('selected');
		$('#neoseo_unistor_menu_main_type option').eq(0).attr('selected', 'selected');
		$('#field_menu_main_type').hide();
	}

	$('#neoseo_unistor_header_type').on('change', function() {
		if ($('#neoseo_unistor_header_type').val() === 'header' || $('#neoseo_unistor_header_type').val() === 'header.type-3') {
			$('#neoseo_unistor_menu_main_type option').removeAttr('selected');
			$('#neoseo_unistor_menu_main_type option').eq(0).attr('selected', 'selected');
			$('#field_menu_main_type').show();
			$('#field_header_information').removeClass('active');
		} else {
			$('#neoseo_unistor_menu_main_type option').removeAttr('selected');
			$('#neoseo_unistor_menu_main_type option').eq(0).attr('selected', 'selected');
			$('#field_menu_main_type').hide();
			$('#field_header_information').addClass('active');
		}

	})

	function toggleChevron(e) {
		$(e.target)
				.prev('.panel-heading')
				.find("i.indicator")
				.toggleClass('fa-chevron-down fa-chevron-up');
	}
	$('.accordion').on('hidden.bs.collapse', toggleChevron);
	$('.accordion').on('shown.bs.collapse', toggleChevron);

	$(document).ready(function () {
		$(".colorpicker-component").colorpicker();
		$('._col_pick_tool').on('click', function () {
			var input = $('.ui-draggable').children('.gradient-component');
			var prev = $('.ui-draggable').parent('._colpick_tool_cont');
			setTimeout(function() {
				$(prev).prepend(input);
			},300)

		});
	});

	$('#neoseo_unistor_product_attributes_status').change(function() {
		if ($('#neoseo_unistor_product_attributes_status').val() == 1) {
			$('#product_show_selected_attributes').show();
		} else {
			$('#product_show_selected_attributes').hide();
		}
	});
	$('#neoseo_unistor_product_attributes_status').trigger('change');

	window.token = '<?php echo $token; ?>';

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

	function updateColumnType(target){
		var value = $(".column_" + target + " [type=radio]:checked").val();
		if (value == 0) {
			$("#column_menu_" + target).hide();
			$("#column_sudscribe_" + target).hide();
			$("#column_text_" + target).show();
		} else if (value == 2) {
			$("#column_text_" + target).hide();
			$("#column_menu_" + target).hide();
			$("#column_sudscribe_" + target).show();

		} else {
			$("#column_text_" + target).hide();
			$("#column_sudscribe_" + target).hide();
			$("#column_menu_" + target).show();
		}
	}

	$(".content-type input[type=radio]").click(function() {
		updateColumnType($(this).attr('target'));
	});

	var selectedItems = new Array();

	$(".content-type input[type=radio]:checked").each(function() {
		var target = $(this).attr('target');
		var id = $(this).attr('id');
		if (id.substr( - 1) == 1){
			$("#column_text_" + target).hide();
			$("#column_sudscribe_" + target).hide();
			$("#column_menu_" + target).show();
		} else if (id.substr( - 1) == 2){
			$("#column_menu_" + target).hide();
			$("#column_sudscribe_" + target).show();
			$("#column_text_" + target).hide();
		} else {
			$("#column_menu_" + target).hide();
			$("#column_sudscribe_" + target).hide();
			$("#column_text_" + target).show();
		}
	});

	$(function () {

		// Обработка хеш-тегов для табов
		var tabs = [];
		$('.panel-body:first > .nav-tabs li').each(function(index){
			var obj = $(this).children().prop('href');
			tabs.push(obj.substring(obj.indexOf('#')));
		});
		if (window.location.hash.indexOf('#tab') == 0 && $("[href=" + window.location.hash + "]").length) {
			$(".panel-body > .nav-tabs li").removeClass("active");
			$("[href=" + window.location.hash + "]").parents('li').addClass("active");
			$(".panel-body:first .tab-content:first .tab-pane:first").removeClass("active");
			$(window.location.hash).addClass("active");
		}
		$(".nav-tabs li a").click(function(){
			var url = $(this).prop('href');
			var tab = url.substring(url.indexOf('#'));
			if ($.inArray(tab, tabs) != -1 ){
				window.location.hash = tab;
			}
		});
	});
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

	<?php foreach ($languages as $language) { ?>
	<?php if ($ckeditor) { ?>
			ckeditorInit('neoseo_unistor_delivery<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
			ckeditorInit('neoseo_unistor_payment<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
			ckeditorInit('neoseo_unistor_guarantee<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
		<?php } else { ?>
			$('#neoseo_unistor_delivery<?php echo $language['language_id']; ?>').summernote({height: 300, lang:'ru-RU'});
			$('#neoseo_unistor_payment<?php echo $language['language_id']; ?>').summernote({height: 300, lang:'ru-RU'});
			$('#neoseo_unistor_guarantee<?php echo $language['language_id']; ?>').summernote({height: 300, lang:'ru-RU'});
		<?php } ?>
	<?php } ?>

</script>
<?php echo $footer; ?>
