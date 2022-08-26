function getURLVar(key) {
	var value = [];

	var query = String(document.location).split('?');

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

$(document).ready(function() {

	$('html').keypress(function (e) {
		if (e.keyCode == 13) {
			$('#button-filter').trigger('click');
		}
	});

// dropdown-menu open in .tile-dash

	$('.tile-dash .tile-footer .dropdown-menu').each(function () {
		var ddW = $(this).width();
		var tileW = $(this).closest('.tile-dash').width();
		var tileOffset = $(this).closest('.tile-dash').offset().left;

		var imgOffsetX = ddW - tileW - tileOffset;


		if ( imgOffsetX > 0) {
			$(this).css('transform', 'translateX('+imgOffsetX+'px)');
		}
	});

	$(document).on('click', function(event) {

		if (($(event.target).closest('.tile-footer').length > 0) && ($(event.target).closest('.tile-footer').find('a.dropdown-toggle').length > 0)) {
			$(event.target).closest('.tile-dash .tile-footer').addClass('this');
			$('.tile-dash .tile-footer:not(.this)').removeClass('open');
			$('.tile-dash .tile-footer.this').addClass('open').removeClass('this');
		}
		else
			// {
			// 	$('.tile-dash .tile-footer.open').removeClass('open');
			// 	console.log('2')

			// }

		if (($(event.target).closest('.tile-body').length > 0) && ($(event.target).closest('.tile-body').find('a.dropdown-toggle').length > 0)) {
			console.log($(event.target))
			$(event.target).closest('.tile-body').addClass('this');
			$('.tile-dash .tile-body:not(.this) > div').removeClass('open');
			$('.tile-dash .this > div').addClass('open').closest('.this').removeClass('this');
		}
		else {
			$('.tile-dash .open').removeClass('open');

		}

	})

	$('.order-dropdown').each(function() {
		var tdTop = $(this).closest('td').position().top;
		var tdH = $(this).closest('td').height();
		var thisTop = tdTop + tdH + 10;
		console.log(thisTop)
		$(this).css('top',thisTop+'px');
	})

// dropdown-menu open in .tile-dash end

	//Form Submit for IE Browser
	/*$('button[type=\'submit\']').on('click', function(e) {
		if ($("form[id*='form-']").length > 0) {
			e.preventDefault();
			$("form[id*='form-']").submit();
		}
	});*/

	// Highlight any found errors
	$('.text-danger').each(function() {
		var element = $(this).parent().parent();

		if (element.hasClass('form-group')) {
			element.addClass('has-error');
		}
	});

	// Set last page opened on the menu
	$('#menu a[href]').on('click', function() {
		sessionStorage.setItem('menu', $(this).attr('href'));
	});

	if (!sessionStorage.getItem('menu')) {
		$('#menu #dashboard').addClass('active');
	} else {
		// Sets active and open to selected page in the left column menu.
		$('#menu a[href=\'' + sessionStorage.getItem('menu') + '\']').parents('li').addClass('active open');
	}

	if (localStorage.getItem('column-left') == 'active') {
		$('#button-menu i').replaceWith('<i class="fa fa-dedent fa-lg"></i>');

		$('#column-left').addClass('active');

		// Slide Down Menu
		$('#menu li.active').has('ul').children('ul').addClass('collapse in');
		$('#menu li').not('.active').has('ul').children('ul').addClass('collapse');
		$('.qs-menu').removeClass('collapsed');
	} else {
		$('#button-menu i').replaceWith('<i class="fa fa-indent fa-lg"></i>');

		$('#menu li li.active').has('ul').children('ul').addClass('collapse in');
		$('#menu li li').not('.active').has('ul').children('ul').addClass('collapse');
		$('.qs-menu').addClass('collapsed');
	}

	// Menu button
	$('#button-menu').on('click', function() {
		// Checks if the left column is active or not.
		if ($('#column-left').hasClass('active')) {
			localStorage.setItem('column-left', '');

			$('#button-menu i').replaceWith('<i class="fa fa-indent fa-lg"></i>');

			$('#column-left').removeClass('active');

			$('#menu > li > ul').removeClass('in collapse');
			$('#menu > li > ul').removeAttr('style');
			$('.qs-menu').addClass('collapsed');
		} else {
			localStorage.setItem('column-left', 'active');
			$('#button-menu i').replaceWith('<i class="fa fa-dedent fa-lg"></i>');
			$('#column-left').addClass('active');
			// Add the slide down to open menu items
			$('#menu li.open').has('ul').children('ul').addClass('collapse in');
			$('#menu li').not('.open').has('ul').children('ul').addClass('collapse');
			$('.qs-menu').removeClass('collapsed');
		}
	});

	// Menu
	$('#menu').find('li').has('ul').children('a').on('click', function() {
		if ($('#column-left').hasClass('active')) {
			$(this).parent('li').toggleClass('open').children('ul').collapse('toggle');
			$(this).parent('li').siblings().removeClass('open').children('ul.in').collapse('hide');
			$('.qs-menu').removeClass('collapsed');
		} else if (!$(this).parent().parent().is('#menu')) {
			$(this).parent('li').toggleClass('open').children('ul').collapse('toggle');
			$(this).parent('li').siblings().removeClass('open').children('ul.in').collapse('hide');
			$('.qs-menu').addClass('collapsed');
		}
	});

	// Override summernotes image manager
	$('button[data-event=\'showImageDialog\']').attr('data-toggle', 'image').removeAttr('data-event');

	$(document).delegate('button[data-toggle=\'image\']', 'click', function() {
		$('#modal-image').remove();

		$(this).parents('.note-editor').find('.note-editable').focus();

		$.ajax({
			url: 'index.php?route=common/filemanager&token=' + getURLVar('token'),
			dataType: 'html',
			beforeSend: function() {
				$('#button-image i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
				$('#button-image').prop('disabled', true);
			},
			complete: function() {
				$('#button-image i').replaceWith('<i class="fa fa-upload"></i>');
				$('#button-image').prop('disabled', false);
			},
			success: function(html) {
				$('body').append('<div id="modal-image" class="modal">' + html + '</div>');

				$('#modal-image').modal('show');
			}
		});
	});

	// Image Manager
	$(document).delegate('a[data-toggle=\'image\']', 'click', function(e) {
		e.preventDefault();

		$('.popover').popover('hide', function() {
			$('.popover').remove();
		});

		var element = this;

		$(element).popover({
			html: true,
			placement: 'right',
			trigger: 'manual',
			content: function() {
				return '<button type="button" id="button-image" class="btn btn-primary"><i class="fa fa-pencil"></i></button> <button type="button" id="button-clear" class="btn btn-danger"><i class="fa fa-trash-o"></i></button>';
			}
		});

		$(element).popover('show');

		$('#button-image').on('click', function() {
			$('#modal-image').remove();

			$.ajax({
				url: 'index.php?route=common/filemanager&token=' + getURLVar('token') + '&target=' + $(element).parent().find('input').attr('id') + '&thumb=' + $(element).attr('id'),
				dataType: 'html',
				beforeSend: function() {
					$('#button-image i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
					$('#button-image').prop('disabled', true);
				},
				complete: function() {
					$('#button-image i').replaceWith('<i class="fa fa-pencil"></i>');
					$('#button-image').prop('disabled', false);
				},
				success: function(html) {
					$('body').append('<div id="modal-image" class="modal">' + html + '</div>');

					$('#modal-image').modal('show');
				}
			});

			$(element).popover('hide', function() {
				$('.popover').remove();
			});
		});

		$('#button-clear').on('click', function() {
			$(element).find('img').attr('src', $(element).find('img').attr('data-placeholder'));

			$(element).parent().find('input').attr('value', '');

			$(element).popover('hide', function() {
				$('.popover').remove();
			});
		});
	});

	// tooltips on hover
	$('[data-toggle=\'tooltip\']').tooltip({container: 'body', html: true});

	// Makes tooltips work on ajax generated content
	$(document).ajaxStop(function() {
		$('[data-toggle=\'tooltip\']').tooltip({container: 'body'});
	});

	// https://github.com/opencart/opencart/issues/2595
	$.event.special.remove = {
		remove: function(o) {
			if (o.handler) {
				o.handler.apply(this, arguments);
			}
		}
	}

	$('[data-toggle=\'tooltip\']').on('remove', function() {
		$(this).tooltip('destroy');
	});
});

// Autocomplete */
(function($) {
	$.fn.autocomplete = function(option) {
		return this.each(function() {
			this.timer = null;
			this.items = new Array();

			$.extend(this, option);

			$(this).attr('autocomplete', 'off');

			// Focus
			$(this).on('focus', function() {
				this.request();
			});

			// Blur
			$(this).on('blur', function() {
				setTimeout(function(object) {
					object.hide();
				}, 200, this);
			});

			// Keydown
			$(this).on('keydown', function(event) {
				switch(event.keyCode) {
					case 27: // escape
						this.hide();
						break;
					default:
						this.request();
						break;
				}
			});

			// Click
			this.click = function(event) {
				event.preventDefault();

				value = $(event.target).parent().attr('data-value');

				if (value && this.items[value]) {
					this.select(this.items[value]);
				}
			}

			// Show
			this.show = function() {
				var pos = $(this).position();

				$(this).siblings('ul.dropdown-menu').css({
					top: pos.top + $(this).outerHeight(),
					left: pos.left
				});

				$(this).siblings('ul.dropdown-menu').show();
			}

			// Hide
			this.hide = function() {
				$(this).siblings('ul.dropdown-menu').hide();
			}

			// Request
			this.request = function() {
				clearTimeout(this.timer);

				this.timer = setTimeout(function(object) {
					object.source($(object).val(), $.proxy(object.response, object));
				}, 200, this);
			}

			// Response
			this.response = function(json) {
				html = '';

				if (json.length) {
					for (i = 0; i < json.length; i++) {
						this.items[json[i]['value']] = json[i];
					}

					for (i = 0; i < json.length; i++) {
						if (!json[i]['category']) {
							html += '<li data-value="' + json[i]['value'] + '"><a href="#">' + json[i]['label'] + '</a></li>';
						}
					}

					// Get all the ones with a categories
					var category = new Array();

					for (i = 0; i < json.length; i++) {
						if (json[i]['category']) {
							if (!category[json[i]['category']]) {
								category[json[i]['category']] = new Array();
								category[json[i]['category']]['name'] = json[i]['category'];
								category[json[i]['category']]['item'] = new Array();
							}

							category[json[i]['category']]['item'].push(json[i]);
						}
					}

					for (i in category) {
						html += '<li class="dropdown-header">' + category[i]['name'] + '</li>';

						for (j = 0; j < category[i]['item'].length; j++) {
							html += '<li data-value="' + category[i]['item'][j]['value'] + '"><a href="#">&nbsp;&nbsp;&nbsp;' + category[i]['item'][j]['label'] + '</a></li>';
						}
					}
				}

				if (html) {
					this.show();
				} else {
					this.hide();
				}

				$(this).siblings('ul.dropdown-menu').html(html);
			}

			$(this).after('<ul class="dropdown-menu"></ul>');
			$(this).siblings('ul.dropdown-menu').delegate('a', 'click', $.proxy(this.click, this));

		});
	}
})(window.jQuery);

$(function () {


	$('#neoseo_unistor_scheme_style').on('click', function () {
		changeScheme($(this).val());
	});

	function colors(scheme, color_static, color_active, color_no_active) {

		obj = {

			// НАСТРОЙКИ МОДУЛЕЙ
			//Цвет заголовка блока
			neoseo_unistor_module_title_color: color_static,
			//Цвет фона блока
			neoseo_unistor_module_background_color: color_no_active,
			//Цвет заголовков
			neoseo_unistor_title_color: color_static,
			//Цвет обводки при наведении
			neoseo_unistor_module_border_color_hover: color_active,
			//------------------------------------------------------//

			// КНОПКИ
			//Цвет фона кнопок
			neoseo_unistor_button_color: color_static,
			//Цвет текста кнопок
			neoseo_unistor_button_color_no_active: color_no_active,
			//Цвет фона кнопок при наведении
			neoseo_unistor_button_color_hover: color_active,
			//Цвет текста кнопок при наведении
			neoseo_unistor_button_color_text_hover: color_no_active,
			//Цвет иконок сравнения, лупы, добавления в избранные
			neoseo_unistor_product_thumb_icon_color: color_active,

			// Цвет фона кнопки превью товаров
			neoseo_unistor_preview_button_color: color_active,
			// Цвет текста кнопки превью товаров при наведении
			neoseo_unistor_preview_button_color_text_hover: color_active,

			//------------------------------------------------------//

			// КНОПКА НАВЕРХ
			//Цвет фона кнопки
			neoseo_unistor_go_top_background: color_static,
			//Цвет текста
			neoseo_unistor_go_top_color: color_no_active,
			//Цвет фона кнопки при наведении
			neoseo_unistor_go_top_background_hover: color_active,
			//Цвет текста кнопки наверх при наведении
			neoseo_unistor_go_top_color_active: color_static,

			//------------------------------------------------------//

			// НАСТРОЙКА ПАГИНАЦИИ
			//Цвет фона ссылок
			neoseo_unistor_pagination_background: color_no_active,
			//Цвет текста ссылок
			neoseo_unistor_pagination_color: color_static,
			//Цвет фона ссылок при наведении
			neoseo_unistor_pagination_background_hover: color_static,
			//Цвет текста ссылок при наведении
			neoseo_unistor_pagination_color_hover: color_no_active,
			//Цвет фона активной ссылки
			neoseo_unistor_pagination_background_active: color_active,
			//Цвет текста активной ссылки
			neoseo_unistor_pagination_color_active: color_static,

			//------------------------------------------------------//

			// НАСТРОЙКА ТАБОВ
			//Цвет фона табов
			neoseo_unistor_tab_color: color_no_active,
			//Цвет текста таба
			neoseo_unistor_tab_text_color: color_static,
			//Цвет фона активного таба
			neoseo_unistor_tab_color_active: color_active,
			//Цвет текста активного таба
			neoseo_unistor_tab_text_color_active: color_no_active,
			//Цвет фона табов при наведении
			neoseo_unistor_tab_color_hover: color_static,
			//Цвет текста табов при наведении
			neoseo_unistor_tab_text_color_hover: color_no_active,


			//ЛИПКОЕ МЕНЮ
			//Цвет иконки липкого меню
			neoseo_unistor_sticky_menu_color: color_no_active,
			neoseo_unistor_sticky_cart_total_color: color_active,
			neoseo_unistor_sticky_menu_icon_color: color_active,

			//ВЕРХНЕЕ МЕНЮ
			//Цвет фона верхнего меню
			neoseo_unistor_top_menu_background: color_static,
			//Цвет текста верхнего меню
			neoseo_unistor_top_menu_color: color_no_active,
			//Цвет текста верхнего меню при наведении
			neoseo_unistor_top_menu_hover_color: color_active,

			//Цвет фона личного кабинета
			neoseo_unistor_top_menu_account_bg: color_active,
			//Цвет текста личного кабинета
			neoseo_unistor_top_menu_account_color: color_no_active,

			//Цвет фона валюты
			neoseo_unistor_currency_bg: color_static,
			//Цвет текста валюты
			neoseo_unistor_currency_color: color_active,
			//Цвет фона валюты при наведении
			neoseo_unistor_currency_bg_hover: color_active,
			//Цвет текста валюты при наведении
			neoseo_unistor_currency_color_hover: color_no_active,
			//Цвет фона активной валюты
			neoseo_unistor_currency_active_bg: color_active,
			//Цвет текста активной валюты
			neoseo_unistor_currency_active_color: color_no_active,
			//Цвет фона активной валюты при наведении
			neoseo_unistor_currency_active_bg_hover: color_no_active,
			//Цвет текста активной валюты при наведении
			neoseo_unistor_currency_active_color_hover: color_no_active,
			//Цвет фона активного языка
			neoseo_unistor_language_active_bg: color_static,

			//ОСНОВНОЕ МЕНЮ
			//Цвет границы главного меню
			neoseo_unistor_menu_border_color: color_active,
			// Цвета границы пунтка меню при наведении
			neoseo_unistor_menu_border_link_color: color_active,
			//Цвет фона главного меню
			neoseo_unistor_menu_main_bg_color: color_active,
			//Цвет текста главного меню
			neoseo_unistor_menu_main_text_color: color_no_active,
			//Цвет фона главного меню при наведении
			neoseo_unistor_menu_main_bg_hover_color: color_active,
			//Цвет текста главного меню при наведении
			neoseo_unistor_menu_main_text_hover_color: color_no_active,
			//Цвет фона активного элемента главного меню
			neoseo_unistor_menu_main_bg_active_color: color_active,
			//Цвет текста активного элемента главного меню
			neoseo_unistor_menu_main_text_active_color: color_no_active,
			//Цвет фона подменю
			neoseo_unistor_menu_sub_bg_color: color_no_active,
			//Цвет текста подменю
			neoseo_unistor_menu_sub_text_color: color_static,
			//Цвет фона подменю при наведении
			neoseo_unistor_menu_sub_bg_hover_color: color_active,
			//Цвет текста подменю при наведении
			neoseo_unistor_menu_sub_text_hover_color: color_no_active,
			//Цвет фона активного подменю
			neoseo_unistor_menu_sub_bg_active_color: color_active,
			//Цвет текста активного подменю
			neoseo_unistor_menu_sub_text_active_color: color_static,
			//Цвет корзины
			neoseo_unistor_header_icon_color: color_active,

			//ПОДВАЛ
			// Фон подвала - верхняя часть
			neoseo_unistor_footer_top_background: "#222222",
			neoseo_unistor_footer_bottom_background: "#222222",
		}

		if (scheme === 'yellow') {
			obj.neoseo_unistor_top_menu_account_color = color_static;
		}

		if (scheme === 'yellow' || scheme === 'blue') {
			obj.neoseo_unistor_button_color_text_hover = color_static;
			obj.neoseo_unistor_tab_text_color_active = color_static;
			obj.neoseo_unistor_currency_bg = color_no_active;
			obj.neoseo_unistor_currency_color = color_static;
			obj.neoseo_unistor_currency_color_hover = color_static;
			obj.neoseo_unistor_currency_active_color = color_static;
			obj.neoseo_unistor_currency_active_bg = color_active;
			obj.neoseo_unistor_currency_active_bg_hover = color_static;
			obj.neoseo_unistor_currency_active_color_hover = color_active;
			obj.neoseo_unistor_menu_main_text_color = color_static;
			obj.neoseo_unistor_menu_main_text_hover_color = color_static;
			obj.neoseo_unistor_menu_sub_text_hover_color = color_static;
			obj.neoseo_unistor_menu_sub_text_active_color = color_static;
		}


		if (scheme === 'indigo') {
			obj.neoseo_unistor_footer_top_background = '#052a70';
			obj.neoseo_unistor_footer_bottom_background = '#052a70';
		}

		if (scheme === 'purple') {
			obj.neoseo_unistor_footer_top_background = '#0e0524';
			obj.neoseo_unistor_footer_bottom_background = '#0e0524';
		}

		if (scheme === 'black') {
			obj.neoseo_unistor_menu_main_bg_hover_color = color_no_active;
			obj.neoseo_unistor_menu_main_text_hover_color = color_active;
			obj.neoseo_unistor_header_icon_color = color_static;
		}

		if (scheme === 'white') {
			obj.neoseo_unistor_menu_main_bg_color = color_no_active;
			obj.neoseo_unistor_menu_main_text_color = color_static;
			obj.neoseo_unistor_menu_main_text_hover_color = color_static;
			obj.neoseo_unistor_menu_sub_text_hover_color = color_active;
			obj.neoseo_unistor_menu_border_link_color = color_static;
			obj.neoseo_unistor_header_icon_color = color_static;
		}

		return obj;

	}


	function changeScheme(scheme) {

		var schemes = {
			default: colors(scheme, '#1d1d1d', '#ef532b', '#ffffff'),
			yellow: colors(scheme, '#1d1d1d', '#fec83c', '#ffffff'),
			red: colors(scheme, '#1d1d1d','#f21a32','#ffffff'),
			orange: colors(scheme, '#1d1d1d','#ff4400','#ffffff'),
			green: colors(scheme, '#1d1d1d','#6ba91b','#ffffff'),
			purple: colors(scheme, '#1d1d1d','#632dfd','#ffffff'),
			indigo: colors(scheme, '#1d1d1d','#116dea','#ffffff'),
			blue: colors(scheme, '#1d1d1d','#57d6e9','#ffffff'),
			black: colors(scheme, '#1d1d1d','#333333','#ffffff'),
			white: colors(scheme, '#1d1d1d','#333333','#ffffff'),
		};

		for (var key in schemes[scheme]) {

			$('#' + key).val(schemes[scheme][key]);
			$('#' + key).next('span').children('i').css('background-color',schemes[scheme][key]);

		}

	}
});