<?php

/**
 *  Класс для работы с сервисом sms-sms.com.ua
 * */
class SmssmsComUa
{

	public $login = "";
	public $password = "";
	public $sender = false;
	public $message = "";
	public $phone = "";
	public $debug = false;
	public $_logFile = "neoseo_sms_notify.log";

	public function send()
	{

		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);

		$src = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
		$src .= "<request>";
		$src .= "<operation>SENDSMS</operation>";
		$src .= '        <message start_time="AUTO" end_time="AUTO" lifetime="4" rate="1" desc=" " source="' . $this->sender . '" version="does not matter">' . "\n";
		$src .= "        <body>" . $this->message . "</body>";
		$src .= "        <recipient>" . $this->phone . "</recipient>";
		$src .= "</message>";
		$src .= "</request>";

		$Curl = curl_init();
		$CurlOptions = array(CURLOPT_URL => 'http://sms-fly.com/api/api.php',
			CURLOPT_FOLLOWLOCATION => false,
			CURLOPT_POST => true,
			CURLOPT_USERPWD => $this->login . ":" . $this->password,
			CURLOPT_HEADER => false,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_CONNECTTIMEOUT => 15,
			CURLOPT_TIMEOUT => 100,
			CURLOPT_POSTFIELDS => $src,
		);
		curl_setopt_array($Curl, $CurlOptions);

		$result = curl_exec($Curl);

		if (!$result) {
			$this->log("Не удалось подключиться к шлюзу smssmscomua");
		} else {
			$this->log("ответ сервера: " . print_r($result, true));
		}

		curl_close($Curl);

		return $result;
	}

	public function log($message)
	{
		if (!$this->debug)
			return;
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "sms-sms.com.ua: " . $message . "\r\n", FILE_APPEND);
	}

}
