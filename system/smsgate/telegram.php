<?php

/**
 * Класс для работы с сервисом Telegram
 */
class telegram
{

	public $login = "";
	public $api_key = "";
	public $chat_id = "";
	public $password = "";
	public $sender = false;
	public $message = "";
	public $phone = "";
	public $debug = true;
	public $_logFile = "neoseo_sms_notify.log";

	protected function log($message)
	{
		if (!$this->debug)
			return;
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "telegram: " . $message . "\r\n", FILE_APPEND);
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

		if (empty($this->api_key) || empty($this->chat_id)) {
			$this->log("Telegram API Key or chat_id is empty. Can't make request!");
			return;
		}

		$data['api_key'] = $this->api_key;
		$data['chat_id'] = $this->chat_id;
		$data['message'] = urlencode($this->message);
		$this->log("Telegram " . $this->sender . ": " . $this->phone . " => " . $this->message);

		$url = "https://api.telegram.org/bot" . $data['api_key'] . "/sendMessage?chat_id=" . $data['chat_id'] . "&text=" . $data['message'];

		$this->log("запрос к серверу: " . print_r($url, true));

		$result = @file_get_contents($url);

		if (!$result) {
			$this->log("Не удалось подключиться к API Telegram");
		} else {
			$this->log("ответ сервера: " . print_r($result, true));
		}

		return $result;
	}

}
