<?php

class ControllerCommonSeoPro extends Controller
{

	private $cache_data = null;

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->cache_data = $this->cache->get('seo_pro');
		if (!$this->cache_data) {
			$query = $this->db->query("SELECT LOWER(`keyword`) as 'keyword', `query` FROM " . DB_PREFIX . "url_alias ORDER BY url_alias_id");
			$this->cache_data = array();
			foreach ($query->rows as $row) {
				if (isset($this->cache_data['keywords'][$row['keyword']])) {
					$this->cache_data['keywords'][$row['query']] = $this->cache_data['keywords'][$row['keyword']];
					continue;
				}
				$this->cache_data['keywords'][$row['keyword']] = $row['query'];
				$this->cache_data['queries'][$row['query']] = $row['keyword'];
			}
			$this->cache->set('seo_pro', $this->cache_data);
		}
	}

	/* NeoSeo Order Referrer - begin */

	public function saveReferrer()
	{
		$this->load->model('tool/neoseo_order_referrer');
		$this->model_tool_neoseo_order_referrer->checkReferrer();
	}

	/* NeoSeo Order Referrer - end */

	public function index()
	{
		/* NeoSeo Order Referrer - begin */
		$this->saveReferrer();
		/* NeoSeo Order Referrer - end */


		// Add rewrite to url class
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		} else {
			return;
		}


		/* NeoSeo SEO Languages - begin */
		if (!$this->model_module_neoseo_seo_languages) {
			$this->load->model("module/neoseo_seo_languages");
		}

		if (isset($this->request->get['_route_'])) {

			$urllanguage = explode('/', trim(utf8_strtolower($this->request->get['_route_']), '/'));

			$languageCode = $urllanguage[0];
			$lang = $this->model_module_neoseo_seo_languages->getActiveLanguages();

			if (isset($languageCode) && in_array($languageCode, $lang)) {
				$this->model_module_neoseo_seo_languages->initLanguage($languageCode);

				$replace_lang = $languageCode;
				if (count($urllanguage) > 1) {
					$replace_lang .= "/";
				}

				$this->request->get['_route_'] = str_replace($replace_lang, '', $this->request->get['_route_']);

				if ($this->request->get['_route_'] == '' || $this->request->get['_route_'] == '/' || $this->request->get['_route_'] == 'index.php') {
					unset($this->request->get['_route_']);
				}
			} else {
				$code = $this->model_module_neoseo_seo_languages->getDefaultLanguage();
				if ($this->config->get("config_language") != $code) {
					// Real switch to default language
					$this->model_module_neoseo_seo_languages->initLanguage($code);
				}
			}
		} elseif (!(isset($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest')) {
			$code = $this->model_module_neoseo_seo_languages->getDefaultLanguage();
			$this->model_module_neoseo_seo_languages->initLanguage($code);
		}
		/* NeoSeo SEO Languages - end */
		// Decode URL
		if (!isset($this->request->get['_route_'])) {
			$this->validate();
		} else {
			$route_ = $route = $this->request->get['_route_'];
			unset($this->request->get['_route_']);
			$parts = explode('/', trim(utf8_strtolower($route), '/'));
			list($last_part) = explode('.', array_pop($parts));

			/* NeoSeo SEO Pagination - begin */
			if (strpos($last_part, "page-") !== false) {
				$page = (int) substr($last_part, 5);
				if ($page > 1) {
					$this->request->get['page'] = $page;
				}
				list($last_part) = explode('.', array_pop($parts));
			}
			/* NeoSeo SEO Pagination - end */

			array_push($parts, $last_part);

			$rows = array();
			foreach ($parts as $keyword) {
				if (isset($this->cache_data['keywords'][$keyword])) {
					$rows[] = array('keyword' => $keyword, 'query' => $this->cache_data['keywords'][$keyword]);
				}
			}

			if (isset($this->cache_data['keywords'][$route])) {
				$keyword = $route;
				$parts = array($keyword);
				$rows = array(array('keyword' => $keyword, 'query' => $this->cache_data['keywords'][$keyword]));
			}

			if (count($rows) == sizeof($parts)) {
				$queries = array();
				foreach ($rows as $row) {
					$queries[utf8_strtolower($row['keyword'])] = $row['query'];
				}

				reset($parts);
				foreach ($parts as $part) {
					if (!isset($queries[$part]))
						return false;
					$url = explode('=', $queries[$part], 2);

					if ($url[0] == 'category_id') {
						if (!isset($this->request->get['path'])) {
							$this->request->get['path'] = $url[1];
						} else {
							$this->request->get['path'] .= '_' . $url[1];
						}
					} elseif (count($url) > 1) {
						$this->request->get[$url[0]] = $url[1];
					}
				}
			} else {
				$this->request->get['route'] = 'error/not_found';
			}


			/* NeoSeo Action Manager - begin */
			if (isset($this->request->get['action_id'])) {
				$this->request->get['route'] = 'module/neoseo_action_manager/action';
			} else
			/* NeoSeo Action Manager - end */

			/* NeoSeo Blog - begin */
			if (isset($this->request->get['article_id'])) {
				$this->request->get['route'] = 'blog/neoseo_blog_article';
			} elseif (isset($this->request->get['blog_category_id'])) {
				$this->request->get['route'] = 'blog/neoseo_blog_category';
			} else if (isset($this->request->get['author_id'])) {
				$this->request->get['route'] = 'blog/neoseo_blog_author';
			} else
			/* NeoSeo Blog - end */

			if (isset($this->request->get['product_id'])) {
				$this->request->get['route'] = 'product/product';
				if (!isset($this->request->get['path'])) {
					$path = $this->getPathByProduct($this->request->get['product_id']);
					if ($path)
						$this->request->get['path'] = $path;
				}
			} elseif (isset($this->request->get['path'])) {
				$this->request->get['route'] = 'product/category';
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$this->request->get['route'] = 'product/manufacturer/info';
			} elseif (isset($this->request->get['information_id'])) {
				$this->request->get['route'] = 'information/information';
			} elseif (isset($this->cache_data['queries'][$route_])) {
				header($this->request->server['SERVER_PROTOCOL'] . ' 301 Moved Permanently');
				$this->response->redirect($this->cache_data['queries'][$route_]);
			} else {
				if (isset($queries[$parts[0]])) {
					$this->request->get['route'] = $queries[$parts[0]];
				}
			}

			$this->validate();

			if (isset($this->request->get['route'])) {
				return new Action($this->request->get['route']);
			}
		}
	}

	public function rewrite($link)
	{
		if (!$this->config->get('config_seo_url'))
			return $link;

		$seo_url = '';

		$component = parse_url(str_replace('&amp;', '&', $link));

		$data = array();
		parse_str($component['query'], $data);

		$route = $data['route'];
		unset($data['route']);

		switch ($route) {

			/* NeoSeo Blog - begin */
			case 'blog/neoseo_blog_article':
				if (isset($data['article_id'])) {
					if ($this->config->get('config_seo_url_include_path')) {
						$this->load->model('blog/neoseo_blog_article');
						$article_category = $this->model_blog_neoseo_blog_article->getMainCategory($data['article_id']);
						if ($article_category) {
							$data = array_merge(array('blog_category_id' => $article_category['category_id']), $data);
						}
					}
				}
				break;
			case 'blog/neoseo_blog_category':
				if (isset($data['blog_category_id'])) {
						$this->load->model('blog/neoseo_blog_category');
						$blog_parent_categories = $this->model_blog_neoseo_blog_category->getParentIds($data['blog_category_id']);
						if ($blog_parent_categories) {
							$data['blog_categories'] = $blog_parent_categories;
							$data['blog_categories'][] = $data['blog_category_id'];
							unset($data['blog_category_id']);
						}
				}
				break;
			/* NeoSeo Blog - end */

			case 'product/product':
				if (isset($data['product_id'])) {
					$tmp = $data;
					$data = array();
					if ($this->config->get('config_seo_url_include_path')) {
						$data['path'] = $this->getPathByProduct($tmp['product_id']);
						if (!$data['path'])
							return $link;
					}
					$data['product_id'] = $tmp['product_id'];

					/* NeoSeo UniSTOR - begin */
					// Add comments page to product
					if (isset($tmp['page'])) {
						$data['page'] = $tmp['page'];
					}
					/* NeoSeo UniSTOR - end */

					if (isset($tmp['tracking'])) {
						$data['tracking'] = $tmp['tracking'];
					}
				}
				break;

			case 'product/category':
				if (isset($data['path'])) {
					$category = explode('_', $data['path']);
					$category = end($category);
					$data['path'] = $this->getPathByCategory($category);
					if (!$data['path'])
						return $link;
				}
				break;

			case 'product/product/review':
			case 'information/information/agree':
				return $link;
				break;

			default:
				break;
		}

		if ($component['scheme'] == 'https') {
			$link = $this->config->get('config_ssl');
		} else {
			$link = $this->config->get('config_url');
		}

		$link .= 'index.php?route=' . $route;

		if (count($data)) {
			$link .= '&amp;' . urldecode(http_build_query($data, '', '&amp;'));
		}

		$manufacturer_id = false;
		$queries = array();
		if (!in_array($route, array('product/search'))) {
			foreach ($data as $key => $value) {
				switch ($key) {

					/* NeoSeo Blog - begin */
					case 'article_id':
					case 'author_id':
						$queries[] = $key . '=' . $value;
					case 'blog_category_id':
						if ($route == 'blog/neoseo_blog_category') {
							$queries[] = $key . '=' . $value;
						}
						unset($data[$key]);
						$postfix = 1;
						break;
					case 'blog_categories':
						foreach ($value as $category_id) {
							$queries[] = 'blog_category_id=' . $category_id;
						}
						unset($data[$key]);
						break;
					/* NeoSeo Blog - end */


					/* NeoSeo Action Manager - begin */
					case 'action_id':
						$queries[] = $key . '=' . $value;
						unset($data[$key]);
						break;
					/* NeoSeo Action Manager - end */

					case 'product_id':
					case 'category_id':
					case 'information_id':
					case 'order_id':
						$queries[] = $key . '=' . $value;
						unset($data[$key]);
						$postfix = 1;
						break;

					case 'path':
						$categories = explode('_', $value);
						foreach ($categories as $category) {
							$queries[] = 'category_id=' . $category;
						}
						unset($data[$key]);
						break;

					case 'manufacturer_id':
						$manufacturer_id = $value;
						$queries[] = $key . '=' . $value;
						unset($data[$key]);
						$postfix = 1;
						break;

					default:
						break;
				}
			}
		}

		if (empty($queries)) {
			$queries[] = $route;
		}

		$rows = array();
		foreach ($queries as $query) {
			if (isset($this->cache_data['queries'][$query])) {
				$rows[] = array('query' => $query, 'keyword' => $this->cache_data['queries'][$query]);
			}
		}

		if (count($rows) == count($queries)) {
			$aliases = array();
			foreach ($rows as $row) {
				$aliases[$row['query']] = $row['keyword'];
			}
			foreach ($queries as $query) {
				$seo_url .= '/' . rawurlencode($aliases[$query]);
			}
		}

		/* NeoSeo SEO Languages - begin */
		$this->load->model("module/neoseo_seo_languages");
		$link = $this->model_module_neoseo_seo_languages->insertLanguage($link, $this->session->data['language']);
		/* NeoSeo SEO Languages - end */
		if ($seo_url == '')
			return $link;

		$seo_url = trim($seo_url, '/');

		if ($component['scheme'] == 'https') {
			$seo_url = $this->config->get('config_ssl') . $seo_url;
		} else {
			$seo_url = $this->config->get('config_url') . $seo_url;
		}

		if (isset($postfix)) {
			$seo_url .= trim($this->config->get('config_seo_url_postfix'));
		} else {
			$seo_url .= '/';
		}

		if (substr($seo_url, -2) == '//') {
			$seo_url = substr($seo_url, 0, -1);
		}

		if (count($data)) {
			$seo_url .= '?' . urldecode(http_build_query($data, '', '&amp;'));
		}

		/* NeoSeo SEO Languages - begin */
		$this->load->model("module/neoseo_seo_languages");
		$seo_url = $this->model_module_neoseo_seo_languages->insertLanguage($seo_url, $this->session->data['language']);
		/* NeoSeo SEO Languages - end */
		/* NeoSeo SEO Pagination - begin */
		$this->load->model("module/neoseo_seo_pagination");
		$seo_url = $this->model_module_neoseo_seo_pagination->replacePage($seo_url);
		/* NeoSeo SEO Pagination - end */
		return $seo_url;
	}

	private function getPathByProduct($product_id)
	{
		$product_id = (int) $product_id;
		if ($product_id < 1)
			return false;

		static $path = null;
		if (!isset($path)) {
			$path = $this->cache->get('product.seopath');
			if (!isset($path))
				$path = array();
		}

		if (!isset($path[$product_id])) {
			$query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . $product_id . "' ORDER BY main_category DESC LIMIT 1");

			$path[$product_id] = $this->getPathByCategory($query->num_rows ? (int) $query->row['category_id'] : 0);

			$this->cache->set('product.seopath', $path);
		}

		return $path[$product_id];
	}

	private function getPathByCategory($category_id)
	{
		$category_id = (int) $category_id;
		if ($category_id < 1)
			return false;

		static $path = null;
		if (!isset($path)) {
			$path = $this->cache->get('category.seopath');
			if (!isset($path))
				$path = array();
		}

		if (!isset($path[$category_id])) {
			$max_level = 10;

			$sql = "SELECT CONCAT_WS('_'";
			for ($i = $max_level - 1; $i >= 0; --$i) {
				$sql .= ",t$i.category_id";
			}
			$sql .= ") AS path FROM " . DB_PREFIX . "category t0";
			for ($i = 1; $i < $max_level; ++$i) {
				$sql .= " LEFT JOIN " . DB_PREFIX . "category t$i ON (t$i.category_id = t" . ($i - 1) . ".parent_id)";
			}
			$sql .= " WHERE t0.category_id = '" . $category_id . "'";

			$query = $this->db->query($sql);

			$path[$category_id] = $query->num_rows ? $query->row['path'] : false;

			$this->cache->set('category.seopath', $path);
		}

		return $path[$category_id];
	}

	private function validate()
	{
		if (isset($this->request->get['route']) && $this->request->get['route'] == 'error/not_found') {
			return;
		}
		if (ltrim($this->request->server['REQUEST_URI'], '/') == 'sitemap.xml') {
			$this->request->get['route'] = 'feed/google_sitemap';
			return;
		}

		if (empty($this->request->get['route'])) {
			$this->request->get['route'] = 'common/home';
		}

		if (isset($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
			return;
		}

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$config_ssl = substr($this->config->get('config_ssl'), 0, $this->strpos_offset('/', $this->config->get('config_ssl'), 3) + 1);
			$url = str_replace('&amp;', '&', $config_ssl . ltrim($this->request->server['REQUEST_URI'], '/'));
			$seo = str_replace('&amp;', '&', $this->url->link($this->request->get['route'], $this->getQueryString(array('route')), true));
		} else {
			$config_url = substr($this->config->get('config_url'), 0, $this->strpos_offset('/', $this->config->get('config_url'), 3) + 1);
			$url = str_replace('&amp;', '&', $config_url . ltrim($this->request->server['REQUEST_URI'], '/'));
			$seo = str_replace('&amp;', '&', $this->url->link($this->request->get['route'], $this->getQueryString(array('route')), false));
		}

		/* NeoSeo SEO Languages - begin */
		$this->load->model("module/neoseo_seo_languages");
		$seo = $this->model_module_neoseo_seo_languages->insertLanguage($seo, $this->session->data['language']);
		/* NeoSeo SEO Languages - begin */

		/* NeoSeo SEO Pagination - begin */
		if (strpos($url, "index.php") === false) {
			$this->load->model("module/neoseo_seo_pagination");
			if (isset($this->request->get['page']) && $this->request->get['route'] != 'common/home') {
				if (strpos($seo, "?") !== false) {
					$seo .= "&page=" . $this->request->get['page'];
				} else {
					$seo .= "?page=" . $this->request->get['page'];
				}
			}
			$seo = $this->model_module_neoseo_seo_pagination->replacePage($seo);
			$seo = str_replace("&amp;", "&", $seo);
			if (strpos($url, "page=")) {
				header($this->request->server['SERVER_PROTOCOL'] . ' 301 Moved Permanently');
				$this->response->redirect($seo, 301);
			}
		}
		/* NeoSeo SEO Pagination - begin */

		if (rawurldecode($url) != rawurldecode($seo)) {
			header($this->request->server['SERVER_PROTOCOL'] . ' 301 Moved Permanently');

			/* NeoSeo SEO Pagination - begin */
			$this->response->redirect($seo, 301);
			/* NeoSeo SEO Pagination - end */
		}
	}

	private function strpos_offset($needle, $haystack, $occurrence)
	{
		// explode the haystack
		$arr = explode($needle, $haystack);
		// check the needle is not out of bounds
		switch ($occurrence) {
			case $occurrence == 0:
				return false;
			case $occurrence > max(array_keys($arr)):
				return false;
			default:
				return strlen(implode($needle, array_slice($arr, 0, $occurrence)));
		}
	}

	private function getQueryString($exclude = array())
	{
		if (!is_array($exclude)) {
			$exclude = array();
		}

		return urldecode(http_build_query(array_diff_key($this->request->get, array_flip($exclude))));
	}

}

?>
