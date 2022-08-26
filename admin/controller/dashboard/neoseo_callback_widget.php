<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');

class ControllerDashboardNeoSeoCallbackWidget extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_callback_widget";
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

		$data['token'] = $this->session->data['token'];
		$data['setting_widget'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');

		$callback_status = $this->config->get('neoseo_callback_status');
		if ($callback_status == 1) {

			$this->load->model("sale/neoseo_callback");

			$language_id = $this->config->get('config_language_id');
			$limit = $this->config->get($this->_moduleSysName . '_limit');
			$title = $this->config->get($this->_moduleSysName . '_title');
			$data['title'] = isset($title[$language_id]) ? $title[$language_id] : '';
			$data['show_callback_number'] = $this->config->get($this->_moduleSysName . '_show_callback_number');
			$data['show_customer'] = $this->config->get($this->_moduleSysName . '_show_customer');
			$data['show_customer_email'] = $this->config->get($this->_moduleSysName . '_show_customer_email');
			$data['show_customer_telephone'] = $this->config->get($this->_moduleSysName . '_show_customer_telephone');
			$data['show_status'] = $this->config->get($this->_moduleSysName . '_show_status');
			$data['show_date_added'] = $this->config->get($this->_moduleSysName . '_show_date_added');
			$data['show_comment'] = $this->config->get($this->_moduleSysName . '_show_comment');
			$data['show_manager'] = $this->config->get($this->_moduleSysName . '_show_manager');
			$data['show_message'] = $this->config->get($this->_moduleSysName . '_show_message');
			$data['more'] = $this->url->link('sale/neoseo_callback', 'token=' . $this->session->data['token'], 'SSL');

			$data['items'] = array();

			$filter = array(
				'filter_status' => 0,
				'start' => 0,
				'limit' => $limit ? $limit : 5,
			);
			$data['count_items'] =  $this->model_sale_neoseo_callback->getListTotalItems($filter);
			$results = $this->model_sale_neoseo_callback->getListItems($filter);

			foreach ($results as $result) {
				$data['items'][] = array(
					'callback_id' => $result['callback_id'],
					'customer' => $result['name'],
					'email' => $result['email'],
					'telephone' => $result['phone'],
					'status' => $result['status'],
					'text_status' => $result['status'] == 1 ? $this->language->get('text_status_enabled') : $this->language->get('text_status_disabled'),
					'comment' => $result['comment'],
					'manager' => $result['manager'],
					'message' => $result['message'],
					'date_added' => date($this->language->get('date_format_short'), strtotime($result['date'])),
					'view' => $this->url->link('sale/neoseo_callback/edit', 'token=' . $this->session->data['token'] . '&callback_id=' . $result['callback_id'], 'SSL'),
				);
			}

			$template = 'dashboard/' . $this->_moduleSysName . '.tpl';
		} else {
			$data['domain'] = $this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG;
			$data['email'] = $this->config->get('config_email');
			$data['text_content'] = $callback_status == NULL ? $this->language->get('text_module_uninstall') : $this->language->get('text_module_turnof');
			$data['send_request'] = $callback_status == NULL ? true : false;
			$data['setting_module'] = $this->url->link('module/neoseo_callback', 'token=' . $this->session->data['token'], 'SSL');
			$template = 'dashboard/' . $this->_moduleSysName . '_request.tpl';
		}
		return $this->load->view($template, $data);
	}

	public function sendRequest()
	{
		$this->language->load('dashboard/' . $this->_moduleSysName);

		$domain = $this->request->get['domain'];
		$email = $this->request->get['email'];

		$json = array();

		if (!$domain || !$email) {
			$json = array(
				'error' => true,
				'result' => $this->language->get('text_error'),
			);

			$this->response->setOutput(json_encode($json));
			return;
		}

		$email_to = $this->language->get('params_email');
		$subject = $this->language->get('params_subject');
		$message = sprintf($this->language->get('params_message'), $domain, $email);

		$this->sendEmail($email_to, $subject, $message);

		$json = array(
			'error' => false,
			'result' => $this->language->get('text_success'),
		);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	private function sendEmail($email, $subject, $message)
	{
		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
		$mail->smtp_username = $this->config->get('config_mail_smtp_username');
		$mail->smtp_password = $this->config->get('config_mail_smtp_password');
		$mail->smtp_port = $this->config->get('config_mail_smtp_port');
		$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender($this->config->get('config_email'));

		$mail->setSubject($subject);
		$mail->setHTML($message);

		$mail->setTo($email);
		$mail->send();
	}

	public function changeStatus()
	{
		$json = array();

		$this->load->model('tool/' . $this->_moduleSysName);
		$this->model_tool_neoseo_callback_widget->changeStatus(
		    $this->request->post['status'], $this->request->post['callback_id']
		);

		$json = array(
			'success' => true,
		);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		return;
	}

	public function changeComment()
	{
		$json = array();

		$this->load->model('tool/' . $this->_moduleSysName);
		$this->model_tool_neoseo_callback_widget->changeComment(
		    $this->request->post['comment'], $this->request->post['callback_id']
		);

		$json = array(
			'success' => true,
		);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		return;
	}

	public function changeManager()
	{
		$json = array();

		$this->load->model('tool/' . $this->_moduleSysName);
		$this->model_tool_neoseo_callback_widget->changeManager(
		    $this->request->post['manager'], $this->request->post['callback_id']
		);

		$json = array(
			'success' => true,
		);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		return;
	}

}
