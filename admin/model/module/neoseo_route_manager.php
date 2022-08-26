<?php

require_once(DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoRouteManager extends NeoSeoModel
{

    public function __construct($registry)
    {
        parent::__construct($registry);
        $this->_moduleSysName = "neoseo_route_manager";
        $this->_logFile = $this->_moduleSysName . ".log";
        $this->debug = $this->config->get($this->_moduleSysName . "_debug");
    }

    // Install/Uninstall
    public function install()
    {

        // Значения параметров по умолчанию
        $this->initParamsDefaults(array(
            'debug' => 0,
        ));

        $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "url_alias` WHERE Field = 'seo_mod'");
        if ($query->num_rows == 0) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "url_alias` ADD COLUMN seo_mod INT(1) DEFAULT 0;");
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "url_alias` ADD INDEX (seo_mod);");
        }
        $this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE `seo_mod` = 1;");
        $sql = array();
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('common/home', '', 1);";

        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('checkout/cart', 'cart', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('checkout/checkout', 'checkout', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('checkout/success', 'checkout-success', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('checkout/voucher', 'gift-vouchers', 1);";

        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/wishlist', 'wishlist', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/account', 'account', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/success', 'account-success', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/login', 'login', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/logout', 'logout', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/order', 'orders', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/newsletter', 'newsletter', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/forgotten', 'lost-password', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/download', 'downloads', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/return', 'returns', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/return/insert', 'request-return', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/transaction', 'transactions', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/register', 'register', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/edit', 'edit-account', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/password', 'change-password', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/address', 'addresses', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/voucher', 'vouchers', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('account/reward', 'reward-points', 1);";

        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('product/special', 'specials', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('product/manufacturer', 'brands', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('product/compare', 'compare', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('product/search', 'search', 1);";

        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('information/contact', 'contact', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('information/sitemap', 'sitemap', 1);";

        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('affiliate/account', 'affiliates', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('affiliate/edit', 'affiliate-edit-account', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('affiliate/password', 'affiliate-change-password', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('affiliate/payment', 'affiliate-payment-options', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('affiliate/tracking', 'affiliate-tracking-code', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('affiliate/transaction', 'affiliate-transactions', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('affiliate/logout', 'affiliate-logout', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('affiliate/forgotten', 'affiliate-forgot-password', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('affiliate/register', 'affiliate-register', 1);";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "url_alias` (query, keyword, seo_mod) VALUES ('affiliate/login', 'affiliate-login', 1);";

        $params = array(
            'neoseo_route_manager_status' => 1,
            'neoseo_route_manager_debug' => 0,
        );

        $this->load->model('setting/setting');
        $this->model_setting_setting->editSetting('neoseo_route_manager', $params);


        foreach ($sql as $_sql) {
            $this->db->query($_sql);
        }
        $this->cache->delete('seo_pro');
        $this->cache->delete('seo_url');

        // Пермишены
        $this->load->model('user/user_group');
        $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'module/neoseo_route_manager');
        $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'module/neoseo_route_manager');
        $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'tool/neoseo_route_manager');
        $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'tool/neoseo_route_manager');

        return TRUE;
    }

    public function uninstall()
    {
        $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "url_alias` WHERE Field = 'seo_mod'");
        if ($query->num_rows == 1) {
            $this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE `seo_mod` = 1;");
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "url_alias` DROP INDEX seo_mod;");
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "url_alias` DROP COLUMN `seo_mod`;");
        }

        $this->cache->delete('seo_pro');
        $this->cache->delete('seo_url');

        return TRUE;
    }

    public function upgrade()
    {

    }

}
