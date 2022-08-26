<?php

class intelTeleCom
{


	public $login = "";
	public $password = "";
	public $sender = "";
	public $message = "";
	public $phone = "";
	public $debug = false;
	public $_logFile = "neoseo_sms_notify.log";

	protected function log($message)
	{
		if (!$this->debug)
			return;
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "intel-tele.com: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{

		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);

		$data = array(
			"to" => $this->phone,
			"from" => $this->sender,
			"message" => $this->message,
			"username" => $this->login,
			"api_key" => $this->password,
		);

		$curl = curl_init("http://api.sms.intel-tele.com/message/send/");
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
		$result = curl_exec($curl);
		curl_close($curl);

		if (!$result) {
			$this->log("Не удалось подключиться к шлюзу intel-tele.com");
		} else {
			$this->log("ответ сервера: " . print_r($result, true));
		}

		return $result;
	}

}

?>
