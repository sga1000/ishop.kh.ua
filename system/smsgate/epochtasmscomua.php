<?php

/**
 * Класс для работы с сервисом epochtasms.com.ua
 */
class EpochtasmsComUa
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
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "epochtasms.com.ua: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{

		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);

		$src = '<?xml version="1.0" encoding="UTF-8"?>    
<SMS> 
  <operations>  
    <operation>SEND</operation> 
  </operations> 
  <authentification>    
    <username>' . $this->login . '</username>   
    <password>' . $this->password . '</password>   
  </authentification>   
  <message> 
    <sender>' . $this->sender . '</sender>    
    <text>' . $this->message . '</text>   
  </message>    
  <numbers> 
    <number messageID="msg11">' . $this->phone . '</number> 
  </numbers>    
</SMS>';

		$Curl = curl_init();
		$CurlOptions = array(
			CURLOPT_URL => 'http://api.myatompark.com/members/sms/xml.php',
			CURLOPT_FOLLOWLOCATION => false,
			CURLOPT_POST => true,
			CURLOPT_HEADER => false,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_CONNECTTIMEOUT => 15,
			CURLOPT_TIMEOUT => 100,
			CURLOPT_POSTFIELDS => array('XML' => $src),
		);
		curl_setopt_array($Curl, $CurlOptions);

		$result = curl_exec($Curl);

		if (!$result) {
			$this->log("Не удалось подключиться к шлюзу epochtasmscomua");
		} else {
			$this->log("ответ сервера: " . print_r($result, true));
		}

		curl_close($Curl);

		return $result;
	}

}
