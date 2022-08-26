<?php

require_once(DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerApiOrderHistory extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_sysModuleName = "neoseo_exchange1c";
		$this->_logFile = $this->_sysModuleName . ".log";
		$this->debug = $this->config->get($this->_sysModuleName . "_debug") == 1;
	}

	public function index()
	{
		$this->load->language('api/order');

		// Проверка IP-адреса
		$ipList = $this->config->get("neoseo_exchange1c_ip_list");
		if (trim($ipList) != "") {
			$found = false;
			foreach (explode("\n", $ipList) as $ip) {
				if (trim($ip) == $_SERVER['REMOTE_ADDR']) {
					$found = true;
					break;
				}
			}
			if (!$found) {
				$this->log('Несанкционированное обращение с адреса: ' . $_SERVER['REMOTE_ADDR']);
				return;
			}
		}

		if (!isset($this->request->post['order_id'])) {
			$this->log('Не указан order_id');
			return;
		}
		$order_id = $this->request->post['order_id'];

		$this->load->model('checkout/order');
		$order_info = $this->model_checkout_order->getOrder($order_id);
		if (!$order_info) {
			$this->log('Не найден заказ с номером ' . $order_id);
			return;
		}

		$this->log("Устанавливаем заказу с номером $order_id новые параметры: " . print_r($this->request->post, true));
		$this->load->model('checkout/order');
		$this->model_checkout_order->addOrderHistory(
		    $order_id, $this->request->post['order_status_id'], $this->request->post['comment'], $this->request->post['notify'], $this->request->post['override']
		);

		return;
	}

}
