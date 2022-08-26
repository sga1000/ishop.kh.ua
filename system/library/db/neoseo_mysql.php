<?php

/*
 * Автор: Александр Сорокин ( alex.sorokin@neoseo.com.ua )
 *
 * Необходимость в этой поделке возникла потому что оригинальный файл активно использует trigger_error + exit,
 * не давая тем самым возможности обработать ошибку, которая могла бы быть вполне ожидаемой. Также, оригинальный файл
 * не дает возможность использовать его подключение, устанавливая private-модификатор доступа к переменной link.
 *
 * Все бы можно было исправить посредством vqMod, но он только с версии 2.4.1 начал нормально обрабатывать database/mysql.php,
 * а версии ниже тупо игнорируют этот файл, не давая вносить туда модификации.
 *
 * За исключением этих двух нюансов, файл является полным клоном системного файла.
 */

class NeoSeo_MySQL {
	private $link;

	public function getLink() {
		return $this->link;
	}

	public function connect($hostname, $username, $password, $database) {
		$this->link = mysqli_connect($hostname, $username, $password);
		if (!$this->link)
			throw new Exception('Error: Could not make a database link using '.$username.'@'.$hostname);

		if (!mysqli_select_db($this->link,$database))
			throw new Exception('Error: Could not connect to database '.$database);

		mysqli_query($this->link, "SET NAMES 'utf8'");
		mysqli_query($this->link, "SET CHARACTER SET utf8");
		mysqli_query($this->link, "SET CHARACTER_SET_CONNECTION=utf8");
		mysqli_query($this->link, "SET SQL_MODE = ''");
	}

	public function query($sql) {
		$resource = mysqli_query($this->link, $sql);

		if (!$resource  )
			throw new Exception('Error: '.mysqli_error($this->link).'. Error No: '.mysql_errno($this->link).'. Query: '.$sql);

		if (!is_object($resource))
			return true;

		$i = 0;
		$data = array();
		while ($result = mysqli_fetch_assoc($resource)) {
			$data[$i] = $result;
			$i++;
		}

		mysqli_free_result($resource);

		$query = new stdClass();
		$query->row = isset($data[0]) ? $data[0] : array();
		$query->rows = $data;
		$query->num_rows = $i;

		unset($data);

		return $query;
	}

	public function escape($value) {
		return mysqli_real_escape_string($this->link, $value);
	}

	public function countAffected() {
		return mysqli_affected_rows($this->link);
	}

	public function getLastId() {
		return mysqli_insert_id($this->link);
	}

	public function __destruct() {
		// Если закрыть, то закроется и основное соединение
		// Цитирую http://ca.php.net/manual/en/function.mysql-connect.php
		// ... Opens or reuses a connection to a MySQL server ...
		//mysql_close($this->link);
	}
}
?>