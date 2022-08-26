<?php

require_once( DIR_SYSTEM . "/engine/soforp_model.php");

class ModelCatalogSoforpProductOrderHistory extends SoforpModel {

    public function __construct($registry) {
        parent::__construct($registry);
        $this->_moduleSysName = "soforp_product_order_history";
        $this->_logFile = $this->_moduleSysName . ".log";
        $this->debug = $this->config->get($this->_moduleSysName . "_debug");
    }

    public function getOrders($filter){
        $data = $this->language->load('catalog/soforp_product_order_history');
        $data['token'] = $this->session->data['token'];
        $data['orders'] = $this->getOrdersData($filter);
        return $this->load->view('catalog/soforp_product_order_history.tpl', $data);
    }

    public function getOrdersData($filter) {
        if( !isset($filter['product_id']) || !$filter['product_id'] ) {
            return array();
        }

        $sql = "SELECT * FROM " . DB_PREFIX . "order_product WHERE product_id = " . (int)$filter['product_id'] . " ORDER BY order_id DESC";
        $query = $this->db->query($sql);
        if( !$query->num_rows) {
            return array();
        }

        $result = array();
        foreach( $query->rows as $row ) {
            $sql = "SELECT *, (SELECT os.name FROM " . DB_PREFIX . "order_status os WHERE os.order_status_id = o.order_status_id AND os.language_id = '" . (int)$this->config->get('config_language_id') . "') AS order_status FROM " . DB_PREFIX . "order o WHERE o.order_id = " . (int)$row['order_id'];
            $orderQuery = $this->db->query($sql);

            $sql = "SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$row['order_id'] . "' AND order_product_id = '" . (int)$row['order_product_id'] . "'";
            $optionQuery = $this->db->query($sql);

            $row['price_currency'] = $this->currency->format($row['price'],$orderQuery->row['currency_code']);
            $row['total_currency'] = $this->currency->format($row['total'],$orderQuery->row['currency_code']);
            $result[] = array(
                'product_detail' => $row,
                'order_detail' => $orderQuery->row,
                'option_detail' => $optionQuery->rows,
            );
        }

        return $result;
    }


}
