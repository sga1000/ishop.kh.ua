<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelFeedNeoSeoFeeds extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_feeds';
		$this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()()
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;

		$this->params = array(
			'status' => 1,
			'debug' => 0,
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
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "neoseo_feeds` (
              `neoseo_feed_id` INT NOT NULL AUTO_INCREMENT,
              `name` VARCHAR(255),
              `cod` VARCHAR(60),
              `status` INT(3),
               PRIMARY KEY (`neoseo_feed_id`)
            ) DEFAULT CHARSET=utf8;");
	}

	public function upgrade(){

		// Добавляем недостающие новые параметры
		$this->initParams($this->params);

		// Создаем недостающие таблицы в актуальной структуре
		$this->installTables();

	}

	public function uninstall()
	{
		// Удаляем таблицы модуля
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "neoseo_feeds");


		// Удаляем права на нестандартные контроллеры, если они используются
		$this->load->model('user/user_group');
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'access', 'tool/' . $this->_moduleSysName());
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'modify', 'tool/' . $this->_moduleSysName());

		return TRUE;
	}

    public function getFeeds()
    {
        $feeds = array();
        $files = glob(DIR_APPLICATION . 'controller/feed/neoseo/*.php');

        foreach ($files as $file) {
            $feeds[basename($file, '_feed.php')] = $this->load->controller('feed/neoseo/'. basename($file, '.php') . '/getName');
        }

        $result = array();
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "neoseo_feeds");
        foreach ($feeds as $feed => $name) {
            $search = array_filter($query->rows, function ($item) use ($feed) {
                return $item['cod'] == $feed ? $item : false;
            });
            if ($search) {
                $result[] = array_pop($search);
            } else {
                $result[] = [
                    'cod' => $feed,
                    'name' => $name,
                    'status' => 1,
                ];
                $this->db->query("INSERT INTO " . DB_PREFIX . "neoseo_feeds SET cod = '" . $feed . "', name = '" . $name . "', status = 1");
            }
        }

        return $result;
    }

    public function getFeedsDB()
    {
        $result = array();
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "neoseo_feeds");

        return $query->rows;
    }

    //удалить)
    public function getFeedsData($method, $arg = array())
    {
        $result = array();
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "neoseo_feeds WHERE status = 1");
        foreach ($query->rows as $row) {
            $result[] = $this->load->controller('feed/neoseo/'. $row['cod'] . '_feed/' . $method);
        }
        return $result;
    }
}

