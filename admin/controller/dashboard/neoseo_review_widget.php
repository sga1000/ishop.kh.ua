<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');

class ControllerDashboardNeoSeoReviewWidget extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_review_widget";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function index()
	{
		if ($this->config->get($this->_moduleSysName . '_status') != 1) {
			return false;
		}

		$data = $this->language->load('dashboard/' . $this->_moduleSysName);
		$this->load->model("tool/" . $this->_moduleSysName);
		$this->load->model("tool/image");

		$language_id = $this->config->get('config_language_id');
		$limit = $this->config->get($this->_moduleSysName . '_limit');
		$height_image = $this->config->get($this->_moduleSysName . '_height_image') ? $this->config->get($this->_moduleSysName . '_height_image') : 100;
		$width_image = $this->config->get($this->_moduleSysName . '_width_image') ? $this->config->get($this->_moduleSysName . '_width_image') : 100;
		$title = $this->config->get($this->_moduleSysName . '_title');
		$data['title'] = isset($title[$language_id]) ? $title[$language_id] : '';
		$data['show_review_number'] = $this->config->get($this->_moduleSysName . '_show_review_number');
		$data['show_text'] = $this->config->get($this->_moduleSysName . '_show_text');
		$data['show_author'] = $this->config->get($this->_moduleSysName . '_show_author');
		$data['show_rating'] = $this->config->get($this->_moduleSysName . '_show_rating');
		$data['show_date_added'] = $this->config->get($this->_moduleSysName . '_show_date_added');
		$data['show_product'] = $this->config->get($this->_moduleSysName . '_show_product');
		$data['show_status'] = $this->config->get($this->_moduleSysName . '_show_status');
		$data['more'] = $this->url->link('catalog/review', 'token=' . $this->session->data['token'], 'SSL');
		$data['setting_widget'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');

		$data['items'] = array();

		$filter = array(
			'start' => 0,
			'limit' => $limit ? $limit : 5,
			'filter_status' => 0,
		);

		$results = $this->model_tool_neoseo_review_widget->getReviews($filter);

		foreach ($results as $result) {

			if (file_exists(DIR_IMAGE . $result['product_image']) && is_file(DIR_IMAGE . $result['product_image'])) {
				$image = $this->model_tool_image->resize($result['product_image'], $width_image, $height_image);
			} else {
				$image = $this->model_tool_image->resize('no_image.png', $width_image, $height_image);
			}

			$data['items'][] = array(
				'review_id' => $result['review_id'],
				'status' => $result['status'],
				'author' => $result['author'],
				'rating' => $result['rating'],
				'text' => $result['text'],
				'text_status' => $result['status'] == 1 ? $this->language->get('text_status_enabled') : $this->language->get('text_status_disabled'),
				'product' => $result['product_name'],
				'product_href' => HTTP_CATALOG . "index.php?route=product/product&product_id=" . $result['product_id'],
				'customer_href' => $result['customer_id'] != 0 ? $this->url->link('customer/customer/edit', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'], 'SSL') : false,
				'product_image' => $this->config->get($this->_moduleSysName . '_show_product_image') == 1 ? $image : false,
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'view' => $this->url->link('catalog/review/edit', 'token=' . $this->session->data['token'] . '&review_id=' . $result['review_id'], 'SSL'),
			);
		}

		$data['count_items'] = count($data['items']);
		$data['token'] = $this->session->data['token'];

		return $this->load->view('dashboard/' . $this->_moduleSysName . '.tpl', $data);
	}

	public function changeStatus()
	{
		$json = array();

		$this->load->model('tool/' . $this->_moduleSysName);
		$this->model_tool_neoseo_review_widget->changeStatus(
		    $this->request->post['status'], $this->request->post['review_id']
		);

		$json = array(
			'success' => true,
		);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		return;
	}

}
