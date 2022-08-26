<?php

/**
 * Класс для работы с сервисом kazinfoteh.kz
 */
class KazInfoTehKz
{

	public $login = "";
	public $password = "";
	public $sender = false;
	public $message = "";
	public $phone = "";
	public $debug = false;
	public $_logFile = "neoseo_sms_notify.log";
	private $_soapCli;
	private $_soapSession;
	private $_err = array();
	private $_login;
	private $_password;
	private $_sign;

	const VERSION = '0.10';

	protected function log($message)
	{
		if (!$this->debug)
			return;
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "kazinfoteh.kz: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{

		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);

		$data = array(
			'action' => 'sendmessage',
			'username' => $this->login,
			'password' => $this->password,
			'recipient' => $this->phone,
			'messagetype' => 'SMS:TEXT',
			'originator' => $this->sender,
			'messagedata' => $this->message,
		);

		$url = "http://kazinfoteh.org:9501/api?" . http_build_query($data);

		//$this->log("запрос к серверу: $url");

		$result = @file_get_contents($url);

		if (!$result) {
			$this->log("Не удалось подключиться к шлюзу kazinfotehkz");
		} else {
			$this->log("ответ сервера: " . print_r($result, true));
		}

		return $result;
	}

}
