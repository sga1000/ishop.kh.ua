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
	// Highlight any found errors
	$('.text-danger').each(function() {
		var element = $(this).parent().parent();

		if (element.hasClass('form-group')) {
			element.addClass('has-error');
		}
	});

	// Currency
	$('#currency .currency-select').on('click', function(e) {
		e.preventDefault();

		$('#currency input[name=\'code\']').attr('value', $(this).attr('name'));

		$('#currency').submit();
	});
    $('.most-popular-search a').on('click', function(e) {
        e.preventDefault();
        $('input[name=search]').val($(this).text());
        $('input[name=search]').trigger('keyup')
    });
	// Language
	$('#language a').on('click', function(e) {
		e.preventDefault();

		$('#language input[name=\'code\']').attr('value', $(this).attr('href'));

		$('#language').submit();
	});


	/* Search main */
	$('.button-search').on('click', function() {
		//url = $('base').attr('href') + 'index.php?route=product/search';

		let current_language_code =  $('.language__compact-wrap li.active').attr('data-code');

		if (current_language_code === undefined || current_language_code === null) {
			var url = 'index.php?route=product/search';
		} else {
			var url = current_language_code + '/index.php?route=product/search';
		}

		$('#main-search input[name="search"]').each(function () {
			if ($(this).val()) {
				var value = $(this).val();
				var filter_category = $('.category-list-title').data('categoryid');
				if (value) {
					url += '&search=' + encodeURIComponent(value);
					if (filter_category) {
						url += '&category_id='+filter_category+'&sub_category=true';
					}
				}

				location = url;
				return false;
			}
		});
	});
	$('input[name="search"]').on('keydown', function(e) {
		var parents = $(this).parents('#main-search');
		if (e.keyCode == 13) {
			parents.find('button').trigger('click');
		}
	});

	// Product List
	$('#list-view').click(function() {
		$('#content .row > .product-grid').attr('class', 'product-layout product-list col-xs-12');
		$('#content .row > .product-list').attr('class', 'product-layout product-list col-xs-12');
		$('#content .row > .product-table').attr('class', 'product-layout product-list col-xs-12');
		$(this).addClass('active').siblings('.btn').removeClass('active');
		localStorage.setItem('display', 'list');
	});
	// Product Table
	$('#table-view').click(function() {
		$('#content .row > .product-grid').attr('class', 'product-layout product-table col-xs-12');
		$('#content .row > .product-list').attr('class', 'product-layout product-table col-xs-12');
		$('#content .row > .product-table').attr('class', 'product-layout product-table col-xs-12');
		$(this).addClass('active').siblings('.btn').removeClass('active');
		localStorage.setItem('display', 'table');
	});
	// Product Grid
	$('#grid-view').click(function() {
		cols = $('#column-right, #column-left').length;
		if (cols == 2) {
			$('#content .product-grid').attr('class', 'product-layout product-grid col-lg-6 col-md-6 col-sm-12 col-xs-12');
			$('#content .product-list').attr('class', 'product-layout product-grid col-lg-6 col-md-6 col-sm-12 col-xs-12');
			$('#content .product-table').attr('class', 'product-layout product-grid col-lg-6 col-md-6 col-sm-12 col-xs-12');
		} else if (cols == 1) {
			$('#content .product-grid').attr('class', 'product-layout product-grid col-lg-4 col-md-4 col-sm-6 col-xs-12');
			$('#content .product-list').attr('class', 'product-layout product-grid col-lg-4 col-md-4 col-sm-6 col-xs-12');
			$('#content .product-table').attr('class', 'product-layout product-grid col-lg-4 col-md-4 col-sm-6 col-xs-12');
		} else {
			$('#content .product-grid').attr('class', 'product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-12');
			$('#content .product-list').attr('class', 'product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-12');
			$('#content .product-table').attr('class', 'product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-12');
		}
		$(this).addClass('active').siblings('.btn').removeClass('active');
		localStorage.setItem('display', 'grid');
	});
    if (localStorage.getItem('display') === null) {
        //setTimeout(function () {
		$('.btn-view-type.active').trigger('click')
        //}, 40);
    } else if (localStorage.getItem('display') == 'list') {
		$('#list-view').trigger('click');
	} else if (localStorage.getItem('display') == 'grid') {
		$('#grid-view').trigger('click');
	} else if (localStorage.getItem('display') == 'table') {
		$('#table-view').trigger('click');
	}

	// Checkout
	$(document).on('keydown', '#collapse-checkout-option input[name=\'email\'], #collapse-checkout-option input[name=\'password\']', function(e) {
		if (e.keyCode == 13) {
			$('#collapse-checkout-option #button-login').trigger('click');
		}
	});

	// tooltips on hover
	$('[data-toggle=\'tooltip\']').tooltip({container: 'body',trigger: 'hover'});

	// Makes tooltips work on ajax generated content
	$(document).ajaxStop(function() {
		$('[data-toggle=\'tooltip\']').tooltip({container: 'body'});
	});
});

