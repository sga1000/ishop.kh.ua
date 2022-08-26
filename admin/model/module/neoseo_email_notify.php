<?php
require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoEmailNotify extends NeoSeoModel {

	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_email_notify";
		$this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . ".log";
		$this->debug = $this->config->get( $this->_moduleSysName() . "_debug") == 1;

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'recipients' => '',
			'status_zero_shipping_cost' => 0,
			'templates' => $this->getDefaultTemplates()
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		return TRUE;
	}

	public function uninstall()
	{
		return TRUE;
	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);
	}

	public function getDefaultTemplates()
	{
		$baseTemplates = array(
			1 => array(
				0 => array(
					"status" => 1,
					"subject" => "У вас новый заказ №{order_id}",
					"filename" => "new_admin",
				),
				'en' => array(
					"status" => 1,
					"subject" => "We've get your order #{order_id}",
					"filename" => "new_en",
				),
				'ru' => array(
					"status" => 1,
					"subject" => "Мы получили ваш заказ №{order_id}",
					"filename" => "new_ru",
				),
				'uk' => array(
					"status" => 1,
					"subject" => "Ми отримали ваш заказ №{order_id}",
					"filename" => "new_uk",
				),
			),
			2 => array(
				0 => array(
					"status" => 0,
					"subject" => "Заказ №{order_id} отправлен в обработку",
					"filename" => "process_admin",
				),
				'en' => array(
					"status" => 1,
					"subject" => "We've process your order #{order_id}",
					"filename" => "process_en",
				),
				'ru' => array(
					"status" => 1,
					"subject" => "Мы обрабатываем ваш заказ №{order_id}",
					"filename" => "process_ru",
				),
				'uk' => array(
					"status" => 1,
					"subject" => "Ми обробляємо ваше замовлення №{order_id}",
					"filename" => "process_uk",
				),
			),
			3 => array(
				0 => array(
					"status" => 0,
					"subject" => "Заказ №{order_id} отправлен Новой Почтой",
					"filename" => "novaposhta_admin",
				),
				'en' => array(
					"status" => 1,
					"subject" => "We've sent your order #{order_id} via Nova Poshta",
					"filename" => "novaposhta_en",
				),
				'ru' => array(
					"status" => 1,
					"subject" => "Мы отправили ваш заказ №{order_id} Новой Почтой",
					"filename" => "novaposhta_ru",
				),
				'uk' => array(
					"status" => 1,
					"subject" => "Ми вiдправили ваш заказ №{order_id} Новою Поштою",
					"filename" => "novaposhta_uk",
				),
			),
			4 => array(
				0 => array(
					"status" => 0,
					"subject" => "Заказ №{order_id} отправлен УкрПочтой",
					"filename" => "ukrposhta_admin",
				),
				'en' => array(
					"status" => 1,
					"subject" => "We've sent your order #{order_id} via UkrPoshta",
					"filename" => "ukrposhta_en",
				),
				'ru' => array(
					"status" => 1,
					"subject" => "Мы отправили ваш заказ №{order_id} УкрПочтой",
					"filename" => "ukrposhta_ru",
				),
				'uk' => array(
					"status" => 1,
					"subject" => "Ми вiдправили ваш заказ №{order_id} УкрПоштою",
					"filename" => "ukrposhta_uk",
				),
			),
			5 => array(
				0 => array(
					"status" => 0,
					"subject" => "Заказ №{order_id} отправлен курьером",
					"filename" => "courier_admin",
				),
				'en' => array(
					"status" => 1,
					"subject" => "We've sent your order #{order_id} via currier",
					"filename" => "courier_en",
				),
				'ru' => array(
					"status" => 1,
					"subject" => "Мы отправили ваш заказ №{order_id} курьером",
					"filename" => "courier_ru",
				),
				'uk' => array(
					"status" => 1,
					"subject" => "Ми вiдправили ваш заказ №{order_id} курьером",
					"filename" => "courier_uk",
				),
			),
			6 => array(
				0 => array(
					"status" => 0,
					"subject" => "Заказ №{order_id} готов к самовывозу",
					"filename" => "pickup_admin",
				),
				'en' => array(
					"status" => 1,
					"subject" => "We've prepared your order #{order_id} for pickuo",
					"filename" => "pickup_en",
				),
				'ru' => array(
					"status" => 1,
					"subject" => "Ваш заказ №{order_id} ожидает самовывоза",
					"filename" => "pickup_ru",
				),
				'uk' => array(
					"status" => 1,
					"subject" => "Ваш заказ №{order_id} очiкуе самовивiзу",
					"filename" => "pickup_uk",
				),
			),
			7 => array(
				0 => array(
					"status" => 0,
					"subject" => "Заказ №{order_id} завершен",
					"filename" => "complete_admin",
				),
				'en' => array(
					"status" => 1,
					"subject" => "We've complete your order #{order_id}",
					"filename" => "complete_en",
				),
				'ru' => array(
					"status" => 1,
					"subject" => "Ваш заказ №{order_id} завершен",
					"filename" => "complete_ru",
				),
				'uk' => array(
					"status" => 1,
					"subject" => "Ваш заказ №{order_id} виконаний",
					"filename" => "complete_uk",
				),
			),
		);

		$defaultTemplates = array();
		$empty = array(
			"status" => 0,
			"subject" => "",
			"filename" => "",
		);
		$this->load->model('localisation/order_status');
		$this->load->model('localisation/language');
		// Инициализируем структуру, чтобы были данные по всем языкам
		$orderStatuses = $this->model_localisation_order_status->getOrderStatuses();
		$languages = $this->model_localisation_language->getLanguages();
		foreach ($orderStatuses as $id => $status) {
			if (isset($baseTemplates[$status['order_status_id']])) {
				$defaultTemplates[$status['order_status_id']][0] = $baseTemplates[$status['order_status_id']][0];
				foreach ($languages as $language) {
					if (isset($baseTemplates[$status['order_status_id']][$language['code']])) {
						$defaultTemplates[$status['order_status_id']][$language['language_id']] = $baseTemplates[$status['order_status_id']][$language['code']];
					}
				}
			}else{
				$defaultTemplates[$status['order_status_id']][0] = $empty;
				foreach ($languages as $language) {
					$defaultTemplates[$status['order_status_id']][$language['language_id']] = $empty;
				}
			}
		}
		return $defaultTemplates;
	}

	public function getFields() {
		$result = array();
		$keys = array();

		$keys[] = 'product:start';
		$keys[] = 'product_url';
		$keys[] = 'product_id';
		$keys[] = 'product_image';
		$keys[] = 'product_name';
		$keys[] = 'product_model';
		$keys[] = 'product_quantity';
		$keys[] = 'product_price';
		$keys[] = 'product_price_gross';
		$keys[] = 'product_attribute';
		$keys[] = 'product_option';
		$keys[] = 'product_sku';
		$keys[] = 'product_upc';
		$keys[] = 'product_tax';
		$keys[] = 'product_total';
		$keys[] = 'product_total_gross';
		$keys[] = 'product:stop';

		$keys[] = 'voucher:start';
		$keys[] = 'voucher_description';
		$keys[] = 'voucher_amount';
		$keys[] = 'voucher:stop';

		$keys[] = 'tax:start';
		$keys[] = 'tax_title';
		$keys[] = 'tax_value';
		$keys[] = 'tax:stop';

		$keys[] = 'total:start';
		$keys[] = 'total_title';
		$keys[] = 'total_value';
		$keys[] = 'total:stop';

		$keys[] = 'firstname';
		$keys[] = 'lastname';
		$keys[] = 'order_date';
		$keys[] = 'order_id';
		$keys[] = 'date';
		$keys[] = 'payment';
		$keys[] = 'shipment';
		$keys[] = 'total';
		$keys[] = 'invoice_number';
		$keys[] = 'order_href';
		$keys[] = 'store_url';
		$keys[] = 'store_telephone';
		$keys[] = 'status_name';
		$keys[] = 'store_name';
		$keys[] = 'ip';
		$keys[] = 'comment';
		$keys[] = 'sub_total';
		$keys[] = 'shipping_cost';
		$keys[] = 'client_comment';
		$keys[] = 'email';
		$keys[] = 'telephone';
		$keys[] = 'logo_url';
		$keys[] = 'shipping_country';
		$keys[] = 'shipping_zone';
		$keys[] = 'shipping_city';
		$keys[] = 'shipping_postcode';
		$keys[] = 'shipping_address_1';
		$keys[] = 'shipping_address_2';
		$keys[] = 'first_referrer';
		$keys[] = 'last_referrer';

		foreach ($keys as $key) {
			$result[$key] = $this->language->get('field_desc_' . $key);
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
}
