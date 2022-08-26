<?php
require_once( DIR_SYSTEM . "/engine/soforp_model.php");
class ModelModuleNeoseoCategoryWall extends SoforpModel {

	// Install/Uninstall
	public function install()
	{
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'module/neoseo_category_wall');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'module/neoseo_category_wall');

		$this->initParamsDefaults(array(
			'status' => 1,
			'debug' => 0,
			'type' => 0,
		));

		$this->installTables();

	}
	
	public function installTables() {
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "neoseo_category` (
			`category_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
			`status` int(11) NOT NULL DEFAULT '0',
			`title` varchar(64) NOT NULL
        ) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "neoseo_category_items` (
			`item_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
			`id` int(11) NOT NULL,
			`category_id` int(11) NOT NULL,
			`type` varchar(255) NOT NULL,
			`type_id` int(11) NOT NULL,
			`parent_id` int(11) NOT NULL,
			`params` varchar(255) NOT NULL,
			`class` VARCHAR(255) NOT NULL,
			`style` VARCHAR(255) NOT NULL,
			`icon` VARCHAR(255) NOT NULL,
			`max_width` VARCHAR(255) NOT NULL,
			`bg_color` VARCHAR(255) NOT NULL,
			`hover_bg_color` VARCHAR(255) NOT NULL,
			`font_color` VARCHAR(255) NOT NULL,
			`hover_font_color` VARCHAR(255) NOT NULL
		) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "neoseo_category_items_description` (
			`id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
			`item_id` int(11) NOT NULL,
			`category_id` int(11) NOT NULL,
			`title` varchar(255) NOT NULL,
			`url` varchar(255) NOT NULL,
			`language_id` int(11) NOT NULL
        ) DEFAULT CHARSET=utf8;");
	}

	public function uninstall() {

	}

	public function upgrade(){
		$this->installTables();

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_category_items` LIKE 'class';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_category_items`  ADD COLUMN `class` VARCHAR(255) NOT NULL  AFTER `params`;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_category_items` LIKE 'style';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_category_items`  ADD COLUMN `style` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_category_items` LIKE 'icon';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_category_items`  ADD COLUMN `icon` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_category_items` LIKE 'max_width'";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_category_items`  ADD COLUMN `max_width` VARCHAR(255) NOT NULL;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_category_items` LIKE 'bg_color';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_category_items`  ADD COLUMN `bg_color` VARCHAR(255) NOT NULL;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_category_items` LIKE 'hover_bg_color';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_category_items`  ADD COLUMN `hover_bg_color` VARCHAR(255) NOT NULL;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_category_items` LIKE 'font_color';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_category_items`  ADD COLUMN `font_color` VARCHAR(255) NOT NULL;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_category_items` LIKE 'hover_font_color';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_category_items`  ADD COLUMN `hover_font_color` VARCHAR(255) NOT NULL;";
            $this->db->query($sql);
        }
	}

	public function getCategories($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "neoseo_category";

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
			$sql = "SELECT * FROM " . DB_PREFIX . "neoseo_category";
			$query = $this->db->query($sql);
			return $query->rows;
		}
	}

	public function getCategoryParams($category_id) {
		if ($category_id) {
			$sql = "SELECT * FROM " . DB_PREFIX . "neoseo_category WHERE category_id = '".(int)$category_id."'";
			$query = $this->db->query($sql);
			if ($query->row) {
				return $query->row;
			}
		}
	}

	public function getCategory($category_id, $parent_id="") {
		$sql = "SELECT DISTINCT * FROM " . DB_PREFIX . "neoseo_category_items 
                WHERE category_id = '" . (int)$category_id . "'";
		if ($parent_id) {
			$sql .= " AND parent_id = '". (int)$parent_id."'";
		} else if ($parent_id === 0) {
			$sql .= " AND parent_id = 0";
		}
		$sql .= " ORDER BY id";
		$query = $this->db->query($sql);
		if ($query->rows) {
			$data = array();
			foreach ($query->rows as $category) {
				$description = array();
				$description = $this->getCategoryDescriptions($category['item_id']);

				$child = $this->getCategory($category_id,$category['id']);

				if ($child) {
					$childcategory = $child;
				} else {
					$childcategory = "";
				}

                $this->load->model('tool/image');
                if ($category['icon'] && is_file(DIR_IMAGE . $category['icon'])) {
                    $thumb = $this->model_tool_image->resize($category['icon'], 24, 24);
                } else {
                    $thumb = $this->model_tool_image->resize('no_image.png', 24, 24);
                }

				$data[] = array(
                    'item_id' => $category['item_id'],
					'id' => $category['id'],
					'title' => $description['title'],
					'url' => $description['url'],
					'type' => $category['type'],
					'type_id' =>$category['type_id'],
					'parent_id' => $category['parent_id'],
					'params' => $category['params'],
					'class' => $category['class'],
					'style' => $category['style'],
                    'max_width' => $category['max_width'],
					'icon' => $category['icon'],
                    'thumb' => $thumb,
                    'bg_color' => $category['bg_color'],
                    'hover_bg_color' => $category['hover_bg_color'],
                    'font_color' => $category['font_color'],
                    'hover_font_color' => $category['hover_font_color'],
					'child' => $childcategory
				);
			}
			return $data;
		}

	}

	public function getTotalCategories() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "neoseo_category");
		return $query->row['total'];
	}


	public function insertCategory($data){

		$this->db->query("INSERT INTO " . DB_PREFIX . "neoseo_category SET title = '" . $this->db->escape($data['category_title']) . "', status = '" . (int)($data['category_status']) . "'");
		$category_id = $this->db->getLastId();
		foreach ($data['categories'] as $category) {

			$this->db->query("INSERT INTO " . DB_PREFIX . "neoseo_category_items SET id = '" . (int)$category['id'] . "', category_id = '" .(int)$category_id. "', type = '" . $this->db->escape($category['type']) . "', type_id = '" . (int)$category['type_id'] . "', max_width = '" . $this->db->escape($category['max_width']) . "', hover_font_color = '" . $this->db->escape($category['hover_font_color']) . "', font_color = '" . $this->db->escape($category['font_color']) . "', hover_bg_color = '" . $this->db->escape($category['hover_bg_color']) . "', bg_color = '" . $this->db->escape($category['bg_color']) . "', icon = '" . $this->db->escape($category['icon']) . "', class = '" . $this->db->escape($category['class']) . "', style = '" . $this->db->escape($category['style']) . "', params = '" . $this->db->escape($category['params']) . "', parent_id = '" . (int)$category['parent_id'] . "'");
			$item_id = $this->db->getLastId();

			foreach ($category['title'] as $language_id => $title) {
				$category_description[$language_id]['title'] = $title;
			}
			foreach ($category['url'] as $language_id => $url) {
				$category_description[$language_id]['url'] = $url;
			}
			foreach ($category_description as $language_id => $description) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "neoseo_category_items_description SET item_id = '" . (int)$item_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($description['title']) . "', url = '" . $this->db->escape($description['url']) . "', category_id = '" . (int)$category_id . "'");
			}
			// todo:позже 3 массива в 1 всунуть

		}
		return $category_id;
	}

	public function editCategory($category_id, $data){
		$this->db->query("UPDATE " . DB_PREFIX . "neoseo_category SET title = '" . $this->db->escape($data['category_title']) . "', status = '" . (int)($data['category_status']) . "' WHERE category_id = '" . (int)$category_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "neoseo_category_items WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "neoseo_category_items_description WHERE category_id = '" . (int)$category_id . "'");

		foreach ($data['categories'] as $category) {

			$this->db->query("INSERT INTO " . DB_PREFIX . "neoseo_category_items SET id = ".$category['id'].", category_id = '" .(int)$category_id. "', type = '" . $this->db->escape($category['type']) . "', type_id = '" . (int)$category['type_id'] . "', params = '" . $this->db->escape($category['params']) . "', max_width = '" . $this->db->escape($category['max_width']) . "', hover_font_color = '" . $this->db->escape($category['hover_font_color']) . "', font_color = '" . $this->db->escape($category['font_color']) . "', hover_bg_color = '" . $this->db->escape($category['hover_bg_color']) . "', bg_color = '" . $this->db->escape($category['bg_color']) . "', icon = '" . $this->db->escape($category['icon']) . "', style = '" . $this->db->escape($category['style']) . "', class = '" . $this->db->escape($category['class']) . "', parent_id = '" . (int)$category['parent_id'] . "'");
			$item_id = $this->db->getLastId();

			foreach ($category['title'] as $language_id => $title) {
				$category_description[$language_id]['title'] = $title;
			}
			foreach ($category['url'] as $language_id => $url) {
				$category_description[$language_id]['url'] = $url;
			}
			foreach ($category_description as $language_id => $description) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "neoseo_category_items_description SET item_id = '" . (int)$item_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($description['title']) . "', url = '" . $this->db->escape($description['url']) . "', category_id = '" . (int)$category_id . "'");
			}

		}
		return $category_id;

	}

	public function getCategoryDescriptions($item_id) {
		$category_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "neoseo_category_items_description WHERE item_id = '" . (int)$item_id . "'");

		foreach ($query->rows as $result) {
			$category_data['title'][$result['language_id']] = $result['title'];
			$category_data['url'][$result['language_id']] = $result['url'];
		}

		return $category_data;
	}

	public function deleteCategory($category_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "neoseo_category WHERE category_id= '". (int)$category_id."'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "neoseo_category_items WHERE category_id= '". (int)$category_id."'" );
		$this->db->query("DELETE FROM " . DB_PREFIX . "neoseo_category_items_description WHERE category_id= '". (int)$category_id."'" );
	}

	public function copyCategory($category_id) {
		/*
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "neoseo_category WHERE category_id = '" . (int)$category_id . "'");

		if ($query->num_rows) {
			$data = $query->row;

			$data['status'] = '0';

			$this->addShipping($data);

		}*/
	}
}
