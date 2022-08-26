<?php

require_once(DIR_SYSTEM . "/engine/neoseo_controller.php");


class ControllerModuleNeoSeoOrderReferrer extends NeoSeoController
{

    private $error = array();

    public function __construct( $registry )
    {
        parent::__construct($registry);
        $this->_moduleSysName = "neoseo_order_referrer";
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

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

            $this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            if ($this->request->post['action'] == "save") {
                $this->response->redirect($this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
            } else {
                $this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
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
            array("module/" . $this->_moduleSysName, "heading_title_raw")
        ), $data);

        $data = $this->initButtons($data);
        $data = $this->initParamsList(array(
            "status",
            "debug",
            "list_short_url_status",
            "detail_short_url_status",
            "first_referrer_days",
            "last_referrer_hours",
            "bad_user_agents",
        ), $data);

        $data['params'] = $data;

        $data["logs"] = $this->getLogs();

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
            return TRUE;
        } else {
            return FALSE;
        }
    }

}

?>
