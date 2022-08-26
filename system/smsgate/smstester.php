<?php

/**
 * Просто логирование итоговых сообщений
 * чтобы не тратить деньги на тестирование
 */
class SmsTester
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
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "smstester: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{
		$this->log($this->sender . ": " . $this->phone . " => " . $this->message);
		return true;
	}

}
