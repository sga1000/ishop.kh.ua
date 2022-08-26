<?php

require_once(DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoOrderManager extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_order_manager";
		$this->_logFile = $this->_moduleSysName() . ".log";
		$this->debug = $this->config->get($this->_moduleSysName() . "_debug");
		$this->language->load('module/' . $this->_moduleSysName());

		$this->params = array(
			"status" => 1,
			"block_send_comment" => 0,
			"debug" => 0,
			"replace_system_status" => 0,
			"hide_unavailable" => 0,
			"product" => $this->language->get('text_product'),
			"history" => $this->language->get('text_history'),
			"visible_order_statuses" => array(1, 2, 3, 9)
		);
	}

	public function checkInstall()
	{
		$query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "'order_manager_columns");
		$columnTable = count($query->rows);

		$query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "'order_manager_buttons");
		$buttonTable = count($query->rows);

		if ($columnTable == 0 || $buttonTable == 0)
			$this->install();
	}

	// Install/Uninstall
	public function install($store_id = 0)
	{
		$this->initParams($this->params);
		$this->installTables();

		$lngArray = array();

		$sql = "SELECT language_id, code FROM `" . DB_PREFIX . "language` WHERE code = 'en' OR code = 'ru'";
		$query = $this->db->query($sql);
		$langs = $query->rows;

		if (count($langs) < 1)
			return false;

		foreach ($langs as $ld) {
			$lngArray[$ld["code"]] = $ld["language_id"];
		}

		$sql = array();

		if (isset($lngArray["ru"])) {
			$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_columns` (language_id, type, name, align, pattern, width) VALUES (" . $lngArray["ru"] . ", 'system', 'Заказ', '', '<p><span style=\"font-size:16px;\">Заказ №<strong>{order_id}</strong></span><br/>{date_added}<br /><u>{status}</u></p>', '150');";
			$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_columns` (language_id, type, name, align, pattern, width) VALUES (" . $lngArray["ru"] . ", 'system', 'Покупатель', '', '<p>{firstname} {lastname}<br /><strong>{telephone}</strong><br /><u>{email}</u></p>', '150');";
			$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_columns` (language_id, type, name, align, pattern, width) VALUES (" . $lngArray["ru"] . ", 'system', 'Доставка', '', '<p><u>{shipping_method}</u><br />{shipping_zone}, <strong>{shipping_city}</strong><br /> {shipping_address_1}<br />{shipping_address_2}</p>', '150');";
			$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_columns` (language_id, type, name, align, pattern, width) VALUES (" . $lngArray["ru"] . ", 'system', 'Оплата', '', '<p><u>{payment_method}</u><br />Сумма: <span style=\"font-size:16px;\">{total}</span></p>', '150');";
			if ("1" == $this->config->get("neoseo_order_referrer_status") || "1" == $this->config->get("neoseo_order_referrer_status")) {
				$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_columns` (language_id, type, name, align, pattern, width) VALUES (" . $lngArray["ru"] . ", 'system', 'Источник заказа', '', '<p>{first_referrer}</p><p>{last_referrer}</p>', '');";
			}
			$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_columns` (language_id, type, name, align, pattern, width) VALUES (" . $lngArray["ru"] . ", 'system', 'Товары', '', '{products}', '250');";

			$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_buttons` (language_id, name, class, style, link, onclick) VALUES (" . $lngArray["ru"] . ", 'Показать счет', 'btn btn-primary', '', 'sale/order/invoice', '');";
		}

		if (isset($lngArray["en"])) {
			$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_columns` (language_id, type, name, align, pattern, width) VALUES (" . $lngArray["en"] . ", 'system', 'Order', '', '<p><span style=\"font-size:16px;\">Order №<strong>{order_id}</strong></span><br/>{date_added}<br /><u>{status}</u></p>', '150');";
			$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_columns` (language_id, type, name, align, pattern, width) VALUES (" . $lngArray["en"] . ", 'system', 'Customer', '', '<p>{firstname} {lastname}<br /><strong>{telephone}</strong><br /><u>{email}</u></p>', '150');";
			$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_columns` (language_id, type, name, align, pattern, width) VALUES (" . $lngArray["en"] . ", 'system', 'Delivery', '', '<p><u>{shipping_method}</u><br />{shipping_zone}, <strong>{shipping_city}</strong><br /> {shipping_address_1}<br />{shipping_address_2}</p>', '150');";
			$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_columns` (language_id, type, name, align, pattern, width) VALUES (" . $lngArray["en"] . ", 'system', 'Payment', '', '<p><u>{payment_method}</u><br />Сумма: <span style=\"font-size:16px;\">{total}</span></p>', '150');";
			if ("1" == $this->config->get("neoseo_order_referrer_status") || "1" == $this->config->get("neoseo_order_referrer_status")) {
				$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_columns` (language_id, type, name, align, pattern, width) VALUES (" . $lngArray["en"] . ", 'system', 'Order referrer', '', '<p>{first_referrer}</p><p>{last_referrer}</p>', '');";
			}
			$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_columns` (language_id, type, name, align, pattern, width) VALUES (" . $lngArray["en"] . ", 'system', 'Products', '', '{products}', '300');";

			$sql[] = "INSERT INTO `" . DB_PREFIX . "order_manager_buttons` (language_id, name, class, style, link, onclick) VALUES (" . $lngArray["en"] . ", 'Show check', 'button', '', 'sale/order/invoice', '');";
		}

		foreach ($sql as $_sql) {
			$this->db->query($_sql);
		}

		//Установка прав
		$this->addPermission($this->user->getGroupId(), 'access', 'sale/' . $this->_moduleSysName());
		$this->addPermission($this->user->getGroupId(), 'modify', 'sale/' . $this->_moduleSysName());
		$this->addPermission($this->user->getGroupId(), 'access', 'tool/' . $this->_moduleSysName());
		$this->addPermission($this->user->getGroupId(), 'modify', 'tool/' . $this->_moduleSysName());
		return true;
	}

	public function installTables()
	{
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "order_manager_columns` ( `order_manager_columns_id` int(11) NOT NULL AUTO_INCREMENT, `language_id` int(1) NOT NULL, `type` varchar(10) NOT NULL, `name` varchar(128) NOT NULL, `align` varchar(10) NOT NULL, `pattern` text NOT NULL, `width` varchar(10), PRIMARY KEY (`order_manager_columns_id`) )  CHARACTER SET utf8 COLLATE utf8_general_ci;");
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "order_manager_buttons` ( `order_manager_buttons_id` int(11) NOT NULL AUTO_INCREMENT, `language_id` int(1) NOT NULL, `name` varchar(128) NOT NULL, `class` varchar(255) NOT NULL, `style` text NOT NULL, `link` varchar(255), `post` varchar(255), `onclick` varchar(255), PRIMARY KEY (`order_manager_buttons_id`) )  CHARACTER SET utf8 COLLATE utf8_general_ci;");
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "order_history_to_user` ( `order_history_user_id` int(11) NOT NULL AUTO_INCREMENT, `order_id` int(11) NOT NULL, `user_id` int(11) NOT NULL, PRIMARY KEY (`order_history_user_id`) )  CHARACTER SET utf8 COLLATE utf8_general_ci;");
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "order_allowed_status` ( `order_status_allowed_id` int(11) NOT NULL AUTO_INCREMENT, `language_id` int(11) NOT NULL, `order_status_id` int(11) NOT NULL, allowed text, PRIMARY KEY (`order_status_allowed_id`,`language_id`), UNIQUE KEY `order_status_id` (`order_status_id`) )  CHARACTER SET utf8 COLLATE utf8_general_ci;");
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "customer_scfield` (`customer_scfield_id` int(11) NOT NULL AUTO_INCREMENT, `customer_id` int(11) NOT NULL, `name` varchar(256) NOT NULL, `value` text NOT NULL, PRIMARY KEY (`customer_scfield_id`)) DEFAULT CHARSET=utf8;");
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "order_scfield` (`order_scfield_id` int(11) NOT NULL AUTO_INCREMENT, `order_id` int(11) NOT NULL, `name` varchar(256) NOT NULL, `value` text NOT NULL, PRIMARY KEY (`order_scfield_id`)) DEFAULT CHARSET=utf8;");

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "order_product` LIKE 'product_custom_field'";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "order_product` ADD `product_custom_field` TEXT NOT NULL AFTER `product_id`;";
			$this->db->query($sql);
		}

		$hasNewIndex = false;
		$sql = "SHOW INDEX FROM `" . DB_PREFIX . "order_product`";
		$query = $this->db->query($sql);
		foreach ($query->rows as $row) {
			if ($row['Key_name'] == 'order_id') {
				$hasNewIndex = true;
			}
		}
		if (!$hasNewIndex) {
			$sql = "ALTER TABLE " . DB_PREFIX . "order_product ADD INDEX  `order_id` (  `order_id` )";
			$this->db->query($sql);
		}
	}

	public function upgrade()
	{
		$this->initParams($this->params);
		$this->installTables();
	}

	public function uninstall()
	{
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "order_manager_columns`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "order_manager_buttons`");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "setting` WHERE `code` = '".$this->_moduleSysName()."'");

		return true;
	}

}

?>