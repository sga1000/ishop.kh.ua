<?php
require_once(DIR_SYSTEM.'/engine/neoseo_model.php');

class ModelBlogNeoSeoBlogAuthor extends NeoSeoModel
{
	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_blog';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_status') == 1;
	}

	public function addAuthor($data)
	{
		$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_author` SET name = '" . $this->db->escape($data['name']) . "', status='" . (int) $data['status'] . "', date_added=NOW(), date_modified=NOW()");

		$author_id = $this->db->getLastId();

		if (isset($data['image'])) {
			$this->db->query("UPDATE `" . DB_PREFIX . "blog_author` SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE author_id = '" . (int) $author_id . "'");
		}

		if ($data['seo_url']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'author_id=" . (int) $author_id . "', keyword = '" . $this->db->escape($data['seo_url']) . "'");
		}

		foreach ($data['author_description'] as $language_id => $value) {
			// summernote bug @see https://github.com/summernote/summernote/issues/143
			if (!strip_tags(html_entity_decode($value['description'], ENT_QUOTES, 'UTF-8'))) {
				$value['description'] = '';
			}
			$this->db->query("INSERT INTO " . DB_PREFIX . "blog_author_description SET author_id = '" . (int) $author_id . "', language_id = '" . (int) $language_id . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		$this->cache->delete('blog');
		$this->event->trigger('post.admin.blog.author.add', $author_id);
	}

	public function editAuthor($author_id, $data)
	{
		$this->db->query("UPDATE `" . DB_PREFIX . "blog_author` SET name = '" . $this->db->escape($data['name']) . "', status='" . (int) $data['status'] . "', date_modified=NOW() WHERE author_id='" . (int) $author_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE `" . DB_PREFIX . "blog_author` SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE author_id = '" . (int) $author_id . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'author_id=" . (int) $author_id . "'");

		if ($data['seo_url']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'author_id=" . (int) $author_id . "', keyword = '" . $this->db->escape($data['seo_url']) . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_author_description WHERE author_id = '" . (int) $author_id . "'");

		foreach ($data['author_description'] as $language_id => $value) {
			// summernote bug @see https://github.com/summernote/summernote/issues/143
			if (!strip_tags(html_entity_decode($value['description'], ENT_QUOTES, 'UTF-8'))) {
				$value['description'] = '';
			}
			$this->db->query("INSERT INTO " . DB_PREFIX . "blog_author_description SET author_id = '" . (int) $author_id . "', language_id = '" . (int) $language_id . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		$this->cache->delete('blog');
		$this->event->trigger('post.admin.blog.author.edit', $author_id);
	}

	public function deleteAuthor($blog_manager_id)
	{
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_author WHERE author_id = '" . (int) $blog_manager_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_author_description WHERE author_id = '" . (int) $blog_manager_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'author_id=" . (int) $blog_manager_id . "'");

		$this->cache->delete('blog');
	}

	public function getAuthor($author_id)
	{
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'author_id=" . (int) $author_id . "') AS seo_url FROM `" . DB_PREFIX . "blog_author` WHERE author_id = '" . (int) $author_id . "'");
		return $query->row;
	}

	public function getTotalAuthors($data = array())
	{
		$sql = "SELECT COUNT(DISTINCT(ba.author_id)) AS total FROM `" . DB_PREFIX . "blog_author` ba LEFT JOIN `" . DB_PREFIX . "blog_author_description` bad ON(ba.author_id=bad.author_id) WHERE bad.language_id='" . (int) $this->config->get('config_language_id') . "'";

		if (isset($data['filter_name']) && !empty($data['filter_name'])) {
			$sql .= " AND ba.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (isset($data['filter_status'])) {
			$sql .= " AND ba.status='" . (int) $data['filter_status'] . "'";
		}

		if (isset($data['filter_date_added']) && !empty($data['filter_date_added'])) {
			$sql .= " AND DATE(ba.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getAuthors($data = array())
	{
		$sql = "SELECT ba.* FROM `" . DB_PREFIX . "blog_author` ba LEFT JOIN `" . DB_PREFIX . "blog_author_description` bad ON(ba.author_id=bad.author_id) WHERE bad.language_id='" . (int) $this->config->get('config_language_id') . "'";

		if (isset($data['filter_name']) && !empty($data['filter_name'])) {
			$sql .= " AND ba.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (isset($data['filter_status'])) {
			$sql .= " AND ba.status='" . (int) $data['filter_status'] . "'";
		}

		if (isset($data['filter_date_added']) && !empty($data['filter_date_added'])) {
			$sql .= " AND DATE(ba.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$sort_data = array(
			'ba.name',
			'ba.status',
			'ba.date_added'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY ba.name";
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

	public function getAuthorDescriptions($author_id)
	{
		$author_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_author_description WHERE author_id = '" . (int) $author_id . "'");

		foreach ($query->rows as $result) {
			$author_description_data[$result['language_id']] = $result;
		}

		return $author_description_data;
	}

	public function getAuthorName($author_id)
	{
		$sql = $this->db->query("SELECT name FROM `" . DB_PREFIX . "blog_author` WHERE author_id='" . (int) $author_id . "'");

		return $sql->num_rows ? $sql->row['name'] : '';
	}

	public function checkAuthorName($name, $author_id = 0)
	{
		if (!$author_id) {
			$sql = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_author` WHERE LCASE(name) = '" . $this->db->escape(utf8_strtolower($name)) . "'");
			return $sql->num_rows;
		} else {
			$sql = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_author` WHERE LCASE(name) = '" . $this->db->escape(utf8_strtolower($name)) . "' AND author_id <> '" . (int) $author_id . "'");
			return $sql->num_rows;
		}
	}

	public function getTotalArticleByAuthorId($author_id)
	{
		$sql = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_article` WHERE author_id='" . (int) $author_id . "'");
		return $sql->num_rows;
	}

}
