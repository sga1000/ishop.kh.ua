<?php

require_once(DIR_SYSTEM . "/engine/neoseo_controller.php");
require_once(DIR_SYSTEM . '/engine/neoseo_view.php');

class ControllerModuleNeoSeoOrderManager extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_order_manager";
		$this->_modulePostfix = "";
		$this->_logFile = $this->_moduleSysName() . ".log";
		$this->debug = $this->config->get($this->_moduleSysName() . "_debug");
		$this->ckeditor = $this->config->get('config_editor_default');
		if ($this->config->get('config_editor_default')) {
			$this->document->addScript('view/javascript/ckeditor/ckeditor.js');
			$this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
		}
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load('module/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$setting = $this->request->post;
			if (!isset($setting[$this->_moduleSysName() . '_visible_order_statuses'])) {
				$setting[$this->_moduleSysName() . '_visible_order_statuses'] = array();
			}

			$this->model_setting_setting->editSetting($this->_moduleSysName(), $setting);
			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == "save") {
				$json = array('success' => true,
					'link' => html_entity_decode($this->url->link('module/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'], 'SSL')),
				);
				$this->response->setOutput(json_encode($json));
				return;
			} else {
				$json = array('success' => true,
					'link' => html_entity_decode($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')),
				);
				$this->response->setOutput(json_encode($json));
				return;
			}
		}

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
		$data = $this->initBreadcrumbs(array(
			array("extension/module", "text_module"),
			array("module/" . $this->_moduleSysName(), "heading_title_raw")
		), $data);

		$data = $this->initButtons($data);
		$data['add_columns'] = $this->url->link('module/' . $this->_moduleSysName() . '/addColumns', 'token=' . $this->session->data['token'], 'SSL');
		$data['delete_columns'] = $this->url->link('module/' . $this->_moduleSysName() . '/deleteColumns', 'token=' . $this->session->data['token'] . "#tab-columns", 'SSL');
		$data['add_buttons'] = $this->url->link('module/' . $this->_moduleSysName() . '/addButtons', 'token=' . $this->session->data['token'], 'SSL');
		$data['delete_buttons'] = $this->url->link('module/' . $this->_moduleSysName() . '/deleteButtons', 'token=' . $this->session->data['token'] . "#tab-buttons", 'SSL');

		$this->document->addStyle('view/javascript/jquery/bootstrapColorPickerSliders/bootstrap.colorpickersliders.css');
		$this->document->addScript('view/javascript/jquery/bootstrapColorPickerSliders/tinycolor.js');
		$this->document->addScript('view/javascript/jquery/bootstrapColorPickerSliders/bootstrap.colorpickersliders.js');
		$this->document->addScript('view/javascript/jquery/bootstrapColorPickerSliders/bootstrap.colorpickersliders.nocielch.js');

		$this->load->model('localisation/order_status');
		$orderStatus = $this->model_localisation_order_status->getOrderStatuses();

		$data['orders_status'] = $orderStatus;
		foreach ($orderStatus as $id => $value) {
			$data[$this->_moduleSysName() . "_status_colors"][$value["order_status_id"]]["name"] = $value["name"];
			$data[$this->_moduleSysName() . "_status_colors"][$value["order_status_id"]]["value"] = "";
		}
		$savedStatus = $this->config->get($this->_moduleSysName() . "_status_colors") ? $this->config->get($this->_moduleSysName() . "_status_colors") : unserialize($this->language->get('params_colors'));
		if ($savedStatus) {
			foreach ($savedStatus as $id => $value) {
				if (isset($data[$this->_moduleSysName() . '_status_colors'][$id])) {
					$data[$this->_moduleSysName() . '_status_colors'][$id]["value"] = $value;
				}
			}
		}

		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName()}->params, $data);


		if (isset($this->request->post['selected_columns'])) {
			$data['selected_columns'] = (array)$this->request->post['selected_columns'];
		} else {
			$data['selected_columns'] = array();
		}

		if (isset($this->request->post['selected_buttons'])) {
			$data['selected_buttons'] = (array)$this->request->post['selected_buttons'];
		} else {
			$data['selected_buttons'] = array();
		}

		$data['visible_order_statuses'] = array(); //Заполнять значениями из БД
		$data['fields'] = $this->getFields();
		$columns = $this->getListColumns();
		$buttons = $this->getListButtons();

		$sysCols = array();
		if (count($columns)) {
			foreach ($columns as $cld) {
				if (!$cld["type"])
					continue;

				$sysCols[] = $cld;
			}
		}

		$data['columns'] = $columns;
		$data['buttons'] = $buttons;
		$data['sysCols'] = $sysCols;
		$data["logs"] = $this->getLogs();

		$data['params'] = $data;
		$data['token'] = $this->session->data['token'];
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$data['ckeditor'] = $this->ckeditor;

		$widgets = new NeoSeoWidgets($this->_moduleSysName() . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName() . '.tpl', $data));
	}

	protected function getFields()
	{
		$result = array();

		$result["order_id"] = $this->language->get("field_desc_order_id");
		$result["status"] = $this->language->get("field_desc_status");
		$result["status:select"] = $this->language->get("field_desc_status_select");
		$result["date_added"] = $this->language->get("field_desc_date_added");
		$result["total"] = $this->language->get("field_desc_total");
		$result["firstname"] = $this->language->get("field_desc_firstname");
		$result["lastname"] = $this->language->get("field_desc_lastname");
		$result["telephone"] = $this->language->get("field_desc_telephone");
		$result["email"] = $this->language->get("field_desc_email");
		$result["shipping_address_1"] = $this->language->get("field_desc_shipping_address_1");
		$result["shipping_address_2"] = $this->language->get("field_desc_shipping_address_2");
		$result["shipping_city"] = $this->language->get("field_desc_shipping_city");
		$result["payment_method"] = $this->language->get("field_desc_payment_method");
		$result["shipping_method"] = $this->language->get("field_desc_shipping_method");
		$result["shipping_zone"] = $this->language->get("field_desc_shipping_zone");
		$result["comment"] = $this->language->get("field_desc_comment");
		$result["custom_fields"] = $this->language->get("field_desc_custom_fields");
		$result["store_id"] = $this->language->get("field_desc_store_id");
		$result["store_name"] = $this->language->get("field_desc_store_name");

		$text_edited = $this->language->get("text_edited");

		if ("1" == $this->config->get("neoseo_order_referrer_status") || "1" == $this->config->get("neoseo_order_referrer_status")) {
			$result["first_referrer"] = $this->language->get("field_desc_first_referrer");
			$result["last_referrer"] = $this->language->get("field_desc_last_referrer");
		}

		$this->load->model('customer/custom_field');

		$custom_fields = $this->model_customer_custom_field->getCustomFields();
		foreach ($custom_fields as $custom_field) {
			$location = $custom_field['location'] == 'address' ? 'shipping' : ($custom_field['location'] == 'account' ? 'account' : 'product');
			$result[$location . '_custom_field.' . $custom_field['custom_field_id']] = $custom_field['name'];
			$result[$location . '_custom_field.' . $custom_field['custom_field_id'] . ':edit'] = $custom_field['name'] . $text_edited;
		}

		// Инициализируем дополнительными полями
		$simple_tables = array(
			"order_simple_fields" => array(
				"short" => "osf",
				"prefix" => "simple_order",
				"join" => " LEFT JOIN `" . DB_PREFIX . "order_simple_fields` AS osf ON o.order_id = osf.order_id "
			),
		);

		foreach ($simple_tables as $table_name => $table_data) {
			$field_prefix = $table_data['prefix'];

			$query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "$table_name'");
			if (!$query->num_rows) {
				continue;
			}

			$query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "$table_name`");
			if ($query->num_rows > 1) {
				array_shift($query->rows);
			}
			foreach ($query->rows as $row) {
				$field_name = $field_prefix . "_" . strtolower($row['Field']);
				$result[$field_name] = "Поле модуля simple";
			}
		}

		return $result;
	}

	protected function getListButtons()
	{
		$this->load->model("tool/" . $this->_moduleSysName());
		$results = $this->model_tool_neoseo_order_manager->getListButtons();
		foreach ($results as $result) {
			$res[] = array(
				'order_manager_buttons_id' => $result['order_manager_buttons_id'],
				'language_id' => $result['language_id'],
				'name' => $result['name'],
				'class' => $result['class'],
				'style' => $result['style'],
				'link' => $result['link'],
				'post' => $result['post'],
				'onclick' => $result['onclick'],
				'selected' => isset($this->request->post['selected']) && in_array($result['order_manager_buttons_id'], $this->request->post['selected']),
				'action_text' => $this->language->get('text_edit'),
				'edit' => $this->url->link('module/' . $this->_moduleSysName() . '/editButtons', 'token=' . $this->session->data['token'] . '&order_manager_buttons_id=' . $result['order_manager_buttons_id'], 'SSL')
			);
		}
		return $res;
	}

	public function addButtons()
	{
		$this->language->load('module/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('tool/' . $this->_moduleSysName());

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_tool_neoseo_order_manager->addItem("bt", $this->request->post['item']);
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('module/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . "#tab-buttons", 'SSL'));
		}

		$this->getFormButtons();
	}

	public function editButtons()
	{
		$this->language->load('module/' . $this->_moduleSysName());
		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('tool/' . $this->_moduleSysName());
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_tool_neoseo_order_manager->editItem("bt", $this->request->get['order_manager_buttons_id'], $this->request->post['item']);
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('module/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . '#tab-buttons', 'SSL'));
		}

		$this->getFormButtons();
	}

	public function deleteButtons()
	{
		$this->language->load('module/' . $this->_moduleSysName());
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('tool/' . $this->_moduleSysName());

		if (isset($this->request->post['selected_buttons']) && $this->validateDelete("bt", $this->request->post['selected_buttons'])) {

			foreach ($this->request->post['selected_buttons'] as $order_manager_columns_id) {
				$this->model_tool_neoseo_order_manager->deleteItem("bt", $order_manager_columns_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('module/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . '#tab-buttons', 'SSL'));
		}

		$this->getListColumns();
	}

	protected function getFormButtons()
	{
		$data = $this->language->load('module/' . $this->_moduleSysName());
		$this->document->setTitle($this->language->get('heading_title_raw'));
		$data['text_form'] = !isset($this->request->get['order_manager_buttons_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else if (isset($this->session->data['error_warning'])) {
			$data['error_warning'] = $this->session->data['error_warning'];
			unset($this->session->data['error_warning']);
		} else {
			$data['error_warning'] = '';
		}

		$data = $this->initBreadcrumbs(array(
			array("module/" . $this->_moduleSysName(), "text_list_columns"),
			array("module/" . $this->_moduleSysName() . "/addButtons", "text_add")
		), $data);


		if (!isset($this->request->get['order_manager_buttons_id'])) {
			$data['action'] = $this->url->link('module/' . $this->_moduleSysName() . '/addButtons', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('module/' . $this->_moduleSysName() . '/editButtons', 'token=' . $this->session->data['token'] . '&order_manager_buttons_id=' . $this->request->get['order_manager_buttons_id'], 'SSL');
		}
		$data['cancel'] = $this->url->link('module/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . "&#tab-buttons", 'SSL');


		if (isset($this->request->get['order_manager_buttons_id'])) {

			$data['item_id'] = $this->request->get['order_manager_buttons_id'];
			$this->load->model('module/' . $this->_moduleSysName());
			$data['item'] = $this->model_tool_neoseo_order_manager->getItem("bt", $this->request->get['order_manager_buttons_id']);
		} else {
			$data['item'] = array(
				'name' => '',
				'class' => '',
				'style' => '',
				'link' => '',
				'post' => '',
			);
		}
		$data['ckeditor'] = $this->ckeditor;
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName() . '_buttons_form.tpl', $data));
	}

	protected function getListColumns()
	{
		$this->load->model("tool/" . $this->_moduleSysName());
		$results = $this->model_tool_neoseo_order_manager->getListColumns();
		foreach ($results as $result) {
			$res[] = array(
				'order_manager_columns_id' => $result['order_manager_columns_id'],
				'language_id' => $result['language_id'],
				'type' => $result['type'],
				'name' => $result['name'],
				'align' => $result['align'],
				'pattern' => html_entity_decode($result['pattern']),
				'width' => $result['width'],
				'selected' => isset($this->request->post['selected']) && in_array($result['order_manager_columns_id'], $this->request->post['selected']),
				'action_text' => $this->language->get('text_edit'),
				'edit' => $this->url->link('module/' . $this->_moduleSysName() . '/editColumns', 'token=' . $this->session->data['token'] . '&order_manager_columns_id=' . $result['order_manager_columns_id'], 'SSL')
			);
		}
		return $res;
	}

	public function addColumns()
	{
		$this->language->load('module/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('tool/' . $this->_moduleSysName());

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_tool_neoseo_order_manager->addItem("cl", $this->request->post['item']);
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('module/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getFormColumns();
	}

	public function editColumns()
	{
		$this->language->load('module/' . $this->_moduleSysName());
		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('tool/' . $this->_moduleSysName());
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_tool_neoseo_order_manager->editItem("cl", $this->request->get['order_manager_columns_id'], $this->request->post['item']);
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('module/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . '#tab-columns', 'SSL'));
		}

		$this->getFormColumns();
	}

	public function deleteColumns()
	{
		$this->language->load('module/' . $this->_moduleSysName());
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('tool/' . $this->_moduleSysName());

		if (isset($this->request->post['selected_columns']) && $this->validateDelete("cl", $this->request->post['selected_columns'])) {

			foreach ($this->request->post['selected_columns'] as $order_manager_columns_id) {
				$this->model_tool_neoseo_order_manager->deleteItem("cl", $order_manager_columns_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('module/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . '#tab-columns', 'SSL'));
		}

		$this->getFormButtons();
	}

	protected function getFormColumns()
	{
		$data = $this->language->load('module/' . $this->_moduleSysName());
		$this->document->setTitle($this->language->get('heading_title_raw'));
		$data['text_form'] = !isset($this->request->get['order_manager_columns_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else if (isset($this->session->data['error_warning'])) {
			$data['error_warning'] = $this->session->data['error_warning'];
			unset($this->session->data['error_warning']);
		} else {
			$data['error_warning'] = '';
		}

		$data = $this->initBreadcrumbs(array(
			array("module/" . $this->_moduleSysName(), "text_list_columns"),
			array("module/" . $this->_moduleSysName() . "/addColumns", "text_add")
		), $data);

		if (!isset($this->request->get['order_manager_columns_id'])) {
			$data['action'] = $this->url->link('module/' . $this->_moduleSysName() . '/addColumns', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('module/' . $this->_moduleSysName() . '/editColumns', 'token=' . $this->session->data['token'] . '&order_manager_columns_id=' . $this->request->get['order_manager_columns_id'], 'SSL');
		}
		$data['cancel'] = $this->url->link('module/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . "&#tab-columns", 'SSL');


		if (isset($this->request->get['order_manager_columns_id'])) {

			$data['item_id'] = $this->request->get['order_manager_columns_id'];
			$this->load->model('module/' . $this->_moduleSysName());
			$data['item'] = $this->model_tool_neoseo_order_manager->getItem("cl", $this->request->get['order_manager_columns_id']);
		} else {
			$data['item'] = array(
				'name' => '',
				'align' => '',
				'width' => '',
				'pattern' => '',
			);
		}
		$data['ckeditor'] = $this->ckeditor;
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName() . '_columns_form.tpl', $data));
	}

	public function getAllowedList()
	{
		$data = $this->language->load('module/' . $this->_moduleSysName());
		$this->load->model('tool/' . $this->_moduleSysName());
		$json = array();
		if (!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName())) {
			$json['error'] = $this->language->get('error_permission');
		} else {
			if (isset($this->request->get["status_id"])) {
				$statusRow = $this->model_tool_neoseo_order_manager->getAllowedList($this->request->get["status_id"]);
				if (isset($statusRow["allowed"])) {
					$statusData = unserialize($statusRow["allowed"]);
				} else {
					$this->load->model('localisation/order_status');

					$orderStatus = $this->model_localisation_order_status->getOrderStatuses();
					$statusData = array();

					foreach ($orderStatus as $data) {
						$statusData[$data["order_status_id"]]["status_id"] = $data["order_status_id"];
						$statusData[$data["order_status_id"]]["name"] = $data["name"];
						$statusData[$data["order_status_id"]]["allowed"] = true;
					}
				}

				$data["statusData"] = $statusData;

				$data['token'] = $this->session->data['token'];
				$json["form"] = $this->renderTemplate('module/' . $this->_moduleSysName() . '_allowed_list.tpl', $data);
				$json['success'] = 1;
			}
		}

		$this->outputJson($json);
	}

	public function setAllowedList()
	{
		$data = $this->language->load('module/' . $this->_moduleSysName());

		$this->load->model('tool/' . $this->_moduleSysName());

		$json = array();

		if (!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName())) {
			$json['error'] = $this->language->get('error_permission');
		} else {
			if (isset($this->request->get["status_id"])) {
				$this->model_tool_neoseo_order_manager->setAllowedList($this->request->get["status_id"], $this->request->post["allowed"]);
				$json['success'] = 1;
			}
		}
		$this->outputJson($json);
	}

	protected function renderTemplate($template, $data)
	{
		extract($data);
		ob_start();

		require(DIR_TEMPLATE . $template);
		$result = ob_get_contents();
		ob_end_clean();

		return $result;
	}

	private function validate()
	{
		if (!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName())) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

	protected function validateDelete($type, $request_post)
	{
		if (!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName())) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		$this->load->model('tool/' . $this->_moduleSysName());

		foreach ($request_post as $id) {

			$res = $this->model_tool_neoseo_order_manager->getTotalItem($type, $id);

			if (!$res) {
				$this->error['warning'] = sprintf($this->language->get('error_delete'), $res);
			}
		}

		return !$this->error;
	}

	protected function validateForm()
	{
		if (!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName())) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		return !$this->error;
	}

}

?>
