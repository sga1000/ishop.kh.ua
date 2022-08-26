<?php
require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoseoProductBundlesModule extends NeoSeoModel {

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_product_bundles';
		$this->_modulePostfix = "_module";
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;
	}

	// Install/Uninstall
	public function installTables()
	{
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "product_bundles_p2b` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(10) NOT NULL,
  `bundle_id` int(10) NOT NULL,
  `options` TEXT NOT NULL,
   PRIMARY KEY (`id`),
   KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "product_bundles_p2p_name` (
  `bundle_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` tinyint(2) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
   PRIMARY KEY (`bundle_id`),
   KEY `sort_order` (`sort_order`),
   KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "product_bundles_p2p` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bundle_id` int(10) NOT NULL,
  `product_id` int(11) NOT NULL,
  `row_id` int(11) NOT NULL,
  `special` decimal(15,4) NOT NULL,
  `sort` int(1) NOT NULL DEFAULT '0',
  `options` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bundle_id` (`bundle_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;");

		// Добавляем недостающие столбцы к корзине
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "cart` LIKE 'bundle_id'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "cart` ADD `bundle_id` INT NOT NULL DEFAULT '0' AFTER `quantity`;");
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "cart` LIKE 'bundle_action_id'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "cart` ADD `bundle_action_id` INT NOT NULL DEFAULT '0' AFTER `quantity`;");
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "order_product` LIKE 'bundle_id'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "order_product` ADD `bundle_id` INT NOT NULL DEFAULT '0' AFTER `reward`;");
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "order_product` LIKE 'bundle_action_id'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "order_product` ADD `bundle_action_id` INT NOT NULL DEFAULT '0' AFTER `reward`;");
		}

	}

	public function install()
	{
		$this->load->model('user/user_group');
		$this->addPermission($this->user->getGroupId(), 'access', 'catalog/' . $this->_moduleSysName);
		$this->addPermission($this->user->getGroupId(), 'modify', 'catalog/' . $this->_moduleSysName);

		$this->installTables();
	}

	public function uninstall()
	{
		$this->db->query("DROP TABLE `" . DB_PREFIX . "product_bundles_p2b`");
		$this->db->query("DROP TABLE `" . DB_PREFIX . "product_bundles_p2p_name`");
		$this->db->query("DROP TABLE `" . DB_PREFIX . "product_bundles_p2p`");

		// Удаляем лишние столбцы из корзины
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "cart` LIKE 'bundle_id'";
		$query = $this->db->query($sql);
		if( $query->num_rows ) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "cart`  DROP `bundle_id`");
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "cart` LIKE 'bundle_action_id'";
		$query = $this->db->query($sql);
		if( $query->num_rows ) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "cart`  DROP `bundle_action_id`");
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "order_product` LIKE 'bundle_id'";
		$query = $this->db->query($sql);
		if( $query->num_rows ) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "order_product`  DROP `bundle_id`");
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "order_product` LIKE 'bundle_action_id'";
		$query = $this->db->query($sql);
		if( $query->num_rows ) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "order_product`  DROP `bundle_action_id`");
		}

		$this->load->model('user/user_group');
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'access', 'catalog/' . $this->_moduleSysName);
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'modify', 'catalog/' . $this->_moduleSysName);
		return true;
	}
	public function upgrade()
	{
		$this->installTables();
	}

}
