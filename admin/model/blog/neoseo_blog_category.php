<?php
require_once(DIR_SYSTEM.'/engine/neoseo_model.php');

class ModelBlogNeoSeoBlogCategory extends NeoSeoModel
{
	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_blog';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_status') == 1;
	}

	public function addCategory($data)
	{

		$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_category` SET parent_id = '" . (int) $data['parent_id'] . "', sort_order = '" . (int) $data['sort_order'] . "', status = '" . (int) $data['status'] . "', date_added = NOW(), date_modified = NOW()");

		$category_id = $this->db->getLastId();

		if (isset($data['image'])) {
			$this->db->query("UPDATE `" . DB_PREFIX . "blog_category` SET image = '" . $this->db->escape($data['image']) . "' WHERE category_id = '" . (int) $category_id . "'");
		}

		if ($data['seo_url']) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "url_alias` SET query = 'blog_category_id=" . (int) $category_id . "', keyword = '" . $this->db->escape($data['seo_url']) . "'");
		}

		foreach ($data['category_description'] as $language_id => $value) {
			// summernote bug @see https://github.com/summernote/summernote/issues/143
			if (!strip_tags(html_entity_decode($value['description'], ENT_QUOTES, 'UTF-8'))) {
				$value['description'] = '';
			}
			$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_category_description` SET category_id = '" . (int) $category_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($value['name']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		// MySQL Hierarchical Data Closure Table Pattern
		$level = 0;

		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_category_path` WHERE category_id = '" . (int) $data['parent_id'] . "' ORDER BY `level` ASC");

		foreach ($query->rows as $result) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_category_path` SET `category_id` = '" . (int) $category_id . "', `path_id` = '" . (int) $result['path_id'] . "', `level` = '" . (int) $level . "'");

			$level++;
		}

		$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_category_path` SET `category_id` = '" . (int) $category_id . "', `path_id` = '" . (int) $category_id . "', `level` = '" . (int) $level . "'");

		if (isset($data['category_store'])) {
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_category_to_store` SET category_id = '" . (int) $category_id . "', store_id = '" . (int) $store_id . "'");
			}
		}

		if (isset($data['category_layout'])) {
			foreach ($data['category_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_category_to_layout` SET category_id = '" . (int) $category_id . "', store_id = '" . (int) $store_id . "', layout_id = '" . (int) $layout['layout_id'] . "'");
				}
			}
		}

		$this->cache->delete('blog_category');
		$this->event->trigger('post.admin.blog.category.add', $category_id);
	}

	public function editCategory($category_id, $data)
	{

		$this->db->query("UPDATE `" . DB_PREFIX . "blog_category` SET parent_id = '" . (int) $data['parent_id'] . "', sort_order = '" . (int) $data['sort_order'] . "', status = '" . (int) $data['status'] . "', date_modified = NOW() WHERE category_id = '" . (int) $category_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE `" . DB_PREFIX . "blog_category` SET image = '" . $this->db->escape($data['image']) . "' WHERE category_id = '" . (int) $category_id . "'");
		}

		$this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE query = 'blog_category_id=" . (int) $category_id . "'");

		if ($data['seo_url']) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "url_alias` SET query = 'blog_category_id=" . (int) $category_id . "', keyword = '" . $this->db->escape($data['seo_url']) . "'");
		}

		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_category_description` WHERE category_id = '" . (int) $category_id . "'");

		foreach ($data['category_description'] as $language_id => $value) {
			// summernote bug @see https://github.com/summernote/summernote/issues/143
			if (!strip_tags(html_entity_decode($value['description'], ENT_QUOTES, 'UTF-8'))) {
				$value['description'] = '';
			}
			$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_category_description` SET category_id = '" . (int) $category_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($value['name']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		// MySQL Hierarchical Data Closure Table Pattern
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_category_path` WHERE path_id = '" . (int) $category_id . "' ORDER BY level ASC");

		if ($query->rows) {
			foreach ($query->rows as $category_path) {
				// Delete the path below the current one
				$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_category_path` WHERE category_id = '" . (int) $category_path['category_id'] . "' AND level < '" . (int) $category_path['level'] . "'");

				$path = array();

				// Get the nodes new parents
				$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_category_path` WHERE category_id = '" . (int) $data['parent_id'] . "' ORDER BY level ASC");

				foreach ($query->rows as $result) {
					$path[] = $result['path_id'];
				}

				// Get whats left of the nodes current path
				$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_category_path` WHERE category_id = '" . (int) $category_path['category_id'] . "' ORDER BY level ASC");

				foreach ($query->rows as $result) {
					$path[] = $result['path_id'];
				}

				// Combine the paths with a new level
				$level = 0;

				foreach ($path as $path_id) {
					$this->db->query("REPLACE INTO `" . DB_PREFIX . "blog_category_path` SET category_id = '" . (int) $category_path['category_id'] . "', `path_id` = '" . (int) $path_id . "', level = '" . (int) $level . "'");

					$level++;
				}
			}
		} else {
			// Delete the path below the current one
			$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_category_path` WHERE category_id = '" . (int) $category_id . "'");

			// Fix for records with no paths
			$level = 0;

			$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_category_path` WHERE category_id = '" . (int) $data['parent_id'] . "' ORDER BY level ASC");

			foreach ($query->rows as $result) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_category_path` SET category_id = '" . (int) $category_id . "', `path_id` = '" . (int) $result['path_id'] . "', level = '" . (int) $level . "'");

				$level++;
			}

			$this->db->query("REPLACE INTO `" . DB_PREFIX . "blog_category_path` SET category_id = '" . (int) $category_id . "', `path_id` = '" . (int) $category_id . "', level = '" . (int) $level . "'");
		}

		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_category_to_store` WHERE category_id = '" . (int) $category_id . "'");

		if (isset($data['category_store'])) {
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_category_to_store` SET category_id = '" . (int) $category_id . "', store_id = '" . (int) $store_id . "'");
			}
		}

		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_category_to_layout` WHERE category_id = '" . (int) $category_id . "'");

		if (isset($data['category_layout'])) {
			foreach ($data['category_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_category_to_layout` SET category_id = '" . (int) $category_id . "', store_id = '" . (int) $store_id . "', layout_id = '" . (int) $layout_id . "'");
			}
		}

		$this->cache->delete('blog_category');
		$this->event->trigger('post.admin.blog.category.edit', $category_id);
	}

	public function copyCategory($category_id)
	{
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_category` WHERE article_id = '" . (int) $category_id . "'");

		if ($query->num_rows) {
			$data = $query->row;

			$data['status'] = '0';
			$data['seo_url'] = '';

			$data['category_description'] = $this->getCategoryDescriptions($category_id);
			$data['category_store'] = $this->getCategoryStores($category_id);
			$data['category_layout'] = $this->getCategoryLayouts($category_id);

			$this->addCategory($data);
		}
	}

	public function deleteCategory($category_id)
	{
		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_category` WHERE category_id = '" . (int) $category_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_category_description` WHERE category_id = '" . (int) $category_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_category_to_store` WHERE category_id = '" . (int) $category_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_category_to_layout` WHERE category_id = '" . (int) $category_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE query = 'blog_category_id=" . (int) $category_id . "'");

		$query = $this->db->query("SELECT category_id FROM `" . DB_PREFIX . "blog_category` WHERE parent_id = '" . (int) $category_id . "'");

		foreach ($query->rows as $result) {
			$this->deleteCategory($result['category_id']);
		}

		$this->cache->delete('blog_category');
	}

	public function repairCategories($parent_id = 0)
	{
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_category WHERE parent_id = '" . (int) $parent_id . "'");

		foreach ($query->rows as $category) {
			// Delete the path below the current one
			$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_category_path` WHERE category_id = '" . (int) $category['category_id'] . "'");

			// Fix for records with no paths
			$level = 0;

			$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_category_path` WHERE category_id = '" . (int) $parent_id . "' ORDER BY level ASC");

			foreach ($query->rows as $result) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_category_path` SET category_id = '" . (int) $category['category_id'] . "', `path_id` = '" . (int) $result['path_id'] . "', level = '" . (int) $level . "'");

				$level++;
			}

			$this->db->query("REPLACE INTO `" . DB_PREFIX . "blog_category_path` SET category_id = '" . (int) $category['category_id'] . "', `path_id` = '" . (int) $category['category_id'] . "', level = '" . (int) $level . "'");

			$this->repairCategories($category['category_id']);
		}
	}

	public function getCategory($category_id)
	{
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'blog_category_id=" . (int) $category_id . "') AS seo_url FROM `" . DB_PREFIX . "blog_category` WHERE category_id = '" . (int) $category_id . "'");
		return $query->row;
	}

	public function getTotalCategories($data = array())
	{
		$sql = "SELECT COUNT(DISTINCT(bc.category_id)) AS total FROM `" . DB_PREFIX . "blog_category` bc LEFT JOIN `" . DB_PREFIX . "blog_category_description` bcd ON(bc.category_id=bcd.category_id) WHERE bcd.language_id='" . (int) $this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND bcd.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (isset($data['filter_status'])) {
			$sql .= " AND bc.status = '" . (int) $data['filter_name'] . "'";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getCategories($data = array())
	{

		$sql = "SELECT cp.category_id AS category_id, GROUP_CONCAT(cd1.name ORDER BY cp.level SEPARATOR '&nbsp;&nbsp;&gt;&nbsp;&nbsp;') AS name, c1.parent_id, c1.sort_order, c1.status FROM " . DB_PREFIX . "blog_category_path cp LEFT JOIN " . DB_PREFIX . "blog_category c1 ON (cp.category_id = c1.category_id) LEFT JOIN " . DB_PREFIX . "blog_category c2 ON (cp.path_id = c2.category_id) LEFT JOIN " . DB_PREFIX . "blog_category_description cd1 ON (cp.path_id = cd1.category_id) LEFT JOIN " . DB_PREFIX . "blog_category_description cd2 ON (cp.category_id = cd2.category_id) WHERE cd1.language_id = '" . (int) $this->config->get('config_language_id') . "' AND cd2.language_id = '" . (int) $this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND cd2.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (isset($data['filter_status'])) {
			$sql .= " AND c1.status = '" . (int) $data['filter_name'] . "'";
		}

		$sql .= " GROUP BY cp.category_id";

		$sort_data = array(
			'name',
			'sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY name";
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

			$sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getPath($category_id)
	{
		$query = $this->db->query("SELECT bcd.name AS name, bc.parent_id AS parent_id FROM " . DB_PREFIX . "blog_category bc LEFT JOIN " . DB_PREFIX . "blog_category_description bcd ON (bc.category_id = bcd.category_id) WHERE bc.category_id = '" . (int) $category_id . "' AND bcd.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY bc.sort_order, bcd.name ASC");

		if ($query->row['parent_id']) {
			return $this->getPath($query->row['parent_id'], $this->config->get('config_language_id')) . '&nbsp;&nbsp;&gt;&nbsp;&nbsp;' . $query->row['name'];
		} else {
			return $query->row['name'];
		}
	}

	public function getCategoryDescriptions($category_id)
	{
		$category_description_data = array();

		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_category_description` WHERE category_id = '" . (int) $category_id . "'");

		foreach ($query->rows as $result) {
			$category_description_data[$result['language_id']] = $result;
		}

		return $category_description_data;
	}

	public function getCategoryStores($category_id)
	{
		$simple_category_store_data = array();

		$sql = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_category_to_store` WHERE category_id = '" . (int) $category_id . "'");

		foreach ($sql->rows as $result) {
			$simple_category_store_data[] = $result['store_id'];
		}

		return $simple_category_store_data;
	}

	public function getCategoryLayouts($category_id)
	{
		$simple_category_layout_data = array();

		$sql = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_category_to_layout` WHERE category_id = '" . (int) $category_id . "'");

		foreach ($sql->rows as $result) {
			$simple_category_layout_data[$result['store_id']] = $result['layout_id'];
		}

		return $simple_category_layout_data;
	}

	public function getTotalArticleCategoryWise($category_id)
	{
		$sql = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_article_to_category` WHERE category_id='" . (int) $category_id . "'");

		return $sql->num_rows;
	}

}
