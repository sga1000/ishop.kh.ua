<?php

/**
 * Класс для работы с сервисом Sms.ru
 */
class SmsRu
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
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "sms.ru: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{

		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);

		$data = array(
			'api_id' => $this->login,
			'from' => $this->sender,
			'to' => $this->phone,
			'msg' => $this->message
		);

		$ch = curl_init("https://sms.ru/sms/send?json=1");
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_TIMEOUT, 5);
		curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
		$result = curl_exec($ch);

		$result = json_decode($result);
		if (!$result) {
			$this->log("Не удалось подключиться к шлюзу smsru");
		} else {
			$this->log("ответ сервера: " . print_r($result, true));
		}

		curl_close($ch);

		return $result;
	}

}
