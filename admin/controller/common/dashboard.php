<?php
class ControllerCommonDashboard extends Controller {
	public function index() {
		$this->load->language('common/dashboard');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_sale'] = $this->language->get('text_sale');
		$data['text_map'] = $this->language->get('text_map');
		$data['text_activity'] = $this->language->get('text_activity');
		$data['text_recent'] = $this->language->get('text_recent');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		// Check install directory exists
		if (is_dir(dirname(DIR_APPLICATION) . '/install')) {
			$data['error_install'] = $this->language->get('error_install');
		} else {
			$data['error_install'] = '';
		}

		$data['token'] = $this->session->data['token'];

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		/*$data['order'] = $this->load->controller('dashboard/order');
		$data['sale'] = $this->load->controller('dashboard/sale');
		$data['customer'] = $this->load->controller('dashboard/customer');
		$data['online'] = $this->load->controller('dashboard/online');
		$data['map'] = $this->load->controller('dashboard/map');
		$data['chart'] = $this->load->controller('dashboard/chart');
		$data['activity'] = $this->load->controller('dashboard/activity');
		$data['recent'] = $this->load->controller('dashboard/recent');*/
		/* NeoSeo Widget Orders - begin */
		if($this->config->get('neoseo_widget_orders_status') == 1){
			$data['neoseo_widget_orders'] = $this->load->controller('dashboard/neoseo_widget_orders');
		}
		/* NeoSeo Widget Orders - end */
		/* NeoSeo Callback Widget - begin */
		if($this->config->get('neoseo_callback_widget_status') == 1){
			$data['neoseo_callback_widget'] = $this->load->controller('dashboard/neoseo_callback_widget');
		}
		/* NeoSeo Callback Widget - end */
		/* Neoseo Testimonials Widget - begin */
		if($this->config->get('neoseo_testimonials_widget_status') == 1){
			$data['neoseo_testimonials_widget'] = $this->load->controller('dashboard/neoseo_testimonials_widget');
		}
		/* Neoseo Testimonials Widget - begin */
		/* Neoseo Review Widget - begin */
		if($this->config->get('neoseo_review_widget_status') == 1){
			$data['neoseo_review_widget'] = $this->load->controller('dashboard/neoseo_review_widget');
		}
		/* Neoseo Review Widget - begin */
		/* NeoSeo Broken Links Widget - begin */
		if($this->config->get('neoseo_broken_links_widget_status') == 1){
			$data['neoseo_broken_links_widget'] = $this->load->controller('dashboard/neoseo_broken_links_widget');
		}
		/* NeoSeo Broken Links Widget - begin */
		/* NeoSeo Broken Links Widget - begin */
		if($this->config->get('neoseo_dropped_cart_widget_status') == 1){
			$data['neoseo_dropped_cart_widget'] = $this->load->controller('dashboard/neoseo_dropped_cart_widget');
		}
		/* NeoSeo Broken Links Widget - begin */
		/* NeoSeo Backup Widget - begin */
		if($this->config->get('neoseo_backup_widget_status') == 1){
			$data['neoseo_backup_widget'] = $this->load->controller('dashboard/neoseo_backup_widget');
		}
		/* NeoSeo Backup Widget - begin */
		/* NeoSeo Notes Widget - begin */
		if($this->config->get('neoseo_notes_widget_status') == 1){
			$data['neoseo_notes_widget'] = $this->load->controller('dashboard/neoseo_notes_widget');
		}
		/* NeoSeo Notes Widget - begin */
		$data['footer'] = $this->load->controller('common/footer');

		// Run currency update
		if ($this->config->get('config_currency_auto')) {
			$this->load->model('localisation/currency');

			$this->model_localisation_currency->refresh();
		}

		$this->response->setOutput($this->load->view('common/dashboard.tpl', $data));
	}
}