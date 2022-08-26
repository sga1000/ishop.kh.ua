<?php

require_once(DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoExchange1c extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_exchange1c";
		$this->_logFile = $this->_sysModuleName . ".log";
		$this->debug = $this->config->get($this->_sysModuleName . "_debug") == 1;

		$this->params = array(
			"status" => 1,
			"debug" => 1,
			"sql_before" => "",
			"sql_after" => "",
			"username" => "",
			"password" => "",
			"ip_list" => "",
			"fill_parent_cats" => 0,
			"update_parent_cats" => 0,
			"price_name" => "",
			"product_status" => 1,
			"product_stock_status" => 1,
			"update_name" => 0,
			"update_description" => 0,
			"update_price" => 1,
            "update_price_installment" => 0,
			"update_currency_plus" => 0,
			"new_price_column" => "",
			"update_sku" => 0,
			"update_quantity" => 1,
			"create_attribute" => 0,
			"update_attribute" => 0,
			"update_categories" => 0,
			"update_images" => 1,
			"create_product" => 1,
			"lookup_product" => 0,
			"create_category" => 0,
			"category_status" => 0,
			"category_links" => "",
			"category_top_status" => 0,
			"category_update_name" => 0,
			"create_manufacturer" => 0,
			"create_option" => 0,
			"update_option" => 0,
			"update_option_images" => 0,
			"customer_phone" => 0,
			"order_status_notify" => 0,
			"order_date" => "",
			"order_currency" => "",
			"order_utf8" => 1,
			"order_utf8_bom" => 0,
			"order_status_override" => 0,
			"get_from_naclad" => 0,
			"final_order_status" => 2,
			"order_statuses" => array(1),
			"product_languages" => array(0),
			"category_languages" => array(0),
			"product_subtract" => 0,
			"product_fullname" => 0,
			"product_fulldescription" => 0,
			"product_export_model_to_sku" => 0,
			"use_warehouse" => 0,
			"main_warehouse" => "",
			"use_related_options" => 0,
			"ignore_attributes" => "ОписаниеФайла\nВидНоменклатуры\nТипНоменклатуры\nПолное наименование\nID Class365\nСЕО_УРЛ",
			"unit_field" => "",
			"unit_field_offer" => 0,
			"order_customer" => "",
			"code_field" => "upc",
			"seo_url_field" => "",
			"barcode_field" => "ean",
			"option_price" => 0,
			"order_shipping_links" => "",
			"order_payment_links" => "",
			"order_total_links" => "",
			"unit_links" => "",
			"currency_convertor" => "",
			"delete_zero_option" => 0,
			"disable_missing_tag" => "",
			"disable_missing" => array(),
			"enable_zip" => 0,
            "group_or_category" => 'group',
			"extra_comment" => 0,
			"price_special" => "",
			"option_type" => 0,
			"option_required" => 0,
			"option_by_box" => 0,
			"totals_positive" => 0,
			"option_quantity" => 1,
			"options_as_product" => 0,
			"attribute_routing" => "",
			"missing_quantity_is_zero" => 0,
			"delete_offers" => 0,
			"price_type" => array(array(
					'keyword' => '',
					'customer_group_id' => 0,
					'quantity' => 0,
					'priority' => 0
				)),
			"update_filter" => 0,
			"order_export_type" => 0,
			"final_list_order_statuses" => "",
			"model_in_id" => 0,
			"transaction_status" => 1,
			"extra_document_tag" => "",
			"extra_customer" => "",
			"extra_property" => "",
			"product_extra_property" => "",
			"extra_address" => "",
			"sync_missing_status" => "",
			"default_missing_status" => 2,
			"product_dimension" => 0,
			"category_forced" => 0,
			"category_forced_id" => 0,
			"attribute_group_prefix" => "",
			"forbidden_options" => "",
			"option_source" => 0,
			"multy_currency" => 0,
			"multy_currency_price" => 0,
			"currency_convertor_multy" => 0,
			"ignore_table_quantities" => 0,
			"update_option_product_filter" => 0,
			"option_product_filter" => "",
			"update_attribute_group" => 0,
			"update_attribute_product_sort" => 0,
			"order_status_marge_list" => "",
			"limit_orders" => 0,
			"order_manufacturer" => 0,
			"get_orders_from_1c" => 0,
			"special_group_id" => 1,
			"use_tree_delete" => 0,
			"update_related_products" => 0,
			"update_related_products_mode" => 0,
			"clear_system_cache" => 0,
			"clear_image_cache" => 0,
			"clear_neoseo_filter_cache" => 0,
			"update_date" => 0,
			"special_price_type" => array(array(
					'keyword' => '',
					'customer_group_id' => $this->config->get('config_customer_group_id'),
					'priority' => 0
				)),
			"use_fraction_quantity" => 0,
			"search_option_for_sku" => 0,
			"option_field_sku" => 'sku',
			"option_field_ean" => '',
			"option_sku_add_product_sku" => 0,
			"option_sku_symbol_add_product_sku" => '-',
			"set_auto_tag_order" => 0,
			"exclude_auto_tag_order" => array(),
			"use_filter" => array(0),
			"delete_special_price" => 1,
			"delete_discount_price" => 1,
			"zero_special_discount" => 1,
			"user_answer_for_moy_sklad" => 0,
			"import_orders_disable_curl" => 0,
			"import_orders_comment_field" => '',
			"exclude_warehouses" => '',
			"zero_quantity_missing_goods" => 0,
			"commerce_ml_version" => 2,
			"commerce_ml_version_order" => 2,
			"use_two_side_products_exchange" => 0,
			'counterparties_exchange' => 0,
			'counterparties_method' => 'phone',
			'counterparties_create_new' => 0,
			'counterparties_update_fio' => 0,
			'counterparties_new_group' => 0,
			'counterparties_import_address' => 0,
			'counterparties_fio_field' => 'ПолноеНаименование',
			'counterparties_phone_field' => 'Телефон',
			'counterparties_email_field' => 'Электронная почта',
			'import_external_orders' => 0,
			'external_orders_status' => 1,
			'wait_import_command' => 0,
			'extra_totals_property' => '',
			'field_for_1c_order_id' => '',
			'attribute_label' => '',
			'currency_convertor_multy_main_price' => '',
			'special_price_tag_date_start' => 'НачалоАкции',
			'special_price_tag_date_end' => 'ОкончаниеАкции',
			'export_order_special_price_tag' => '',
			'order_comment' => 'Передано в 1С',
			'decimal_separator' => 'dot',
			'use_options_special' => 0,
			'options_special_price' => '',
			'update_auto_filter' => 0,
			'warehouses_multistore' => '',
			'counterparties_custom_field' => '',
			'update_auto_neoseo_filter_warehouse' => 0,
			'export_product_field_attr' => '',
			'attribute_file_name' => '',
			'attribute_routing_download_files' => '',
			'delete_by_mark' => 0,
			'categories_reset_quantity' => array(),
			'description_column' => 'description',
			'update_price_special_option' => 0,
			'skip_without_id' => 0,
			'product_kit_status' => 0,
			'product_kit_field' => 'model',
			'product_kit_tag' => 'КодыКомплектаТовара',
			'option_discount_price_type' => array(array(
					'keyword' => '',
					'customer_group_id' => $this->config->get('config_customer_group_id'),
					'priority' => 0
				)),
			'save_forbidden_options' => 0,
			'attribute_links' => '',
			'product_for_option_discount_price' => 0,
			'update_only_main_product_category' => 0,
			'export_discount_as_element' => 0,
			"order_category" => 0,
			"add_manufacturer_to_attribute" => 0,
			"alternative_manufacturer_tag" => '',
			'tax_list' => 0,
			'no_address' => 0,
			'options_in_product' => 0,
        );
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		// Недостающие таблицы
		$this->installTables();

		// Недостающие права
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'tool/neoseo_exchange1c');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'tool/neoseo_exchange1c');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'catalog/neoseo_warehouse');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'catalog/neoseo_warehouse');

		return TRUE;
	}

	public function isOptionsHasSpecial()
	{
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "product_option_value` LIKE 'special';";
		$query = $this->db->query($sql);
		if ($query->num_rows) {
			return true;
		}
		return false;
	}

	protected function installTables()
	{
		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'product_to_1c` (
				`product_id` int(11) NOT NULL,
				`1c_id` varchar(255) NOT NULL,
				KEY (`product_id`),
				KEY `1c_id` (`1c_id`)
            ) DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'category_to_1c` (
				`category_id` int(11) NOT NULL,
				`1c_id` varchar(255) NOT NULL,
				KEY (`category_id`),
				KEY `1c_id` (`1c_id`)
            ) ENGINE=MyISAM DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'order_to_1c` (
				`order_id` int(11) NOT NULL,
				`1c_id` varchar(255) NOT NULL,
				KEY (`order_id`),
				KEY `1c_id` (`1c_id`)
            ) DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'warehouse` (
				`warehouse_id` int(11) NOT NULL AUTO_INCREMENT,
				`name` varchar(255) NOT NULL,
				`1c_id` varchar(255) NOT NULL,
				`sort_order` int(11) NOT NULL DEFAULT "1",
				PRIMARY KEY (`warehouse_id`),
				KEY `1c_id` (`1c_id`),
				KEY `sort_order` (`sort_order`)
            ) DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'warehouse_to_store` (
				`warehouse_id` int(11),
				`store_id` int(11),
				KEY `warehouse_id` (`warehouse_id`),
				KEY `store_id` (`store_id`)
            ) DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'warehouse_description` (
				`warehouse_id` int(11) NOT NULL,
				`language_id` int(11) NOT NULL,
				`param1` varchar(255) NOT NULL,
				`param2` varchar(255) NOT NULL,
				`param3` varchar(255) NOT NULL,
				`param4` varchar(255) NOT NULL,
				`param5` varchar(255) NOT NULL,
				KEY (`warehouse_id`)
            ) DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'product_warehouse` (
				`product_warehouse_id` int(11) NOT NULL AUTO_INCREMENT,
				`product_id` int(11) NOT NULL,
				`warehouse_id` int(11) NOT NULL,
				`quantity` varchar(255) NOT NULL,
				PRIMARY KEY (`product_warehouse_id`),
				KEY `product_id` (`product_id`),
				KEY `warehouse_id` (`warehouse_id`)
            ) DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'order_warehouse` (
				`order_warehouse_id` int(11) NOT NULL AUTO_INCREMENT,
				`order_id` int(11) NOT NULL,
				`order_product_id` int(11) NOT NULL,
				`warehouse_id` int(11) NOT NULL,
				PRIMARY KEY (`order_warehouse_id`)			
			) DEFAULT CHARSET=utf8;'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'order_warehouse` (
				`order_warehouse_id` int(11) NOT NULL,
				`order_id` int(11) NOT NULL,
				`order_product_id` int(11) NOT NULL,
				`warehouse_id` int(11) NOT NULL
			) DEFAULT CHARSET=utf8;'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'product_option_warehouse` (
				`product_warehouse_id` int(11) NOT NULL AUTO_INCREMENT,
				`product_id` int(11) NOT NULL,
				`product_option_value_id` int(11) NOT NULL,
				`warehouse_id` int(11) NOT NULL,
				`quantity` varchar(255) NOT NULL,
				PRIMARY KEY (`product_warehouse_id`),
				KEY `product_option_value_id` (`product_option_value_id`),
				KEY `warehouse_id` (`warehouse_id`)
            ) DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'product_related_option_warehouse` (
				`product_warehouse_id` int(11) NOT NULL AUTO_INCREMENT,
				`product_id` int(11) NOT NULL,
				`related_option_id` int(11) NOT NULL,
				`warehouse_id` int(11) NOT NULL,
				`quantity` varchar(255) NOT NULL,
				PRIMARY KEY (`product_warehouse_id`),
				KEY `product_option_id` (`product_id`,`related_option_id`),
				KEY `warehouse_id` (`warehouse_id`)
            ) DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'product_option_to_1c` (
				`product_id` int(11) NOT NULL,
				`product_option_value_id` int(11) NOT NULL,
				`related_option_id` int(11) NOT NULL,
				`1c_id` varchar(255) NOT NULL,
				KEY `product_to_option` (`product_id`,`product_option_value_id`),
				KEY `product_to_related_option` (`product_id`,`related_option_id`)
            ) DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'property_1c` (
				`property_id` varchar(255) NOT NULL,
				`name` varchar(255) NOT NULL,
				PRIMARY KEY (`property_id`),
				KEY `name` (`name`)
            ) DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'property_value_1c` (
				`property_value_id` varchar(255) NOT NULL,
				`property_id` varchar(255) NOT NULL,
				`value` varchar(255) NOT NULL,
				KEY `property_value_id` (`property_value_id`),
				KEY `property_id` (`property_id`),
				KEY `value` (`value`)
            ) DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'prices_to_1c` (
				`price_name` varchar(255) NOT NULL,
				`1c_id` varchar(255) NOT NULL,
				KEY (`price_name`),
				KEY `1c_id` (`1c_id`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'customer_to_1c` (
				`customer_id` int(11) NOT NULL,
				`1c_id` varchar(255) NOT NULL,
				KEY (`customer_id`),
				KEY `1c_id` (`1c_id`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'option_1c` (
				`option_id` varchar(255) NOT NULL,
				`name` varchar(255) NOT NULL,
				PRIMARY KEY (`option_id`),
				KEY `name` (`name`)
            ) DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'option_value_1c` (
				`option_value_id` varchar(255) NOT NULL,
				`option_id` varchar(255) NOT NULL,
				`value` varchar(255) NOT NULL,
				KEY `option_value_id` (`option_value_id`),
				KEY `option_id` (`option_id`),
				KEY `value` (`value`)
            ) DEFAULT CHARSET=utf8'
		);

		$this->db->query(
				'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'product_kit_1c` (
				`product_kit_1c_id` int(11) NOT NULL AUTO_INCREMENT,
				`product_id` int(11) NOT NULL,
				`product_code` varchar(255) NOT NULL,
				PRIMARY KEY (`product_kit_1c_id`)
            ) DEFAULT CHARSET=utf8'
		);

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "customer` LIKE 'updated';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "customer` ADD COLUMN updated INT(11) NOT NULL DEFAULT 1, ADD INDEX (`updated`);";
			$this->db->query($sql);
		}
	}

	public function upgrade()
	{
		// Недостающие значения параметров
		$this->initParams($this->params);

		$this->installTables();

		// category_to_1c.1c_category_id => 1c_id
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "category_to_1c` LIKE '1c_category_id'";
		$query = $this->db->query($sql);
		if ($query->num_rows) {
			$sql = "ALTER TABLE " . DB_PREFIX . "category_to_1c CHANGE `1c_category_id` `1c_id` VARCHAR(64)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "category_to_1c` LIKE '1c_id';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "category_to_1c` ADD COLUMN 1c_id varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "product_to_1c` LIKE '1c_id';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "product_to_1c` ADD COLUMN 1c_id varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "order_to_1c` LIKE '1c_id';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "order_to_1c` ADD COLUMN 1c_id varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "warehouse` LIKE '1c_id';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "warehouse` ADD COLUMN 1c_id varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "warehouse` LIKE 'sort_order';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "warehouse` ADD `sort_order` INT NOT NULL DEFAULT '1' AFTER `1c_id`";
			$this->db->query($sql);
			$sql = "ALTER TABLE `" . DB_PREFIX . "warehouse` ADD INDEX(`sort_order`);";
			$this->db->query($sql);
		}

		$hasNewIndex = false;
		$sql = "SHOW INDEX FROM `" . DB_PREFIX . "category_to_1c`";
		$query = $this->db->query($sql);
		foreach ($query->rows as $row) {
			if ($row['Key_name'] == '1c_id') {
				$hasNewIndex = true;
			}
			if ($row['Key_name'] == '1c_category_id') {
				$sql = "ALTER TABLE " . DB_PREFIX . "category_to_1c DROP INDEX 1c_category_id";
				$this->db->query($sql);
			}
		}
		if (!$hasNewIndex) {
			$sql = "ALTER TABLE " . DB_PREFIX . "category_to_1c ADD INDEX  `1c_id` (  `1c_id` )";
			$this->db->query($sql);
		}
	}

	public function uninstall()
	{
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "customer` DROP `updated`;");
		return TRUE;
	}

}

?>