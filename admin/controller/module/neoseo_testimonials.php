<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoTestimonials extends NeoSeoController {

    private $error = array();
    private $routes = array();

    public function __construct($registry) {
        parent::__construct($registry);
        $this->_moduleSysName = "neoseo_testimonials";
        $this->_logFile = $this->_moduleSysName . ".log";
        $this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
    }

    protected function checkRoutes($root_dir, $start_dir) {
        $scan_results = scandir($root_dir.$start_dir);
        foreach ($scan_results as $index => $result) {
            if($index < 2) continue;
            if(is_dir($root_dir.$start_dir.'/'.$result)) {
                $this->checkRoutes($root_dir.$start_dir.'/', $result);
            } else {
                $this->routes[] = pathinfo($start_dir.'_'.$result, PATHINFO_FILENAME);
            }
        }
    }

    public function index() {
        $this->checkLicense();
        $this->upgrade();

        $data = $this->language->load('module/' . $this->_moduleSysName);
        $this->document->setTitle($this->language->get('heading_title_raw'));

        $this->load->model('setting/setting');
        $this->load->model('extension/module');
        $this->load->model('localisation/language');

        if(!isset($this->session->data['neoseo_scan_routes']) || empty($this->session->data['neoseo_scan_routes'])) {
            $this->checkRoutes(DIR_CATALOG, 'controller');
            $this->session->data['neoseo_scan_routes'] = $this->routes;
        }

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            $globalModuleData[$this->_moduleSysName . '_debug'] = $this->request->post[$this->_moduleSysName . '_debug'];
            $globalModuleData[$this->_moduleSysName . '_youtube'] = $this->request->post[$this->_moduleSysName . '_youtube'];
            $globalModuleData[$this->_moduleSysName . '_user_image_status'] = $this->request->post[$this->_moduleSysName . '_user_image_status'];
            $this->model_setting_setting->editSetting($this->_moduleSysName, $globalModuleData);

            $moduleData = array();
            foreach ($this->request->post as $key => $value) {
                $shortKey = str_replace($this->_moduleSysName . "_", "", $key);
                if (in_array($shortKey, array("action", "debug"))) {
                    continue;
                }
                $moduleData[$shortKey] = $value;
            }
            if (!isset($this->request->get['module_id'])) {
                $this->model_extension_module->addModule($this->_moduleSysName, $moduleData);
                $module_id = $this->db->getLastId();
            } else {
                $this->model_extension_module->editModule($this->request->get['module_id'], $moduleData);
                $module_id = $this->request->get['module_id'];
            }

            foreach ($this->model_localisation_language->getLanguages() as $language) {
                foreach(range(1,10) as $cache_module_id) {
                    foreach ($this->session->data['neoseo_scan_routes'] as $route) {
                        $this->cache->delete($this->_moduleSysName.'_'. $route .'_'. $cache_module_id .'_'. $language['language_id']);
                        $this->cache->delete($this->_moduleSysName.'_total_'. $route .'_'. $cache_module_id .'_'. $language['language_id']);
                    }
                }
            }

            $this->session->data['success'] = $this->language->get('text_success');

            if (isset($this->request->get['close'])) {
                $this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
            } else {
                $this->response->redirect($this->url->link('module/' . $this->_moduleSysName, "module_id=" . $module_id . '&token=' . $this->session->data['token'], 'SSL'));
            }
        }

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
        if (isset($this->error['image'])) {
            $data['error_image'] = $this->error['image'];
        } else {
            $data['error_image'] = array();
        }
        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        }

        $data = $this->initBreadcrumbs(array(
            array("extension/module", "text_module"),
            array("module/" . $this->_moduleSysName, "heading_title_raw")
        ), $data);

        if (!isset($this->request->get['module_id'])) {
            $data['save'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
            $data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . "&close=1", 'SSL');
        } else {
            $data['save'] = $this->url->link('module/' . $this->_moduleSysName, 'module_id=' . $this->request->get['module_id'] . '&token=' . $this->session->data['token'], 'SSL');
            $data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName, 'module_id=' . $this->request->get['module_id'] . '&token=' . $this->session->data['token'] . "&close=1", 'SSL');
        }
        $data['clear'] = $this->url->link('module/' . $this->_moduleSysName . '/clear', 'token=' . $this->session->data['token'], 'SSL');
        $data['close'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        $data['token'] = $this->session->data['token'];
        $data['modules'] = array();

        $languages = array();
        foreach ($this->model_localisation_language->getLanguages() as $language) {
            $languages[$language['language_id']] = $language['name'];
        }
        $data['languages'] = $languages;
        $data['full_languages'] = $this->model_localisation_language->getLanguages();

        $defaultTitle = array();
        foreach ($data['languages'] as $language_id => $name) {
            $defaultTitle[$language_id] = $this->language->get('text_default_title');
        }

        $data = $this->initParamsList(array(
            'youtube',
            'user_image_status',
        ), $data);

        $data = $this->initModuleParams(array(
            array($this->_moduleSysName . '_status', 1),
            array($this->_moduleSysName . '_debug', 0),
            array($this->_moduleSysName . '_name', ""),
            array($this->_moduleSysName . '_title', $defaultTitle),
            array($this->_moduleSysName . '_limit', 10),
            // array($this->_moduleSysName . '_youtube', 0),
            //array($this->_moduleSysName . '_user_image_status', 1),
            array($this->_moduleSysName . '_user_image_width', 50),
            array($this->_moduleSysName . '_user_image_height', 50),
            array($this->_moduleSysName . '_template', "carousel"),
            array($this->_moduleSysName . '_description_limit', 100),
        ), $data, $this->_moduleSysName);



        $data['templates'] = array();
        $template_files = glob(DIR_CATALOG . 'view/theme/default/template/module/' . $this->_moduleSysName . '_*.tpl');
        if ($template_files) {
            foreach ($template_files as $template_file) {
                $template_file_name = str_replace($this->_moduleSysName . "_", "", basename($template_file, '.tpl'));
                $data['templates'][$template_file_name] = $this->language->get('text_template') . " - " . $template_file_name;
            }
        }


        $data['params'] = $data;

        if (is_file(DIR_LOGS . $this->_logFile))
            $data["logs"] = substr(nl2br(file_get_contents(DIR_LOGS . $this->_logFile)), -10000);
        else
            $data["logs"] = "";

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');
        $this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
    }

    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName)) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        if (isset($this->request->post[$this->_moduleSysName . '_module'])) {
            foreach ($this->request->post[$this->_moduleSysName . '_module'] as $key => $value) {
                if (!$value['image_width'] || !$value['image_height']) {
                    $this->error['image'][$key] = $this->language->get('error_image');
                }
            }
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

}

?>