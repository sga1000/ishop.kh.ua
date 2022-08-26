<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerFeedNeoSeoFeeds extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_feeds";
		$this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . ".log";
		$this->debug = $this->config->get($this->_moduleSysName() . "_debug") == 1;
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

			$this->model_setting_setting->editSetting($this->_moduleSysName(), $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/' . $this->_route, 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else if (isset($this->session->data['error_warning'])) {
			$data['error_warning'] = $this->session->data['error_warning'];
			unset($this->session->data['error_warning']);
		} else {
			$data['error_warning'] = '';
		}
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}

		$data = $this->initBreadcrumbs(array(
			array('extension/' . $this->_route, 'text_module'),
			array($this->_route . '/' . $this->_moduleSysName(), "heading_title_raw")
			), $data);


        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'ad.name';
        }

        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'ASC';
        }

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $data['feeds'] = array();

        $filter_data = array(
            'sort'  => $sort,
            'order' => $order,
            'start' => ($page - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );

        $this->load->model('feed/neoseo_feeds');
        $results = $this->model_feed_neoseo_feeds->getFeeds($filter_data);

        foreach ($results as $result) {
            $data['feeds'][] = array(
                'name'            => $result['name'],
                'cod'             => $result['cod'],
                'install'         => $this->url->link('feed/neoseo/' . $result['cod'] . '_feed/install', 'token=' . $this->session->data['token'], 'SSL'),
                'uninstall'       => $this->url->link('feed/neoseo/' . $result['cod'] . '_feed/uninstall', 'token=' . $this->session->data['token'], 'SSL'),
                'installed'       => $result['status'],
                'edit'            => $this->url->link('feed/neoseo/' . $result['cod'] . '_feed/edit', 'token=' . $this->session->data['token'], 'SSL'),
            );
        }

		$data = $this->initButtons($data);

		$this->load->model($this->_route . "/" . $this->_moduleSysName());
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName()}->params, $data);

		$data["token"] = $this->session->data['token'];
		$data['config_language_id'] = $this->config->get('config_language_id');
		$data['params'] = $data;

		$data["logs"] = $this->getLogs();

		$widgets = new NeoSeoWidgets($this->_moduleSysName() . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName() . '.tpl', $data));
	}

	private function validate()
	{
		if (!$this->user->hasPermission('modify', $this->_route . '/' . $this->_moduleSysName())) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

	public function getWidget($data)
    {
        $widgets = array();
        $this->load->model('feed/neoseo_feeds');
        $results = $this->model_feed_neoseo_feeds->getFeedsDB(array());
        foreach ($results as $item) {
            $widgets[] =  $this->load->controller('feed/neoseo/'. $item['cod'] . '_feed/getWidget' . ucfirst($data['type']), $data['arg']);
        }

        return implode('', $widgets);
    }

    public function getNav()
    {
        $data = $this->language->load('feed/' . $this->_moduleSysName());
        $this->load->model('feed/neoseo_feeds');
        $data['feeds'] = $this->model_feed_neoseo_feeds->getFeedsDB(array());
        $data['token'] = $this->session->data['token'];

        return $this->load->view('feed/' . $this->_moduleSysName() . '_navbar.tpl', $data);
    }

    public function setData($data)
    {
        $this->load->model('feed/neoseo_feeds');
        $results = $this->model_feed_neoseo_feeds->getFeeds(array());
        foreach ($results as $item) {
            $this->load->model('feed/neoseo/'. $item['cod'] . '_feed');
            if (method_exists($this->{"model_feed_neoseo_" . $item['cod'] . '_feed'}, "setData" . ucfirst($data['type']))) {
	            $this->{"model_feed_neoseo_" . $item['cod'] . '_feed'}->{"setData" . ucfirst($data['type'])}($data);
            }
        }
        return true;
    }
}