// Cart add remove functions
var cart = {
	'add': function(product_id, quantity) {
		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function() {
				$('.cart > button').button('loading');
			},
			complete: function() {
				$('.cart > button').button('reset');
			},
			success: function(json) {
				$('.alert, .text-danger').remove();

				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

					// Need to set timeout otherwise it wont update the total
					setTimeout(function () {
						$('.cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
					}, 100);

					$('html,body').animate({ scrollTop: 0 }, 'slow');

					$('.cart > ul').load('index.php?route=common/cart/info ul li');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'update': function(key, quantity) {
		$.ajax({
			url: 'index.php?route=checkout/cart/edit',
			type: 'post',
			data: 'key=' + key + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function() {
				$('.header-top .cart > button').button('loading');
			},
			complete: function() {
				$('.header-top  .cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('.header-top .cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('.header-top  .cart > ul').load('index.php?route=common/cart/info ul li');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('.header-top .cart > button').button('loading');
			},
			complete: function() {
				$('.header-top .cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('.header-top .cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('.header-top .cart > ul').load('index.php?route=common/cart/info ul li');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
}

var voucher = {
	'add': function() {

	},
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('.header-top .cart > button').button('loading');
			},
			complete: function() {
				$('.header-top .cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('.header-top .cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('.header-top .cart > ul').load('index.php?route=common/cart/info ul li');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
}

var wishlist = {
	'add': function(product_id) {
		$.ajax({
			url: 'index.php?route=account/wishlist/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();

				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				$('#wishlist-total span').html(json['total']);
				$('#wishlist-total').attr('title', json['total']);

				$('html, body').animate({ scrollTop: 0 }, 'slow');
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'remove': function() {

	}
}

var compare = {
	'add': function(product_id) {
		$.ajax({
			url: 'index.php?route=product/compare/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();

				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

					$('#compare-total').html(json['total']);

					$('html, body').animate({ scrollTop: 0 }, 'slow');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'remove': function() {

	}
}

/* Agree to Terms */
$(document).delegate('.agree', 'click', function(e) {
	e.preventDefault();

	$('#modal-agree').remove();

	var element = this;

	$.ajax({
		url: $(element).attr('href'),
		type: 'get',
		dataType: 'html',
		success: function(data) {
			html  = '<div id="modal-agree" class="modal">';
			html += '  <div class="modal-dialog">';
			html += '    <div class="modal-content">';
			html += '      <div class="modal-header">';
			html += '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
			html += '        <h4 class="modal-title">' + $(element).text() + '</h4>';
			html += '      </div>';
			html += '      <div class="modal-body">' + data + '</div>';
			html += '    </div';
			html += '  </div>';
			html += '</div>';

			$('body').append(html);

			$('#modal-agree').modal('show');
		}
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

/// - - - Common ENDe

function adjustMenu() {
	var desktopView = $(document).width();
	if (desktopView >= "768") {
		$("#menu .navbar-nav a[data-toggle]").attr("data-toggle", "");
	} else {
		$("#menu .navbar-nav a[data-toggle]").attr("data-toggle", "dropdown");
	}
}

function toggleFilter() {
	if ($("#column-left").hasClass('hidden-xs')) {
		$("#column-left > h3").hide();
		$("#column-left > div").hide();
		$("#column-left > .ocfilter").show();
		$("#column-left").removeClass('hidden-xs')
	} else {
		$("#column-left").addClass('hidden-xs')
		$("#column-left > div").show();
		$("#column-left > h3").show();
	}
}

// getBrowser 1.0
function getBrowser() {
	var ua = navigator.userAgent;

	var bName = function () {
		if (ua.search(/Edge/) > -1) return "edge";
		if (ua.search(/MSIE/) > -1) return "ie";
		if (ua.search(/Trident/) > -1) return "ie11";
		if (ua.search(/Firefox/) > -1) return "firefox";
		if (ua.search(/Opera/) > -1) return "opera";
		if (ua.search(/OPR/) > -1) return "operaWebkit";
		if (ua.search(/YaBrowser/) > -1) return "yabrowser";
		if (ua.search(/Chrome/) > -1) return "chrome";
		if (ua.search(/Safari/) > -1) return "safari";
		if (ua.search(/Maxthon/) > -1) return "maxthon";
	}();

	var version = 0;
	try {
		switch (bName) {
			case "edge":
				version = (ua.split("Edge")[1]).split("/")[1];
				break;
			case "ie":
				version = (ua.split("MSIE ")[1]).split(";")[0];
				break;
			case "ie11":
				bName = "ie";
				version = (ua.split("; rv:")[1]).split(")")[0];
				break;
			case "firefox":
				version = ua.split("Firefox/")[1];
				break;
			case "opera":
				version = ua.split("Version/")[1];
				break;
			case "operaWebkit":
				bName = "opera";
				version = ua.split("OPR/")[1];
				break;
			case "yabrowser":
				version = (ua.split("YaBrowser/")[1]).split(" ")[0];
				break;
			case "chrome":
				version = (ua.split("Chrome/")[1]).split(" ")[0];
				break;
			case "safari":
				version = (ua.split("Version/")[1]).split(" ")[0];
				break;
			case "maxthon":
				version = ua.split("Maxthon/")[1];
				break;
		}
	} catch (err) {
	}

	var platform = 'desktop';
	if (/iphone|ipad|ipod|android|blackberry|mini|windows\sce|palm/i.test(navigator.userAgent.toLowerCase())) platform = 'mobile';
	if (/iphone|ipad|ipod/i.test(navigator.userAgent.toLowerCase())) platform += ' os-ios';
	if (/android/i.test(navigator.userAgent.toLowerCase())) platform += ' os-android';

	var browsrObj;

	try {
		browsrObj = {
			platform: platform,
			browser: bName,
			versionFull: version,
			versionShort: version.split(".")[0]
		};
	} catch (err) {
		browsrObj = {
			platform: platform,
			browser: 'unknown',
			versionFull: 'unknown',
			versionShort: 'unknown'
		};
	}

	return browsrObj;
}
/// getBrowser END

$(document).ready(function () {
	adjustMenu();
	$(window).on("resize", function () {
		adjustMenu();
	});
	if ($(".ocfilter").length > 0) {
		$("#ocfilter-button").removeClass('hidden-xs');
	}
	//Скрол к блоку отзывов
	$('#show_comments').click(function () {
        $('a[href=#tab-review]').click();
        $('html, body').animate({
            scrollTop: $('a[href=#tab-review]').offset().top
        }, 2000);

	});

	/// Browsers  ZY
	var ob = getBrowser();
	if(ob.browser == 'chrome'){ $('html').addClass('br-chrome') }
	if(ob.browser == 'safari'){ $('html').addClass('br-safari') }
	if(ob.browser == 'firefox'){ $('html').addClass('br-firefox')}
	if(ob.browser == 'edge'){ $('html').addClass('br-edge')}
	if(ob.browser == 'ie11'){ $('html').addClass('br-ie11')}
	if(ob.browser == 'ie'){
		$('html').addClass('br-ie');
		if(ob.versionShort == '12'){ $('html').addClass('ie12'); }
		if(ob.versionShort == '11'){ $('html').addClass('ie11'); }
		if(ob.versionShort == '10'){ $('html').addClass('ie10'); }
		if(ob.versionShort == '9') { $('html').addClass('ie9'); }
	}
	if(ob.platform != 'desktop') $('html').addClass(ob.platform);
	///
	// Header Top CITY
	$('#city-list li').click(function(e) {
		event.stopPropagation ? event.stopPropagation() : (event.cancelBubble=true);
		var text = $(this).find('a').text();
		$(this).parents('#city-box').find('.dropdown-title .cur-city').text(text);
	});
	$('#city-box .cur-city, #city-box .button').click(function(e) {
		alert('Send AjaxQuery!')
	});
/////
// show body
	$('body').delay(100).animate({opacity:1},200);
});

var scrollPos = 0;
window.addEventListener('scroll',function () {
	var a = $(window);
	var b = $(window).height() / 2;
	var c = $("footer .container");
	if ((a.scrollTop() >= b) && !($(".go-top").length)) {
		$(c).append("<a href='javascript:void(0)' class='go-top'></a>");
		$(".go-top").bind('click', function () {
			$('html, body').animate({
						scrollTop: 0

					},
					{
						complete: function () {
							$(".go-top").remove();
						}
					}, 'swing', 500
			);

		});
	}
	if (a.scrollTop() < b) {
		$(".go-top").remove();
	}
	if ((a.scrollTop() > 230)){ /// show Stiky Top!

		if ($('#stiky_box').css('display') == 'none') return;
		$('#stiky_box').addClass('active');
		$('.search #main-search, .vertical-search #main-search').addClass('hidden');
		$('#stiky_box #main-search').removeClass('hidden');
	} else {
		if ($('.sticky-catalog-menu .main-menu').length > 0) {
			$('.sticky-catalog-menu .main-menu').hide();
		}
		$('#stiky_box').removeClass('active');
		$('.search #main-search, .vertical-search #main-search').removeClass('hidden');
        $('#stiky_box #main-search').addClass('hidden')
	}
	scrollPos = a.scrollTop();

  if ( $('.sticky-catalog-menu:hover').length == '0') {
    //console.log('mouse outside');
	  $('#stiky_box .open').removeClass('open');
  }
},  {passive: true});

$(document).click(function(event) {
    if (event.target.closest('.search #main-search, .vertical-search #main-search, #stiky_box #main-search') == null) {
        $('body').find('#stiky_box #search_main, .search #search_main, .vertical-search #search_main').each(function () {
            $(this).hide()
        });
    }
});
/*!
 * Readmore.js jQuery plugin
 * Author: @jed_foster
 * Project home: jedfoster.github.io/Readmore.js
 * Licensed under the MIT license
 */

(function ($) {

	var readmore = 'readmore',
			defaults = {
				speed: 100,
				maxHeight: 200,
				heightMargin: 16,
				moreLink: '<a href="#">Read More</a>',
				lessLink: '<a href="#">Close</a>',
				embedCSS: true,
				sectionCSS: 'display: block; width: 100%;',
				startOpen: false,
				expandedClass: 'readmore-js-expanded',
				collapsedClass: 'readmore-js-collapsed',
				// callbacks
				beforeToggle: function () {
				},
				afterToggle: function () {
				}
			},
			cssEmbedded = false;

	function Readmore(element, options) {
		this.element = element;

		this.options = $.extend({}, defaults, options);

		$(this.element).data('max-height', this.options.maxHeight);
		$(this.element).data('height-margin', this.options.heightMargin);

		delete(this.options.maxHeight);

		if (this.options.embedCSS && !cssEmbedded) {
			var styles = '.readmore-js-toggle, .readmore-js-section { ' + this.options.sectionCSS + ' } .readmore-js-section { overflow: hidden; }';

			(function (d, u) {
				var css = d.createElement('style');
				css.type = 'text/css';
				if (css.styleSheet) {
					css.styleSheet.cssText = u;
				}
				else {
					css.appendChild(d.createTextNode(u));
				}
				d.getElementsByTagName('head')[0].appendChild(css);
			}(document, styles));

			cssEmbedded = true;
		}

		this._defaults = defaults;
		this._name = readmore;

		this.init();
	}

	Readmore.prototype = {
		init: function () {
			var $this = this;

			$(this.element).each(function () {
				var current = $(this),
						maxHeight = (current.css('max-height').replace(/[^-\d\.]/g, '') > current.data('max-height')) ? current.css('max-height').replace(/[^-\d\.]/g, '') : current.data('max-height'),
						heightMargin = current.data('height-margin');

				if (current.css('max-height') != 'none') {
					current.css('max-height', 'none');
				}

				$this.setBoxHeight(current);

				if (current.outerHeight(true) <= maxHeight + heightMargin) {
					// The block is shorter than the limit, so there's no need to truncate it.
					return true;
				}
				else {
					current.addClass('readmore-js-section ' + $this.options.collapsedClass).data('collapsedHeight', maxHeight);

					var useLink = $this.options.startOpen ? $this.options.lessLink : $this.options.moreLink;
					current.after($(useLink).on('click', function (event) {
						$this.toggleSlider(this, current, event)
					}).addClass('readmore-js-toggle'));

					if (!$this.options.startOpen) {
						current.css({height: maxHeight});
					}
				}
			});

			$(window).on('resize', function (event) {
				$this.resizeBoxes();
			});
		},
		toggleSlider: function (trigger, element, event)
		{
			event.preventDefault();

			var $this = this,
					newHeight = newLink = sectionClass = '',
					expanded = false,
					collapsedHeight = $(element).data('collapsedHeight');

			if ($(element).height() <= collapsedHeight) {
				newHeight = $(element).data('expandedHeight') + 'px';
				newLink = 'lessLink';
				expanded = true;
				sectionClass = $this.options.expandedClass;
			}

			else {
				newHeight = collapsedHeight;
				newLink = 'moreLink';
				sectionClass = $this.options.collapsedClass;
			}

			// Fire beforeToggle callback
			$this.options.beforeToggle(trigger, element, expanded);

			$(element).animate({'height': newHeight}, {duration: $this.options.speed, complete: function () {
				// Fire afterToggle callback
				$this.options.afterToggle(trigger, element, expanded);

				$(trigger).replaceWith($($this.options[newLink]).on('click', function (event) {
					$this.toggleSlider(this, element, event)
				}).addClass('readmore-js-toggle'));

				$(this).removeClass($this.options.collapsedClass + ' ' + $this.options.expandedClass).addClass(sectionClass);
			}
			});
		},
		setBoxHeight: function (element) {
			var el = element.clone().css({'height': 'auto', 'width': element.width(), 'overflow': 'hidden'}).insertAfter(element),
					height = el.outerHeight(true);

			el.remove();

			element.data('expandedHeight', height);
		},
		resizeBoxes: function () {
			var $this = this;

			$('.readmore-js-section').each(function () {
				var current = $(this);

				$this.setBoxHeight(current);

				if (current.height() > current.data('expandedHeight') || (current.hasClass($this.options.expandedClass) && current.height() < current.data('expandedHeight'))) {
					current.css('height', current.data('expandedHeight'));
				}
			});
		},
		destroy: function () {
			var $this = this;

			$(this.element).each(function () {
				var current = $(this);

				current.removeClass('readmore-js-section ' + $this.options.collapsedClass + ' ' + $this.options.expandedClass).css({'max-height': '', 'height': 'auto'}).next('.readmore-js-toggle').remove();

				current.removeData();
			});
		}
	};

	$.fn[readmore] = function (options) {
		var args = arguments;
		if (options === undefined || typeof options === 'object') {
			return this.each(function () {
				if ($.data(this, 'plugin_' + readmore)) {
					var instance = $.data(this, 'plugin_' + readmore);
					instance['destroy'].apply(instance);
				}

				$.data(this, 'plugin_' + readmore, new Readmore(this, options));
			});
		} else if (typeof options === 'string' && options[0] !== '_' && options !== 'init') {
			return this.each(function () {
				var instance = $.data(this, 'plugin_' + readmore);
				if (instance instanceof Readmore && typeof instance[options] === 'function') {
					instance[options].apply(instance, Array.prototype.slice.call(args, 1));
				}
			});
		}
	}
})(jQuery);

$(window).resize(function () {

	var viewportWidth = $(window).width();
    if ( viewportWidth >= 992) {
        // Цикл проверки ширины соответствия родительскому элементу
        var buttonHave = $('div').is('.main-drop-list');
        // Цикл проверки ширины соответствия родительскому элементу
        var parentWidth = $('.main').width();
        var childWidth = 0;
        $(".main .list > li").each(function(){
            childWidth+=$(this).innerWidth();
        });

        var dropListCount = $(".drop-list > li").length;

        var buttonWidth = $('.drop-list-button').width();
        var itemWidth = $('.drop-list').children('li:first-child').width();


        var totalWidth = childWidth + itemWidth + buttonWidth;

        if ( childWidth + buttonWidth > parentWidth && buttonHave == true) {

            do {
                var parent = 0;
                var child = 0;
                var buttonWidth = $('.drop-list-button').width();
                parent = $('.main').innerWidth();

                $(".main .list > li").each(function () {
                    child += $(this).innerWidth();
                });

                if (child + buttonWidth > parent) {
                    $('.main .list').children('li:last-child').prependTo('.drop-list');
                } else {
                    break;
                }
            } while (child + buttonWidth > parent)
        }
        else if ( childWidth + buttonWidth < parentWidth && buttonHave == true && dropListCount > 1) {

            do {
                var buttonHave = $('div').is('.main-drop-list');
                var buttonWidth = $('.drop-list-button').width();

                var parent = 0;
                var child = 0;
                var itemWidth = $('.drop-list').children('li:first-child').width();

                parent = $('.main').width();

                $(".main .list > li").each(function () {
                    child += $(this).innerWidth();
                });

                var totalWidth = child + buttonWidth + itemWidth;

                if (parent > totalWidth ) {
                    var firstChild = $('.drop-list').children('li:first-child');
                    $(firstChild).appendTo('.main .list');
                }  else {
                    break;
                }
            } while (child < parent)
        }
        else if ( childWidth > parentWidth && buttonHave == false) {


            // Вставляем меню и кнопку
            // Вставляем меню и кнопку
            $('<div class="main-drop-list" data-Ripple="#fff">\n' +
                '<div class="open-list-button">' +
                '<i class="fa fa-circle" aria-hidden="true"></i>\n' +
                '<i class="fa fa-circle" aria-hidden="true"></i>\n' +
                '<i class="fa fa-circle" aria-hidden="true"></i>\n' +
                '</div>' +
                '<div class="drop-main">' +
                '<ul class="drop-list">' +
                '</ul>' +
                '</div>' +
                '</div>' ).appendTo('.main');
            do {
                var parent = 0;
                var child = 0;
                var buttonWidth = $('.drop-list-button').width();
                parent = $('.main').width();

                $(".main .list > li").each(function () {
                    child += $(this).innerWidth();
                });



                if (child + buttonWidth > parent) {
                    $('.main .list').children('li:last-child').prependTo('.drop-list');

                } else {
                    break;
                }
            } while (child + buttonWidth > parent)

            $('.open-list-button').click(function () {
                $(this).toggleClass('open');
                $('.drop-main').toggleClass('open');
            });
        }
        else if ( totalWidth < parentWidth && buttonHave == true && dropListCount == 1 || totalWidth < parentWidth && buttonHave == true && dropListCount == 0) {


            var firstChild = $('.drop-list').children('li:first-child');
            $(firstChild).appendTo('.main .list');
            if (totalWidth < parentWidth) {
                $('.main-drop-list').remove();
                $('.drop-main').removeClass('open');
            }
        }
	}


});

// Карусель 2.0 beta
(function($) {
	$.fn.Carousel = function(options)  {

		//Настройки
		let settings = $.extend( {
			autoPlay         : '',
			playTime         : '',
			desktop          : '',
			tablet           : '',
			phone           : ''
		}, options);

		return this.each(function () {

			let main = this;
			let mainSiblings = $(main).siblings('.carousel-nav');
			let mainWrapper = $(main).children();

			//Переменные кол-ва div'oв из настроек - 1 т.к. порядовый номер eq начинается с 0
			let desktopIQ = (options.desktop - 1);
			let tabletIQ = (options.tablet - 1);
			let phoneIQ = (options.phone - 1);
			//Переменные ширины div'oв
			let containerWidth = $(main).width();
			let desktopIW = ( containerWidth / (options.desktop));
			let tabletIW = ( containerWidth / (options.tablet));
			let phoneIW = ( containerWidth / (options.phone));
			let carouselItem = $(mainWrapper).children();
			let event = (isPortable()) ? 'touchstart': 'click';

			function startCarousel() {

				if (viewportWidth >= 992) {
					$(mainWrapper).children().css('width', desktopIW);
					$(carouselItem).children().css('min-width',desktopIW);
					rollCarousel();
				}
				else if ( viewportWidth >= 768) {
					$(mainWrapper).children().css('width', tabletIW);
					$(carouselItem).children().css('min-width',tabletIW);
					rollCarousel();
				}
				else if (viewportWidth <= 767 ) {
					$(mainWrapper).children().css('width', phoneIW);
					$(carouselItem).children().css('min-width',phoneIW);
					rollCarousel();
				}
			}

			//Функции прокрутки
			function rollCarousel() {
				intervalId = setInterval(function () {
					if (options.autoPlay) {
						if (options.playTime) {


							$(mainWrapper).children().eq(0).css({
								'width': '0',
								'height': '100%',
								'transition': '0.5s',
								'opacity': '0'
							});

							setTimeout(function () {

								let viewportWidth = $(window).width();
								let containerWidth = $(main).width();
								let desktopIW = ( containerWidth / (options.desktop));
								let tabletIW = ( containerWidth / (options.tablet));
								let phoneIW = ( containerWidth / (options.phone));

								$(mainWrapper).children().eq(0).appendTo(mainWrapper).css({
									'opacity': '1'
								});

								if (viewportWidth >= 992) {
									$(mainWrapper).children().eq(-1).css('width', desktopIW);
								}
								else if ( viewportWidth >= 768) {
									$(mainWrapper).children().eq(-1).css('width', tabletIW);
								}
								else if (viewportWidth <= 767 ) {
									$(mainWrapper).children().eq(-1).css('width', phoneIW);
								}

							}, 500);

						}
					}
				}, (options.playTime * 1000));
			}

			let viewportWidth = $(window).width();

			//Вычисояется ширина и количество div'oв
			startCarousel();
			let timeCount = (options.playTime);

			function onCarousel(){
				$(mainWrapper).children().show();
				setTimeout(function () {
					(options.playTime) = 0;

					if (viewportWidth >= 992) {
						$(mainWrapper).children().eq(desktopIQ).show().nextAll().hide();
						$(main).css('overflow', 'visible');
						$(mainWrapper).css({
							'width': $(main).width(),
							'overflow': 'visible'
						});
					}
					else if (viewportWidth >= 768) {
						$(mainWrapper).children().eq(tabletIQ).show().nextAll().hide();
						$(main).css('overflow', 'visible');
						$(mainWrapper).css({
							'width': $(main).width(),
							'overflow': 'visible'
						});
					}
					else if (viewportWidth < 768) {
						$(mainWrapper).children().eq(phoneIQ).show().nextAll().hide();
						$(main).css('overflow', 'visible');
						$(mainWrapper).css({
							'width': $(main).width(),
							'overflow': 'visible'
						});
					}
				},100);
			}

			function outCarousel () {
				if (viewportWidth >= 992) {
					$(mainWrapper).children().eq(desktopIQ).nextAll().show();
					$(main).css('overflow','hidden');
					$(mainWrapper).css('width','100000');
				}
				else if ( viewportWidth >= 768) {
					$(mainWrapper).children().eq(tabletIQ).nextAll().show();
					$(main).css('overflow','hidden');
					$(mainWrapper).css('width','100000');
				}
				else if (viewportWidth <= 767) {
					$(mainWrapper).children().eq(phoneIQ).nextAll().show();
					$(main).css('overflow','hidden');
					$(mainWrapper).css('width','100000');
				}
				setTimeout(function () {
					(options.playTime) = timeCount;

				},100);

			}


			function isPortable() {
				return /Android|webOS|iPhone|iPad|iPod|BlackBerry|BB|PlayBook|IEMobile|Windows Phone|Kindle|Silk|Opera Mini/i.test(navigator.userAgent);
			}


			//Кнопки навигации
			$(mainSiblings).children('.next').on(event,function () {
				(options.playTime) = (isPortable()) ? options.playTime : 0;
				navNext();

				function navNext () {
					let stepWidth = 0;
					let viewportWidth = $(window).width();

					let containerWidth = $(main).width();
					let desktopIW = ( containerWidth / (options.desktop));
					let tabletIW = ( containerWidth / (options.tablet));
					let phoneIW = ( containerWidth / (options.phone));
					let carouselItem = $(mainWrapper).children();

					$(mainWrapper).children().eq(0).css({
						'width': '0',
						'height': '100%',
						'transition': '0.5s',
						'opacity': '0'
					});

					setTimeout(function () {
						$(mainWrapper).children().eq(0).appendTo(mainWrapper).css({
							'opacity': '1'
						});

						if (viewportWidth >= 992) {
							$(mainWrapper).children().css('width', desktopIW);
						}
						else if ( viewportWidth >= 768) {
							$(mainWrapper).children().css('width', tabletIW);
						}
						else if (viewportWidth <= 767 ) {
							$(mainWrapper).children().css('width', phoneIW);
						}

					}, 500);
				}
			});

			$(mainSiblings).children('.prev').on(event,function () {
				(options.playTime) = (isPortable()) ? options.playTime : 0;
				navPrev();

				function navPrev () {
					let stepWidth = 0;
					let viewportWidth = $(window).width();

					let containerWidth = $(main).width();
					let desktopIW = ( containerWidth / (options.desktop));
					let tabletIW = ( containerWidth / (options.tablet));
					let phoneIW = ( containerWidth / (options.phone));
					let carouselItem = $(mainWrapper).children();

					stepWidth = $(mainWrapper).children().width();
					$(mainWrapper).children().eq(-1).css('margin-left', -stepWidth).prependTo(mainWrapper);
					setTimeout(function () {
						$(mainWrapper).children().css('opacity','1');
						$(mainWrapper).children().eq(0).css({
							'margin-left': stepWidth,
							'transition' : '0.3s'
						});
						$(mainWrapper).children().css({
							'margin-left':'0'
						});
					},100);
				}
			});

			//Остановка карусели по наведению
			if (!isPortable()) {

				$(main).hover(
					function () {
						onCarousel()
					},
					function () {
						outCarousel()
					}
				);

				$(mainSiblings).hover(
					function () {
						(options.playTime) = 0;
					},
					function () {
						(options.playTime) = timeCount;
					}
				);

			}


			//------------- RESIZE -------------//
			$(window).resize(function () {
				//Переменные кол-ва div'oв из настроек - 1 т.к. порядовый номер eq начинается с 0
				let desktopIQ = (options.desktop - 1);
				let tabletIQ = (options.tablet - 1);
				let phoneIQ = (options.phone - 1);
				//Переменные ширины div'oв
				let containerWidth = $(main).width();
				let desktopIW = ( containerWidth / (options.desktop));
				let tabletIW = ( containerWidth / (options.tablet));
				let phoneIW = ( containerWidth / (options.phone));
				let carouselItem = $(mainWrapper).children();
				let viewportWidth = $(window).width();

				if (viewportWidth >= 992) {
					$(mainWrapper).children().css('width', desktopIW);
					$(carouselItem).children().css('min-width',desktopIW);
				}
				else if ( viewportWidth >= 768) {
					$(mainWrapper).children().css('width', tabletIW);
					$(carouselItem).children().css('min-width',tabletIW);
				}
				else if (viewportWidth <= 767 ) {
					$(mainWrapper).children().css('width', phoneIW);
					$(carouselItem).children().css('min-width',phoneIW);
				}
			});
		});
	};
})(jQuery);


function onChangeOption(){
	var priceLabel = $('.product-info-block .product-price');
	var priceFrom = parseFloat(priceLabel.text().replace(/[^\d\.]+/, ''));

	var priceTo = parseFloat($('#price').attr('data-price').replace(/[^\d\.]+/, ''));
	$('.product-info-block select option:selected, .product-info-block input[type=radio]:checked, .product-info-block input[type=checkbox]:checked, .product-info-block input[type=text], .product-info-block textarea').each(function () {
		el = $(this);

		if (el.data('price')) {
			var option_price = parseFloat(String(el.data('price')).replace(/[^\d\.]+/, ''));
			priceTo += el.data('prefix') == '-' ? option_price * (-1) : option_price;
		};
	});

	changePrice(
		priceFrom,
		priceTo,
		priceLabel
	);
}

function changePrice(priceFrom, priceTo, priceLabel){

	if ( priceFrom == priceTo || isNaN(priceFrom) || isNaN(priceTo)  ) {
		return;
	}

	priceFrom = parseFloat(priceFrom);
	priceTo = parseFloat(priceTo);
	var price = priceFrom;
	var step = parseFloat(Number(Math.abs( priceFrom - priceTo ) / 10).toFixed(2));

	var timer_id = setInterval(function(){

		if(priceFrom > priceTo) {
			price -= step;
			if(price < priceTo) {
				price = priceTo;
			}
		} else {
			price += step;
			if(price > priceTo) {
				price = priceTo;
			}
		}

		priceLabel.text(priceLabel.text().replace(/^[\d\.\s]+/, parseFloat(price).toFixed(2) + ' '));

		if ( price != priceTo) {
			return;
		}

		clearInterval(timer_id)

	}, 20);
}

$(function () {
    $('.show-list').on('click', function () {
        $(this).css('z-index','20');
        $('.sort-list').css('z-index','10')
    });

    $('.sort-list').on('click', function () {
        $(this).css('z-index','20');
        $('.show-list').css('z-index','10')
    });

    $('.cart #button-quick-order-dropdowm-cart, .cart #input-phone-dropdowm-cart').on('click', function() {
        $('.cart__products-list').addClass('show');
        setTimeout(function () {
            $('.cart').addClass('open');
        },100);
        setTimeout(function () {
            $('.cart__products-list').removeClass('show');
        },200);
    });
});

function verticalMenuNav(text) {

	function menuNav(text) {
		var quantity = $('#menuCategoryV .main-menu-category_item').length;
		var itemHeight = 0;
		var listHeight = 0;
		if ($('[data-slideshow]').length > 0) {
			listHeight = $('[data-slideshow]').height();
		} else {
			listHeight = $('.main-menu-category_list').height();
		}

		if ($('#menuCategoryV .main-menu-category-nav').height() > 0) {
			var navHeight = $('#menuCategoryV .main-menu-category-nav').height();
		} else {
			var navHeight = 50;
		}
		if ($(window).width() < 1199) {

			if ($('#menuCategoryV .main-menu-category-nav').height() > 0) {
				var navHeight = $('#menuCategoryV .main-menu-category-nav').height() + 30;
			} else {
				var navHeight = 80;
			}
		}

		var i = -1;
		var nav = false;
		var count = 1;
		$('#menuCategoryV .main-menu-category-nav').remove();
		$('#menuCategoryV .main-menu-category_item').removeClass('invisible').show();

		$('#menuCategoryV .main-menu-category_item').each(function () {
			itemHeight+=$(this).height();

			if (itemHeight + navHeight > listHeight) {
				$('#menuCategoryV .main-menu-category_list').children('#menuCategoryV .main-menu-category_item').eq(i).hide().addClass('invisible');
				i--;

				if (nav == false) {

					$('<div class="main-menu-category-nav top">' +
						'<div class="main-menu-category-nav__list">' +
						'<span class="nav-next"><i class="fa fa-chevron-up"></i><i class="fa fa-caret-up"></i></span>' +
						'</div>' +
						'</div>' ).prependTo('#menuCategoryV .main-menu-category_list');
					$('#menuCategoryV .main-menu-category_list').addClass('have-nav')
					$('<div class="main-menu-category-nav bottom">' +
						'<div class="main-menu-category-nav__list">' +
						'<span class="nav-prev"><i class="fa fa-caret-down"></i><i class="fa fa-chevron-down"></i></span>' +
						'</div>' +
						'<div class="main-menu-category-nav__quantity">' +
						'<div class="__text">' + text + '</div>' +
						'<div class="__quantity">' + quantity + '</div>' +
						'</div>' +
						'</div>' ).appendTo('#menuCategoryV .main-menu-category_list');
					nav = true;

					if (!$('.main-menu-title').hasClass('have-list')) {
						$('#menuCategoryV .main-menu-category_item').each(function () {
							var textItem = $(this).find('.item-name').text();
							$(this).find('.item-name').remove();
							$(this).find('.item-line').children('a').prepend('<div class="item-name"><b class="number">' + count + '</b>' + '<span class="text">' + textItem + '</span>' + '</div>');
							if ($(this).find('.item-line').children('a').hasClass('action')) {
								var color = $(this).css('color');
								$(this).find('.number').css({
									'color': color,
									'border-color' : color
								});
							}
							var itemName = $(this).find('a.left').children('.item-name');
							var iconItem = $(this).find('.ico-nav');
							$(iconItem).prependTo(itemName);
							count++;
						});
						$('.main-menu-title:not(.stiky-catalog)').addClass('have-list');
					}
					$('#menuCategoryV .main-menu-category_list').addClass('have-nav');

				}


			} else {
				$('#menuCategoryV .main-menu-category_list').removeClass('overflow');
			}
		});

		$('#menuCategoryV .main-menu-category-nav .nav-next').dblclick(function () {
			return false;
		});
		$('#menuCategoryV .main-menu-category-nav .nav-prev').dblclick(function () {
			return false;
		});

		$('#menuCategoryV .main-menu-category-nav .nav-prev').on('click',function () {
			$('#menuCategoryV .main-menu-category_item').eq(0).appendTo('#menuCategoryV .main-menu-category_list').hide().addClass('invisible');
			$('#menuCategoryV .main-menu-category_item.invisible').eq(0).show().removeClass('invisible');
			$('#menuCategoryV .main-menu-category-nav').appendTo('#menuCategoryV .main-menu-category_list');
		});

		$('#menuCategoryV .main-menu-category-nav .nav-next').on('click',function () {
			$('#menuCategoryV .main-menu-category_item.invisible').eq(0).prev('#menuCategoryV .main-menu-category_item').hide().addClass('invisible');
			$('#menuCategoryV .main-menu-category_item.invisible').eq(-1).prependTo('#menuCategoryV .main-menu-category_list').show().removeClass('invisible');
			$('#menuCategoryV .main-menu-category-nav').appendTo('#menuCategoryV .main-menu-category_list');

		});
	}

    if ($(window).width() >= 992) {
        menuNav(text);
    }

    $(window).resize(function () {
        menuNav(text);

    });

    $('.main-menu-title').mouseenter(function () {
        menuNav(text);
    });

}

function verticalStikyMenuNav(text) {

	function menuNav(text) {
		var quantity = $('#stickyCategoryV .main-menu-category_item').length;
		var itemHeight = 0;
		var listHeight = $('#stickyCategoryV .main-menu-category_list').height() - 50;
		var navHeight = $('#stickyCategoryV .main-menu-category-nav').height();
		if ($(window).width() < 1199) {
			navHeight = $('#stickyCategoryV .main-menu-category-nav').height();
		}

		var i = -1;
		var nav = false;
		var count = 1;
		$('#stickyCategoryV .main-menu-category-nav').remove();
		$('#stickyCategoryV .main-menu-category_item').removeClass('invisible').show();

		$('#stickyCategoryV .main-menu-category_item').each(function () {
			itemHeight+=$(this).height();


			if (itemHeight + navHeight > listHeight) {
				$('#stickyCategoryV .main-menu-category_list').children('#stickyCategoryV .main-menu-category_item').eq(i).hide().addClass('invisible');
				i--;

				if (nav == false) {

					$('<div class="main-menu-category-nav top">' +
						'<div class="main-menu-category-nav__list">' +
						'<span class="nav-next"><i class="fa fa-chevron-up"></i><i class="fa fa-caret-up"></i></span>' +
						'</div>' +
						'</div>' ).prependTo('#stickyCategoryV .main-menu-category_list');
					$('<div class="main-menu-category-nav bottom">' +
						'<div class="main-menu-category-nav__list">' +
						'<span class="nav-prev"><i class="fa fa-caret-down"></i><i class="fa fa-chevron-down"></i></span>' +
						'</div>' +
						'<div class="main-menu-category-nav__quantity">' +
						'<div class="__text">' + text + '</div>' +
						'<div class="__quantity">' + quantity + '</div>' +
						'</div>' +
						'</div>' ).appendTo('#stickyCategoryV .main-menu-category_list');
					nav = true;

					if (!$('.main-menu-title.stiky-catalog').hasClass('have-list')) {

						$('#stickyCategoryV .main-menu-category_item').each(function () {
							var textItem = $(this).find('.item-name').text();
							$(this).find('.item-name').remove();
							$(this).find('.item-line').children('a').prepend('<div class="item-name"><b class="number">' + count + '</b>' + '<span class="text">' + textItem + '</span>' + '</div>');
							if ($(this).find('.item-line').children('a').hasClass('action')) {
								var color = $(this).css('color');
								$(this).find('.number').css({
									'color': color,
									'border-color' : color
								});
							}
							var itemName = $(this).find('a.left').children('.item-name');
							var iconItem = $(this).find('.ico-nav');
							$(iconItem).prependTo(itemName);
							count++;
						});
						$('.main-menu-title.stiky-catalog').addClass('have-list');
					}


				}


			} else {
				$('#stickyCategoryV .main-menu-category_list').removeClass('overflow');
			}
		});


		$('#stickyCategoryV .main-menu-category-nav .nav-next').dblclick(function () {
			return false;
		});
		$('#stickyCategoryV .main-menu-category-nav .nav-prev').dblclick(function () {
			return false;
		});

		$('#stickyCategoryV .main-menu-category-nav .nav-prev').on('click',function () {
			$('#stickyCategoryV .main-menu-category_item').eq(0).appendTo('#stickyCategoryV .main-menu-category_list').hide().addClass('invisible');
			$('#stickyCategoryV .main-menu-category_item.invisible').eq(0).show().removeClass('invisible');
			$('#stickyCategoryV .main-menu-category-nav').appendTo('#stickyCategoryV .main-menu-category_list');
		});

		$('#stickyCategoryV .main-menu-category-nav .nav-next').on('click',function () {
			$('#stickyCategoryV .main-menu-category_item.invisible').eq(0).prev('#stickyCategoryV .main-menu-category_item').hide().addClass('invisible');
			$('#stickyCategoryV .main-menu-category_item.invisible').eq(-1).prependTo('#stickyCategoryV .main-menu-category_list').show().removeClass('invisible');
			$('#stickyCategoryV .main-menu-category-nav').appendTo('#stickyCategoryV .main-menu-category_list');

		});

	}

	if ($(window).width() >= 992) {
		menuNav(text);
	}

}

function popupGallery (trigger = [], options = {}) {

	if (undefined === trigger) {
		console.log('ERROR: popupGallery.trigger undefined');
		return false;
	}

	if (undefined === options.activeClass) {
		console.log('ERROR: popupGallery.options.activeClass undefined');
		return false;
	}

	if (undefined !== options.title) {
		this.title = options.title;
	}

	this.activeClass = options.activeClass;

	this.popup = document.querySelector('.popupGallery');
	this.popupTitle = document.querySelector('.popupGallery__title');
	this.popupClose = document.querySelector('.popupGallery__close');
	this.popupBox = document.querySelector('.popupGallery__box');
	this.popupImageList = document.querySelector('.popupGallery__imageList-Box');
	this.popupImage = document.querySelector('.popupGallery__image').children[0];

	const removeClassActive = () => {
		for (let value of Object.values(this.popupImageList.children)) {
			value.classList.remove('active');
		}
	}


	/*=== ADD EVENTS - begin ===*/

	for (let value of Object.values(this.popupImageList.children)) {

		value.addEventListener('click', (e) => {

			removeClassActive();

			e.target.classList.add('active');
			let src = e.target.getAttribute('href');
			let data_zoom_image = e.target.getAttribute('data-zoom-image');

			this.popupImage.setAttribute('src', src);
			this.popupImage.setAttribute('data-zoom-image', data_zoom_image);
		});
	}

	const galleryRun = (e) => {
		e.preventDefault();

		this.popup.classList.add('active');

		let index = 0;
		for (let value of Object.values(document.querySelectorAll('.image-additional'))) {
			if (value.children[0].classList.contains('active')) {
				break;
			}
			index++;
		}

		let index2 = 0;
		for (let value of Object.values(this.popupImageList.children)) {

			if (index === index2) {
				value.classList.add('active');
			}
			index2++;
		}


		setTimeout(() => {
			this.popupBox.classList.add('active');
			document.querySelector('.popupGallery__imageList img').click();
		},300)

		document.querySelector('html').classList.add('popupGalleryActive')

		// ADD SRC AND ZOOM TO IMAGE
		let src = document.querySelector(this.activeClass).getAttribute('data-image');
		let data_zoom_image = document.querySelector(this.activeClass).getAttribute('data-zoom-image');

		this.popupImage.setAttribute('src', src);
		this.popupImage.setAttribute('data-zoom-image', data_zoom_image);

		// ADD TITLE

		if (undefined !== options.title) {

			this.popupTitle.innerHTML = document.querySelector(options.title).innerHTML;
		}

	}


	trigger.forEach((element) => {
		document.querySelector(element).addEventListener('click', galleryRun, true)
	})


	this.popupClose.addEventListener('click', () => {

		this.popupBox.classList.remove('active')
		removeClassActive();

		if (null !== document.querySelector('.ZoomContainer')) {
			document.querySelector('.ZoomContainer').remove();
		}


		setTimeout(() => {
			this.popup.classList.remove('active');
			document.querySelector('html').classList.remove('popupGalleryActive')
		},300)
	}, true)

	/*=== ADD EVENTS - end ===*/

}
