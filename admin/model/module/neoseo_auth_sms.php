<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoAuthSms extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_auth_sms';
		$this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;

		//В зависимости от статуса модуля neoseo_sms_notify определим статус данного модуля
		if ($this->config->get('neoseo_sms_notify_status') == 1){
			$status = 1;
		}else{
			$status = 0;
		}

		$this->params = array(
			'status' => $status,
			'debug' => 0,
			'sms_length' => 4,
			'password_lifetime' => 5,
			'times_before_ban' => 5,
			'ban_time' => 24,
			'captcha' => '',
			'mask' => '+38 (099) 999-99-99',
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		// Создаем новые и недостающие таблицы в актуальной структуре
		$this->installTables();

		return TRUE;
	}

	public function installTables(){
		// Добавляем поле date_modified в таблицу customer
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "customer` LIKE 'date_modified'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "customer`  ADD `date_modified` datetime NOT NULL";
			$this->db->query($sql);
		}
		// Добавляем поле salt в таблицу customer_login
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "customer_login` LIKE 'salt'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "customer_login`  ADD `salt` varchar(255) NOT NULL";
			$this->db->query($sql);
		}
		// Добавляем поле password в таблицу customer_login
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "customer_login` LIKE 'password'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "customer_login`  ADD `password` varchar(255) NOT NULL";
			$this->db->query($sql);
		}
	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);

		// Создаем недостающие таблицы в актуальной структуре
		$this->installTables();

	}

	public function uninstall()
	{
		// Удаляем поле date_modified из таблицы customer
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "customer` LIKE 'date_modified'";
		$query = $this->db->query($sql);
		if( $query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "customer`  DROP `date_modified`";
			$this->db->query($sql);
		}

		// Удаляем поле salt из таблицы customer_login
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "customer_login` LIKE 'salt'";
		$query = $this->db->query($sql);
		if( $query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "customer_login`  DROP `salt`";
			$this->db->query($sql);
		}

		// Удаляем поле password из таблицы customer_login
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "customer_login` LIKE 'password'";
		$query = $this->db->query($sql);
		if( $query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "customer_login`  DROP `password`";
			$this->db->query($sql);
		}

		return TRUE;
	}

}

