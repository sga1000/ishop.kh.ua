<?php

require_once(DIR_SYSTEM . "/engine/neoseo_model.php");


class ModelModuleNeoSeoOrderReferrer extends NeoSeoModel
{

    public function __construct( $registry )
    {
        parent::__construct($registry);
        $this->_moduleSysName = "neoseo_order_referrer";
        $this->_logFile = $this->_moduleSysName . ".log";
        $this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
    }

    public function checkInstall()
    {
        $query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "order_referrer'");
        if (!$query->num_rows)
            $this->install();
    }

    // Install/Uninstall
    public function install()
    {
        $params = array(
            $this->_moduleSysName . '_status' => 1,
            $this->_moduleSysName . '_debug' => 0,
            $this->_moduleSysName . '_list_short_url_status' => 1,
            $this->_moduleSysName . '_detail_short_url_status' => 0,
            $this->_moduleSysName . '_first_referrer_days' => 365,
            $this->_moduleSysName . '_last_referrer_hours' => 24,
            $this->_moduleSysName . '_bad_user_agents' => "bot\nyandex\nYaDirectFetcher\nspider\nslurp\ncurl\nltx71.com\ncrawler",
        );
        $this->load->model('setting/setting');
        $this->model_setting_setting->editSetting($this->_moduleSysName, $params);

        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "order_referrer` ( 
            `order_referrer_id` int(11) NOT NULL AUTO_INCREMENT,
            `time_added` TIMESTAMP, 
            `order_id` int(11), 
            `cookie_name` varchar(100), 
            `referrer` text, 
            INDEX `order` (`order_id`,`cookie_name`),
            PRIMARY KEY (`order_referrer_id`) 
            )CHARACTER SET utf8 COLLATE utf8_general_ci
        ");

        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "referrer` ( 
            `referrer_id` int(11) NOT NULL AUTO_INCREMENT,
            `time_added` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
            `cookie_name` varchar(100), 
            `referrer` text, 
            INDEX `cookie_name` (`cookie_name`),
            PRIMARY KEY (`referrer_id`)
            ) CHARACTER SET utf8 COLLATE utf8_general_ci
        ");

        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "referrer_patterns` ( 
            `pattern_id` int(11) NOT NULL AUTO_INCREMENT, 
            `name` varchar(128) NOT NULL, 
            `url_mask` varchar(256) NOT NULL, 
            `url_param` varchar(256) NOT NULL, 
            PRIMARY KEY (`pattern_id`) 
            ) CHARACTER SET utf8 COLLATE utf8_general_ci
        ");

        $query = $this->db->query("SELECT COUNT(*) as `count` FROM `" . DB_PREFIX . "referrer_patterns`;");

        if (!$query->num_rows || !$query->row['count']) {
            $queries = array();

            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Картинки.Mail', 'go.mail.ru', 'q');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Google', 'google.','q');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Google', 'google.','as_q');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс', 'yandex.', 'text');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Картинки', 'images.yandex.', 'text');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Мобайл', 'm.yandex.', 'query');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Копия', 'hghltd.yandex.', 'text');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Маркет', 'market.yandex.', '*');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Директ - Поиск', 'direct.yandex.search', 'text');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Директ - Контекст', 'direct.yandex.context', 'text');";

            foreach ($queries as $query) {
                $this->db->query($query);
            }

            $this->cache->delete('referrer_patterns');
        }
        $this->load->model('user/user_group');
        $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'tool/neoseo_order_referrer');
        $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'tool/neoseo_order_referrer');
        return TRUE;
    }

    public function upgrade()
    {
        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "order_referrer` ( 
            `order_referrer_id` int(11) NOT NULL AUTO_INCREMENT,
            `time_added` TIMESTAMP, 
            `order_id` int(11), 
            `cookie_name` varchar(100), 
            `referrer` text, 
            INDEX `order` (`order_id`,`cookie_name`),
            PRIMARY KEY (`order_referrer_id`) 
            )CHARACTER SET utf8 COLLATE utf8_general_ci
        ");

        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "referrer` ( 
            `referrer_id` int(11) NOT NULL AUTO_INCREMENT,
            `time_added` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
            `cookie_name` varchar(100), 
            `referrer` text, 
            INDEX `cookie_name` (`cookie_name`),
            PRIMARY KEY (`referrer_id`)
            ) CHARACTER SET utf8 COLLATE utf8_general_ci
        ");

        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "referrer_patterns` ( 
            `pattern_id` int(11) NOT NULL AUTO_INCREMENT, 
            `name` varchar(128) NOT NULL, 
            `url_mask` varchar(256) NOT NULL, 
            `url_param` varchar(256) NOT NULL, 
            PRIMARY KEY (`pattern_id`) 
            ) CHARACTER SET utf8 COLLATE utf8_general_ci
        ");

        $query = $this->db->query("SELECT COUNT(*) as `count` FROM `" . DB_PREFIX . "referrer_patterns`;");

        if (!$query->num_rows || !$query->row['count']) {
            $queries = array();

            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Картинки.Mail', 'go.mail.ru', 'q');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Google', 'google.','q');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Google', 'google.','as_q');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс', 'yandex.', 'text');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Картинки', 'images.yandex.', 'text');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Мобайл', 'm.yandex.', 'query');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Копия', 'hghltd.yandex.', 'text');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Маркет', 'market.yandex.', '*');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Директ - Поиск', 'direct.yandex.search', 'text');";
            $queries[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Директ - Контекст', 'direct.yandex.context', 'text');";

            foreach ($queries as $query) {
                $this->db->query($query);
            }

            $this->cache->delete('referrer_patterns');
        }
    }

    public function uninstall()
    {
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "order_referrer`");
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "referrer`");
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "referrer_patterns`");

        $this->cache->delete('referrer_patterns');
        return TRUE;
    }

}

?>