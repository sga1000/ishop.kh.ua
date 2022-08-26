<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');

class ControllerDashboardNeoSeoTestimonialsWidget extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_testimonials_widget";
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

		$data['token'] = $this->session->data['token'];
		$data['setting_widget'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');

		$testimonials_status = $this->model_tool_neoseo_testimonials_widget->getTableModule();
		if ($testimonials_status == 1) {

			$this->load->model("tool/image");

			$language_id = $this->config->get('config_language_id');
			$limit = $this->config->get($this->_moduleSysName . '_limit');
			$method = $this->config->get($this->_moduleSysName . '_method');
			$height_image = $this->config->get($this->_moduleSysName . '_height_image') ? $this->config->get($this->_moduleSysName . '_height_image') : 100;
			$width_image = $this->config->get($this->_moduleSysName . '_width_image') ? $this->config->get($this->_moduleSysName . '_width_image') : 100;
			$title = $this->config->get($this->_moduleSysName . '_title');
			$data['title'] = isset($title[$language_id]) ? $title[$language_id] : '';
			$data['show_testimonial_number'] = $this->config->get($this->_moduleSysName . '_show_testimonial_number');
			$data['show_text'] = $this->config->get($this->_moduleSysName . '_show_text');
			$data['show_admin_text'] = $this->config->get($this->_moduleSysName . '_show_admin_text');
			$data['show_author'] = $this->config->get($this->_moduleSysName . '_show_author');
			$data['show_rating'] = $this->config->get($this->_moduleSysName . '_show_rating');
			$data['show_date_added'] = $this->config->get($this->_moduleSysName . '_show_date_added');
			$data['show_youtube'] = $this->config->get($this->_moduleSysName . '_show_youtube');
			$data['show_image'] = $this->config->get($this->_moduleSysName . '_show_image');
			$data['show_status'] = $this->config->get($this->_moduleSysName . '_show_status');
			$data['more'] = $this->url->link('catalog/neoseo_testimonials', 'token=' . $this->session->data['token'], 'SSL');

			$data['items'] = array();

			$filter = array(
				'start' => 0,
				'limit' => $limit ? $limit : 5,
			);
			if (in_array(1, $method)) {
				$filter['filter_status'] = 0;
			}
			if (in_array(2, $method)) {
				$filter['filter_admin_text'] = '';
			}

			$results = $this->model_tool_neoseo_testimonials_widget->getTestimonials($filter);

			foreach ($results as $result) {

				if (file_exists(DIR_IMAGE . $result['user_image']) && is_file(DIR_IMAGE . $result['user_image'])) {
					$image = $this->model_tool_image->resize($result['user_image'], $width_image, $height_image);
				} else {
					$image = false;
				}

				$data['items'][] = array(
					'testimonial_id' => $result['testimonial_id'],
					'name' => $result['name'],
					'rating' => $result['rating'],
					'status' => $result['status'],
					'text' => $result['description'],
					'admin_text' => $result['admin_text'],
					'text_status' => $result['status'] == 1 ? $this->language->get('text_status_enabled') : $this->language->get('text_status_disabled'),
					'youtube' => $result['youtube'],
					'image' => $image,
					'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					'view' => $this->url->link('catalog/neoseo_testimonials/edit', 'token=' . $this->session->data['token'] . '&neoseo_testimonial_id=' . $result['testimonial_id'], 'SSL'),
				);
			}

			$data['count_items'] = count($data['items']);
			$template = 'dashboard/' . $this->_moduleSysName . '.tpl';
		} else {
			$data['domain'] = $this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG;
			$data['email'] = $this->config->get('config_email');
			$data['text_content'] = $this->language->get('text_module_uninstall');
			$data['send_request'] = true;
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
		$this->model_tool_neoseo_testimonials_widget->changeStatus(
		    $this->request->post['status'], $this->request->post['testimonial_id']
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
		$this->model_tool_neoseo_testimonials_widget->changeComment(
		    $this->request->post['admin_text'], $this->request->post['testimonial_id']
		);

		$json = array(
			'success' => true,
		);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		return;
	}

}
