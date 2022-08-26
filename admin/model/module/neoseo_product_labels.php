<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoProductLabels extends NeoSeoModel {

    public function __construct($registry) {
        parent::__construct($registry);
        $this->_moduleSysName = "neoseo_product_labels";
    }

    public function install() {
        $positions = array(
            'label-top-left' => $this->language->get('params_position_top_left'),
            'label-top-right' => $this->language->get('params_position_top_right'),
            'label-bottom-left' => $this->language->get('params_position_bottom_left'),
            'label-bottom-right' => $this->language->get('params_position_bottom_right'),
        );
        $types = array(
            'type-1' 	=> $this->language->get('params_type_label_type_1'),
            'type-2' 	=> $this->language->get('params_type_label_type_2'),

            'corner' 	=> $this->language->get('params_type_label_corner'),
            'b-ribbon' 	=> $this->language->get('params_type_label_flag'),
            'stripes' 	=> $this->language->get('params_type_label_stripes'),
            'sticker' 	=> $this->language->get('params_type_label_sticker'),
            'chip'   	=> $this->language->get('params_type_label_chip'),
            'tally'		=> $this->language->get('params_type_label_tally')
        );

        $params = array(
            $this->_moduleSysName . '_status' => 1,
            $this->_moduleSysName . '_debug' => 0,
            $this->_moduleSysName . '_special_status' => 0,
            $this->_moduleSysName . '_special_label_type' => $types,
            $this->_moduleSysName . '_special_type' => 1,
            $this->_moduleSysName . '_special_position' => $positions,
            $this->_moduleSysName . '_special_class' => '',
            $this->_moduleSysName . '_special_style' => '',
            $this->_moduleSysName . '_special_priority' => '',
            $this->_moduleSysName . '_special_color' => 'f12717',
        );
        $this->load->model('setting/setting');
        $this->model_setting_setting->editSetting($this->_moduleSysName, $params);

        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "labels` (
            `label_id` int(11) NOT NULL AUTO_INCREMENT, 
            `name` varchar(255) NOT NULL,
            `label_type` varchar(255) NOT NULL, 
            `class` varchar(255) NOT NULL,   
            `style` varchar(255) NOT NULL,
            `position` varchar(255) NOT NULL,
            `color` varchar(255) NOT NULL,   
            `type` varchar(255) NOT NULL, 
            `status` varchar(255) NOT NULL, 
            `priority` varchar(255) NOT NULL, 
            PRIMARY KEY (`label_id`) 
            )  CHARACTER SET utf8 COLLATE utf8_general_ci;");

        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "product_to_labels` (
	    `product_label_id` int(11) NOT NULL AUTO_INCREMENT,
            `product_id` int(11) NOT NULL,
	    `label_id` int(11) NOT NULL, 
            PRIMARY KEY (`product_label_id`) 
            )  CHARACTER SET utf8 COLLATE utf8_general_ci;");

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "labels` LIKE 'days';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "labels` ADD COLUMN days int(11) DEFAULT 0;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "labels` LIKE 'viewes';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "labels` ADD COLUMN viewes int(11) DEFAULT 0;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "labels` LIKE 'sold';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "labels` ADD COLUMN sold int(11) DEFAULT 0;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "labels` LIKE 'product_limit';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "labels` ADD COLUMN product_limit int(11) DEFAULT 10;";
            $this->db->query($sql);
        }

        return TRUE;
    }

    public function upgrade() {

        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "labels` (
            `label_id` int(11) NOT NULL AUTO_INCREMENT, 
            `name` varchar(255) NOT NULL,
            `label_type` varchar(255) NOT NULL, 
            `class` varchar(255) NOT NULL,   
            `style` varchar(255) NOT NULL,
            `position` varchar(255) NOT NULL,
            `color` varchar(255) NOT NULL,   
            `type` varchar(255) NOT NULL, 
            `status` varchar(255) NOT NULL, 
            `priority` varchar(255) NOT NULL, 
            PRIMARY KEY (`label_id`) 
            )  CHARACTER SET utf8 COLLATE utf8_general_ci;");

        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "product_to_labels` (
	    `product_label_id` int(11) NOT NULL AUTO_INCREMENT,
            `product_id` int(11) NOT NULL,
	    `label_id` int(11) NOT NULL, 
            PRIMARY KEY (`product_label_id`) 
            )  CHARACTER SET utf8 COLLATE utf8_general_ci;");

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "labels` LIKE 'days';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "labels` ADD COLUMN days int(11) DEFAULT 0;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "labels` LIKE 'store_ids';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "labels` ADD COLUMN store_ids text NOT NULL;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "labels` LIKE 'viewes';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "labels` ADD COLUMN viewes int(11) DEFAULT 0;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "labels` LIKE 'sold';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "labels` ADD COLUMN sold int(11) DEFAULT 0;";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "labels` LIKE 'product_limit';";
        $query = $this->db->query($sql);
        if (!$query->num_rows) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "labels` ADD COLUMN product_limit int(11) DEFAULT 10;";
            $this->db->query($sql);
        }

        return TRUE;
    }

    public function uninstall() {

        $this->db->query("DELETE FROM `" . DB_PREFIX . "setting` WHERE `code` = '" . $this->_moduleSysName . "'");
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "labels`");
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "product_to_labels`");

        return TRUE;
    }

}

?>