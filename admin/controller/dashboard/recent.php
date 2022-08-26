<?php
class ControllerDashboardRecent extends Controller {
	public function index() {
		$this->load->language('dashboard/recent');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_no_results'] = $this->language->get('text_no_results');


        /* NeoSeo Order Referrer - before */
        $this->load->model('module/neoseo_order_referrer');
        $this->model_module_neoseo_order_referrer->checkInstall();
        $this->load->model('tool/neoseo_order_referrer');
        $data['column_referrer'] = $this->language->get('column_referrer');
        /* NeoSeo Order Referrer - end */
                
		$data['column_order_id'] = $this->language->get('column_order_id');
		$data['column_customer'] = $this->language->get('column_customer');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_date_added'] = $this->language->get('column_date_added');
		$data['column_total'] = $this->language->get('column_total');
		$data['column_action'] = $this->language->get('column_action');

		$data['button_view'] = $this->language->get('button_view');

		$data['token'] = $this->session->data['token'];

		// Last 5 Orders

            /* NeoSeo Order Referrer - before */
            $order_info = $this->model_sale_order->getOrder($result['order_id']);
            $result['first_referrer'] =  $this->model_tool_neoseo_order_referrer->decode( $order_info['first_referrer'], "list" );
            $result['last_referrer'] =  $this->model_tool_neoseo_order_referrer->decode( $order_info['last_referrer'], "list" );
            /* NeoSeo Order Referrer - end */
                
		$data['orders'] = array();

		$filter_data = array(
			'sort'  => 'o.date_added',
			'order' => 'DESC',
			'start' => 0,
			'limit' => 5
		);

		$results = $this->model_sale_order->getOrders($filter_data);

		foreach ($results as $result) {
			$data['orders'][] = array(
				'order_id'   => $result['order_id'],
				/* NeoSeo Order Referrer - before */
                'first_referrer'    => $result['first_referrer'],
                'last_referrer'     => $result['last_referrer'],
                /* NeoSeo Order Referrer - end */
				'customer'   => $result['customer'],
				'status'     => $result['status'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'total'      => $this->currency->format($result['total'], $result['currency_code'], $result['currency_value']),
				'view'       => $this->url->link('sale/order/info', 'token=' . $this->session->data['token'] . '&order_id=' . $result['order_id'], 'SSL'),
			);
		}

		return $this->load->view('dashboard/recent.tpl', $data);
	}
}