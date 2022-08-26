<?php
require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoMenu extends NeoSeoModel {

	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_menu";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
	}

	public function install()
	{
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'module/neoseo_menu');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'module/neoseo_menu');

		$this->initParamsDefaults(array(
			'status' => 1,
			'debug' => 0,
			'type' => 0,
		));

		$this->installTables();

	}

	public function installTables() {
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "neoseo_menu` (
			`menu_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
			`status` int(11) NOT NULL DEFAULT '0',
			`title` varchar(64) NOT NULL
        ) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "neoseo_menu_items` (
			`item_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
			`id` int(11) NOT NULL,
			`menu_id` int(11) NOT NULL,
			`type` varchar(255) NOT NULL,
			`type_id` int(11) NOT NULL,
			`parent_id` int(11) NOT NULL,
			`params` varchar(255) NOT NULL,
			`class` VARCHAR(255) NOT NULL,
			`style` VARCHAR(255) NOT NULL,
			`icon` VARCHAR(255) NOT NULL,
			`image` VARCHAR(255) NOT NULL,
			`image_width` VARCHAR(255) NOT NULL,
			`image_height` VARCHAR(255) NOT NULL,
			`max_width` VARCHAR(255) NOT NULL,
			`bg_color` VARCHAR(255) NOT NULL,
			`image_position` VARCHAR(255) NOT NULL,
			`hover_bg_color` VARCHAR(255) NOT NULL,
			`font_color` VARCHAR(255) NOT NULL,
			`hover_font_color` VARCHAR(255) NOT NULL,
			`infoblock_status` int(11) NOT NULL DEFAULT '0',
            `infoblock_image` varchar(255) DEFAULT NULL,
            `infoblock_show_by_button` int(11) DEFAULT NULL,
            `infoblock_product_id` int(11) DEFAULT NULL,
            `infoblock_main_class` varchar(255) DEFAULT NULL,
            `infoblock_position` varchar(255) DEFAULT NULL,
            `infoblock_image_width` int(11) DEFAULT NULL,
            `infoblock_image_height` int(11) DEFAULT NULL
		) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "neoseo_menu_items_description` (
			`id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
			`item_id` int(11) NOT NULL,
			`menu_id` int(11) NOT NULL,
			`title` varchar(255) NOT NULL,
			`url` varchar(255) NOT NULL,
			`language_id` int(11) NOT NULL,
			`infoblock_title` VARCHAR(255) DEFAULT NULL,
			`infoblock_link` VARCHAR(255) DEFAULT NULL
        ) DEFAULT CHARSET=utf8;");
	}

	public function uninstall() {

	}

	public function upgrade(){
		$this->installTables();

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items` LIKE 'class';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `class` VARCHAR(255) NOT NULL  AFTER `params`;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items` LIKE 'style';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `style` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items` LIKE 'icon';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `icon` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items` LIKE 'image';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `image` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items` LIKE 'image_width';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `image_width` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items` LIKE 'image_height';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `image_height` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items` LIKE 'max_width'";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `max_width` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items` LIKE 'bg_color';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `bg_color` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items` LIKE 'hover_bg_color';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `hover_bg_color` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items` LIKE 'font_color';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `font_color` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items` LIKE 'hover_font_color';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `hover_font_color` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items` LIKE 'image_position';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `image_position` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items` LIKE 'infoblock_status';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `infoblock_status` int(11) NOT NULL DEFAULT '0';";
			$this->db->query($sql);
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `infoblock_image` varchar(255) DEFAULT NULL;";
			$this->db->query($sql);
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `infoblock_show_by_button` int(11) DEFAULT NULL;";
			$this->db->query($sql);
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `infoblock_product_id` int(11) DEFAULT NULL;";
			$this->db->query($sql);
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `infoblock_main_class` varchar(255) DEFAULT NULL;";
			$this->db->query($sql);
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `infoblock_position` varchar(255) DEFAULT NULL;";
			$this->db->query($sql);
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `infoblock_image_width` int(11) DEFAULT NULL;";
			$this->db->query($sql);
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items`  ADD COLUMN `infoblock_image_height` int(11) DEFAULT NULL;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_menu_items_description` LIKE 'infoblock_title';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items_description`  ADD COLUMN `infoblock_title` VARCHAR(255) DEFAULT NULL;";
			$this->db->query($sql);

			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_menu_items_description`  ADD COLUMN `infoblock_link` VARCHAR(255) DEFAULT NULL;";
			$this->db->query($sql);
		}
	}

	public function getMenus($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "neoseo_menu";

			$sort_data = array(
				'md.title'
			);

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];
			} else {
				$sql .= " ORDER BY title";
			}

			if (isset($data['order']) && ($data['order'] == 'DESC')) {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}

			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}

				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}

			$query = $this->db->query($sql);

			return $query->rows;
		} else {
			$sql = "SELECT * FROM " . DB_PREFIX . "neoseo_menu";
			$query = $this->db->query($sql);
			return $query->rows;
		}
	}

	public function getMenuParams($menu_id) {
		if ($menu_id) {
			$sql = "SELECT * FROM " . DB_PREFIX . "neoseo_menu WHERE menu_id = '".(int)$menu_id."'";
			$query = $this->db->query($sql);
			if ($query->row) {
				return $query->row;
			}
		}
	}

	public function getMenu($menu_id, $parent_id="") {
		$sql = "SELECT DISTINCT * FROM " . DB_PREFIX . "neoseo_menu_items 
                WHERE menu_id = '" . (int)$menu_id . "'";
		if ($parent_id) {
			$sql .= " AND parent_id = '". (int)$parent_id."'";
		} else if ($parent_id === 0) {
			$sql .= " AND parent_id = 0";
		}
		$sql .= " ORDER BY id";
		$query = $this->db->query($sql);
		if ($query->rows) {
			$data = array();
			foreach ($query->rows as $menu) {
				$description = array();
				$description = $this->getMenuDescriptions($menu['item_id']);

				$child = $this->getMenu($menu_id,$menu['id']);

				if ($child) {
					$childmenu = $child;
				} else {
					$childmenu = "";
				}

				if ($menu['icon'] && is_file(DIR_IMAGE . $menu['icon'])) {
					$thumb = $this->model_tool_image->resize($menu['icon'], 24, 24);
				} else {
					$thumb = $this->model_tool_image->resize('no_image.png', 24, 24);
				}

				if ($menu['image'] && is_file(DIR_IMAGE . $menu['image'])) {
					$main_image = $this->model_tool_image->resize($menu['image'], 100, 100);
				} else {
					$main_image = $this->model_tool_image->resize('no_image.png', 100, 100);
				}

				if ($menu['infoblock_image'] && is_file(DIR_IMAGE . $menu['infoblock_image'])) {
					$infoblock_image = $this->model_tool_image->resize($menu['infoblock_image'], 100, 100);
				} else {
					$infoblock_image = $this->model_tool_image->resize('no_image.png', 100, 100);
				}

				$product_name = "";
				if($menu['infoblock_product_id'] > 0){
					$product= $this->model_catalog_product->getproduct($menu['infoblock_product_id']);
					$product_name = $product['name'];
				}

				$data[] = array(
					'item_id' => $menu['item_id'],
					'id' => $menu['id'],
					'title' => $description['title'],
					'url' => $description['url'],
					'type' => $menu['type'],
					'type_id' =>$menu['type_id'],
					'parent_id' => $menu['parent_id'],
					'params' => $menu['params'],
					'class' => $menu['class'],
					'style' => $menu['style'],
					'max_width' => $menu['max_width'],
					'icon' => $menu['icon'],
					'image' => $menu['image'],
					'main_image' => $main_image,
					'image_width' => $menu['image_width'],
					'image_height' => $menu['image_height'],
					'thumb' => $thumb,
					'bg_color' => $menu['bg_color'],
					'hover_bg_color' => $menu['hover_bg_color'],
					'font_color' => $menu['font_color'],
					'hover_font_color' => $menu['hover_font_color'],
					'image_position' => $menu['image_position'],
					'child' => $childmenu,
					'infoblock_link' => $description['infoblock_link'],
					'infoblock_title' => $description['infoblock_title'],
					'infoblock_status' => $menu['infoblock_status'],
					'infoblock_image' => $menu['infoblock_image'],
					'infoblock_image_pic' => $infoblock_image,
					'infoblock_show_by_button' => $menu['infoblock_show_by_button'],
					'infoblock_product_id' => $menu['infoblock_product_id'],
					'infoblock_main_class' => $menu['infoblock_main_class'],
					'infoblock_position' => $menu['infoblock_position'],
					'infoblock_image_width' => $menu['infoblock_image_width'],
					'infoblock_image_height' => $menu['infoblock_image_height'],
					'infoblock_product_name' => $product_name,
				);
			}
			return $data;
		}

	}

	public function getTotalMenus() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "neoseo_menu");
		return $query->row['total'];
	}


	public function insertMenu($data){

		$this->db->query("INSERT INTO " . DB_PREFIX . "neoseo_menu SET title = '" . $this->db->escape($data['menu_title']) . "', status = '" . (int)($data['menu_status']) . "'");
		$menu_id = $this->db->getLastId();
		foreach ($data['menus'] as $menu) {
			$image = isset($menu['image']) ? $menu['image'] : '';
			$image_width = isset($menu['image_width']) ? $menu['image_width'] : '';
			$image_height = isset($menu['image_height']) ? $menu['image_height'] : '';

			$this->db->query("INSERT INTO " . DB_PREFIX . "neoseo_menu_items SET id = '" . (int)$menu['id'] . "', menu_id = '" .(int)$menu_id. "', type = '" . $this->db->escape($menu['type']) . "', type_id = '" . (int)$menu['type_id'] . "', max_width = '" . $this->db->escape($menu['max_width']) . "', hover_font_color = '" . $this->db->escape($menu['hover_font_color']) . "', font_color = '" . $this->db->escape($menu['font_color']) . "', hover_bg_color = '" . $this->db->escape($menu['hover_bg_color']) . "', image_position = '" . $this->db->escape($menu['image_position']) . "', bg_color = '" . $this->db->escape($menu['bg_color']) . "', icon = '" . $this->db->escape($menu['icon']) . "', image = '" . $this->db->escape($image) . "', image_width = '" . $this->db->escape($image_width) . "', image_height = '" . $this->db->escape($image_height) . "', class = '" . $this->db->escape($menu['class']) . "', style = '" . $this->db->escape($menu['style']) . "', params = '" . $this->db->escape($menu['params']) . "', parent_id = '" . (int)$menu['parent_id'] . "'".
			", `infoblock_status` = '".$menu['infoblock_status']."', `infoblock_image` = '".$menu['infoblock_image']."', `infoblock_show_by_button` = '".$menu['infoblock_show_by_button']."', `infoblock_product_id` = '".$menu['infoblock_product_id']."', `infoblock_main_class` = '".$menu['infoblock_main_class']."', `infoblock_position` = '".$menu['infoblock_position']."', `infoblock_image_width` = '".$menu['infoblock_image_width']."', `infoblock_image_height` = '".$menu['infoblock_image_height']."'"
			);
			$item_id = $this->db->getLastId();

			foreach ($menu['title'] as $language_id => $title) {
				$menu_description[$language_id]['title'] = $title;
			}
			foreach ($menu['url'] as $language_id => $url) {
				$menu_description[$language_id]['url'] = $url;
			}
			foreach ($menu['infoblock_link'] as $language_id => $url) {
				$menu_description[$language_id]['infoblock_link'] = $url;
			}
			foreach ($menu['infoblock_title'] as $language_id => $title) {
				$menu_description[$language_id]['infoblock_title'] = $title;
			}
			foreach ($menu_description as $language_id => $description) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "neoseo_menu_items_description SET item_id = '" . (int)$item_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($description['title']) . "', url = '" . $this->db->escape($description['url']) . "', menu_id = '" . (int)$menu_id . "'"
				.",`infoblock_link` = '" . $this->db->escape($description['infoblock_link']) . "' , `infoblock_title` = '" . $this->db->escape($description['infoblock_title']) . "'"
				);
			}
			// todo:позже 3 массива в 1 всунуть

		}
		return $menu_id;
	}

	public function editMenu($menu_id, $data){
		$this->db->query("UPDATE " . DB_PREFIX . "neoseo_menu SET title = '" . $this->db->escape($data['menu_title']) . "', status = '" . (int)($data['menu_status']) . "' WHERE menu_id = '" . (int)$menu_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "neoseo_menu_items WHERE menu_id = '" . (int)$menu_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "neoseo_menu_items_description WHERE menu_id = '" . (int)$menu_id . "'");

		foreach ($data['menus'] as $menu) {
			$image = isset($menu['image']) ? $menu['image'] : '';
			$image_width = isset($menu['image_width']) ? $menu['image_width'] : '';
			$image_height = isset($menu['image_height']) ? $menu['image_height'] : '';

			$this->db->query("INSERT INTO " . DB_PREFIX . "neoseo_menu_items SET id = '" . (int)$menu['id'] . "', menu_id = '" .(int)$menu_id. "', type = '" . $this->db->escape($menu['type']) . "', type_id = '" . (int)$menu['type_id'] . "', max_width = '" . $this->db->escape($menu['max_width']) . "', hover_font_color = '" . $this->db->escape($menu['hover_font_color']) . "', font_color = '" . $this->db->escape($menu['font_color']) . "', hover_bg_color = '" . $this->db->escape($menu['hover_bg_color']) . "', image_position = '" . $this->db->escape($menu['image_position']) . "', bg_color = '" . $this->db->escape($menu['bg_color']) . "', icon = '" . $this->db->escape($menu['icon']) . "', image = '" . $this->db->escape($image) . "', image_width = '" . $this->db->escape($image_width) . "', image_height = '" . $this->db->escape($image_height) . "', class = '" . $this->db->escape($menu['class']) . "', style = '" . $this->db->escape($menu['style']) . "', params = '" . $this->db->escape($menu['params']) . "', parent_id = '" . (int)$menu['parent_id'] . "'".
				", `infoblock_status` = '".$menu['infoblock_status']."', `infoblock_image` = '".$menu['infoblock_image']."', `infoblock_show_by_button` = '".$menu['infoblock_show_by_button']."', `infoblock_product_id` = '".$menu['infoblock_product_id']."', `infoblock_main_class` = '".$menu['infoblock_main_class']."', `infoblock_position` = '".$menu['infoblock_position']."', `infoblock_image_width` = '".$menu['infoblock_image_width']."', `infoblock_image_height` = '".$menu['infoblock_image_height']."'"
			);			$item_id = $this->db->getLastId();

			foreach ($menu['title'] as $language_id => $title) {
				$menu_description[$language_id]['title'] = $title;
			}
			foreach ($menu['url'] as $language_id => $url) {
				$menu_description[$language_id]['url'] = $url;
			}
			foreach ($menu['infoblock_link'] as $language_id => $url) {
				$menu_description[$language_id]['infoblock_link'] = $url;
			}
			foreach ($menu['infoblock_title'] as $language_id => $title) {
				$menu_description[$language_id]['infoblock_title'] = $title;
			}
			foreach ($menu_description as $language_id => $description) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "neoseo_menu_items_description SET item_id = '" . (int)$item_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($description['title']) . "', url = '" . $this->db->escape($description['url']) . "', menu_id = '" . (int)$menu_id . "'"
					.",`infoblock_link` = '" . $this->db->escape($description['infoblock_link']) . "' , `infoblock_title` = '" . $this->db->escape($description['infoblock_title']) . "'"
				);
			}

		}
		return $menu_id;

	}

	public function getMenuDescriptions($item_id) {
		$menu_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "neoseo_menu_items_description WHERE item_id = '" . (int)$item_id . "'");

		foreach ($query->rows as $result) {
			$menu_data['title'][$result['language_id']] = $result['title'];
			$menu_data['url'][$result['language_id']] = $result['url'];
			$menu_data['infoblock_link'][$result['language_id']] = $result['infoblock_link'];
			$menu_data['infoblock_title'][$result['language_id']] = $result['infoblock_title'];
		}

		return $menu_data;
	}

	public function deleteMenu($menu_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "neoseo_menu WHERE menu_id= '". (int)$menu_id."'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "neoseo_menu_items WHERE menu_id= '". (int)$menu_id."'" );
		$this->db->query("DELETE FROM " . DB_PREFIX . "neoseo_menu_items_description WHERE menu_id= '". (int)$menu_id."'" );
	}

	public function copyMenu($menu_id) {
		/*
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "neoseo_menu WHERE menu_id = '" . (int)$menu_id . "'");

		if ($query->num_rows) {
			$data = $query->row;

			$data['status'] = '0';

			$this->addShipping($data);

		}*/
	}
}
