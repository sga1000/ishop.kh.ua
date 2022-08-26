<?php

/**
 * Класс для работы с сервисом AlphaSms.ua
 */
class AlphaSmsUa
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
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "alphasms.ua: " . $message . "\r\n", FILE_APPEND);
	}

	public function base64_url_encode($input)
	{
		return strtr(base64_encode($input), '+/=', '-_,');
	}

	public function base64_url_decode($input)
	{
		return base64_decode(strtr($input, '-_,', '+/='));
	}

	public function send()
	{

		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);

		$data = array();

		if (!$this->password) {
			$data['key'] = $this->base64_url_encode($this->login);
		} else {
			$data['login'] = $this->base64_url_encode($this->login);
			$data['password'] = $this->base64_url_encode($this->password);
		}

		$data['command'] = $this->base64_url_encode('send');
		if ($this->sender) {
			$data['from'] = $this->base64_url_encode($this->sender);
		}
		$data['to'] = $this->base64_url_encode($this->phone);
		$data['message'] = $this->base64_url_encode($this->message);
		$data['version'] = $this->base64_url_encode('http');

		$url = "https://alphasms.com.ua/api/http.php?" . http_build_query($data);
		$this->log("запрос к серверу: " . print_r($url, true));

		$result = @file_get_contents($url);

		//$result = $this->base64_url_decode($response);

		if (!$result) {
			$this->log("Не удалось подключиться к шлюзу alphasmsua");
		} else {
			$this->log("ответ сервера: " . print_r($result, true));
		}

		return $result;
	}

}
