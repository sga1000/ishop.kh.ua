<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelFeedNeoSeoGoogleFeed extends NeoSeoModel
{
	const OPTION_VALUE_SEP = ':';
	const VALUES_SEP = ',';
	const OPTIONS_SEP = ';';

	private $option_values_to_keywords = null;
	private $option_values_to_options = null;

	public function __construct($registry)
    {
        parent::__construct($registry);
        $this->_moduleSysName = 'neoseo/google_feed';
        $this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()()
        $this->_logFile = $this->_moduleSysName() . '.log';
        $this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;

	    $this->option_values_to_options = $this->cache->get('neoseo_filter_ov2o');
	    if (!$this->option_values_to_options) {
		    $this->option_values_to_options = array();

		    $sql = "SELECT fov.option_id, fov.option_value_id 
				FROM `" . DB_PREFIX . "filter_option_value` fov";
		    $query = $this->db->query($sql);
		    foreach ($query->rows as $row) {

			    $this->option_values_to_options[$row['option_value_id']] = $row['option_id'];
		    }

		    //$this->cache->set('neoseo_filter_ov2o', $this->option_values_to_options);
	    }


	    $this->params = array(
            'status' => 1,
            'debug'      => 0,
            'list_feeds' => array(),
        );
    }

    public function install()
    {
        // Значения параметров по умолчанию
        $this->initParams($this->params);

        // Создаем новые и недостающие таблицы в актуальной структуре
        $this->installTables();

        // Добавляем права на нестандартные контроллеры, если они используются
        $this->load->model('user/user_group');
        $this->model_user_user_group->addPermission($this->user->getGroupId(), 'access', 'tool/' . $this->_moduleSysName());
        $this->model_user_user_group->addPermission($this->user->getGroupId(), 'modify', 'tool/' . $this->_moduleSysName());

        return TRUE;
    }
    public function installTables(){
        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "neoseo_google_category` (
			  `category_id` INT NOT NULL,
			  `parent_id` INT NOT NULL,
			  `language_id` INT NOT NULL,
        	  `name` varchar(128) NOT NULL
			) DEFAULT CHARSET=utf8;");

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "category` LIKE 'google_category_id';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "category`  ADD COLUMN `google_category_id` int(11) NOT NULL;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "category` LIKE 'google_feed';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "category`  ADD COLUMN `google_feed` int(1) NOT NULL;";
            $this->db->query($sql);
        }

	    $sql = "SHOW TABLES LIKE '%filter_page';";
	    $query = $this->db->query($sql);
	    if ($query->num_rows) {
		    $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page` LIKE 'google_category_id';";
		    $query = $this->db->query($sql);
		    if (!$query->num_rows) {
			    $sql = "ALTER TABLE `" . DB_PREFIX . "filter_page`  ADD COLUMN `google_category_id` int(11) NOT NULL;";
			    $this->db->query($sql);
		    }

		    $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page` LIKE 'google_feed';";
		    $query = $this->db->query($sql);
		    if (!$query->num_rows) {
			    $sql = "ALTER TABLE `" . DB_PREFIX . "filter_page`  ADD COLUMN `google_feed` int(1) NOT NULL;";
			    $this->db->query($sql);
		    }
	    }

        $language_category = array();
        $query = $this->db->query("SELECT DISTINCT language_id FROM `" . DB_PREFIX . "neoseo_google_category`");
        foreach ($query->rows as $row) {
            $language_category[$row['language_id']] = $row['language_id'];
        }

        $this->load->model('localisation/language');
        $code = '';
        $google_category = array();
        foreach ($this->model_localisation_language->getLanguages() as $language) {
            switch ($language['code']) {
                case 'ru':
                    $code = 'ru-RU';
                    break;
                case 'ua':
                    $code = 'uk-UA';
                    break;
                case 'en':
                    $code = 'en-US';
                    break;
                default:
                    $code = 'en-US';
            }
            if (!in_array($language['language_id'], $language_category)) {
                $google_category = $this->getGoogleCategory($code);
                foreach ($google_category as $category_id => $name) {
                    $this->db->query("INSERT INTO `" . DB_PREFIX . "neoseo_google_category` (category_id, language_id, name) "
                        . "VALUE ('" . $category_id . "', '" . $language['language_id'] . "', '" . $this->db->escape($name) ."')");
                }
            }
        }

        return TRUE;
    }

    public function upgrade(){

        // Добавляем недостающие новые параметры
        $this->initParams($this->params);

        // Создаем недостающие таблицы в актуальной структуре
        $this->installTables();

    }

    public function uninstall()
    {
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "neoseo_google_category`");

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "category` LIKE 'google_feed';";
        $query = $this->db->query($sql);
        if ($query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "category`  DROP `google_feed`;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "category` LIKE 'google_category_id';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "category`  DROP `google_category_id`;";
            $this->db->query($sql);
        }

	    $sql = "SHOW TABLES LIKE '%filter_page';";
	    $query = $this->db->query($sql);
	    if ($query->num_rows) {
		    $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page` LIKE 'google_feed';";
		    $query = $this->db->query($sql);
		    if ($query->num_rows) {
			    $sql = "ALTER TABLE `" . DB_PREFIX . "filter_page`  DROP `google_feed`;";
			    $this->db->query($sql);
		    }

		    $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page` LIKE 'google_category_id';";
		    $query = $this->db->query($sql);
		    if (!$query->num_rows) {
			    $sql = "ALTER TABLE `" . DB_PREFIX . "filter_page`  DROP `google_category_id`;";
			    $this->db->query($sql);
		    }
	    }

	    // Удаляем права на нестандартные контроллеры, если они используются
        $this->load->model('user/user_group');
        $this->model_user_user_group->removePermission($this->user->getGroupId(), 'access', 'tool/' . $this->_moduleSysName());
        $this->model_user_user_group->removePermission($this->user->getGroupId(), 'modify', 'tool/' . $this->_moduleSysName());

        return TRUE;
    }

    private function getGoogleCategory($language)
    {
        $category = array();
        $patt = '~^(\d*)~';
        $handle = fopen("https://www.google.com/basepages/producttype/taxonomy-with-ids." . $language . ".txt", "r");
        while (!feof($handle)) {
            $patt = '~^(\d*) -~';
            $buffer = fgets($handle, 4096);
            if (preg_match($patt,$buffer,$match) == 1) {
                $patt = '~- (.*)~';
                preg_match($patt,$buffer,$match_text);
                $category[$match[1]] = $match_text[1];
            }
        }
        fclose($handle);
        return $category;
    }

    public function getCategory($filter_data = array())
    {
        $sql = "SELECT * FROM `" . DB_PREFIX . "neoseo_google_category` WHERE language_id = '" . (int) $this->config->get('config_language_id') . "'";
        if (isset($filter_data['filter_name'])) {
            $sql .= " AND name LIKE '%" . $this->db->escape($filter_data['filter_name']) . "%'";
        }
        if (isset($filter_data['limit'])) {
            $sql .= " LIMIT 0," . (int)$filter_data['limit'];
        }
        $query = $this->db->query($sql);
        return $query->rows;
    }

    public function getCategoryByCategory($category_id)
    {
        $sql = "SELECT ngc.*, c.google_feed FROM `" . DB_PREFIX . "neoseo_google_category` ngc"
            . " LEFT JOIN `" . DB_PREFIX . "category` c ON (c.google_category_id = ngc.category_id)"
            . " WHERE language_id = '" . (int) $this->config->get('config_language_id') . "'"
            . " AND c.category_id = '" . (int)$category_id . "'";
        $query = $this->db->query($sql);
        return $query->row;
    }

	public function getCategoryByFilter($page_id)
	{
		$sql = "SELECT * FROM `" . DB_PREFIX . "filter_page` "
			. " WHERE  page_id = '" . (int)$page_id . "'";
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function setDataCategory($data)
    {
        $this->db->query("UPDATE " . DB_PREFIX . "category SET google_category_id = '" . ($data['google_category_name'] != '' ? (int)$data['google_category_id'] : 0)
            . "', `google_feed` = '" . (isset($data['google_feeded']) ? (int)$data['google_feeded'] : 0) . "' WHERE category_id = '" . (int)$data['category_id'] . "'");

        return true;
    }

	public function setDataSeofilter($data)
	{
		$this->db->query("UPDATE " . DB_PREFIX . "filter_page SET google_category_id = '" . (int)$data['google_category_id']
			. "', `google_feed` = '" . (isset($data['google_feeded']) ? (int)$data['google_feeded'] : 0) . "' WHERE page_id = '" . (int)$data['page_id'] . "'");

		return true;
	}

	public function getProducts($data = array()) {

        $sql = "SELECT p.*, pd.*, m.name as brand, p2c.category_id, c.google_category_id FROM "
            . DB_PREFIX . "product p LEFT JOIN "
            . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";

        $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";
		$sql .= " LEFT JOIN " . DB_PREFIX . "category c ON (c.category_id = p2c.category_id)";
        $sql .= " LEFT JOIN " . DB_PREFIX . "manufacturer m ON (m.manufacturer_id = p.manufacturer_id)";
        $sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";


        if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
            $sql .= " AND p.quantity = '" . (int)$data['filter_quantity'] . "'";
        }

        if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
            $sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";
        }

        if (isset($data['filter_categories'])) {
            $sql .= " AND p2c.category_id IN (" . implode(',', $data['filter_categories']) . ")";
        }

		if (isset($data['filter_nsf'])) {
			$sql .= " AND p.product_id IN (" . implode(",",$data['filter_nsf']) . ") ";
		}


        $sql .= " GROUP BY p.product_id";
        $sql .= " ORDER BY pd.name ASC";

        $query = $this->db->query($sql);

		$result =array();
		foreach ($query->rows as $row) {
			$row['google_category'] = '';
			if ($row['google_category_id'] != 0) {
				$sql = "SELECT *  FROM " . DB_PREFIX . "category c"
					. " LEFT JOIN " . DB_PREFIX . "neoseo_google_category ngc ON (c.google_category_id = ngc.category_id)"
					. " WHERE ngc.language_id = '" . (int)$this->config->get ('config_language_id') . "' AND c.category_id = '" . $row['category_id'] . "'";
				$query_category = $this->db->query($sql);
				if ($query_category->num_rows) {
					$row['google_category'] = $query_category->row['name'];
				}
			} else {
				$sql = "SELECT *  FROM " . DB_PREFIX . "category_description  WHERE language_id = '" . (int)$this->config->get ('config_language_id') . "' AND category_id = '" . $row['category_id'] . "'";
				$query_category = $this->db->query($sql);
				if ($query_category->num_rows) {
					$row['google_category'] = $query_category->row['name'];
				}
			}
			$result[] = $row;
		}

		return $result;
    }

	public function getPages($data = array()) {

		$sql = "SELECT fp.*, fpd.*  FROM " . DB_PREFIX . "filter_page fp"
			. " LEFT JOIN " . DB_PREFIX . "filter_page_description fpd ON (fp.page_id = fpd.page_id)";

		$sql .= " WHERE fpd.language_id = '" . (int)$this->config->get('config_language_id') . "'";


		if (isset($data['filter_page']) && count($data['filter_page']) > 0) {
			$sql .= " AND fp.page_id IN (" . implode(',', $data['filter_page']) . ")";
		}

		$query = $this->db->query($sql);

		$result =array();
		foreach ($query->rows as $row) {
			$row['google_category'] = '';
			if ($row['google_category_id'] == 1) {
				$sql = "SELECT c.*, ngc.*  FROM " . DB_PREFIX . "category c"
					. " LEFT JOIN " . DB_PREFIX . "neoseo_google_category ngc ON (c.google_category_id = ngc.category_id)"
					. " WHERE ngc.language_id = '" . (int)$this->config->get ('config_language_id') . "' AND c.category_id = '" . $row['category_id'] . "'";
				$query_category = $this->db->query($sql);
				if ($query_category->num_rows) {
					$row['google_category'] = $query_category->row['name'];
				}
			} else {
				$sql = "SELECT c.*, cd.*  FROM " . DB_PREFIX . "category c"
					. " LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id)"
					. " WHERE cd.language_id = '" . (int)$this->config->get ('config_language_id') . "' AND c.category_id = '" . $row['category_id'] . "'";
				$query_category = $this->db->query($sql);
				if ($query_category->num_rows) {
					$row['google_category'] = $query_category->row['name'];
				}
			}
			$result[] = $row;
		}

		return $result;
	}

	protected function getItemKeywords ($key)
	{
		$version = "";
		if (defined ('VERSION')) {
			$version = constant ('VERSION');
		}
		if ($version < 3) {
			$sql = "SELECT substr(query," . (strlen ($key) + 2) . ") as keyword_id, keyword FROM `" . DB_PREFIX . "url_alias` WHERE query like \"$key=%\";";
		} else {
			$sql = "SELECT substr(query," . (strlen ($key) + 2) . ") as keyword_id, keyword FROM `" . DB_PREFIX . "seo_url` WHERE query like \"$key=%\" AND language_id = '" . (int)$this->config->get ('config_language_id') . "';";
		}
		$keywordsData = $this->db->query ($sql);

		$keywords = array();

		foreach ($keywordsData->rows as $keyword) {
			$keywords[$keyword["keyword_id"]] = rawurlencode ($keyword["keyword"]);
		}
		unset($keywordsData);

		return $keywords;
	}

	protected function getProductKeywords ()
	{
		static $_productKeywords = -1;

		if ($_productKeywords != -1)
			return $_productKeywords;

		$_productKeywords = $this->getItemKeywords ("product_id");
		return $_productKeywords;
	}

	protected function getCategoryKeywords ()
	{
		static $_categoryKeywords = -1;

		if ($_categoryKeywords != -1)
			return $_categoryKeywords;

		$_categoryKeywords = $this->getItemKeywords ("category_id");
		return $_categoryKeywords;
	}

	protected function getCategoryPath ($categoryId = 0)
	{
		if (!$categoryId)
			return "";

		if ($this->config->get('config_category_short')) {
			return $categoryId;
		}

		$pathes = array();
		$target = $categoryId;
		$path = "$categoryId";
		$categories = $this->getCategories();
		while (true) {
			array_unshift ($pathes, $target);
			$parent_id = isset($categories[$target]) ? $categories[$target] : 0;
			if (!$parent_id)
				break;
			if (in_array ($parent_id, $pathes)) {
				$message = "Обнаружено зацикливание дерева категорий на категории $categoryId: " . implode (",", $pathes);
				$this->log ($message);
				return "";
			}
			$path = $parent_id . "_" . $path;
			$target = $parent_id;
		}

		return $path;
	}

	public function getProductSeoUrl($product)
	{
		$productKeywords = $this->getProductKeywords ();
		$categoryKeywords = $this->getCategoryKeywords ();
		$product_id = $product['product_id'];
		$category_id = $product["category_id"];
		// Тут полная иммитация режима SEO_PRO
		if (!isset($productKeywords[$product_id])) {
			// У нас нет ЧПУ даже для товара.
			$url = $this->store_host . "index.php?route=product/product&amp;product_id=" . $product['product_id'];
		} else if (!$category_id) {
			// Родительская категория отсутствует, либо она не требуется в ЧПУ
			$url = $this->store_host . $productKeywords[$product_id];
		} else {
			// Полный вариант работы - формируем ЧПУ
			$url = $this->store_host;
			$categories = explode ("_", $this->getCategoryPath ($category_id));
			$broken = false;
			foreach ($categories as $categoryId) {
				if (!isset($categoryKeywords[$categoryId])) {
					// Одна из категорий не содержит ЧПУ
					$url = $this->store_host . "index.php?route=product/product&amp;product_id=" . $product['product_id'];
					$broken = true;
					break;
				}
				$url .= $categoryKeywords[$categoryId] . "/";
			}
			if (!$broken)
				$url .= $productKeywords[$product_id];
		}
		return rtrim (($this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG), "/") . '/' . $url;
	}

	public function getPageSeoUrl($page)
	{
		$categoryKeywords = $this->getCategoryKeywords();

		$url = rtrim (($this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG), "/") . '/';
		$categories = explode("_", $this->getCategoryPath($page['category_id']));
		$broken = false;
		$keyword = $page['keyword'];
		if (!isset($page['use_direct_link']) || (isset($page['use_direct_link']) && $page['use_direct_link'] != 1)) {
			foreach ($categories as $categoryId) {
				if (!isset($categoryKeywords[$categoryId])) {
					// Одна из категорий не содержит ЧПУ - не сложилось
					$url = $this->store_host . $keyword . "/";
					$broken = true;
					break;
				}
				$url .= $categoryKeywords[$categoryId] . "/";
			}
		}
		if (!$broken)
			$url .= $keyword . ((isset($row['use_direct_link']) && $row['use_direct_link'] != 1) ? "/" : '');

		return $url;
	}

	protected function getCategories()
	{

		static $_categories = -1;
		if ($_categories != -1)
			return $_categories;

		$sql = "SELECT c.category_id, c.parent_id FROM " . DB_PREFIX . "category c  WHERE c.status = '1' ";
		$query = $this->db->query($sql);

		$categories = array();
		foreach ($query->rows as $row) {
			$categories[$row['category_id']] = $row['parent_id'];
		}
		$_categories = $categories;

		return $_categories;
	}

	public function hasNeoseoFilter()
    {
        $sql = "SHOW TABLES LIKE '%filter_page';";
        $query = $this->db->query($sql);
        if ($query->num_rows) {
            return true;
        }
        return false;
    }

	private function getOptionValuesJoins($option_value_ids)
	{
		$options = array();
		foreach ($option_value_ids as $option_value_id) {
			if (!isset($this->option_values_to_options[$option_value_id])) {
				continue;
			}
			$option_id = $this->option_values_to_options[$option_value_id];
			if (!isset($options[$option_id])) {
				$options[$option_id] = array();
			}
			$options[$option_id][] = $option_value_id;
		}
		$sql = "";
		$i = 1;
		foreach ($options as $option_id => $_option_value_ids) {
			$sql .= " INNER JOIN `" . DB_PREFIX . "filter_option_value_to_product` fovp_{$i} ON ( fovp_{$i}.product_id = p.product_id AND fovp_{$i}.option_value_id IN (" . implode(",", $_option_value_ids) . ") )";
			$i++;
		}
		return $sql;
	}

	public function getProductIds($option_value_ids, $category_id)
	{

		asort($option_value_ids);
		$product_ids = array();

		$option_manufacturer_ids = array();
		$other_option_value_ids = array();
		$on_option_series = false;

		if ($option_value_ids) {
			foreach ($option_value_ids as $option_value_id) {
				if ($option_value_id > 0) {
					$other_option_value_ids[] = $option_value_id;
				} else {
					$option_manufacturer_ids[] = -$option_value_id;
				}
			}
		}
		$sql = "SELECT p.product_id 
			  FROM `" . DB_PREFIX . "product` p
				   INNER JOIN `" . DB_PREFIX . "product_to_category` p2c ON ( p.product_id = p2c.product_id AND p2c.category_id = '" . (int)$category_id . "')";

		if ($other_option_value_ids) {
			$sql .= $this->getOptionValuesJoins($other_option_value_ids);
		}

		$sql .= " WHERE p.status = 1 ";
		if ($option_manufacturer_ids) {
			$sql .= " AND p.manufacturer_id IN (" . implode(",", $option_manufacturer_ids) . ") ";
		}

		$query = $this->db->query($sql);
		//echo $sql; exit;

		foreach ($query->rows as $row) {
			$product_ids[] = (int)$row['product_id'];
		}

		return $product_ids;
	}
	public function getProductIdsByFilter($nsf, $category_id = 0)
	{

		$price = '';

		$selected_option_value_ids = array();
		$options = explode(self::OPTIONS_SEP, (string)$nsf);
		foreach ($options as $option) {
			$parts = explode(self::OPTION_VALUE_SEP, $option);
			if (count($parts) != 2) {
				continue;
			}

			if ($parts[0] === 'p') {
				$price = $parts[1];
				continue;
			}

			$option_values_ids = explode(self::VALUES_SEP, $parts[1]);
			foreach ($option_values_ids as $option_value_id) {
				$selected_option_value_ids[] = (int)$option_value_id;
			}
		}

		if (!$price && !$selected_option_value_ids) {
			return array();
		}

		if ($selected_option_value_ids) {
			$product_ids = $this->getProductIds($selected_option_value_ids, $category_id);
		} else {
			$product_ids = array();
		}

		if ($price) {
			$price_parts = explode("-", $price);
			$price_begin = $price_parts[0];
			$price_end = isset($price_parts[1]) ? $price_parts[1] : $price_parts[0];

			// Коррекция по курсу
			$price_begin = floor($price_begin / $this->currency->getValue());
			$price_end = ceil($price_end / $this->currency->getValue());

			// А теперь еще выберем продукты, которые соответствуют по цене и находятся в нужной категории
			$sql = "SELECT DISTINCT p.product_id ";
			$sql .= "\nFROM `" . DB_PREFIX . "product` p ";
			$sql .= "\n     INNER JOIN `" . DB_PREFIX . "product_to_category` p2c ON ( p.product_id = p2c.product_id ) ";
			if ($this->use_discount) {
				$sql .= "
					LEFT JOIN `" . DB_PREFIX . "product_discount` pd ON ( 
						p.product_id = pd.product_id 
						AND pd.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "'
						AND pd.product_id = p.product_id  
						AND pd.quantity > '0' 
						AND (
							(pd.date_start = '0000-00-00' OR pd.date_start < '" . $this->db->escape(date('Y-m-d')) . "') 
							AND 
							(pd.date_end = '0000-00-00' OR pd.date_end > '" . $this->db->escape(date('Y-m-d')) . "')
						)
					)\n";
			}

			if ($this->use_special) {
				$sql .= "
					LEFT JOIN `" . DB_PREFIX . "product_special` ps ON ( 
						p.product_id = ps.product_id 
						AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' 
						AND (
							(ps.date_start = '0000-00-00' OR ps.date_start < '" . $this->db->escape(date('Y-m-d')) . "') 
							AND 
							(ps.date_end = '0000-00-00' OR ps.date_end > '" . $this->db->escape(date('Y-m-d')) . "')
						) 
					)\n";
			}

			$sql .= "\nWHERE ";

			if ($this->use_discount and $this->use_special) {
				$sql .= "\n CASE WHEN ps.price THEN ( ps.price >= " . (int)$price_begin . " AND ps.price <= " . (int)$price_end . " ) WHEN pd.price THEN ( pd.price >= " . (int)$price_begin . " AND pd.price <= " . (int)$price_end . " ) ELSE ( p.price >= " . (int)$price_begin . " AND p.price <= " . (int)$price_end . " ) END ";
			} else if ($this->use_special) {
				$sql .= "\n CASE WHEN ps.price THEN ( ps.price >= " . (int)$price_begin . " AND ps.price <= " . (int)$price_end . " ) ELSE ( p.price >= " . (int)$price_begin . " AND p.price <= " . (int)$price_end . " ) END ";
			} else if ($this->use_discount) {
				$sql .= "\n CASE WHEN pd.price THEN ( pd.price >= " . (int)$price_begin . " AND pd.price <= " . (int)$price_end . " ) ELSE ( p.price >= " . (int)$price_begin . " AND p.price <= " . (int)$price_end . " ) END ";
			} else {
				$sql .= " ( p.price >= " . (int)$price_begin . " AND p.price <= " . (int)$price_end . " ) ";
			}


			if ($product_ids) {
				$sql .= " AND p.product_id IN (" . implode(",", $product_ids) . ")";
			}


			$query = $this->query($sql);
			if (!$query->num_rows) {
				return array();
			}

			$product_ids = array();
			foreach ($query->rows as $row) {
				$product_ids[] = (int)$row['product_id'];
			}
		}

		return $product_ids;
	}

}