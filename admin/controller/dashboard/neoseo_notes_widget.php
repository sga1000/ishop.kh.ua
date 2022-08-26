<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');

class ControllerDashboardNeoSeoNotesWidget extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_notes_widget";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function index()
	{
		if ($this->config->get($this->_moduleSysName . '_status') != 1) {
			$this->log('Виджет не может быть выведен, т.к. модуль виджета отключен.');
			return false;
		}

		$data = $this->language->load('dashboard/' . $this->_moduleSysName);

		$this->load->model("tool/" . $this->_moduleSysName);

		$language_id = $this->config->get('config_language_id');
		$now = strtotime(date("Y-m-d H:i:s"));
		$title = $this->config->get($this->_moduleSysName . '_title');
		$data['title'] = isset($title[$language_id]) ? $title[$language_id] : '';
		$data['setting_widget'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
		$data['more'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . '#tab-notes', 'SSL');

		$filter['filter_show_dashboard'] = 1;

		$data['items'] = array();
		$data['notification_items'] = array();
		$notes = $this->model_tool_neoseo_notes_widget->getNotes($filter);
		foreach ($notes as $key => $note) {

			$date_notification = strtotime($note['date_notification']);
			$interval = ceil(($date_notification - $now) / (3600 * 24));

			if ($note['use_notification'] == 1 && $date_notification <= $now && $note['notification'] == 0) {
				$data['notification_items'][$note['note_id']] = $note['text_notification'];
			}

			if ($note['show_dashboard'] == 0) {
				continue;
			}

			$data['items'][$key] = $note;
			$data['items'][$key]['date_notification'] = date($this->language->get('datetime_format'), strtotime($note['date_notification']));
			$data['items'][$key]['interval_days'] = ($note['use_notification'] == 1 && $interval > 0) ? $interval : '';
			$data['items'][$key]['view'] = $this->url->link('module/' . $this->_moduleSysName . '/edit', 'token=' . $this->session->data['token'] . '&note_id=' . $note['note_id'], 'SSL');
		}

		$data['token'] = $this->session->data['token'];
		$data['count_items'] = $this->model_tool_neoseo_notes_widget->getTotalNotes();

		return $this->load->view('dashboard/' . $this->_moduleSysName . '.tpl', $data);
	}

	public function changeStatusNotify()
	{
		$json = array();

		$this->load->model('tool/' . $this->_moduleSysName);
		$this->model_tool_neoseo_notes_widget->changeStatusNotify($this->request->post['note_id']);

		$json = array(
			'success' => true,
		);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		return;
	}

}
