<?php

/**
 * Класс для работы с сервисом UniSender.ru
 */
class Tele2Ru
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
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "tele2.ru: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{

		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);

		$data = array(
			'operation' => 'send',
			'login' => $this->login,
			'password' => $this->password,
			'msisdn' => $this->phone,
			'shortcode' => $this->sender,
			'text' => $this->message
		);

		$url = "https://bsms.tele2.ru/api/?" . http_build_query($data);

		//$this->log("запрос к серверу: $url");

		$result = @file_get_contents($url);

		if (!$result) {
			$this->log("Не удалось подключиться к шлюзу tele2ru");
		} else {
			$this->log("ответ сервера: " . print_r($result, true));
		}

		return $result;
	}

}
