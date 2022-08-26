<?php

/**
 * Класс для работы с сервисом sendpulse.com
 */
class Sendpulsecom
{

	public $login = "";
	public $password = "";
	public $sender = false;
	public $message = "";
	public $phone = "";
	public $debug = false;
	public $_logFile = "neoseo_sms_notify.log";
	private $_soapCli;
	private $_err = array();
	private $_login;
	private $_password;
	private $_sign;
	private $apiUrl = 'https://api.sendpulse.com';
	private $token = '';

	protected function log($message)
	{
		if (!$this->debug)
			return;
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "sendpulse.com: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{
		$data = array(
			'grant_type' => 'client_credentials',
			'client_id' => $this->login,
			'client_secret' => $this->password,
		);
		$response = $this->sendRequest('oauth/access_token', $data, false);

		if (!$response || !is_object($response) || !isset($response->access_token) || !$response->access_token)
			return false;

		$this->token = $response->access_token;

		$params = array(
			'sender' => $this->sender,
			'phones' => json_encode(array($this->phone)),
			'body' => $this->message,
			'transliterate' => 0,
		);

		$this->sendRequest('sms/send', $params, true);

		return true;
	}

	private function sendRequest($path, $data = array(), $useToken)
	{
		$url = $this->apiUrl . '/' . $path;
		$curl = curl_init();
		if ($useToken && !empty($this->token)) {
			$headers = array('Authorization: Bearer ' . $this->token);
			curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		}
		curl_setopt($curl, CURLOPT_POST, count($data));
		curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($data));
		curl_setopt($curl, CURLOPT_URL, $url);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HEADER, true);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 15);
		curl_setopt($curl, CURLOPT_TIMEOUT, 15);
		$response = curl_exec($curl);
		$headerCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		$header_size = curl_getinfo($curl, CURLINFO_HEADER_SIZE);
		$responseBody = json_decode(substr($response, $header_size));
		curl_close($curl);
		if (!$response) {
			$this->log("Не удалось подключиться к шлюзу sendpulsecom");
		}
		if ($headerCode !== 200) {
			if (isset($responseBody->error_description))
				$this->log($responseBody->error_description);
			if (isset($responseBody->message))
				$this->log($responseBody->message);
			return false;
		}
		return $responseBody;
	}

}
