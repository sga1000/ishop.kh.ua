<?php

// Examples:
// include "smsc_api.php";
// list($sms_id, $sms_cnt, $cost, $balance) = send_sms("79999999999", "Ваш пароль: 123", 1);
// list($sms_id, $sms_cnt, $cost, $balance) = send_sms("79999999999", "http://my.smscab.ru\nMY.SMSCAB.RU", 0, 0, 0, 0, false, "maxsms=3");
// list($sms_id, $sms_cnt, $cost, $balance) = send_sms("79999999999", "0605040B8423F0DC0601AE02056A0045C60C036D79736974652E72750001036D7973697465000101", 0, 0, 0, 5, false);
// list($sms_id, $sms_cnt, $cost, $balance) = send_sms("79999999999", "", 0, 0, 0, 3, false);
// list($cost, $sms_cnt) = get_sms_cost("79999999999", "Вы успешно зарегистрированы!");
// send_sms_mail("79999999999", "Ваш пароль: 123", 0, "0101121000");
// list($status, $time) = get_status($sms_id, "79999999999");
// $balance = get_balance();


class SmsCabRu
{

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
		file_put_contents(DIR_LOGS . $this->_logFile, date("Y-m-d H:i:s - ") . "smscab.ru: " . $message . "\r\n", FILE_APPEND);
	}

	public function send()
	{
		$this->send_sms($this->phone, $this->message, $this->translit, $this->time, $this->id, $this->format, $this->sender, $this->query);
		return true;
	}

	// Функция отправки SMS
	//
    // обязательные параметры:
	//
    // $phones - список телефонов через запятую или точку с запятой
	// $message - отправляемое сообщение
	//
    // необязательные параметры:
	//
    // $translit - переводить или нет в транслит (1,2 или 0)
	// $time - необходимое время доставки в виде строки (DDMMYYhhmm, h1-h2, 0ts, +m)
	// $id - идентификатор сообщения. Представляет собой 32-битное число в диапазоне от 1 до 2147483647.
	// $format - формат сообщения (0 - обычное sms, 1 - flash-sms, 2 - wap-push, 3 - hlr, 4 - bin, 5 - bin-hex, 6 - ping-sms)
	// $sender - имя отправителя (Sender ID). Для отключения Sender ID по умолчанию необходимо в качестве имени
	// передать пустую строку или точку.
	// $query - строка дополнительных параметров, добавляемая в URL-запрос ("valid=01:00&maxsms=3&tz=2")
	//
    // возвращает массив (<id>, <количество sms>, <стоимость>, <баланс>) в случае успешной отправки
	// либо массив (<id>, -<код ошибки>) в случае ошибки

	function send_sms($phones, $message, $translit = 0, $time = 0, $id = 0, $format = 0, $sender = false, $query = "")
	{
		static $formats = array(1 => "flash=1", "push=1", "hlr=1", "bin=1", "bin=2", "ping=1");

		$m = $this->_smsc_send_cmd("send", "cost=3&phones=" . urlencode($phones) . "&mes=" . urlencode($message) .
		    "&translit=$translit&id=$id" . ($format > 0 ? "&" . $formats[$format] : "") .
		    ($sender === false ? "" : "&sender=" . urlencode($sender)) .
		    ($time ? "&time=" . urlencode($time) : "") . ($query ? "&$query" : ""));

		// (id, cnt, cost, balance) или (id, -error)

		if ($m[1] > 0)
			$this->log("Сообщение отправлено успешно. ID: $m[0], всего SMS: $m[1], стоимость: $m[2], баланс: $m[3].\n");
		else
			$this->log("Ошибка №" . -$m[1] . ", ID: " . $m[0] . "\n");

		return $m;
	}

	// SMTP версия функции отправки SMS

	function send_sms_mail($phones, $message, $translit = 0, $time = 0, $id = 0, $format = 0, $sender = "")
	{
		return mail("send@send.my.smscab.ru", "", SMSC_LOGIN . ":" . SMSC_PASSWORD . ":$id:$time:$translit,$format,$sender:$phones:$message", "From: " . SMTP_FROM . "\nContent-Type: text/plain; charset=" . SMSC_CHARSET . "\n");
	}

	// Функция получения стоимости SMS
	//
    // обязательные параметры:
	//
    // $phones - список телефонов через запятую или точку с запятой
	// $message - отправляемое сообщение
	//
    // необязательные параметры:
	//
    // $translit - переводить или нет в транслит (1,2 или 0)
	// $format - формат сообщения (0 - обычное sms, 1 - flash-sms, 2 - wap-push, 3 - hlr, 4 - bin, 5 - bin-hex, 6 - ping-sms)
	// $sender - имя отправителя (Sender ID)
	// $query - строка дополнительных параметров, добавляемая в URL-запрос ("list=79999999999:Ваш пароль: 123\n78888888888:Ваш пароль: 456")
	//
    // возвращает массив (<стоимость>, <количество sms>) либо массив (0, -<код ошибки>) в случае ошибки

	function get_sms_cost($phones, $message, $translit = 0, $format = 0, $sender = false, $query = "")
	{
		static $formats = array(1 => "flash=1", "push=1", "hlr=1", "bin=1", "bin=2", "ping=1");

		$m = $this->_smsc_send_cmd("send", "cost=1&phones=" . urlencode($phones) . "&mes=" . urlencode($message) .
		    ($sender === false ? "" : "&sender=" . urlencode($sender)) .
		    "&translit=$translit" . ($format > 0 ? "&" . $formats[$format] : "") . ($query ? "&$query" : ""));

		// (cost, cnt) или (0, -error)

		if ($m[1] > 0)
			$this->log("Стоимость рассылки: $m[0]. Всего SMS: $m[1]\n");
		else
			$this->log("Ошибка №" . -$m[1] . "\n");

		return $m;
	}

	// Функция проверки статуса отправленного SMS или HLR-запроса
	//
    // $id - ID cообщения
	// $phone - номер телефона
	// $all - вернуть все данные отправленного SMS, включая текст сообщения (0 или 1)
	//
    // возвращает массив:
	//
    // для SMS-сообщения:
	// (<статус>, <время изменения>, <код ошибки доставки>)
	//
    // для HLR-запроса:
	// (<статус>, <время изменения>, <код ошибки sms>, <код IMSI SIM-карты>, <номер сервис-центра>, <код страны регистрации>, <код оператора>,
	// <название страны регистрации>, <название оператора>, <название роуминговой страны>, <название роумингового оператора>)
	//
    // При $all = 1 дополнительно возвращаются элементы в конце массива:
	// (<время отправки>, <номер телефона>, <стоимость>, <sender id>, <название статуса>, <текст сообщения>)
	//
    // либо массив (0, -<код ошибки>) в случае ошибки

	function get_status($id, $phone, $all = 0)
	{
		$m = $this->_smsc_send_cmd("status", "phone=" . urlencode($phone) . "&id=" . $id . "&all=" . (int) $all);

		// (status, time, err, ...) или (0, -error)

		if ($m[1] != "" && $m[1] >= 0)
			$this->log("Статус SMS = $m[0]", $m[1] ? ", время изменения статуса - " . date("d.m.Y H:i:s", $m[1]) : "", "\n");
		else
			$this->log("Ошибка №" . -$m[1] . "\n");

		if ($all && count($m) > 9 && (!isset($m[14]) || $m[14] != "HLR")) // ',' в сообщении
			$m = explode(",", implode(",", $m), 9);

		return $m;
	}

	// Функция получения баланса
	//
    // без параметров
	//
    // возвращает баланс в виде строки или false в случае ошибки

	function get_balance()
	{
		$m = $this->_smsc_send_cmd("balance"); // (balance) или (0, -error)

		if (!isset($m[1]))
			$this->log("Сумма на счете: ", $m[0], "\n");
		else
			$this->log("Ошибка №" . -$m[1] . "\n");

		return isset($m[1]) ? false : $m[0];
	}

	// ВНУТРЕННИЕ ФУНКЦИИ
	// Функция вызова запроса. Формирует URL и делает 3 попытки чтения

	function _smsc_send_cmd($cmd, $arg = "")
	{
		$url = ($this->https ? "https" : "http") . "://my.smscab.ru/sys/$cmd.php?login=" . urlencode($this->login) . "&psw=" . urlencode($this->password) . "&fmt=1&charset=" . $this->charset . "&" . $arg;
		$i = 0;
		do {
			if ($i) {
				sleep(2);

				if ($i == 2)
					$url = str_replace('://my.smscab.ru/', '://www2.my.smscab.ru/', $url);
			}

			$ret = $this->_smsc_read_url($url);
		} while ($ret == "" && ++$i < 3);

		if ($ret == "") {
			$this->log("Ошибка чтения адреса: $url\n");

			$ret = ","; // фиктивный ответ
		}

		return explode(",", $ret);
	}

	// Функция чтения URL. Для работы должно быть доступно:
	// curl или fsockopen (только http) или включена опция allow_url_fopen для file_get_contents

	function _smsc_read_url($url)
	{
		$ret = "";
		$post = $this->post || strlen($url) > 2000;

		if (function_exists("curl_init")) {
			static $c = 0; // keepalive

			if (!$c) {
				$c = curl_init();
				curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
				curl_setopt($c, CURLOPT_CONNECTTIMEOUT, 10);
				curl_setopt($c, CURLOPT_TIMEOUT, 60);
				curl_setopt($c, CURLOPT_SSL_VERIFYPEER, 0);
			}

			if ($post) {
				list($url, $post) = explode("?", $url, 2);
				curl_setopt($c, CURLOPT_POST, true);
				curl_setopt($c, CURLOPT_POSTFIELDS, $post);
			}

			curl_setopt($c, CURLOPT_URL, $url);

			$ret = curl_exec($c);
		} elseif (!$this->https && function_exists("fsockopen")) {
			$m = parse_url($url);

			if (!$fp = fsockopen($m["host"], 80, $errno, $errstr, 10))
				$fp = fsockopen("78.129.199.124", 80, $errno, $errstr, 10);

			if ($fp) {
				fwrite($fp, ($post ? "POST $m[path]" : "GET $m[path]?$m[query]") . " HTTP/1.1\r\nHost: my.smscab.ru\r\nUser-Agent: PHP" . ($post ? "\r\nContent-Type: application/x-www-form-urlencoded\r\nContent-Length: " . strlen($m['query']) : "") . "\r\nConnection: Close\r\n\r\n" . ($post ? $m['query'] : ""));

				while (!feof($fp))
					$ret .= fgets($fp, 1024);
				list(, $ret) = explode("\r\n\r\n", $ret, 2);

				fclose($fp);
			}
		} else
			$ret = file_get_contents($url);

		return $ret;
	}

}
