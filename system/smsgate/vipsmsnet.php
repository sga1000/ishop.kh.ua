<?php

/**
 * Класс для работы с сервисом VipSMS.net
 */
class VipSmsNet
{

	public $login = "";
	public $password = "";
	public $sender = false;
	public $message = "";
	public $phone = "";
	public $debug = false;
	public $_logFile = "neoseo_sms_notify.log";
	private $_soapCli;
	private $_soapSession;
	private $_err = array();
	private $_login;
	private $_password;
	private $_sign;

	const VERSION = '0.10';

	protected function log($message)
	{
		if (!$this->debug)
			return;
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "vipsms.net: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{
		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);
		try {
			$this->_soapCli = @new SoapClient('http://vipsms.net/api/soap.html', array(
				'exceptions' => 1,
				'connection_timeout' => 5,
				'user_agent' => 'SOAP/PHP_' . phpversion() . '/opencart_' . VERSION . '/mod_' . self::VERSION
			));
			$this->_login = $this->login;
			$this->_password = $this->password;
			$this->_sign = $this->sender;
		} catch (SoapFault $ex) {
			$this->log("Не удалось подключиться к шлюзу: " . $ex->getMessage());
		}

		$result = $this->sendSms("+" . $this->phone, $this->message);
		if (!$result) {
			$this->log("При отправке сообщения произошла ошибка");
		}
		return $result;
	}

	public function sendSms($dst_phone, $message)
	{

		if (!$this->_auth())
			return false;

		try {
			$res = $this->_soapCli->sendSmsOne($this->_soapSession, $dst_phone, $this->_sign, $message);
		} catch (SoapFault $ex) {
			$this->_err[] = 'Soap send message failed:' . $ex->getMessage();
			return false;
		}

		if ($res->code != 0) {
			$this->log("Отправка смс закончилась ошибкой. Детали:\n" . print_r($res, true));

			$this->_explainSoapProblem($res);
			return false;
		}

		return true;
	}

	public function getErrors($sep = "\n")
	{
		return join($sep, $this->_err);
	}

	private function _auth()
	{
		if (is_null($this->_soapCli))
			return false;
		try {
			$res = $this->_soapCli->auth($this->_login, $this->_password);
		} catch (SoapFault $ex) {
			$this->_err[] = 'Soap server connection failed:' . $ex->getMessage();
			return false;
		}

		if ($res->code != 0) {
			$this->_err[] = $res->message;
			$this->_explainSoapProblem($res);
		}

		if (!empty($this->_err)) {
			$this->log("Авторизация не выполнена. Детали:\n" . print_r($res, true));
			return false;
		}

		$this->_soapSession = $res->message;
		return true;
	}

	private function _explainSoapProblem($soap_res)
	{
		if ($soap_res->extend && is_array($soap_res->extend)) {
			$this->_err[] = var_export($soap_res->extend, true);
		}
		return;
	}

}
