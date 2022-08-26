<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoseoOptimizer extends NeoseoModel {

    public function __construct($registry) {
        parent::__construct($registry);
        $this->_moduleSysName = "neoseo_optimizer";
        $this->_logFile = $this->_moduleSysName . ".log";
        $this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
    }

    // Install/Uninstall
    public function install() {

        $this->initParamsDefaults(array(
			'status' => 0,
			'debug' => 0,
			'jpg_driver' => 0,
			'png_driver' => 0,
			'png_to_webp' => 0,
			'webp_converter' => 0,
			'png_compress' => 5,
			'image_dir_list' => '/image/cache/',
			"compress_level" => 85,
			"page_to_cache" => 0,
			"cache_url_limit" => "#checkout/#\n#product/compare#\n#register/country#\n#/wishlist/#\n#/compare/#\n#/captcha#",
			"expire_cache" => 14400,
			"js_tag" => "",
			"js_untag_list" => '',
			'js_defer' => 0,
			'js_async_list' => '',
			'js_undefer' => "jquery-2.1.1.min.js\nowl.carousel.min.js\nblazy.min.js",
			'js_defer_page_list' => "/index.php?route=checkout/checkout\n/checkout",
			'js_unpack_list' => '',
			'js_footer_list' => '',
			'css_unpack_list' => '',
			'css_footer_list' => '',
			"css_tag" => "",
			"css_untag_list" => '',
			"img_lazy_load" => 0,
			"img_unlazy_load" => 'not-lazy',
			"img_lazy_src" => 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==',
	        'use_layout_cache' => 0,
	        'cache_exclude_modules' => "neoseo_account\nneoseo_last_viewed_products",
	        'cache_need_path' => "code\nneoseo_filter\nneoseo_product_bundles\nneoseo_product_bundles_module\nneoseo_similar_products",
        ));
    }

    public function upgrade() {

    }

    public function uninstall() {

    }
    
    public function saveSettings($data) {
		$result = true;
		
		if ($data[$this->_moduleSysName . '_profile']) {
			$result = file_put_contents(DIR_SYSTEM . 'storage/neoseo_profiler_enabled', '1');
		} elseif (is_file(DIR_SYSTEM . 'storage/neoseo_profiler_enabled')) {
			$result = unlink(DIR_SYSTEM . 'storage/neoseo_profiler_enabled');
		}

		if ($result !== false) {
			if ($data[$this->_moduleSysName . '_minify_html']) {
				$result = file_put_contents(DIR_SYSTEM . 'storage/neoseo_html_minifier_enabled', '1');
			} elseif (is_file(DIR_SYSTEM . 'storage/neoseo_html_minifier_enabled')) {
				$result = unlink(DIR_SYSTEM . 'storage/neoseo_html_minifier_enabled');
			}
		}
		
		if ($result !== false) {
			if ($data[$this->_moduleSysName . '_minify_css']) {
				$result = file_put_contents(DIR_SYSTEM . 'storage/neoseo_css_minifier_enabled', '1');
			} elseif (is_file(DIR_SYSTEM . 'storage/neoseo_css_minifier_enabled')) {
				$result = unlink(DIR_SYSTEM . 'storage/neoseo_css_minifier_enabled');
			}
		}
		
		if ($result !== false) {
			if ($data[$this->_moduleSysName . '_minify_js']) {
				$result = file_put_contents(DIR_SYSTEM . 'storage/neoseo_js_minifier_enabled', '1');
			} elseif (is_file(DIR_SYSTEM . 'storage/neoseo_js_minifier_enabled')) {
				$result = unlink(DIR_SYSTEM . 'storage/neoseo_js_minifier_enabled');
			}
		}

	    if ($result !== false) {
		    if ($data[$this->_moduleSysName . '_status']) {
			    $result = file_put_contents(DIR_SYSTEM . 'storage/neoseo_optimizer_enabled', '1');
		    } elseif (is_file(DIR_SYSTEM . 'storage/neoseo_optimizer_enabled')) {
			    $result = unlink(DIR_SYSTEM . 'storage/neoseo_optimizer_enabled');
		    }
	    }
		
		return $result;
    }

}
