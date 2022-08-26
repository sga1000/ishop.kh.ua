<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");


class ControllerModuleNeoSeoSubscribe extends NeoSeoController {

    private $error = array();

    public function __construct($registry) {
        parent::__construct($registry);
        $this->_moduleName = "";
        $this->_moduleSysName = "neoseo_subscribe";
        $this->_logFile = $this->_moduleSysName . ".log";
        $this->debug = $this->config->get($this->_moduleSysName . "_status") == 1;
    }

    public function index() {
        $this->checkLicense();
		$this->upgrade();

        $data = $this->language->load('module/' . $this->_moduleSysName);

        $this->document->setTitle($this->language->get('heading_title_raw'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            if (isset($_GET['close'])) {
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
            array("module/" . $this->_moduleSysName, "heading_title_raw")
		), $data);


        $data['save'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
        $data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . "&close=1", 'SSL');
        $data['close'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        $data['clear'] = $this->url->link('module/' . $this->_moduleSysName . '/clear', 'token=' . $this->session->data['token'], 'SSL');
        
        $data['token'] = $this->session->data['token'];

        $data['ckeditor'] = $this->config->get('config_editor_default');
        if ($this->config->get('config_editor_default')) {
            $this->document->addScript('view/javascript/ckeditor/ckeditor.js');
            $this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
        }
        $this->load->model('localisation/language');
        $data['languages'] = $this->model_localisation_language->getLanguages();

        foreach ($data['languages'] as $language) {
            $title[$language['language_id']] = $this->language->get('text_title');
            $message[$language['language_id']] = $this->language->get('param_message');
            $message_error[$language['language_id']] = $this->language->get('param_message_error');
        }

        $data = $this->initParams(array(
            array($this->_moduleSysName . "_status", 1),
            array($this->_moduleSysName . "_debug", 0),
            array($this->_moduleSysName . "_show_name", 0),
            array($this->_moduleSysName . "_title", $title),
            array($this->_moduleSysName . "_message", $message),
            array($this->_moduleSysName . "_message_error", $message_error),
            array($this->_moduleSysName . "_notify_list", ""),
            array($this->_moduleSysName . "_notify_subject", $this->language->get('param_notify_subject')),
            array($this->_moduleSysName . "_notify_message", $this->language->get('param_notify_message')),
		), $data);

        $data['params'] = $data;

		$data["logs"] = $this->getLogs();

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
    }

    private function validate() {
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