<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');

class ControllerDashboardNeoSeoBrokenLinksWidget extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_broken_links_widget";
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

		$broken_links_status = $this->config->get('neoseo_broken_links_status');
		if ($broken_links_status == 1) {

			$this->load->model('tool/neoseo_broken_links');

			$language_id = $this->config->get('config_language_id');
			$limit = $this->config->get($this->_moduleSysName . '_limit');
			$title = $this->config->get($this->_moduleSysName . '_title');
			$data['title'] = isset($title[$language_id]) ? $title[$language_id] : '';
			$data['show_notfound_number'] = $this->config->get($this->_moduleSysName . '_show_notfound_number');
			$data['show_ip'] = $this->config->get($this->_moduleSysName . '_show_ip');
			$data['show_browser'] = $this->config->get($this->_moduleSysName . '_show_browser');
			$data['show_request_uri'] = $this->config->get($this->_moduleSysName . '_show_request_uri');
			$data['show_referer'] = $this->config->get($this->_moduleSysName . '_show_referer');
			$data['show_date_record'] = $this->config->get($this->_moduleSysName . '_show_date_record');
			$data['show_add_redirect'] = $this->config->get($this->_moduleSysName . '_show_add_redirect');
			$data['more'] = $this->url->link('tool/neoseo_broken_links', 'token=' . $this->session->data['token'], 'SSL');

			$data['redirect_manager'] = false;
			$redirect_manager = $this->config->get('neoseo_redirect_manager_status');
			if ($redirect_manager) {
				$data['redirect_manager'] = true;
				$this->load->model('tool/neoseo_redirect_manager');
			}

			$data['items'] = array();

			$filter = array(
				'start' => 0,
				'limit' => $limit ? $limit : 5,
			);

			$results = $this->model_tool_neoseo_broken_links->getRecords($filter);

			foreach ($results as $result) {

				$isset_redirect = false;
				if ($redirect_manager) {
					$redirect = $this->model_tool_neoseo_redirect_manager->getItemByFromUrl($result['request_uri']);
					$isset_redirect = (count($redirect) > 0 && isset($redirect['from_url'])) ? true : false;
				}

				$data['items'][] = array(
					'notfound_id' => $result['notfound_id'],
					'ip' => $result['ip'],
					'browser' => $result['browser'],
					'request_uri' => $result['request_uri'],
					'referer' => $result['referer'],
					'date_record' => date($this->language->get('date_format_short'), strtotime($result['date_record'])),
					'add_redirect' => isset($redirect_manager) ? $this->url->link('tool/neoseo_redirect_manager/add', 'token=' . $this->session->data['token'] . '&request_uri=' . preg_replace('/&amp;/', 'AND', $result['request_uri']), 'SSL') : "",
					'isset_redirect' => $isset_redirect,
				);
			}

			$data['count_items'] = count($data['items']);
			$template = 'dashboard/' . $this->_moduleSysName . '.tpl';
		} else {
			$data['domain'] = $this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG;
			$data['email'] = $this->config->get('config_email');
			$data['text_content'] = $broken_links_status == NULL ? $this->language->get('text_module_uninstall') : $this->language->get('text_module_turnof');
			$data['send_request'] = $broken_links_status == NULL ? true : false;
			$data['setting_module'] = $this->url->link('module/neoseo_broken_links', 'token=' . $this->session->data['token'], 'SSL');
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

}
