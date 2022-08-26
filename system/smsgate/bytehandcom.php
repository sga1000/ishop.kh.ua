<?php

/**
 * Класс для работы с сервисом ByteHand.com
 */
class ByteHandCom
{

	const REQUEST_SUCCESS = 'success';
	const REQUEST_ERROR = 'error';

	public $login = "";
	public $password = "";
	public $sender = false;
	public $message = "";
	public $phone = "";
	public $debug = false;
	public $_logFile = "neoseo_sms_notify.log";

	protected function log($message)
	{
		if (!$this->debug)
			return;
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "bytehand.com: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{

		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);

		$data = array(
			'id' => $this->login,
			'key' => $this->password,
			'from' => $this->sender,
			'to' => $this->phone,
			'text' => $this->message
		);

		$url = "http://bytehand.com:3800/send?" . http_build_query($data);

		//$this->log("запрос к серверу: $url");

		$result = @file_get_contents($url);

		if (!$result) {
			$this->log("Не удалось подключиться к шлюзу bytehandcom");
		} else {
			$this->log("ответ сервера: " . print_r($result, true));
		}

		return $result;
	}

}
