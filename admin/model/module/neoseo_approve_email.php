<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoApproveEmail extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_approve_email';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_debug') == 1;
		
		// Значения параметров по умолчанию
		$this->language->load("module/" . $this->_moduleSysName);
		
		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();
		foreach ($data['languages'] as $language) {
			$text_theme_mails[$language['language_id']] = $this->language->get('param_theme_mails_text');
			$text_reg[$language['language_id']] = $this->language->get('param_reg_text');
			$text_mails[$language['language_id']] = $this->language->get('param_mails_text');
			$text_mails_admin[$language['language_id']] = $this->language->get('param_mails_text_admin');
			$text_reg_true_text[$language['language_id']] = $this->language->get('param_reg_true_text');
			$text_theme_mails_text_admin[$language['language_id']] = $this->language->get('param_theme_mails_text_admin');
		}

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'reg_text' => $text_reg,
			'theme_mails_text' => $text_theme_mails,
			'mails_text' => $text_mails,
			'mails_admin' => $this->config->get('config_email'),
			'theme_mails_text_admin' => $text_theme_mails_text_admin,
			'mails_text_admin' =>$text_mails_admin,
			'reg_true_text' => $text_reg_true_text,
		);
		
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);
		$this->installTables();

		return TRUE;
	}

	public function installTables(){
		$colsQuery = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "customer` WHERE `Field` = 'email_confirm_token'");
		if(count($colsQuery->rows) == 0 )
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "customer` ADD `email_confirm_token` char(23);");
	}

	public function upgrade()
	{
		$this->initParams($this->params);
		$this->installTables();
		return TRUE;
	}

	public function uninstall()
	{
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "customer` DROP `email_confirm_token`");
		return TRUE;
	}

}

