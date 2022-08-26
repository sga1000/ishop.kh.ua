<?php
class Pagination {
	public $total = 0;
	public $page = 1;
	public $limit = 20;
	public $num_links = 8;
	public $url = '';
	public $text_first = '|&lt;';
	public $text_last = '&gt;|';
	public $text_next = '&gt;';
	public $text_prev = '&lt;';

	private function unparse_url($parsed_url) {
		$scheme   = isset($parsed_url['scheme']) ? $parsed_url['scheme'] . '://' : '';
		$host     = isset($parsed_url['host']) ? $parsed_url['host'] : '';
		$port     = isset($parsed_url['port']) ? ':' . $parsed_url['port'] : '';
		$user     = isset($parsed_url['user']) ? $parsed_url['user'] : '';
		$pass     = isset($parsed_url['pass']) ? ':' . $parsed_url['pass']  : '';
		$pass     = ($user || $pass) ? "$pass@" : '';
		$path     = isset($parsed_url['path']) ? $parsed_url['path'] : '';
		$query    = ( isset($parsed_url['query']) && $parsed_url['query'] ) ? '?' . $parsed_url['query'] : '';
		$fragment = ( isset($parsed_url['fragment']) && $parsed_url['fragment'] ) ? '#' . $parsed_url['fragment'] : '';
		return "$scheme$user$pass$host$port$path$query$fragment";
	}

	protected function log( $message ){
		//file_put_contents(DIR_LOGS . "neoseo_seo_pagination.log", date("Y-m-d H:i:s - ") . " " . $message . "\r\n", FILE_APPEND );
	}

	public function replacePage($url) {

		if(defined('HTTP_CATALOG') ) {
			// admin
			return $url;
		}
		$this->log("process source 0: " . $url );

		$url = str_replace("/page-" . $this->page,"",$url);
		if( strpos($url,"page=") === false ) {
			return $url;
		}
		if( strpos($url,"index.php") !== false ) {
			return $url;
		}

		$url = str_replace("&amp;","&",$url);

		//$this->log("process source 1: " . $url );
		$urlParts = parse_url($url);
		$urlQuery = explode("&",$urlParts['query']);
		$page = 1;
		$newUrlQuery = array();
		foreach( $urlQuery as $item ) {
			if( strpos($item,"page=") !== false ) {
				$page = (int)substr($item,5);
				continue;
			}
			$newUrlQuery[] = $item;
		}
		if( $page > 1 ) {
			$urlParts['path'] = rtrim($urlParts['path'],"/") . "/page-" . $page;
		}
		$urlParts['query'] = implode("&",$newUrlQuery);
		$result = $this->unparse_url($urlParts);
		$result = str_replace("&","&amp;",$result);
		//$this->log("process result 1: " . $result);

		return $result;
	}

	public function render() {
		$total = $this->total;

		if ($this->page < 1) {
			$page = 1;
		} else {
			$page = $this->page;
		}

		if (!(int)$this->limit) {
			$limit = 10;
		} else {
			$limit = $this->limit;
		}

		$num_links = $this->num_links;
		$num_pages = ceil($total / $limit);

		$this->url = str_replace('%7Bpage%7D', '{page}', $this->url);

		$output = '<ul class="pagination">';

		if ($page > 1) {
			$tmp_url = str_replace('&amp;', '&', $this->url);
			$output .= '<li><a class="box-shadow" href="' . $this->replacePage(str_replace('&', '&amp;', rtrim( str_replace('page={page}', '', $tmp_url), '?&'))) . '">' . $this->text_first . '</a></li>';
			if ($page == 2){
				$output .= '<li><a class="box-shadow" href="' . $this->replacePage(str_replace('&', '&amp;', rtrim( str_replace('page={page}', '', $tmp_url), '?&'))) . '">' . $this->text_prev . '</a></li>';
			}else{
				$output .= '<li><a class="box-shadow" href="' . $this->replacePage(str_replace('{page}', $page - 1, $this->url)) . '">' . $this->text_prev . '</a></li>';
			}
		}

		if ($num_pages > 1) {
			if ($num_pages <= $num_links) {
				$start = 1;
				$end = $num_pages;
			} else {
				$start = $page - floor($num_links / 2);
				$end = $page + floor($num_links / 2);

				if ($start < 1) {
					$end += abs($start) + 1;
					$start = 1;
				}

				if ($end > $num_pages) {
					$start -= ($end - $num_pages);
					$end = $num_pages;
				}
			}

			for ($i = $start; $i <= $end; $i++) {
				if ($page == $i) {
									/* NeoSeo Unistor - begin */
				$output .= '<li class="active"><span class="box-shadow">' . $i . '</span></li>';
				/* NeoSeo Unistor  - end */
				} else {
					if ($i == 1){
						$output .= '<li><a class="box-shadow" href="' . $this->replacePage(str_replace('&', '&amp;', rtrim( str_replace('page={page}', '', $tmp_url), '?&'))) . '">' . $i . '</a></li>';
					}else{
						$output .= '<li><a class="box-shadow" href="' . $this->replacePage(str_replace('{page}', $i, $this->url)) . '">' . $i . '</a></li>';
					}
				}
			}
		}

		if ($page < $num_pages) {
			$output .= '<li><a class="box-shadow" href="' . $this->replacePage(str_replace('{page}', $page + 1, $this->url)) . '">' . $this->text_next . '</a></li>';
			$output .= '<li><a class="box-shadow" href="' . $this->replacePage(str_replace('{page}', $num_pages, $this->url)) . '">' . $this->text_last . '</a></li>';
		}

		$output .= '</ul>';

		if ($num_pages > 1) {
			return $output;
		} else {
			return '';
		}
	}
}