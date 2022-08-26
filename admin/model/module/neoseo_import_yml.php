<?php

require_once(DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoImportYml extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName="neoseo_import_yml";
		$this->_logFile=$this->_moduleSysName . '.log';
		$this->debug=$this->config->get($this->_moduleSysName . '_status') == 1;
		$this->language->load('module/' . $this->_moduleSysName);
		$this->params=array(
			'status'=>1,
			'debug'=>0,
			'sql_before' => '',
			'sql_after' => '',
		);
	}

	public function installTables()
	{

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "product_import` (
			`import_id` int(11) NOT NULL AUTO_INCREMENT, 
			`import_name` varchar(255) NOT NULL,
			`import_status` int(1) DEFAULT 0, 
			`import_url` varchar(255) NOT NULL, 
			`import_params`text NOT NULL,
			PRIMARY KEY (`import_id`)
			)  CHARACTER SET utf8 COLLATE utf8_general_ci;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "product_import_available` (
			`import_id` int(11) NOT NULL, 
			`product_id` int(11) NOT NULL,
			KEY `import_id` (`import_id`),
			KEY `product_id` (`product_id`)
		)  CHARACTER SET utf8 COLLATE utf8_general_ci;");
	}

	public function install()
	{
		$this->initParams($this->params);
		$this->installTables();
		return TRUE;
	}

	public function upgrade()
	{
		$this->initParams($this->params);
		$this->installTables();

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "product_import` LIKE 'import_ftp_server';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "product_import` ADD COLUMN `import_ftp_server` varchar(255) NOT NULL;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "product_import` LIKE 'import_ftp_login';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "product_import` ADD COLUMN `import_ftp_login` varchar(255) NOT NULL;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "product_import` LIKE 'import_ftp_password';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "product_import` ADD COLUMN `import_ftp_password` varchar(255) NOT NULL;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "product_import` LIKE 'import_ftp_path';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "product_import` ADD COLUMN `import_ftp_path` varchar(255) NOT NULL;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "product_import` LIKE 'import_params';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "product_import` ADD COLUMN `import_params` text;";
			$this->db->query($sql);
		}

		return TRUE;
	}

	public function uninstall()
	{
		$this->db->query("DELETE FROM `" . DB_PREFIX . "setting` WHERE `code` = '" . $this->_moduleSysName . "'");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "product_import`");
		return TRUE;
	}

}

?>