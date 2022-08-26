<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');

class ControllerDashboardNeoSeoDroppedCartWidget extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_dropped_cart_widget";
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

		$checkout_status = $this->config->get('neoseo_checkout_status');
		if ($checkout_status == 1) {

			$this->load->model('sale/neoseo_dropped_cart');

			$language_id = $this->config->get('config_language_id');
			$limit = $this->config->get($this->_moduleSysName . '_limit');
			$title = $this->config->get($this->_moduleSysName . '_title');
			$data['title'] = isset($title[$language_id]) ? $title[$language_id] : '';
			$data['show_dropped_cart_number'] = $this->config->get($this->_moduleSysName . '_show_dropped_cart_number');
			$data['show_email'] = $this->config->get($this->_moduleSysName . '_show_email');
			$data['show_customer'] = $this->config->get($this->_moduleSysName . '_show_customer');
			$data['show_notification'] = $this->config->get($this->_moduleSysName . '_show_notification');
			$data['show_telephone'] = $this->config->get($this->_moduleSysName . '_show_telephone');
			$data['show_total'] = $this->config->get($this->_moduleSysName . '_show_total');
			$data['show_date_modified'] = $this->config->get($this->_moduleSysName . '_show_date_modified');
			$data['more'] = $this->url->link('sale/neoseo_dropped_cart', 'token=' . $this->session->data['token'], 'SSL');

			$data['items'] = array();

			$filter = array(
				'filter' => array(
					'name' => '',
					'email' => '',
					'modified' => ''
				),
				'sort' => 'modified',
				'order' => 'DESC',
				'start' => 0,
				'limit' => $limit ? $limit : 5,
			);

			$data['count_items'] = $this->model_sale_neoseo_dropped_cart->getTotalCarts($filter);
			$results = $this->model_sale_neoseo_dropped_cart->getCarts($filter);

			foreach ($results as $result) {

				$data['items'][] = array(
					'dropped_cart_id' => $result['dropped_cart_id'],
					'email' => $result['email'],
					'customer' => $result['name'],
					'notification' => $result['notification_count'],
					'telephone' => $result['phone'],
					'total' => $this->currency->format($result['total']),
					'date_modified' => date($this->language->get('datetime_format'), strtotime($result['modified'])),
					'customer_view' => $this->url->link('customer/customer/edit', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'], 'SSL'),
					'view' => $this->url->link('sale/neoseo_dropped_cart/view', 'token=' . $this->session->data['token'] . '&dropped_cart_id=' . $result['dropped_cart_id'], 'SSL'),
					'notify' => $this->url->link('sale/neoseo_dropped_cart/notify', 'token=' . $this->session->data['token'] . '&dropped_cart_id=' . $result['dropped_cart_id'], 'SSL'),
				);
			}

			$template = 'dashboard/' . $this->_moduleSysName . '.tpl';
		} else {
			$data['domain'] = $this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG;
			$data['email'] = $this->config->get('config_email');
			$data['text_content'] = $checkout_status == NULL ? $this->language->get('text_module_uninstall') : $this->language->get('text_module_turnof');
			$data['send_request'] = $checkout_status == NULL ? true : false;
			$data['setting_module'] = $this->url->link('module/neoseo_checkout', 'token=' . $this->session->data['token'], 'SSL');
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
