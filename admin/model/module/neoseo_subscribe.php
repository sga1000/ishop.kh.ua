<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoSubscribe extends NeoSeoModel {

    public function __construct($registry) {
        parent::__construct($registry);
        $this->_moduleSysName = "neoseo_subscribe";
        $this->_logFile = $this->_moduleSysName . ".log";
        $this->debug = $this->config->get($this->_moduleSysName . "_status") == 1;
    }
    public function installTables()
    {
        $sql = "
        CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "subscribe` (
            `subscribe_id` int(11) NOT NULL AUTO_INCREMENT,
            `date` datetime NOT NULL,
            `email` varchar(255) NOT NULL,
            `name` varchar(255) NOT NULL,
            `store_id` int(3) NOT NULL DEFAULT '0',
            PRIMARY KEY (`subscribe_id`)
        ) DEFAULT CHARSET=utf8;
		";

        $this->db->query($sql);
    }
    public function install() {
        $this->installTables();
        $data = $this->language->load("module/neoseo_subscribe");
        // Недостающие таблицы



        $this->load->model('localisation/language');
        foreach ($this->model_localisation_language->getLanguages() as $language) {
            $title[$language['language_id']] = $this->language->get('text_title');
            $message[$language['language_id']] = $this->language->get('param_message');
            $message_error[$language['language_id']] = $this->language->get('param_message_error');
        }
        // Настройки по умолчанию
        $params = array(
            $this->_moduleSysName . "_status" => 1,
            $this->_moduleSysName . "_debug" => 0,
            $this->_moduleSysName . "_title" => $title,
            $this->_moduleSysName . "_message" => $message,
            $this->_moduleSysName . "_message_error" => $message_error,
            $this->_moduleSysName . "_notify_subject" => $this->language->get('param_notify_subject'),
            $this->_moduleSysName . "_notify_message" => $this->language->get('param_notify_message'),
        );

        $this->load->model('setting/setting');
        $this->model_setting_setting->editSetting($this->_moduleSysName, $params);

        // Недостающие права
        $this->load->model('user/user_group');
        $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'customer/neoseo_subscribe');
        $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'customer/neoseo_subscribe');

        return TRUE;
    }

    public function uninstall() {

        return TRUE;
    }

	public function upgrade() {
        $this->installTables();
        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "subscribe` LIKE 'name';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "subscribe`  ADD COLUMN `name` VARCHAR(255) NOT NULL  AFTER `email`;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "subscribe` LIKE 'store_id';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "subscribe`  ADD COLUMN `store_id`int(3) NOT NULL DEFAULT '0' AFTER `email`;";
            $this->db->query($sql);
        }
		return TRUE;
	}
}

?>