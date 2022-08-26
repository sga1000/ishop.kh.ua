<?php

class Mail
{

	protected $to;
	protected $from;
	protected $sender;
	protected $reply_to;
	protected $subject;
	protected $text;
	protected $html;
	protected $attachments = array();
	public $protocol = 'mail';
	public $smtp_hostname;
	public $smtp_username;
	public $smtp_password;
	public $smtp_port = 25;
	public $smtp_timeout = 5;
	public $newline = "\n";
	public $verp = false;
	public $parameter = '';

	public function __construct($config = array())
	{
		foreach ($config as $key => $value) {
			$this->$key = $value;
		}
	}

	protected function log($message){
		file_put_contents(DIR_LOGS . "error.log", date("Y-m-d H:i:s - MAIL: ") . $message . "\r\n", FILE_APPEND);
	}

	public function setTo($to)
	{
		$this->to = $to;
	}

	public function setFrom($from)
	{
		$this->from = $from;
	}

	public function setSender($sender)
	{
		$this->sender = $sender;
	}

	public function setReplyTo($reply_to)
	{
		$this->reply_to = $reply_to;
	}

	public function setSubject($subject)
	{
		$this->subject = $subject;
	}

	public function setText($text)
	{
		$this->text = $text;
	}

	public function setHtml($html)
	{
		$this->html = $html;
	}

	public function addAttachment($filename, $newfilename = '')
	{
		$this->attachments[] = array(
			'filename' => $filename,
			'newfilename' => $newfilename,
		);
	}

