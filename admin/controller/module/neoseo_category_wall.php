<?php

require_once( DIR_SYSTEM . "/engine/soforp_controller.php");


class ControllerModuleNeoseoCategoryWall extends SoforpController {

	private $error = array();

	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_category_wall";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index()
	{
        $this->checkLicense();
        $this->upgrade();
		$data = $this->load->language($this->_route . '/' . $this->_moduleSysName);
		$this->document->setTitle($this->language->get('heading_title_raw'));
		$this->load->model($this->_route . '/' . $this->_moduleSysName);
		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$settings_array = array();
			$settings_array[$this->_moduleSysName . "_status"] = $this->request->post[$this->_moduleSysName . "_status"];
			$settings_array[$this->_moduleSysName . "_debug"] = $this->request->post[$this->_moduleSysName . "_debug"];
			$settings_array[$this->_moduleSysName . "_type"] = $this->request->post[$this->_moduleSysName . "_type"];

			$this->model_setting_setting->editSetting($this->_moduleSysName, $settings_array);

			$this->session->data['success'] = $this->language->get('text_success'); //add data of saved feed

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}


		$data = $this->initParamsList(array(
			"status",
			"debug",
			"type",
		), $data);

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else if (isset($this->session->data['error_warning'])) {
			$data['error_warning'] = $this->session->data['error_warning'];
			unset($this->session->data['error_warning']);
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}

		$data = $this->initBreadcrumbs(array(array("extension/" . $this->_route, "text_module"), array($this->_route . "/" . $this->_moduleSysName, "heading_title_raw")), $data);

		$data = $this->initButtons($data);

		$data['token'] = $this->session->data['token'];
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['add'] = $this->url->link($this->_route . '/' . $this->_moduleSysName . '/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link($this->_route . '/' . $this->_moduleSysName . '/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['copy'] = $this->url->link($this->_route . '/' . $this->_moduleSysName . '/copy', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$filter_data = array(
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$categories_total = $this->model_module_neoseo_category_wall->getTotalCategories();
		$data['categories_total'] = $categories_total;
		$results = $this->model_module_neoseo_category_wall->getCategories($filter_data); //todo:Уточнить как использовать название модуля и путь в моделях
		$data['test_results'] = $results;
		if ($results) {
			foreach ($results as $result) {
				$data['categories'][] = array(
					'category_id' => $result['category_id'],
					'name' => $result['title'],
					'status' => $result['status'],
					'edit' => $this->url->link($this->_route . '/' . $this->_moduleSysName . '/edit', 'token=' . $this->session->data['token'] . '&category_id=' . $result['category_id'] . $url, 'SSL'),
					'delete' => $this->url->link($this->_route . '/' . $this->_moduleSysName . '/delete', 'token=' . $this->session->data['token'] . '&category_id=' . $result['category_id'] . $url, 'SSL')
				);
			}
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}



		$url = '';

		$pagination = new Pagination();
		$pagination->total = $categories_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($categories_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($categories_total - $this->config->get('config_limit_admin'))) ? $categories_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $categories_total, ceil($categories_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data["logs"] = $this->getLogs();
		$data['params'] = $data;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName . '.tpl', $data));
	}

	protected function getForm()
	{
		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName);
		$this->load->model($this->_route . '/' . $this->_moduleSysName);

		$data['text_form'] = !isset($this->request->get['category_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');


		$data['params'] = $data;

        $this->load->model('tool/image');
        $data['placeholder'] = $this->model_tool_image->resize('no_image.png', 24, 24);

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = array();
		}

		if (isset($this->error['error_url_group'])) {
			$data['error_url_group'] = $this->error['error_url_group'];
		} else {
			$data['error_url_group'] = '';
		}

		$this->document->addScript('view/javascript/bootstrap-colorpicker/js/bootstrap-colorpicker.js');
		$this->document->addStyle('view/javascript/bootstrap-colorpicker/css/bootstrap-colorpicker.css');

		$data = $this->initButtons($data);
		$data = $this->initBreadcrumbs(array(array("extension/" . $this->_route, "text_module"), array($this->_route . "/" . $this->_moduleSysName, "heading_title_raw")), $data);


		$data['close'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');

		if (!isset($this->request->get['category_id'])) {
			$data['action'] = $this->url->link($this->_route . '/' . $this->_moduleSysName . '/add', 'token=' . $this->session->data['token'], 'SSL');
			$data['save'] = $this->url->link('module/' . $this->_moduleSysName . '/add', 'token=' . $this->session->data['token'], 'SSL');
			$data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName . '/add', 'token=' . $this->session->data['token'] . "&close=1", 'SSL');

		} else {
			$data['action'] = $this->url->link($this->_route . '/' . $this->_moduleSysName . '/edit', 'token=' . $this->session->data['token'] . '&category_id=' . $this->request->get['category_id'], 'SSL');
			$data['save'] = $this->url->link('module/' . $this->_moduleSysName . '/edit', 'token=' . $this->session->data['token'].'&category_id='.$this->request->get['category_id'], 'SSL');
			$data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName . '/edit', 'token=' . $this->session->data['token'].'&category_id='.$this->request->get['category_id'] . "&close=1", 'SSL');
		}

		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();
		$data['languages'] = $languages;
		$this->document->addScript('view/javascript/jquery/jquery.nestable.js');
		$this->document->addScript('view/javascript/neoseo_category_wall.js');
		$this->document->addStyle('view/stylesheet/neoseo_category_wall.css');


