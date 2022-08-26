<?php

require_once(DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoRouteManager extends NeoSeoController
{

    private $error = array();

    public function __construct($registry)
    {
        parent::__construct($registry);
        $this->_moduleSysName = "neoseo_route_manager";
        $this->_logFile = $this->_moduleSysName . ".log";
        $this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
    }

    public function index()
    {
        $this->checkLicense();
        $this->upgrade();

        $data = $this->language->load('module/' . $this->_moduleSysName);

        $this->document->setTitle($this->language->get('heading_title_raw'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            $this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            if (isset($this->request->get['close'])) {
                $this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
            } else {
                $this->response->redirect($this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
            }
        }

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        }

        $data = $this->initBreadcrumbs(array(
            array("extension/module", "text_module"),
            array('module/' . $this->_moduleSysName, "heading_title_raw")
        ), $data);

        $data['save'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
        $data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . "&close=1", 'SSL');
        $data['action'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        $data['clear'] = $this->url->link('module/' . $this->_moduleSysName . '/clear', 'token=' . $this->session->data['token'], 'SSL');
        $data['close'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        $this->initButtons($data);

        $data = $this->initParamsList(array(
            "status",
            "debug",
        ), $data);

        $data['params'] = $data;
        $data['token'] = $this->session->data['token'];

        $data["logs"] = $this->getLogs();

        $data['db'] = $this->db;

        $this->load->model('catalog/category');
        $data['categories'] = $this->model_catalog_category->getCategories(0);

        $this->load->model('catalog/manufacturer');
        $results = $this->model_catalog_manufacturer->getManufacturers();

        foreach ($results as $result) {
            $data['manufacturers'][] = array(
                'id' => $result['manufacturer_id'],
                'name' => $result['name']
            );
        }

        $this->load->model('catalog/information');
        $results_info = $this->model_catalog_information->getInformations();

        foreach ($results_info as $result) {
            $data['informations'][] = array(
                'id' => $result['information_id'],
                'title' => $result['title']
            );
        }
        $this->load->model('localisation/language');
        $data['languages'] = $this->model_localisation_language->getLanguages();
        $data['current_lang'] = (int)$this->config->get('config_language_id');
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');
        $this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
    }

    private function validate()
    {
        if (!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName)) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

}

?>