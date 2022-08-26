<?php
require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoSeoPagination extends NeoSeoModel {

    public function __construct($registry) {
        parent::__construct($registry);
        $this->_moduleSysName = "neoseo_seo_pagination";
        $this->_logFile = $this->_moduleSysName . ".log";
        $this->debug = true;//$this->config->get( $this->_moduleSysName . "_status") == 1;
    }

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

    public function replacePage($url) {

        if( isset($this->request->get['page']) && $this->request->get['page'] > 1 ) {
            $url = str_replace("/page-" . $this->request->get['page'], "",$url);
        }

        if( strpos($url,"page={page}") !== false ) {
            return $url;
        }
        if( strpos($url,"page=") === false ) {
            return $url;
        }
        if( strpos($url,"index.php") !== false ) {
            return $url;
        }

        $url = str_replace("&amp;","&",$url);

        $this->log("process source: " . $url );
        //$this->log("trace: " . print_r(debug_backtrace(0),true));
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

        // Тут нельзя экранировать, этот код используется в seo_pro, где уже выполняется экранирование
        //$result = str_replace("&","&amp;",$result);
        $this->log("process result: " . $result);

        return $result;
    }
}
