<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerModuleNeoSeoNotesWidget extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_notes_widget";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if (!isset($_GET["close"])) {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/' . $this->_route, 'token=' . $this->session->data['token'], 'SSL'));
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
			array('extension/module', 'text_module'),
			array($this->_route . '/' . $this->_moduleSysName, "heading_title_raw")
		    ), $data);

		$data = $this->initButtons($data);

		$data['add'] = $this->url->link('module/' . $this->_moduleSysName . '/add', 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model($this->_route . "/" . $this->_moduleSysName);
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName}->params, $data);

		$this->load->model("localisation/language");
		$data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model("tool/" . $this->_moduleSysName);
		$notes = $this->model_tool_neoseo_notes_widget->getNotes();
		foreach ($notes as $key => $note) {
			$data['notes'][$key] = $note;
			$data['notes'][$key]['date_notification'] = $note['date_notification'] != '0000-00-00 00:00:00' ? date($this->language->get('datetime_format'), strtotime($note['date_notification'])) : false;
			$data['notes'][$key]['view'] = $this->url->link('module/' . $this->_moduleSysName . '/edit', 'token=' . $this->session->data['token'] . '&note_id=' . $note['note_id'], 'SSL');
		}
		$data["token"] = $this->session->data['token'];
		$data['config_language_id'] = $this->config->get('config_language_id');
		$data['params'] = $data;

		$data["logs"] = $this->getLogs();

		$widgets = new NeoSeoWidgets($this->_moduleSysName . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function add()
	{

		$this->load->model("tool/" . $this->_moduleSysName);

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_tool_neoseo_notes_widget->addNote($this->request->post['note']);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . '#tab-notes', 'SSL'));
		}

		$this->getForm();
	}

	public function edit()
	{

		$this->load->model("tool/" . $this->_moduleSysName);

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_tool_neoseo_notes_widget->editNote($this->request->post['note']);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . '#tab-notes', 'SSL'));
		}

		$this->getForm();
	}

	public function delete()
	{
		$json = array();

		if (!isset($this->request->get['note_id'])) {
			$this->response->setOutput(json_encode($json));
			return;
		}

		$note_id = $this->request->get['note_id'];

		$this->language->load('module/' . $this->_moduleSysName);
		$this->load->model("tool/" . $this->_moduleSysName);

		$this->model_tool_neoseo_notes_widget->deleteNote($note_id);

		$json['result'] = true;

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	protected function getForm()
	{
		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('tool/' . $this->_moduleSysName);

		$this->document->addScript('view/javascript/bootstrap-colorpicker/js/bootstrap-colorpicker.js');
		$this->document->addStyle('view/javascript/bootstrap-colorpicker/css/bootstrap-colorpicker.css');

		$data['text_form'] = !isset($this->request->get['note_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['title'])) {
			$data['error_title'] = $this->error['title'];
		} else {
			$data['error_title'] = '';
		}

		if (isset($this->error['text'])) {
			$data['error_text'] = $this->error['text'];
		} else {
			$data['error_text'] = '';
		}

		$data = $this->initBreadcrumbs(array(
			array('extension/module', 'text_module'),
			array($this->_route . '/' . $this->_moduleSysName, "heading_title_raw", '#tab-notes'),
		    ), $data);

		if (!isset($this->request->get['note_id'])) {
			$data['action'] = $this->url->link($this->_route . '/' . $this->_moduleSysName . '/add', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link($this->_route . '/' . $this->_moduleSysName . '/edit', 'token=' . $this->session->data['token'] . '&note_id=' . $this->request->get['note_id'], 'SSL');
		}

		$data['cancel'] = $this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->get['note_id'])) {

			$data['note_id'] = $this->request->get['note_id'];
			$data['note'] = $this->model_tool_neoseo_notes_widget->getNote($this->request->get['note_id']);
			$data['breadcrumbs'][] = array(
				'text' => $data['note']['title'],
				'href' => $this->url->link($this->_route . '/' . $this->_moduleSysName . '/edit', 'token=' . $this->session->data['token'] . '&note_id=' . $this->request->get['note_id'], 'SSL')
			);
		} elseif (isset($this->request->post['note'])) {
			$note = $this->request->post['note'];
			$data['note'] = array(
				'title' => isset($note['title']) ? $note['title'] : '',
				'text' => isset($note['text']) ? $note['text'] : '',
				'use_notification' => isset($note['use_notification']) ? $note['use_notification'] : 0,
				'date_notification' => isset($note['date_notification']) ? $note['date_notification'] : date($this->language->get('datetime_format')),
				'text_notification' => isset($note['text_notification']) ? $note['text_notification'] : '',
				'show_dashboard' => isset($note['show_dashboard']) ? $note['show_dashboard'] : 0,
				'sort_order' => isset($note['sort_order']) ? $note['sort_order'] : 0,
				'color' => isset($note['color']) ? $note['color'] : '#ffffff',
				'font_color' => isset($note['font_color']) ? $note['font_color'] : '##666',
				'notification' => isset($note['notification']) ? $note['notification'] : 0,
			);
		} else {
			$data['note'] = array(
				'title' => '',
				'text' => '',
				'use_notification' => 0,
				'date_notification' => date($this->language->get('datetime_format')),
				'text_notification' => '',
				'show_dashboard' => 0,
				'sort_order' => 0,
				'color' => '#ffffff',
				'font_color' => '##666',
				'notification' => 0,
			);
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName . '_form.tpl', $data));
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

	protected function validateForm()
	{
		$this->language->load($this->_route . '/' . $this->_moduleSysName);

		if (!$this->user->hasPermission('modify', $this->_route . '/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		$note = $this->request->post['note'];
		if ((utf8_strlen(trim($note['title'])) < 1)) {
			$this->error['title'] = $this->language->get('error_empty');
		}

		if ((utf8_strlen(trim($note['text'])) < 1)) {
			$this->error['text'] = $this->language->get('error_empty');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

}
