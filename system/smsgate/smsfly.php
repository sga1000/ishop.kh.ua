<?php

/**
 * Класс для работы с сервисом Sms.ru
 */
class SmsFly
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

		if (!$this->sender) {
			$source = "InfoCentr";
		} else {
			$source = $this->sender;
		}
		$textQuery = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
		$textQuery .= "<request>";
		$textQuery .= "<operation>SENDSMS</operation>";
		$textQuery .= '		<message start_time="AUTO" end_time="AUTO" lifetime="4" rate="1" desc="" source="' . $source . '" version="opencart">' . "\n";
		$textQuery .= "		<body>" . htmlspecialchars($this->message) . "</body>";
		$textQuery .= "		<recipient>" . preg_replace("/[^0-9+]/", '', $this->phone) . "</recipient>";
		$textQuery .= "</message>";
		$textQuery .= "</request>";

		$auth = $this->login . ':' . $this->password;
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_USERPWD, $auth);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_URL, 'http://sms-fly.com/api/api.php');
		curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-Type: text/xml", "Accept: text/xml"));
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_TIMEOUT, 5);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $textQuery);

		$result = curl_exec($ch);

		if (!$result) {
			$this->log("Не удалось подключиться к шлюзу smsfly");
		} else {
			$this->log("ответ сервера: " . print_r($result, true));
		}

		curl_close($ch);

		return $result;

		//Если отрабатывает этот код,  то заказ оформить невозоможно
		if (!isset($result)) {
			return 'Не удалось выполнить запрос';
		}
		if ($result == 'EMPTY REQUEST' || $result == 'Access denied!') {
			return 'Не удалось выполнить авторизацию';
		}

		$xml = new SimpleXMLElement($result);
		$code = (string) $xml->state['code'];
		switch ($code) {
			case 'ERRPHONES':
				return "Неправильный номер получателя!";
			case 'ACCEPT':
				return "Сообщение отправлено.";
			case 'ERRTEXT':
				return "Текст сообщения не может быть пустым.";
			case 'ERRALFANAME':
				return "Неправильное альфаимя.";
		}

		return 'Неизвестный статус';
	}

}
