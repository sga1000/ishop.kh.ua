<?php

class TurboSMS
{

	private $client;
	public $login = "";
	public $password = "";
	public $sender = false;
	public $post = 0;
	public $https = 0;
	public $charset = "utf-8";
	public $debug = 0;
	public $smtp_from = "api@my.smscab.ru";
	public $phone = "";
	public $message = "";
	public $translit = 0;
	public $time = 0;
	public $id = 0;
	public $format = 0;
	public $query = "";
	public $_logFile = "neoseo_sms_notify.log";

	protected function log($message)
	{
		if (!$this->debug)
			return;
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "turbosms.ua: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{
		$this->send_sms($this->phone, $this->message, $this->translit, $this->time, $this->id, $this->format, $this->sender, $this->query);
		return true;
	}

	public function send_sms($phones, $message, $translit = 0, $time = 0, $id = 0, $format = 0, $sender = false, $query = "")
	{
		$results = array();

		$count = 1;
		$phones = '+' . $phones;
		$auth = array(
			'login' => $this->login,
			'password' => $this->password
		);

		$sms = array(
			'sender' => $sender,
			'destination' => $phones,
			'text' => $message
		);

		$results[] = $this->process($auth, $sms, $count);

		return $results;
	}

	private function process($auth, $sms, $count)
	{
		$message = '';
		$response = '';
		// В режиме отладки процесс отправки сообщений
		// будет записан в журнал system/logs/turbosms.log,
		// для его включения измените значение переменной строкой ниже на true.
		// $debug_mode = false;
		// $this->debug = true;

		if (class_exists('SoapClient')) {
			try {
				$this->client = new SoapClient('http://turbosms.in.ua/api/wsdl.html');

				$connected = false;
				$auth_result = $this->client->Auth($auth);
				$auth_result_text = $auth_result->AuthResult;

				if ($auth_result_text == 'Вы успешно авторизировались') {
					$connected = true;
				} else {
					$message = 'Не удалось пройти авторизацию: ' . $auth_result_text . '.';
					$this->log($message);

					$response .= $message;
				}
				if ($connected) {
					$send_result = $this->client->SendSMS($sms);
					if (is_array($send_result->SendSMSResult->ResultArray)) {
						$status = trim($send_result->SendSMSResult->ResultArray[0]);
					} else {
						$status = trim($send_result->SendSMSResult->ResultArray);
					}

					if ('Сообщения успешно отправлены' == $status) {
						$message = 'Сообщения успешно отправлены: На Вашем счету осталось ' . $this->balance() . ' кредит(а, ов).';
						$this->log($message);
						$response .= $message;

						for ($i = 1; $i <= $count; $i++) {
							$message = 'Идентификатор сообщения №' . $i . ' (в формате UUID): ' . $send_result->SendSMSResult->ResultArray[$i] . '.';
							$this->log($message);
						}
					} else {
						$message = "При отправке сообщения возникла проблема: $status. Подробнее: http://turbosms.ua/soap.html";
						$this->log($message);
						$response .= $message;
					}
				}
			} catch (SoapFault $ex) {
				$message = "Не удалось подключиться к шлюзу: " . $ex->getMessage();
				$this->log($message);
				$response .= $message;
			}
		} else {
			$message = 'SOAP библиотека не подключена, для её подключения обратитесь к хостеру (подробнее: http://www.php.net/manual/ru/soap.installation.php).';

			$this->log($message);

			$response .= $message;
		}

		return $response;
	}

	private function balance()
	{
		$result = $this->client->GetCreditBalance();
		return round($result->GetCreditBalanceResult);
	}

}

?>
