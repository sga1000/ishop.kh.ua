<?php

/**
 * Класс для работы с сервисом letsadscom.com
 */
class LetsadsCom
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
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "letsadscom.com: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{

		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);

		$sUrl = 'https://letsads.com/api';
		$sXML = '<?xml version="1.0" encoding="UTF-8"?>
<request>
    <auth>
        <login>' . $this->login . '</login>
        <password>' . $this->password . '</password>
    </auth>
    <message>
        <from>' . $this->sender . '</from>
        <text>' . $this->message . '</text>
        <recipient>' . $this->phone . '</recipient>
    </message>
</request>';

		$rCurl = curl_init($sUrl);
		curl_setopt($rCurl, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt($rCurl, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($rCurl, CURLOPT_HEADER, 0);
		curl_setopt($rCurl, CURLOPT_POSTFIELDS, $sXML);
		curl_setopt($rCurl, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($rCurl, CURLOPT_POST, 1);
		$sAnswer = curl_exec($rCurl);
		curl_close($rCurl);

		if (!$sAnswer) {
			$this->log("Не удалось подключиться к шлюзу letsadscom");
		} else {
			$this->log("ответ сервера: " . print_r($sAnswer, true));
		}

		return $sAnswer;
	}

}
