<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');

class ControllerDashboardNeoSeoBackupWidget extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_backup_widget";
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

		$backup_status = $this->config->get('neoseo_backup_status');
		if ($backup_status == 1) {

			$this->load->model('tool/neoseo_backup');

			$language_id = $this->config->get('config_language_id');
			$limit = $this->config->get($this->_moduleSysName . '_limit');
			$title = $this->config->get($this->_moduleSysName . '_title');
			$data['title'] = isset($title[$language_id]) ? $title[$language_id] : '';
			$data['more'] = $this->url->link('tool/neoseo_backup', 'token=' . $this->session->data['token'], 'SSL');
			$data['count_files'] = 0;

			$files = $this->model_tool_neoseo_backup->getFiles();
			if ($files) {
				$last_date_create = '';
				foreach ($files as $file) {
					preg_match('/([0-9]{4}-[0-9]{2}-[0-9]{2}\s[0-9]{2}:[0-9]{2}:[0-9]{2})/', $file['name'], $matches);
					$date_create = $matches[1];

					if (!$last_date_create)
						$last_date_create = $date_create;

					if (strtotime($last_date_create) < strtotime($date_create))
						$last_date_create = $date_create;
				}

				$now = new DateTime();
				$last_date = $last_date_create;
				$last_date = new DateTime($last_date);
				$interval_days = date_diff($now, $last_date)->days;

				$days = array(
					0 => $this->language->get('params_sunday'),
					1 => $this->language->get('params_monday'),
					2 => $this->language->get('params_tuesday'),
					3 => $this->language->get('params_wednesday'),
					4 => $this->language->get('params_thursday'),
					5 => $this->language->get('params_friday'),
					6 => $this->language->get('params_saturday'),
				);

				$data['interval_days'] = $interval_days;
				$data['day_week'] = $days[date("w", strtotime($last_date_create))];
				$data['date'] = date("d.m.Y", strtotime($last_date_create));
				$data['time'] = date("H:i:s", strtotime($last_date_create));
				$data['count_files'] = count($files);
				$data['warning'] = $limit <= $interval_days ? sprintf($this->language->get('text_warning'), $interval_days) : false;
			}
			$template = 'dashboard/' . $this->_moduleSysName . '.tpl';
		} else {
			$data['domain'] = $this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG;
			$data['email'] = $this->config->get('config_email');
			$data['text_content'] = $backup_status == NULL ? $this->language->get('text_no_install') : $this->language->get('text_no_information');
			$data['send_request'] = $backup_status == NULL ? true : false;
			$data['setting_module'] = $this->url->link('module/neoseo_backup', 'token=' . $this->session->data['token'], 'SSL');
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
