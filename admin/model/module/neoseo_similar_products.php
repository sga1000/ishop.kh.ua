<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoSimilarProducts extends NeoSeoModel {

    public function __construct($registry) {
        parent::__construct($registry);
        $this->_moduleSysName = "neoseo_similar_products";
        $this->_logFile = $this->_moduleSysName . ".log";
        $this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
    }

    // Install/Uninstall
    public function install($store_id) {
        $params = array(
            'neoseo_similar_products_status' => 1,
            'neoseo_similar_products_debug' => 0,
            'neoseo_similar_products_view' => 0,
        );
        $this->load->model('setting/setting');
        $this->model_setting_setting->editSetting('neoseo_similar_products', $params);
        return TRUE;
    }

    public function uninstall() {

        $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "setting`  LIKE 'group'");

        if( $query->num_rows != 0 ) {
            $this->db->query("DELETE FROM `" . DB_PREFIX . "setting` WHERE `group` = 'neoseo_similar_products'");
        }
        return TRUE;
    }

    public function upgrade() {
        $hasOrderProdIndex = false;
        $hasProdOrderIndex = false;
        $sql = "SHOW INDEX FROM `" . DB_PREFIX . "order_product`";
        $query = $this->db->query($sql);
        foreach($query->rows as $row) {
            if( $row['Key_name'] == 'orderProd') {
                $hasOrderProdIndex = true;
            }
            if( $row['Key_name'] == 'ProdOrder') {
                $hasProdOrderIndex = true;
            }
        }
        if( !$hasOrderProdIndex) {
            $sql = "ALTER TABLE " . DB_PREFIX . "order_product ADD INDEX  `orderProd` (`order_id`,`product_id`)";
            $this->db->query($sql);
        }
        if( !$hasProdOrderIndex) {
            $sql = "ALTER TABLE " . DB_PREFIX . "order_product ADD INDEX  `ProdOrder` (`product_id`,`order_id`)";
            $this->db->query($sql);
        }
    }

}
