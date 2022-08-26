<?php
require_once(DIR_SYSTEM.'/engine/neoseo_controller.php');

class ControllerBlogNeoSeoBlogReport extends NeoSeoController
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

		$data = $this->language->load('blog/neoseo_blog_report');

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('blog/neoseo_blog_article');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'bv.view';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}

		$url = '';

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title_raw'),
			'href' => $this->url->link('blog/neoseo_blog_report', 'token=' . $this->session->data['token'] . $url, 'SSL'),
		);

		$filter_data = array(
			'filter_viewed' => true,
			'sort' => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$total = $this->model_blog_neoseo_blog_article->getTotalArticle($filter_data);

		$views_total = $this->model_blog_neoseo_blog_article->getTotalViews();

		$data['blog_views'] = array();

		$results = $this->model_blog_neoseo_blog_article->getArticles($filter_data);

		foreach ($results as $result) {

			if ($result['viewed']) {
				$percent = round($result['viewed'] / $views_total * 100, 2);
			} else {
				$percent = 0;
			}

			$data['blog_views'][] = array(
				'article_name' => $result['name'],
				'author_name' => $result['author_name'],
				'viewed' => $result['viewed'],
				'percent' => $percent . '%'
			);
		}

		$data['token'] = $this->session->data['token'];

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_article_name'] = $this->url->link('blog/neoseo_blog_report', 'token=' . $this->session->data['token'] . '&sort=bad.name' . $url, 'SSL');
		$data['sort_author_name'] = $this->url->link('blog/neoseo_blog_report', 'token=' . $this->session->data['token'] . '&sort=bau.name' . $url, 'SSL');
		$data['sort_view'] = $this->url->link('blog/neoseo_blog_report', 'token=' . $this->session->data['token'] . '&sort=ba.viewed' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('blog/neoseo_blog_report', 'token=' . $this->session->data['token'] . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($total - $this->config->get('config_limit_admin'))) ? $total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $total, ceil($total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('blog/neoseo_blog_report.tpl', $data));
	}

}
