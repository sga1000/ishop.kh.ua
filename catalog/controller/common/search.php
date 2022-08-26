<?php
class ControllerCommonSearch extends Controller {
	public function index() {
		$this->load->language('common/search');

		/* NeoSeo UniSTOR - begin */
		$this->load->model("module/neoseo_unistor");
		$data = $this->model_module_neoseo_unistor->processSearchData();
		/* NeoSeo UniSTOR - end */
		

		$data['text_search'] = $this->language->get('text_search');


		/* NeoSeo Ajax Search - begin */
		$data['hide_categories'] = !$this->config->get("neoseo_smart_search_show_categories");
		/* NeoSeo Ajax Search - end */


        $data['categories'] = array();

        $data['categories'] = $this->model_catalog_category->getCategories();

		if (isset($this->request->get['search'])) {
			$data['search'] = $this->request->get['search'];
		} else {
			$data['search'] = '';
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/search.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/search.tpl', $data);
		} else {
			return $this->load->view('default/template/common/search.tpl', $data);
		}
	}
}