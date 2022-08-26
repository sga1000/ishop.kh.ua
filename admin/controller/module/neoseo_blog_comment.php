<?php
require_once(DIR_SYSTEM.'/engine/neoseo_controller.php');

class ControllerModuleNeoSeoBlogComment extends NeoSeoController
{
	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_blog';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_status') == 1;
	}

	public function index()
	{

		$data = $this->load->language('module/neoseo_blog_comment');

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('neoseo_blog_comment', $this->request->post);
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		if (isset($this->error['width'])) {
			$data['error_width'] = $this->error['width'];
		} else {
			$data['error_width'] = '';
		}

		if (isset($this->error['height'])) {
			$data['error_height'] = $this->error['height'];
		} else {
			$data['error_height'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		if (!isset($this->request->get['module_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title_raw'),
				'href' => $this->url->link('module/neoseo_blog_comment', 'token=' . $this->session->data['token'], 'SSL')
			);
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title_raw'),
				'href' => $this->url->link('module/neoseo_blog_comment', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
			);
		}

		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('module/neoseo_blog_comment', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('module/neoseo_blog_comment', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}

		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info)) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}


		foreach ($data['languages'] as $language) {
			if (isset($this->request->post['title'][$language['language_id']])) {
				$data['title'][$language['language_id']] = $this->request->post['title'][$language['language_id']];
			} elseif (!empty($module_info['title'][$language['language_id']])) {
				$data['title'][$language['language_id']] = $module_info['title'][$language['language_id']];
			} else {
				$data['title'][$language['language_id']] = '';
			}
		}

		if (isset($this->request->post['blog_category_id'])) {
			$data['blog_category_id'] = $this->request->post['blog_category_id'];
		} elseif (!empty($module_info)) {
			$data['blog_category_id'] = $module_info['blog_category_id'];
		} else {
			$data['blog_category_id'] = '';
		}

		if (isset($this->request->post['root_category_id'])) {
			$data['root_category_id'] = $this->request->post['root_category_id'];
		} elseif (!empty($module_info)) {
			$data['root_category_id'] = $module_info['root_category_id'];
		} else {
			$data['root_category_id'] = 0;
		}


		$data['templates'] = array();
		$files = glob(DIR_CATALOG . 'view/theme/default/template/module/neoseo_blog_comment*.tpl');
		if ($files) {
			foreach ($files as $file) {
				$data['templates'][] = basename($file);
			}
		}

		if (isset($this->request->post['template'])) {
			$data['template'] = $this->request->post['template'];
		} elseif (!empty($module_info) && isset($module_info['template'])) {
			$data['template'] = $module_info['template'];
		} else {
			$data['template'] = '';
		}

		if (isset($this->request->post['type'])) {
			$data['type'] = $this->request->post['type'];
		} elseif (!empty($module_info) && isset($module_info['type'])) {
			$data['type'] = $module_info['type'];
		} else {
			$data['type'] = '';
		}

		$this->load->model('blog/neoseo_blog_category');

		$data['categories'] = $this->model_blog_neoseo_blog_category->getCategories(array('parent_id' => 0));

		if (isset($this->request->post['limit'])) {
			$data['limit'] = $this->request->post['limit'];
		} elseif (!empty($module_info) && isset($module_info['limit'])) {
			$data['limit'] = $module_info['limit'];
		} else {
			$data['limit'] = 5;
		}

		if (isset($this->request->post['width'])) {
			$data['width'] = $this->request->post['width'];
		} elseif (!empty($module_info) && isset($module_info['width'])) {
			$data['width'] = $module_info['width'];
		} else {
			$data['width'] = 200;
		}

		if (isset($this->request->post['height'])) {
			$data['height'] = $this->request->post['height'];
		} elseif (!empty($module_info) && isset($module_info['height'])) {
			$data['height'] = $module_info['height'];
		} else {
			$data['height'] = 200;
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info) && isset($module_info['status'])) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '';
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/neoseo_blog_comment.tpl', $data));
	}

	protected function validate()
	{
		if (!$this->user->hasPermission('modify', 'module/neoseo_blog_comment')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		if (!$this->request->post['width']) {
			$this->error['width'] = $this->language->get('error_width');
		}

		if (!$this->request->post['height']) {
			$this->error['height'] = $this->language->get('error_height');
		}

		return !$this->error;
	}

}
