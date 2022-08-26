<?php

/**
 *  Класс для работы с сервисом bmi-telecom.ru
 * */
class BmiTelecomRU
{

	public $login = "";
	public $password = "";
	public $sender = false;
	public $message = "";
	public $phone = "";
	public $debug = false;
	public $_logFile = "neoseo_sms_notify.log";

	public function log($message)
	{
		if (!$this->debug)
			return;
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "bmi-telecom.ru: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{
		$this->log($this->phone . " => " . $this->message);

		$params = array(
			'login' => $this->login,
			'password' => $this->password,
			'from' => $this->sender,
			'to' => $this->phone,
			'text' => $this->message,
		);

		$ch = curl_init(); //Работаем через CURL библиотеку
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); //Получить ответ
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($params));
		curl_setopt($ch, CURLOPT_URL, "https://api.bmi.io/sms/v1/send");
		$result = curl_exec($ch); //Отправляем данные
		curl_close($ch);

		if (!$result) {
			$this->log("Не удалось подключиться к шлюзу bmitelecomru");
		} else {
			$this->log("ответ сервера: " . print_r($result, true));
		}

		return $result;
	}

}
