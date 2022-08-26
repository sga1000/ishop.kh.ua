<?php

require_once(DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoBrokenLinks extends NeoSeoModel
{

    public function __construct($registry)
    {
        parent::__construct($registry);
        $this->_moduleName = "NeoSeo Broken Links";
        $this->_moduleSysName = "neoseo_broken_links";
        $this->_logFile = $this->_moduleSysName . ".log";
        $this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
    }

    public function install()
    {
        // Создаем недостающие таблицы в актуальной структуре
        $this->installTables();

        $params = array(
            $this->_moduleSysName . '_status' => 1,
            $this->_moduleSysName . '_debug' => 0,
        );
        $this->load->model('setting/setting');
        $this->model_setting_setting->editSetting($this->_moduleSysName, $params);

        $this->load->model('user/user_group');
        $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'tool/' . $this->_moduleSysName);
        $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'tool/' . $this->_moduleSysName);

        return TRUE;
    }

    public function installTables()
    {
        $sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "notfound` (
			`notfound_id` int(11) NOT NULL AUTO_INCREMENT,
			`ip` varchar(255) NOT NULL,
			`browser` text NOT NULL,
			`request_uri` text NOT NULL,
			`referer` text NOT NULL,
			`date_record` datetime NOT NULL,
			PRIMARY KEY (`notfound_id`)
			) DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
        ";
        $this->db->query($sql);
    }

    public function upgrade()
    {
        // Создаем новые и недостающие таблицы в актуальной структуре
        $this->installTables();
    }

    public function uninstall()
    {
        $this->db->query("DELETE FROM `" . DB_PREFIX . "setting` WHERE `code` = '" . $this->_moduleSysName . "'");
        $this->db->query('DROP TABLE IF EXISTS `' . DB_PREFIX . 'notfound`');
        return TRUE;
    }

}

?>