	public function send()
	{
		if (!$this->to) {
			$this->log('Error: E-Mail to required!');
			return;
		}

		if (!$this->from) {
			$this->log('Error: E-Mail from required!');
			return;
		}

		if (!$this->sender) {
			$this->log('Error: E-Mail sender required!');
			return;
		}

		if (!$this->subject) {
			$this->log('Error: E-Mail subject required!');
			return;
		}

		if ((!$this->text) && (!$this->html)) {
			$this->log('Error: E-Mail message required!');
			return;
		}

		if (is_array($this->to)) {
			$to = implode(',', $this->to);
		} else {
			$to = $this->to;
		}

		$boundary = '----=_NextPart_' . md5(time());

		$header = 'MIME-Version: 1.0' . $this->newline;

		if ($this->protocol != 'mail') {
			$header .= 'To: ' . $to . $this->newline;
			$header .= 'Subject: =?UTF-8?B?' . base64_encode($this->subject) . '?=' . $this->newline;
		}

		$header .= 'Date: ' . date('D, d M Y H:i:s O') . $this->newline;
		$header .= 'From: =?UTF-8?B?' . base64_encode($this->sender) . '?=' . ' <' . $this->from . '>' . $this->newline;

		if (!$this->reply_to) {
			$header .= 'Reply-To: =?UTF-8?B?' . base64_encode($this->sender) . '?=' . ' <' . $this->from . '>' . $this->newline;
		} else {
			$header .= 'Reply-To: =?UTF-8?B?' . base64_encode($this->reply_to) . '?=' . ' <' . $this->reply_to . '>' . $this->newline;
		}

		$header .= 'Return-Path: ' . $this->from . $this->newline;
		$header .= 'X-Mailer: PHP/' . phpversion() . $this->newline;
		$header .= 'Content-Type: multipart/related; boundary="' . $boundary . '"' . $this->newline . $this->newline;

		if (!$this->html) {
			$message = '--' . $boundary . $this->newline;
			$message .= 'Content-Type: text/plain; charset="utf-8"' . $this->newline;
			$message .= 'Content-Transfer-Encoding: 8bit' . $this->newline . $this->newline;
			$message .= $this->text . $this->newline;
		} else {
			$message = '--' . $boundary . $this->newline;
			$message .= 'Content-Type: multipart/alternative; boundary="' . $boundary . '_alt"' . $this->newline . $this->newline;
			$message .= '--' . $boundary . '_alt' . $this->newline;
			$message .= 'Content-Type: text/plain; charset="utf-8"' . $this->newline;
			$message .= 'Content-Transfer-Encoding: 8bit' . $this->newline . $this->newline;

			if ($this->text) {
				$message .= $this->text . $this->newline;
			} else {
				$message .= 'This is a HTML email and your email client software does not support HTML email!' . $this->newline;
			}

			$message .= '--' . $boundary . '_alt' . $this->newline;
			$message .= 'Content-Type: text/html; charset="utf-8"' . $this->newline;
			$message .= 'Content-Transfer-Encoding: 8bit' . $this->newline . $this->newline;
			$message .= $this->html . $this->newline;
			$message .= '--' . $boundary . '_alt--' . $this->newline;
		}

		foreach ($this->attachments as $attachment) {
			if (file_exists($attachment['filename'])) {
				$handle = fopen($attachment['filename'], 'r');

				$content = fread($handle, filesize($attachment['filename']));

				fclose($handle);

				$filename= $attachment['filename'];
				
				if($attachment['newfilename'])
					$filename = $attachment['newfilename'];
				
				$message .= '--' . $boundary . $this->newline;
				$message .= 'Content-Type: application/octet-stream; name="' . basename($filename) . '"' . $this->newline;
				$message .= 'Content-Transfer-Encoding: base64' . $this->newline;
				$message .= 'Content-Disposition: attachment; filename="' . basename($filename) . '"' . $this->newline;
				$message .= 'Content-ID: <' . basename(urlencode($attachment['filename'])) . '>' . $this->newline;
				$message .= 'X-Attachment-Id: ' . basename(urlencode($attachment['filename'])) . $this->newline . $this->newline;
				$message .= chunk_split(base64_encode($content));
			}
		}

		$message .= '--' . $boundary . '--' . $this->newline;

		if ($this->protocol == 'mail') {
			ini_set('sendmail_from', $this->from);

			if ($this->parameter) {
				mail($to, '=?UTF-8?B?' . base64_encode($this->subject) . '?=', $message, $header, $this->parameter);
			} else {
				mail($to, '=?UTF-8?B?' . base64_encode($this->subject) . '?=', $message, $header);
			}
		} elseif ($this->protocol == 'smtp') {
			$tls = substr($this->smtp_hostname, 0, 3) == 'tls';
			$hostname = $tls ? substr($this->smtp_hostname, 6) : $this->smtp_hostname;

			$handle = fsockopen($hostname, $this->smtp_port, $errno, $errstr, $this->smtp_timeout);

			if (!$handle) {
				$this->log('Error: ' . $errstr . ' (' . $errno . ')');
				return;
			} else {
				if (substr(PHP_OS, 0, 3) != 'WIN') {
					socket_set_timeout($handle, $this->smtp_timeout, 0);
				}

				while ($line = fgets($handle, 515)) {
					if (substr($line, 3, 1) == ' ') {
						break;
					}
				}

				fputs($handle, 'EHLO ' . getenv('SERVER_NAME') . "\r\n");

				$reply = '';

				while ($line = fgets($handle, 515)) {
					$reply .= $line;

					if (substr($line, 3, 1) == ' ') {
						break;
					}
				}

				if (substr($reply, 0, 3) != 250) {
					$this->log('Error: EHLO not accepted from server!');
					return;
				}

				if ($tls) {
					fputs($handle, 'STARTTLS' . "\r\n");

					$reply = '';

					while ($line = fgets($handle, 515)) {
						$reply .= $line;

						if (substr($line, 3, 1) == ' ') {
							break;
						}
					}

					if (substr($reply, 0, 3) != 220) {
						$this->log('Error: STARTTLS not accepted from server!');
						return;
					}

					stream_socket_enable_crypto($handle, true, STREAM_CRYPTO_METHOD_TLS_CLIENT);
				}

				if (!empty($this->smtp_username) && !empty($this->smtp_password)) {
					fputs($handle, 'EHLO ' . getenv('SERVER_NAME') . "\r\n");

					$reply = '';

					while ($line = fgets($handle, 515)) {
						$reply .= $line;

						if (substr($line, 3, 1) == ' ') {
							break;
						}
					}

					if (substr($reply, 0, 3) != 250) {
						$this->log('Error: EHLO not accepted from server!');
						return;
					}

					fputs($handle, 'AUTH LOGIN' . "\r\n");

					$reply = '';

					while ($line = fgets($handle, 515)) {
						$reply .= $line;

						if (substr($line, 3, 1) == ' ') {
							break;
						}
					}

					if (substr($reply, 0, 3) != 334) {
						$this->log('Error: AUTH LOGIN not accepted from server!');
						return;
					}

					fputs($handle, base64_encode($this->smtp_username) . "\r\n");

					$reply = '';

					while ($line = fgets($handle, 515)) {
						$reply .= $line;

						if (substr($line, 3, 1) == ' ') {
							break;
						}
					}

					if (substr($reply, 0, 3) != 334) {
						$this->log('Error: Username not accepted from server!');
						return;
					}

					fputs($handle, base64_encode($this->smtp_password) . "\r\n");

					$reply = '';

					while ($line = fgets($handle, 515)) {
						$reply .= $line;

						if (substr($line, 3, 1) == ' ') {
							break;
						}
					}

					if (substr($reply, 0, 3) != 235) {
						$this->log('Error: Password not accepted from server!');
						return;
					}
				} else {
					fputs($handle, 'HELO ' . getenv('SERVER_NAME') . "\r\n");

					$reply = '';

					while ($line = fgets($handle, 515)) {
						$reply .= $line;

						if (substr($line, 3, 1) == ' ') {
							break;
						}
					}

					if (substr($reply, 0, 3) != 250) {
						$this->log('Error: HELO not accepted from server!');
						return;
					}
				}

				if ($this->verp) {
					fputs($handle, 'MAIL FROM: <' . $this->from . '>XVERP' . "\r\n");
				} else {
					fputs($handle, 'MAIL FROM: <' . $this->from . '>' . "\r\n");
				}

				$reply = '';

				while ($line = fgets($handle, 515)) {
					$reply .= $line;

					if (substr($line, 3, 1) == ' ') {
						break;
					}
				}

				if (substr($reply, 0, 3) != 250) {
					$this->log('Error: MAIL FROM not accepted from server!');
					return;
				}

				if (!is_array($this->to)) {
					fputs($handle, 'RCPT TO: <' . $this->to . '>' . "\r\n");

					$reply = '';

					while ($line = fgets($handle, 515)) {
						$reply .= $line;

						if (substr($line, 3, 1) == ' ') {
							break;
						}
					}

					if ((substr($reply, 0, 3) != 250) && (substr($reply, 0, 3) != 251)) {
						$this->log('Error: RCPT TO not accepted from server!');
						return;
					}
				} else {
					foreach ($this->to as $recipient) {
						fputs($handle, 'RCPT TO: <' . $recipient . '>' . "\r\n");

						$reply = '';

						while ($line = fgets($handle, 515)) {
							$reply .= $line;

							if (substr($line, 3, 1) == ' ') {
								break;
							}
						}

						if ((substr($reply, 0, 3) != 250) && (substr($reply, 0, 3) != 251)) {
							$this->log('Error: RCPT TO not accepted from server!');
							return;
						}
					}
				}

				fputs($handle, 'DATA' . "\r\n");

				$reply = '';

				while ($line = fgets($handle, 515)) {
					$reply .= $line;

					if (substr($line, 3, 1) == ' ') {
						break;
					}
				}

				if (substr($reply, 0, 3) != 354) {
					$this->log('Error: DATA not accepted from server!');
					return;
				}

				// According to rfc 821 we should not send more than 1000 including the CRLF
				$message = str_replace("\r\n", "\n", $header . $message);
				$message = str_replace("\r", "\n", $message);

				$lines = explode("\n", $message);

				foreach ($lines as $line) {
					$results = str_split($line, 998);

					foreach ($results as $result) {
						if (substr(PHP_OS, 0, 3) != 'WIN') {
							fputs($handle, $result . "\r\n");
						} else {
							fputs($handle, str_replace("\n", "\r\n", $result) . "\r\n");
						}
					}
				}

				fputs($handle, '.' . "\r\n");

				$reply = '';

				while ($line = fgets($handle, 515)) {
					$reply .= $line;

					if (substr($line, 3, 1) == ' ') {
						break;
					}
				}

				if (substr($reply, 0, 3) != 250) {
					$this->log('Error: DATA not accepted from server!');
					return;
				}

				fputs($handle, 'QUIT' . "\r\n");

				$reply = '';

				while ($line = fgets($handle, 515)) {
					$reply .= $line;

					if (substr($line, 3, 1) == ' ') {
						break;
					}
				}

				if (substr($reply, 0, 3) != 221) {
					$this->log('Error: QUIT not accepted from server!');
					return;
				}

				fclose($handle);
			}
		}
	}

}