		if (isset($this->request->get['category_id'])) {
			$category_info = $this->model_module_neoseo_category_wall->getCategoryParams($this->request->get['category_id']);
			$data['neoseo_category_wall_status'] = $category_info['status'];
			$data['neoseo_category_wall_title'] = $category_info['title'];
			$data['item_id'] = $this->request->get['category_id'];
			$this->load->model($this->_route . '/' . $this->_moduleSysName);
			$data['item'] = $this->model_module_neoseo_category_wall->getCategory($this->request->get['category_id'],0);
			$data['breadcrumbs'][] = array(
				'text' => $category_info['title'],
				'href' => $this->url->link($this->_route . '/' . $this->_moduleSysName . '/edit', 'token=' . $this->session->data['token'] . '&category_id=' . $this->request->get['category_id'], 'SSL')
			);
		} else {
			$data['item'] = array();
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_add'),
				'href' => $this->url->link($this->_route . '/' . $this->_moduleSysName . '/add', 'token=' . $this->session->data['token'], 'SSL')
			);
			$data['neoseo_category_wall_status'] = 0;
			$data['neoseo_category_wall_title'] = '';
		}

		$data['current_lang'] = (int) $this->config->get('config_language_id');



        /* Списки категорий, производителей, страниц опенкарта */
		$this->load->model('catalog/category');
		$data['categories'] = $this->model_catalog_category->getCategories(0);

		$this->load->model('catalog/manufacturer');
		$results = $this->model_catalog_manufacturer->getManufacturers();
		$data['manufacturers'] = array();
		foreach ($results as $result) {
			$data['manufacturers'][] = array(
				'id' => $result['manufacturer_id'],
				'name' => $result['name']
			);
		}

		if( file_exists(DIR_APPLICATION . "model/module/neoseo_filter_pages.php") ) {
			$this->load->model('catalog/neoseo_filter_pages');
			$results = $this->model_catalog_neoseo_filter_pages->getFilterPages();
			foreach ($results as $result) {
				$data['landing_pages'][] = array(
					'id' => $result['page_id'],
					'name' => $result['h1']
				);
			}
		} else if( file_exists(DIR_APPLICATION . "model/catalog/ocfilter.php") ) {
			$this->load->model('catalog/ocfilter');
			$results = $this->model_catalog_ocfilter->getPages();
			$data['landing_pages'] = array();
			foreach ($results as $result) {
				$titles = unserialize($result['title']);
				$title = ( isset($titles[$this->config->get('config_language_id')]) ? $titles[$this->config->get('config_language_id')] : $titles[key($titles)] );

				$data['landing_pages'][] = array(
					'id' => $result['ocfilter_page_id'],
					'name' => $title
				);
			}
		}

		if (file_exists(DIR_APPLICATION . "blog/neoseo_blog_category"))
		{
			$this->load->model('blog/neoseo_blog_category');
			$results = $this->model_blog_neoseo_blog_category->getCategories();
			$data['blog_categories'] = array();
			foreach ($results as $result) {
				$data['blog_categories'][] = array(
					'id' => $result['category_id'],
					'name' => $result['name'],
				);
			}
		}


		$this->load->model('catalog/information');
		$results_info = $this->model_catalog_information->getInformations();
		$data['informations'] = array();
		foreach ($results_info as $result) {
			$data['informations'][] = array(
				'id' => $result['information_id'],
				'title' => $result['title']
			);
		}

		$data['system_pages'] = array(
			"common/home" => "Главная",
			"information/contact" => "Связаться с нами",
			"information/sitemap" => "Карта сайта",
			"checkout/voucher"  => "Подарочные сертификаты",
			"checkout/checkout"  => "Оформить заказ",
			"checkout/cart" => "Перейти к корзине",
			"account/account" => "Личный кабинет",
			"account/download" => "Загрузки",
			"account/forgotten" => "Восстановить пароль",
			"account/newsletter" => "Подписка на новости",
			"account/order" => "Ваши заказы",
			"account/wishlist"  => "Избранные товары",
			"account/reward" => "Бонусные балы",
			"account/voucher" => "Ваши подарочные сертификаты",
			"account/address" => "Ваши адреса доставки",
			"account/edit"  => "Ваши контактные данные",
			"account/register"  => "Регистрация",
			"account/transaction"  => "Ваши транзакции",
			"account/return"  => "Возвраты",
			"product/search" => "Поиск",
			"product/compare" => "Сравнение товаров",
			"product/manufacturer" => "Производители",
			"product/special" => "Товары со скидкой",
		);


		$data['params'] = $data;


		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName . '_form.tpl', $data));
	}


	public function add()
	{
		$this->language->load($this->_route . '/' . $this->_moduleSysName);
		$this->document->setTitle($this->language->get('heading_title_raw'));
		$this->load->model($this->_route . '/' . $this->_moduleSysName);

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$test = $this->saveCategory($this->request->post);
			$test2 = $this->model_module_neoseo_category_wall->insertCategory($test);
			$this->session->data['success'] = $this->language->get('text_success');
			$url = '';
			if (isset($this->request->get['sort'])) {
				$url .= '&sort = ' . $this->request->get['sort'];
			}
			if (isset($this->request->get['order'])) {
				$url .= '&order = ' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page = ' . $this->request->get['page'];
			}

			if (isset($this->request->get['close'])) {
				$this->response->redirect($this->url->link($this->_route .'/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName . '/edit', 'token=' . $this->session->data['token'] . '&category_id='. $test2 .  $url, 'SSL'));
			}


		}

		$this->getForm();
	}

	public function edit()
	{
		$this->language->load($this->_route . '/' . $this->_moduleSysName);
		$this->load->model($this->_route . '/'. $this->_moduleSysName);
		$this->document->setTitle($this->language->get('heading_title_raw'));

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$test = $this->saveCategory($this->request->post);
			$test2 = $this->model_module_neoseo_category_wall->editCategory($this->request->get['category_id'], $test);
			$this->session->data['success'] = $this->language->get('text_success');
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort = ' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order = ' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page = ' . $this->request->get['page'];
			}

			$this->load->model('localisation/language');
			foreach( $this->model_localisation_language->getLanguages() as $language ) {
				$this->cache->delete("soforp_category_" . $this->request->get['category_id'] . "_" . $language["language_id"]);
			}

			if (isset($this->request->get['close'])) {
				$this->response->redirect($this->url->link($this->_route .'/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName . '/edit', 'token=' . $this->session->data['token'] . '&category_id='. $this->request->get['category_id'] .  $url, 'SSL'));
			}

		}

		$this->getForm();
	}

	public function copy() {
		$this->language->load($this->_route . '/' . $this->_moduleSysName);
		$this->load->model($this->_route . '/'. $this->_moduleSysName);
		$this->document->setTitle($this->language->get('heading_title_raw'));

		if (isset($this->request->post['selected']) && $this->validateCopy()) {
			foreach ($this->request->post['selected'] as $category_id) {
				$this->model_module_neoseo_category_wall->copyCategory($category_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->index();
	}

	public function delete()
	{

		$this->language->load($this->_route . '/' . $this->_moduleSysName);
		$this->load->model($this->_route . '/'. $this->_moduleSysName);
		$this->document->setTitle($this->language->get('heading_title_raw'));

		if ((isset($this->request->post['selected']) or isset($this->request->get['category_id'])) && $this->validateDelete()) {
			if (isset($this->request->post['selected'])) {

				foreach ($this->request->post['selected'] as $category_id) {
					$this->model_module_neoseo_category_wall->deleteCategory($category_id);
				}
			} else {
				$this->model_module_neoseo_category_wall->deleteCategory($this->request->get['category_id']);
			}


			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';


			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . $url, 'SSL'));

		}

		$this->index();
	}

	protected function saveCategory($data, $category_id = "")
	{
		$this->load->model($this->_route . '/'. $this->_moduleSysName);

		if (isset($data)) {

			if ($data['neoseo_category_wall_title']) {
				$send_data['category_title'] = $data['neoseo_category_wall_title'];
			}
			if ($data['neoseo_category_wall_status']) {
				$send_data['category_status'] = $data['neoseo_category_wall_status'];
			}

			foreach ($data['title'] as $language => $title_language) {
				foreach ($title_language as $key => $title) {
					$category[$key]['title'][$language] = $title;
				}

			}
			foreach ($data['url'] as $language => $title_language) {
				foreach ($title_language as $key => $title) {
					$category[$key]['url'][$language] = $title;
				}

			}

			foreach ($data['params'] as $key => $value) {
				$category[$key]['params'] = $value;
			}

			foreach ($data['class'] as $key => $value) {
				$category[$key]['class'] = $value;
			}
			foreach ($data['style'] as $key => $value) {
				$category[$key]['style'] = $value;
			}
            foreach ($data['max_width'] as $key => $value) {
                $category[$key]['max_width'] = $value;
            }

			foreach ($data['icon'] as $key => $value) {
				$category[$key]['icon'] = $value;
			}

			foreach ($data['bg_color'] as $key => $value) {
                $category[$key]['bg_color'] = $value;
            }
            foreach ($data['hover_bg_color'] as $key => $value) {
                $category[$key]['hover_bg_color'] = $value;
            }
            foreach ($data['font_color'] as $key => $value) {
                $category[$key]['font_color'] = $value;
            }
            foreach ($data['hover_font_color'] as $key => $value) {
                $category[$key]['hover_font_color'] = $value;
            }

			foreach ($data['type'] as $key => $value) {
				$category[$key]['type'] = $value;
				$category[$key]['id'] = (int)$key+1;
			}
			foreach ($data['type_id'] as $key => $value) {
				$category[$key]['type_id'] = $value;
			}
			foreach ($data['parent_id'] as $key => $value) {
				$category[$key]['parent_id'] = $value;
			}
			$send_data['categories'] = $category;
			return $send_data;
		}

	}

	private function validate()
	{
		if (!$this->user->hasPermission('modify', $this->_route . '/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

	protected function validateDelete()
	{
		if (!$this->user->hasPermission('modify', $this->_route . '/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

	protected function validateCopy()
	{
		if (!$this->user->hasPermission('modify', $this->_route . '/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
}

?>