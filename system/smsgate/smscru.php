<?php

/**
 * Класс для работы с сервисом smsc.ru
 */
class Smscru
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
	private $_errors = array(
		1 => 'Ошибка в параметрах',
		2 => 'Неверный логин или пароль.',
		3 => 'Недостаточно средств на счету Клиента.',
		4 => 'IP-адрес временно заблокирован из-за частых ошибок в запросах. Подробнее',
		5 => 'Неверный формат даты.',
		6 => 'Сообщение запрещено (по тексту или по имени отправителя).',
		7 => 'Неверный формат номера телефона.',
		8 => 'Сообщение на указанный номер не может быть доставлено.',
		9 => 'Отправка более одного одинакового запроса на передачу SMS-сообщения в течение минуты',
	);

	const VERSION = '0.01';

	protected function log($message)
	{
		if (!$this->debug)
			return;
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "smsc.ru: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{
		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);
		try {
			$this->_soapCli = @new SoapClient('http://smsc.ru/sys/soap.php?wsdl', array(
				'exceptions' => 1,
				'connection_timeout' => 5,
				'user_agent' => 'SOAP/PHP_' . phpversion() . '/opencart_' . VERSION . '/mod_' . self::VERSION
			));
			$this->_login = $this->login;
			$this->_password = $this->password;
			$this->_sign = $this->sender;
		} catch (SoapFault $ex) {
			$this->log("Не удалось подключиться к шлюзу: " . $ex->getMessage());
			return false;
		}

		return $this->sendSms($this->phone, $this->message);
	}

	public function sendSms($dst_phone, $message)
	{

		try {
			$res = $this->_soapCli->send_sms(array(
				'login' => $this->_login,
				'psw' => $this->_password,
				'phones' => $dst_phone,
				'mes' => $message,
				'id' => '',
				'sender' => $this->_sign,
				'time' => 0
			));
		} catch (SoapFault $ex) {
			$this->log("Проблема SOAP: " . $ex->getMessage());
			return false;
		}

		if (isset($res->sendresult) && isset($res->sendresult->error) && $res->sendresult->error != 0) {
			$error_id = $res->sendresult->error;
			if (isset($this->_errors[$error_id])) {
				$message = $this->_errors[$error_id];
			} else {
				$message = "Неизвестная ошибка №" . $error_id;
			}
			$this->log("Не удалось отправить SMS: " . $message . ". Детали\n" . print_r($res, true));

			return false;
		}

		return true;
	}

	public function getErrors($sep = "\n")
	{
		return join($sep, $this->_err);
	}

}
