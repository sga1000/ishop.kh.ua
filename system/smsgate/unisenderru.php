<?php

/**
 * Класс для работы с сервисом UniSender.ru
 */
class UnisenderRu
{

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
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "unisender.ru: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{

		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);

		$data = array(
			'format' => 'json',
			'api_key' => $this->password,
			'phone' => $this->phone,
			'sender' => $this->sender,
			'text' => $this->message
		);

		$url = "https://api.unisender.com/ru/api/sendSms?" . http_build_query($data);

		//$this->log("запрос к серверу: $url");

		$result = @file_get_contents($url);

		if (!$result) {
			$this->log("Не удалось подключиться к шлюзу unisender.com");
		} else {
			$this->log("ответ сервера: " . print_r($result, true));
		}


		return $result;
	}

}
