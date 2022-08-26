<?php
require_once(DIR_SYSTEM.'/engine/neoseo_model.php');

class ModelBlogNeoSeoBlogArticle extends NeoSeoModel
{
	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_blog';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_status') == 1;
	}

	public function addArticle($data)
	{

		$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_article` SET author_id='" . (int) $data['author_id'] . "', allow_comment='" . (int) $data['allow_comment'] . "', sort_order='" . (int) $data['sort_order'] . "', status='" . (int) $data['status'] . "', date_added='" . $data['date_added'] . "', date_modified='" . $data['date_modified'] . "'");

		$article_id = $this->db->getLastId();

		if (isset($data['image'])) {
			$this->db->query("UPDATE `" . DB_PREFIX . "blog_article` SET image = '" . $this->db->escape($data['image']) . "' WHERE article_id = '" . (int) $article_id . "'");
		}


		if ($data['seo_url']) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "url_alias` SET query = 'article_id=" . (int) $article_id . "', keyword = '" . $this->db->escape($data['seo_url']) . "'");
		}

		// adding article description
		foreach ($data['article_description'] as $language_id => $value) {
			// summernote bug @see https://github.com/summernote/summernote/issues/143
			if (!strip_tags(html_entity_decode($value['teaser'], ENT_QUOTES, 'UTF-8'))) {
				$value['teaser'] = '';
			}
			if (!strip_tags(html_entity_decode($value['description'], ENT_QUOTES, 'UTF-8'))) {
				$value['description'] = '';
			}
			$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_article_description` SET article_id = '" . (int) $article_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', teaser = '" . $this->db->escape($value['teaser']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
		}

		// adding article category
		if (isset($data['article_category'])) {
			foreach ($data['article_category'] as $category_id) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_article_to_category` SET article_id = '" . (int) $article_id . "', category_id = '" . (int) $category_id . "'");
			}
		}

		if (!empty($data['main_category_id'])) {
			$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_to_category WHERE article_id = '" . (int) $article_id . "' AND category_id = '" . (int) $data['main_category_id'] . "'");
			$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_to_category SET article_id = '" . (int) $article_id . "', category_id = '" . (int) $data['main_category_id'] . "', main_category = 1");
		} elseif (isset($data['article_category'][0])) {
			$this->db->query("UPDATE " . DB_PREFIX . "blog_article_to_category SET main_category = 1 WHERE article_id = '" . (int) $article_id . "' AND category_id = '" . (int) $data['article_category'][0] . "'");
		}

		// adding article store
		if (isset($data['article_store'])) {
			foreach ($data['article_store'] as $store_id) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_article_to_store` SET article_id = '" . (int) $article_id . "', store_id = '" . (int) $store_id . "'");
			}
		}

		// adding layout
		if (isset($data['article_layout'])) {
			foreach ($data['article_layout'] as $store_id => $layout) {
				if (!empty($layout['layout_id'])) {
					$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_article_to_layout` SET article_id = '" . (int) $article_id . "', store_id = '" . (int) $store_id . "', layout_id = '" . (int) $layout['layout_id'] . "'");
				}
			}
		}

		// now adding related products for article
		if (isset($this->request->post['related_products'])) {
			foreach ($data['related_products'] as $product_id) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_article_related_product` SET article_id='" . (int) $article_id . "', product_id='" . (int) $product_id . "'");
			}
		}

		// insert related articles
		if (isset($this->request->post['related_articles'])) {
			foreach ($this->request->post['related_articles'] as $related_article) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_article_related_article` SET article_id='" . (int) $article_id . "', related_id='" . (int) $related_article['related_id'] . "', sort_order='" . (int) $related_article['sort_order'] . "', status='" . (int) $related_article['status'] . "', date_added=NOW()");
			}
		}

		$this->cache->delete('blog_article');
		$this->event->trigger('post.admin.blog.article.add', $article_id);
	}

	public function editArticle($article_id, $data)
	{
		$this->db->query("UPDATE `" . DB_PREFIX . "blog_article` SET author_id='" . (int) $data['author_id'] . "', allow_comment='" . (int) $data['allow_comment'] . "', sort_order='" . (int) $data['sort_order'] . "', status='" . (int) $data['status'] . "', date_added='" . $data['date_added'] . "', date_modified='" . $data['date_modified'] . "' WHERE article_id='" . (int) $article_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE `" . DB_PREFIX . "blog_article` SET image = '" . $this->db->escape($data['image']) . "' WHERE article_id = '" . (int) $article_id . "'");
		}

		$this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE query = 'article_id=" . (int) $article_id . "'");

		if ($data['seo_url']) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "url_alias` SET query = 'article_id=" . (int) $article_id . "', keyword = '" . $this->db->escape($data['seo_url']) . "'");
		}

		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_article_description` WHERE article_id='" . (int) $article_id . "'");

		// adding article description
		foreach ($data['article_description'] as $language_id => $value) {
			// summernote bug @see https://github.com/summernote/summernote/issues/143
			if (!strip_tags(html_entity_decode($value['teaser'], ENT_QUOTES, 'UTF-8'))) {
				$value['teaser'] = '';
			}
			if (!strip_tags(html_entity_decode($value['description'], ENT_QUOTES, 'UTF-8'))) {
				$value['description'] = '';
			}
			$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_article_description` SET article_id = '" . (int) $article_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', teaser = '" . $this->db->escape($value['teaser']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
		}


		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_article_to_category` WHERE article_id='" . (int) $article_id . "'");

		// adding article category
		if (isset($data['article_category'])) {
			foreach ($data['article_category'] as $category_id) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_article_to_category` SET article_id = '" . (int) $article_id . "', category_id = '" . (int) $category_id . "'");
			}
		}

		if (!empty($data['main_category_id'])) {
			$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_to_category WHERE article_id = '" . (int) $article_id . "' AND category_id = '" . (int) $data['main_category_id'] . "'");
			$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_to_category SET article_id = '" . (int) $article_id . "', category_id = '" . (int) $data['main_category_id'] . "', main_category = 1");
		} elseif (isset($data['article_category'][0])) {
			$this->db->query("UPDATE " . DB_PREFIX . "blog_article_to_category SET main_category = 1 WHERE article_id = '" . (int) $article_id . "' AND category_id = '" . (int) $data['article_category'][0] . "'");
		}

		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_article_to_store` WHERE article_id='" . (int) $article_id . "'");

		// adding article store
		if (isset($data['article_store'])) {
			foreach ($data['article_store'] as $store_id) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_article_to_store` SET article_id = '" . (int) $article_id . "', store_id = '" . (int) $store_id . "'");
			}
		}

		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_article_to_layout` WHERE article_id='" . (int) $article_id . "'");

		if (isset($data['article_layout'])) {
			foreach ($data['article_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_article_to_layout` SET article_id = '" . (int) $article_id . "', store_id = '" . (int) $store_id . "', layout_id = '" . (int) $layout_id . "'");
			}
		}

		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_article_related_product` WHERE article_id='" . (int) $article_id . "'");

		if (isset($this->request->post['related_products'])) {
			foreach ($data['related_products'] as $product_id) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_article_related_product` SET article_id='" . (int) $article_id . "', product_id='" . (int) $product_id . "'");
			}
		}

		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_article_related_article` WHERE article_id='" . (int) $article_id . "'");

		// insert related articles
		if (isset($data['related_articles'])) {
			foreach ($data['related_articles'] as $related_article) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_article_related_article` SET article_id='" . (int) $article_id . "', related_id='" . (int) $related_article['related_id'] . "', sort_order='" . (int) $related_article['sort_order'] . "', status='" . (int) $related_article['status'] . "', date_added=NOW()");
			}
		}

		$this->cache->delete('blog_article');
		$this->event->trigger('post.admin.blog.article.edit', $article_id);
	}

	public function copyArticle($article_id)
	{
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_article` WHERE article_id = '" . (int) $article_id . "'");

		if ($query->num_rows) {
			$data = $query->row;

			$data['status'] = '0';
			$data['seo_url'] = '';

			$data['article_store'] = $this->getArticleStore($article_id);
			$data['article_layout'] = $this->getArticleLayouts($article_id);
			$data['article_description'] = $this->getArticleDescriptions($article_id);
			$data['article_category'] = $this->getArticleCategories($article_id);
			$data['main_category_id'] = $this->getArticleMainCategoryId($article_id);
			$data['related_products'] = $this->getRelatedProducts($article_id);
			$data['related_articles'] = $this->getRelatedArticles($article_id);

			$this->addArticle($data);
		}
	}

	public function deleteArticle($article_id)
	{
		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_article` WHERE article_id='" . (int) $article_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE query = 'article_id=" . (int) $article_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_article_description` WHERE article_id='" . (int) $article_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_article_to_category` WHERE article_id='" . (int) $article_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_article_to_store` WHERE article_id='" . (int) $article_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_article_to_layout` WHERE article_id='" . (int) $article_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_article_related_product` WHERE article_id='" . (int) $article_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "blog_article_related_article` WHERE article_id='" . (int) $article_id . "'");
		$this->cache->delete('blog_article');
	}

	public function checkDeleteArticle($article_id)
	{
		$sql = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_article_related_article` WHERE related_id='" . (int) $article_id . "'");

		return $sql->num_rows;
	}

	public function getArticle($article_id)
	{
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'article_id=" . (int) $article_id . "' LIMIT 1) AS seo_url FROM `" . DB_PREFIX . "blog_article` ba LEFT JOIN `" . DB_PREFIX . "blog_article_description` bad ON (ba.article_id = bad.article_id) WHERE ba.article_id = '" . (int) $article_id . "' AND bad.language_id = '" . (int) $this->config->get('config_language_id') . "'");

		return $query->row;
	}

	public function getTotalArticle($data = array())
	{
		$sql = "SELECT
					COUNT(DISTINCT ba.article_id) AS total
				  FROM `" . DB_PREFIX . "blog_article` ba
					   LEFT JOIN `" . DB_PREFIX . "blog_article_description` bad ON(ba.article_id=bad.article_id)
					   LEFT JOIN `" . DB_PREFIX . "blog_author` bau ON(ba.author_id = bau.author_id)  ";

		if (isset($data['filter_category']) && !empty($data['filter_category'])) {
			$sql .= "
			LEFT JOIN `" . DB_PREFIX . "blog_article_to_category` bac ON(ba.article_id=bac.article_id)
			";
		}

		$sql .= " WHERE bad.language_id='" . (int) $this->config->get('config_language_id') . "'";

		if (isset($data['filter_article']) && !empty($data['filter_article'])) {
			$sql .= " AND bad.name LIKE '%" . $this->db->escape($data['filter_article']) . "%'";
		}

		if (isset($data['filter_name']) && !empty($data['filter_name'])) {
			$sql .= " AND bad.name LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
		}
		if (isset($data['filter_category']) && !empty($data['filter_category'])) {
			$sql .= " AND bac.category_id='" . (int) $data['filter_category'] . "'";
		}

		if (isset($data['filter_author']) && !empty($data['filter_author'])) {
			$sql .= " AND ba.author_id='" . (int) $data['filter_author'] . "'";
		}

		if (isset($data['filter_status'])) {
			$sql .= " AND ba.status='" . (int) $data['filter_status'] . "'";
		}

		if (isset($data['filter_date_added']) && !empty($data['filter_date_added'])) {
			$sql .= " AND DATE(ba.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		if (!empty($data['filter_viewed'])) {
			$sql .= " AND ba.viewed > 0";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getArticles($data = array())
	{
		$sql = "SELECT
					ba.*,
					bau.name AS author_name,
					bad.name AS name
				  FROM `" . DB_PREFIX . "blog_article` ba
					   LEFT JOIN `" . DB_PREFIX . "blog_article_description` bad ON(ba.article_id=bad.article_id)
					   LEFT JOIN `" . DB_PREFIX . "blog_author` bau ON(ba.author_id = bau.author_id) ";

		if (isset($data['filter_category']) && !empty($data['filter_category'])) {
			$sql .= "
			LEFT JOIN `" . DB_PREFIX . "blog_article_to_category` bac ON(ba.article_id=bac.article_id)
			";
		}

		$sql .= " WHERE bad.language_id='" . (int) $this->config->get('config_language_id') . "'";

		if (isset($data['filter_article']) && !empty($data['filter_article'])) {
			$sql .= " AND bad.name LIKE '%" . $this->db->escape($data['filter_article']) . "%'";
		}

		if (isset($data['filter_name']) && !empty($data['filter_name'])) {
			$sql .= " AND bad.name LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
		}
		if (isset($data['filter_category']) && !empty($data['filter_category'])) {
			$sql .= " AND bac.category_id='" . (int) $data['filter_category'] . "'";
		}

		if (isset($data['filter_author']) && !empty($data['filter_author'])) {
			$sql .= " AND ba.author_id='" . (int) $data['filter_author'] . "'";
		}

		if (isset($data['filter_status'])) {
			$sql .= " AND ba.status='" . (int) $data['filter_status'] . "'";
		}

		if (isset($data['filter_date_added']) && !empty($data['filter_date_added'])) {
			$sql .= " AND DATE(ba.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		if (!empty($data['filter_viewed'])) {
			$sql .= " AND ba.viewed > 0";
		}

		$sql .= " GROUP BY ba.article_id";

		$sort_data = array(
			'bad.name',
			'bau.name',
			'ba.sort_order',
			'ba.status',
			'ba.date_added',
			'ba.date_modified',
			'ba.viewed'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY ba.date_modified";
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

	public function getArticleDescriptions($article_id)
	{
		$blog_article_description_data = array();
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_article_description` WHERE article_id = '" . (int) $article_id . "'");

		foreach ($query->rows as $result) {
			$blog_article_description_data[$result['language_id']] = $result;
		}

		return $blog_article_description_data;
	}

	public function getArticleStore($article_id)
	{
		$article_store_data = array();

		$sql = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_article_to_store` WHERE article_id = '" . (int) $article_id . "'");

		foreach ($sql->rows as $result) {
			$article_store_data[] = $result['store_id'];
		}
		return $article_store_data;
	}

	public function getArticleCategories($article_id)
	{
		$article_categories = array();

		$sql = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_article_to_category` WHERE article_id = '" . (int) $article_id . "'");

		foreach ($sql->rows as $result) {
			$article_categories[] = $result['category_id'];
		}
		return $article_categories;
	}

	public function getArticleLayouts($article_id)
	{
		$article_layout_data = array();

		$sql = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_article_to_layout` WHERE article_id = '" . (int) $article_id . "'");

		foreach ($sql->rows as $result) {
			$article_layout_data[$result['store_id']] = $result['layout_id'];
		}

		return $article_layout_data;
	}

	public function getRelatedProducts($article_id)
	{
		$sql = $this->db->query("SELECT product_id FROM `" . DB_PREFIX . "blog_article_related_product` WHERE article_id='" . (int) $article_id . "'");
		return $sql->rows;
	}

	public function checkAuthorName($author_name)
	{
		$sql = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_author` WHERE LCASE(name) = '" . $this->db->escape(utf8_strtolower($author_name)) . "'");
		return $sql->num_rows;
	}

	public function checkArticleName($language_id, $article_name, $article_id = 0)
	{

		if (!$article_id) {
			$sql = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_article_description` WHERE LCASE(name)='" . $this->db->escape(utf8_strtolower($article_name)) . "' AND language_id='" . (int) $language_id . "'");
			return $sql->num_rows;
		} else {
			$sql = $this->db->query("SELECT * FROM `" . DB_PREFIX . "blog_article_description` WHERE LCASE(name)='" . $this->db->escape(utf8_strtolower($article_name)) . "' AND language_id='" . (int) $language_id . "' AND article_id <> '" . (int) $article_id . "'");
			return $sql->num_rows;
		}
	}

	public function getRelatedArticles($article_id)
	{
		$blog_related_article_data = array();

		$sql = $this->db->query("SELECT sbra.*, bad.name AS name FROM `" . DB_PREFIX . "blog_article_related_article` sbra LEFT JOIN `" . DB_PREFIX . "blog_article_description` bad ON(bad.article_id=sbra.related_id) WHERE sbra.article_id='" . (int) $article_id . "' AND bad.language_id='" . $this->config->get('config_language_id') . "'");

		foreach ($sql->rows as $row) {
			$blog_related_article_data[] = array(
				'related_id' => $row['related_id'],
				'name' => $row['name'],
				'sort_order' => $row['sort_order'],
				'status' => $row['status']
			);
		}

		return $blog_related_article_data;
	}

	public function getArticlesRelated($data, $article_id)
	{
		$sql = "SELECT * FROM `" . DB_PREFIX . "blog_article_description` WHERE LCASE(name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%' AND article_id <> '" . (int) $article_id . "' AND language_id='" . $this->config->get('config_language_id') . "'";

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

	public function getCategories($data = array()) {
		$sql = "SELECT cp.category_id AS category_id, GROUP_CONCAT(cd1.name ORDER BY cp.level SEPARATOR '&nbsp;&nbsp;&gt;&nbsp;&nbsp;') AS name, c1.parent_id, c1.sort_order, c1.status,(select count(product_id) as product_count from " . DB_PREFIX . "product_to_category pc where pc.category_id = c1.category_id) as product_count FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category c1 ON (cp.category_id = c1.category_id) LEFT JOIN " . DB_PREFIX . "category c2 ON (cp.path_id = c2.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd1 ON (cp.path_id = cd1.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd2 ON (cp.category_id = cd2.category_id) " .
		 " LEFT JOIN " . DB_PREFIX . "category_to_store cts ON c1.category_id = cts.category_id 
		 WHERE cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND cd2.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		$sql .= " AND cts.store_id IN (" . ((!isset($data['filter_store_id'])) ? '' : $data['filter_store_id']) . ")";

		$sql .= " GROUP BY cp.category_id";

		$sort_data = array(
			'product_count',
			'name',
			'sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY sort_order";
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
	}	

	public function getManufacturers($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "manufacturer";

		$sql = "SELECT c.manufacturer_id, md.name, c.sort_order FROM " . DB_PREFIX . "manufacturer c LEFT JOIN " . DB_PREFIX . "manufacturer_description md ON (c.manufacturer_id = md.manufacturer_id) LEFT JOIN " . DB_PREFIX . "manufacturer_to_store mts ON c.manufacturer_id = mts.manufacturer_id WHERE md.language_id = '" . (int)$this->config->get('config_language_id') . "'";



		if (!empty($data['filter_name'])) {
			$sql .= " AND c.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		$sql .= " AND mts.store_id IN (" . ((!isset($data['filter_store_id'])) ? '' : $data['filter_store_id']) . ")";

		$sort_data = array(
			'name',
			'sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY c.name";
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
	}	

	public function getProducts($data = array())
	{
		$sql = "SELECT DISTINCT(p.product_id), pd.name, p.model, p.price, p.quantity FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) " .
			" LEFT JOIN " . DB_PREFIX . "product_to_store pts ON p.product_id = pts.product_id";

		if (!empty($data['filter_category_id'])) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";
		}

		$sql .= " WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (!empty($data['filter_model'])) {
			$sql .= " AND p.model LIKE '" . $this->db->escape($data['filter_model']) . "%'";
		}

		if (!empty($data['filter_price'])) {
			$sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
		}

		if (!empty($data['filter_quantity'])) {
			$sql .= " AND p.quantity = '" . $this->db->escape($data['filter_quantity']) . "'";
		}

		if (!empty($data['filter_status'])) {
			$sql .= " AND p.status = '" . (int) $data['filter_status'] . "'";
		}

		if (!empty($data['filter_category_id'])) {
			$sql .= " AND p2c.category_id = '" . (int) $data['filter_category_id'] . "'";
		}

		if (!empty($data['filter_manufacturer_id'])) {
			$sql .= " AND p.manufacturer_id = '" . (int) $data['filter_manufacturer_id'] . "'";
		}

		$sql .= " AND pts.store_id IN (" . ((!isset($data['filter_store_id'])) ? '' : $data['filter_store_id']) . ")";

		//$sql .= " GROUP BY p.product_id";

		$sort_data = array(
			'pd.name',
			'p.model',
			'p.price',
			'p.quantity',
			'p.status',
			'p.sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY pd.name";
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

	public function getTotalViews()
	{
		$sql = "SELECT SUM(viewed) AS total FROM `" . DB_PREFIX . "blog_article` WHERE viewed > 0";

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getArticleMainCategoryId($article_id)
	{
		$query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "blog_article_to_category WHERE article_id = '" . (int) $article_id . "' AND main_category = '1' LIMIT 1");

		return ($query->num_rows ? (int) $query->row['category_id'] : 0);
	}

	public function getCategoryToBlogArticle($category_id)
	{
		$categories = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_blog_article WHERE category_id = '" . (int) $category_id . "'");

		foreach ($query->rows as $result) {
			$categories[] = $result['article_id'];
		}

		return $categories;
	}

	public function updateCategoryToBlogArticle($articles, $category_id = 0)
	{
		if (!$category_id) {
			$query = $this->db->query("SELECT max(`category_id`) as category_id FROM `" . DB_PREFIX . "category` ");
			$category_id = $query->row['category_id'];
		}
		$this->db->query("DELETE FROM `" . DB_PREFIX . "category_to_blog_article` WHERE category_id='" . (int) $category_id . "'");

		foreach ($articles as $article_id) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "category_to_blog_article` SET category_id='" . (int) $category_id . "', article_id='" . (int) $article_id . "'");
		}
	}

	public function deleteCategoryToBlogArticle($category_id)
	{
		$this->db->query("DELETE FROM `" . DB_PREFIX . "category_to_blog_article` WHERE category_id='" . (int) $category_id . "'");
	}

}
