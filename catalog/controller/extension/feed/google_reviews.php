<?php
class ControllerExtensionFeedGoogleReviews extends Controller {
	public function index() {
		if ($this->config->get('remarketing_reviews_feed_status')) {
			$output  = '<?xml version="1.0" encoding="UTF-8" ?>';
			$output .= '<feed xmlns:vc="http://www.w3.org/2007/XMLSchema-versioning"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xsi:noNamespaceSchemaLocation=
 "http://www.google.com/shopping/reviews/schema/product/2.2/product_reviews.xsd">
    <version>2.2</version>
    <aggregator>
        <name>Opencart</name>
    </aggregator>
    <publisher>
        <name>' . $this->config->get('config_name') . '</name>
		 <favicon>'.$this->config->get('config_ssl').'image/' . $this->config->get('config_icon').'</favicon>
    </publisher>';
	
			$output .= '  <reviews>';

			
			$this->load->model('extension/feed/google_base');
			$this->load->model('catalog/category');
			$this->load->model('catalog/product');

			$this->load->model('tool/image');

			$review_data = array();
			
			$reviews = $this->getReviews();

				foreach ($reviews as $review) {
					if(!$review['status']) continue;
					$product = $this->model_catalog_product->getProduct($review['product_id']);
					if($product) {
					$output .= '<review>';
					$output .= '<reviewer><name>'.$review['author'].'</name></reviewer>';
					$output .= '<review_timestamp>'. date('Y-m-d\TH:i:sP', strtotime($review['date_added'])).'</review_timestamp>';
					$output .= '<content>'.$review['text'].'</content>';
					$output .= '<review_url type="group">'.$this->url->link('product/product', 'product_id=' . $review['product_id']).'</review_url>';
					$output .= '<ratings>
                <overall min="1" max="5">'.$review['rating'].'</overall>
            </ratings>';
			$output .= ' <products>
                <product>
                    <product_url>'.$this->url->link('product/product', 'product_id=' . $review['product_id']).'</product_url>
                    <product_name>'.$review['name'].'</product_name>';
                    if($product['manufacturer']) { $output .= ' <product_ids><brands><brand>'.$product['manufacturer'].'</brand></brands></product_ids>';}
               $output .= ' </product>
				</products>';
					$output .= '</review>';
				}
				}
			

			$output .= '  </reviews>';
			$output .= '</feed>';

			$this->response->addHeader('Content-Type: application/xml');
			$this->response->setOutput($output);
			}
		}
	

	public function getReviews($data = array()) {
		$sql = "SELECT pd.*, r.*, r.review_id, pd.name, r.author, r.rating, r.status, r.date_added FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product_description pd ON (r.product_id = pd.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_product'])) {
			$sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_product']) . "%'";
		}

		if (!empty($data['filter_author'])) {
			$sql .= " AND r.author LIKE '" . $this->db->escape($data['filter_author']) . "%'";
		}

		if (isset($data['filter_status']) && $data['filter_status'] !== '') {
			$sql .= " AND r.status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_date_added'])) {
			$sql .= " AND DATE(r.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$sort_data = array(
			'pd.name',
			'r.author',
			'r.rating',
			'r.status',
			'r.date_added'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY r.date_added";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 10000;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}
	
}