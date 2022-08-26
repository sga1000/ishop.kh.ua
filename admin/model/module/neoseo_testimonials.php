<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoTestimonials extends NeoSeoModel {

	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_testimonials';
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	// Install/Uninstall
	public function install($store_id) {
		$params = array(
			$this->_moduleSysName . '_status' => 1,
			$this->_moduleSysName . '_debug' => 0,
			$this->_moduleSysName . '_view' => 0,
		);
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('neoseo_testimonials', $params);

		$sql  = "CREATE TABLE IF NOT EXISTS `".DB_PREFIX."testimonials` ( ";
		$sql .= "`testimonial_id` int(11) NOT NULL AUTO_INCREMENT, ";
		$sql .= "`name` varchar(64) COLLATE utf8_bin NOT NULL, ";
		$sql .= "`description` text COLLATE utf8_unicode_ci NOT NULL, ";
		$sql .= "`admin_text` text COLLATE utf8_unicode_ci NOT NULL, ";
		$sql .= "`status` int(1) NOT NULL DEFAULT '0', ";
		$sql .= "`rating` int(1) NOT NULL DEFAULT '0', ";
		$sql .= "`youtube` varchar(100) COLLATE utf8_bin , ";
		$sql .= "`user_image` varchar(100) COLLATE utf8_bin , ";
		$sql .= "`date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00', ";
		$sql .= "`date_admin_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00', ";
		$sql .= "`store_id` int(1) NOT NULL DEFAULT '0', ";
		$sql .= "PRIMARY KEY (`testimonial_id`) ";
		$sql .= ") DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;";
		$this->db->query($sql);


		// Схемы
		$sql = "INSERT INTO `".DB_PREFIX."layout` (`name`) VALUES('neoseo_testimonials');";
		$this->db->query($sql);
		$layout_id = $this->db->getLastId();

		$sql = "INSERT INTO `".DB_PREFIX."layout_route` (`layout_id`, `store_id`, `route`) VALUES ($layout_id, 0, 'information/neoseo_testimonials');";
		$this->db->query($sql);

		// ЧПУ
		$sql = "SHOW COLUMNS FROM " . DB_PREFIX . "url_alias like 'seo_mod'";
		$query = $this->db->query($sql);
		if ( $query->num_rows > 0 ) {
			$sql = array();
			$sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('information/neoseo_testimonials', 'testimonials', 1);";
			$sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('information/neoseo_testimonials/insert', 'testimonials-insert', 1);";
			$sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('information/neoseo_testimonials/success', 'testimonials-insert-success', 1);";
			foreach ($sql as $_sql) {
				$this->db->query($_sql);
			}
			$this->cache->delete('seo_pro');
			$this->cache->delete('seo_url');
		}

		// Пермишены
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'information/neoseo_testimonials');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'information/neoseo_testimonials');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'catalog/neoseo_testimonials');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'catalog/neoseo_testimonials');

		return TRUE;
	}

	public function uninstall() {

		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."testimonials`;";
		$this->db->query($sql);

		$sql = "DELETE FROM `".DB_PREFIX."layout` WHERE `name`='neoseo_testimonials';";
		$this->db->query($sql);

		$sql = "DELETE FROM `".DB_PREFIX."layout_route` WHERE `route`='information/neoseo_testimonials';";
		$this->db->query($sql);

		$sql = array();
		$sql[] = "DELETE FROM `" . DB_PREFIX . "url_alias` WHERE query='information/neoseo_testimonials';";
		$sql[] = "DELETE FROM `" . DB_PREFIX . "url_alias` WHERE query='information/neoseo_testimonials/insert';";
		$sql[] = "DELETE FROM `" . DB_PREFIX . "url_alias` WHERE query='information/neoseo_testimonials/success';";
		foreach ($sql as $_sql) {
			$this->db->query($_sql);
		}
		$this->cache->delete('seo_pro');
		$this->cache->delete('seo_url');

		return TRUE;
	}

	public function upgrade() {

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "testimonials` LIKE 'admin_text'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "testimonials` ADD `admin_text` VARCHAR(255)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "testimonials` LIKE 'youtube'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "testimonials` ADD `youtube` VARCHAR(255)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "testimonials` LIKE 'user_image'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "testimonials` ADD `user_image` VARCHAR(255)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "testimonials` LIKE 'store_id'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "testimonials` ADD `store_id` INT(1) NOT NULL DEFAULT '0'";
			$this->db->query($sql);
		}
	}

}
