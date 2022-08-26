<?php

/**
 * Класс для работы с сервисом semysms.net
 * В качестве логина используем device
 * В качестве пароля используем token
 */
class SemySmsNet
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
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "semysms.net: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{

		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);

		$data = array(
			"phone" => $this->phone,
			"msg" => $this->message,
			"device" => $this->login, // Код вашего устройства
			"token" => $this->password, // Ваш токен (секретный)
		);

		$curl = curl_init("https://semysms.net/api/3/sms.php");
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
		$result = curl_exec($curl);
		curl_close($curl);

		if (!$result) {
			$this->log("Не удалось подключиться к шлюзу semysmsnet");
		} else {
			$this->log("ответ сервера: " . print_r($result, true));
		}

		return $result;
	}

}
