<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoNotifyWhenAvailable extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_notify_when_available";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;

		// Значения параметров по умолчанию
		$data = $this->language->load("module/" . $this->_moduleSysName);

		$this->load->model('localisation/language');
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$subject[$language['language_id']] = $this->language->get('param_subscribe_subject');
			$message[$language['language_id']] = $this->language->get('param_subscribe_message');
			$unSubject[$language['language_id']] = $this->language->get('param_unsubscribe_subject');
			$unMessage[$language['language_id']] = $this->language->get('param_unsubscribe_message');
			$subjectMail[$language['language_id']] = $this->language->get('param_subscribe_subject_mail');
			$messageMail[$language['language_id']] = $this->language->get('param_subscribe_message_mail');
			$text_subscribe[$language['language_id']] = $this->language->get('param_subscribe_text');
			$text_unsubscribe[$language['language_id']] = $this->language->get('param_unsubscribe_text');
		}

		// Значения параметров по умолчанию
		$this->params = array(
			"status" => 1,
			"debug" => 0,
			"script" => '',
			"subscribe_subject" => $subject,
			"subscribe_message" => $message,
			"unsubscribe_subject" => $unSubject,
			"unsubscribe_message" => $unMessage,
			"subscribe_subject_mail" => $subjectMail,
			"subscribe_message_mail" => $messageMail,
			"admin_subscribe_notify" => '',
			"subscribe_text" => $text_subscribe,
			"unsubscribe_text" => $text_unsubscribe,
			"admin_subscribe_notify_subject" => $data['param_admin_subscribe_notify_subject'],
			"admin_subscribe_notify_message" => $data['param_admin_subscribe_notify_message'],
			"admin_unsubscribe_notify_subject" => $data['param_admin_unsubscribe_notify_subject'],
			"admin_unsubscribe_notify_message" => $data['param_admin_unsubscribe_notify_message'],
			"image_width" => 240,
			"image_height" => 240,
			"stock_statuses" => array(5),
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		// Создаем новые и недостающие таблицы в актуальной структуре
		$this->installTables();

		// Недостающие права
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'sale/' . $this->_moduleSysName);
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'sale/' . $this->_moduleSysName);

		return TRUE;
	}

	private function installTables()
	{
		//Таблица для заявок
		$sql = "
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "notify_when_available` (
				`id` int(11) NOT NULL AUTO_INCREMENT,
				`product_id` int(11) NOT NULL,
				`language`  varchar(255) NOT NULL,
				`date` datetime NOT NULL,
				`name` varchar(255) NOT NULL,
				`email` varchar(255) NOT NULL,
				`product_name` varchar(255) NOT NULL,
				`options` varchar(255) NOT NULL,
				`status` int(1) NOT NULL,
				PRIMARY KEY (`id`)
				) DEFAULT CHARSET=utf8;
		";
		$this->db->query($sql);
	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);

		// Создаем недостающие таблицы в актуальной структуре
		$this->installTables();

		return TRUE;
	}

	public function uninstall()
	{
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "notify_when_available`");

		// Удаляем права на нестандартные контроллеры
		$this->load->model('user/user_group');
		$this->model_user_user_group->removePermission($this->user->getId(), 'access', 'sale/' . $this->_moduleSysName);
		$this->model_user_user_group->removePermission($this->user->getId(), 'modify', 'sale/' . $this->_moduleSysName);

		return TRUE;
	}

}
