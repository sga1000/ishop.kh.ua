<?php
set_time_limit(0);

// Configuration
require_once(dirname(__FILE__) . "/../admin/config.php");

// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Database
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);

function delete_dirty_data($result){

	while( true ) {
		$result2 = preg_replace("#(\r).*(\r)#", "\r", $result);
		if( $result2 == $result ) {
			$result = $result2;
			break;
		}
		$result = $result2;
	}
	return $result;
}


function write_log( $message ){
	file_put_contents(DIR_LOGS . "neoseo_optimizer.log" , date("Y-m-d H:i:s - ") . $message . "\r\n", FILE_APPEND );
}

// Settings
$query = $db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE `key`= 'neoseo_optimizer_image_dir_list'");
if($query->num_rows){
	$conf_image_dir = trim($query->row['value']);
}else{
	$conf_image_dir = "/image/cache/";
}

// ищем настройку уровень компрессии
$query = $db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE `key`= 'neoseo_optimizer_compress_level'");
if($query->num_rows){
	$compress_level = trim($query->row['value']);
}else{
	$compress_level = 85;
}
// ищем настройку библиотеки для JPG
$query = $db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE `key`= 'neoseo_optimizer_jpg_driver'");
if($query->num_rows){
	$jpg_driver = trim($query->row['value']);
}else{
	$jpg_driver = 0;
}
// ищем настройку библиотеки для PNG
$query = $db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE `key`= 'neoseo_optimizer_png_driver'");
if($query->num_rows){
	$png_driver = trim($query->row['value']);
}else{
	$png_driver = 0;
}
// ищем настройку библиотеки для PNG to WEBP
$query = $db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE `key`= 'neoseo_optimizer_png_to_webp'");
if($query->num_rows){
	$png_to_webp = trim($query->row['value']);
}else{
	$png_to_webp = 0;
}
// ищем настройку библиотеки для драйвера webp
$query = $db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE `key`= 'neoseo_optimizer_webp_converter'");
if($query->num_rows){
	$webp_driver = trim($query->row['value']);
}else{
	$webp_driver = 0;
}

// ищем настройку бсжатия png
$query = $db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE `key`= 'neoseo_optimizer_png_compress'");
if($query->num_rows){
	$compress_png = trim($query->row['value']);
}else{
	$compress_png = 0;
}

$image_dir_links = array();
$image_dir_links = explode("\n", $conf_image_dir);
write_log("Используем следующие директории для поиска изображений: " . print_r($image_dir_links, true));

write_log("Начинаем оптимизировать данные, уровень комрпесии " . $compress_level);


if($jpg_driver){
	switch ($compress_level){
		case ($compress_level >= 90):
			$compress_jpg = 10;
			break;
		case ($compress_level >= 80):
			$compress_jpg = 20;
			break;
		case ($compress_level >= 70):
			$compress_jpg = 30;
			break;
		case ($compress_level >= 60):
			$compress_jpg = 40;
			break;
		case ($compress_level >= 50):
			$compress_jpg = 50;
			break;
		case ($compress_level >= 40):
			$compress_jpg = 60;
			break;
		case ($compress_level >= 30):
			$compress_jpg = 70;
			break;
		case ($compress_level >= 20):
			$compress_jpg = 80;
			break;
		case ($compress_level >= 10):
			$compress_jpg = 90;
			break;
	}
}else{
	$compress_jpg = 0;
}

foreach ($image_dir_links as $image_dir){
	$image_dir = trim(str_replace('\\',"/",$image_dir));

	$image_dir = ltrim($image_dir,'/');
	if($image_dir{0} != '/' || $image_dir{0} != '\\'){
		$image_dir = '/'.$image_dir;
	}


	$image_dir =  dirname(dirname(__FILE__)) . $image_dir;
	write_log("Сжимаем картинки в каталоге: " .  $image_dir);
	$dir = new RecursiveDirectoryIterator($image_dir);
	$iterator = new RecursiveIteratorIterator($dir);
	$files = new RegexIterator( $iterator, '/^.+\.png/i',RecursiveRegexIterator::GET_MATCH);

	foreach ($files as $file) {
		$filename = $file[0];
		$data = getimagesize($filename);
		if($data[0] < 65 || $data[1] < 65) continue;
		if($png_driver){
			$cmd = 'optipng -o' . $compress_png . ' "' . $filename . '"';
			echo "$cmd\n";
			write_log($cmd);
			$result = shell_exec($cmd);
			echo "$result\n";
			$result = delete_dirty_data($result);
			write_log($result);

			if($png_to_webp){
				// создаем webp
				if(!$webp_driver){
					$im = new Imagick($filename);
					$im->writeImage($filename . '.webp');
				}else{
					$img = imagecreatefrompng($filename);
					imagepalettetotruecolor($img);
					imagealphablending($img, true);
					imagesavealpha($img, true);
					imagewebp($img, $filename . '.webp');
				}
				write_log('Webp формат сгенерирован '.$filename . '.webp');
				echo $filename." .webp\n";
			}
		}else{
			$cmd = 'pngout -y "' . $filename . '"';
			echo "$cmd\n";
			write_log($cmd);
			$result = shell_exec($cmd);
			echo "$result\n";
			$result = delete_dirty_data($result);
			write_log($result);
			if($png_to_webp){
				// создаем webp
				if(!$webp_driver){
					$im = new Imagick($filename);
					$im->writeImage($filename . '.webp');
				}else{
					imagewebp(imagecreatefrompng($filename), $filename . '.webp');
				}
				write_log('Webp формат сгенерирован '.$filename . '.webp');
				echo $filename." .webp\n";
			}
		}

	}

	if($png_driver && $png_to_webp){
		$dir = new RecursiveDirectoryIterator($image_dir);
		$iterator = new RecursiveIteratorIterator($dir);
		$files = new RegexIterator($iterator, '/^.+\.jpeg/i', RecursiveRegexIterator::GET_MATCH);

		foreach ($files as $file) {
			$filename = $file[0];
			$data = getimagesize($filename);
			if($data[0] < 65 || $data[1] < 65) continue;
			$cmd = 'optipng -o' . $compress_png . ' "' . $filename . '"';
			echo "$cmd\n";
			write_log($cmd);
			$result = shell_exec($cmd);
			echo "$result\n";
			$result = delete_dirty_data($result);
			write_log($result);

			if($png_to_webp){
				// создаем webp
				if(!$webp_driver){
					$im = new Imagick($filename);
					$im->writeImage($filename . '.webp');
				}else{
					imagewebp(imagecreatefrompng($filename), $filename . '.webp');
				}
				write_log('Webp формат сгенерирован '.$filename . '.webp');
				echo $filename." .webp\n";
			}

		}
	}

	$dir = new RecursiveDirectoryIterator($image_dir);
	$iterator = new RecursiveIteratorIterator($dir);
	$files = new RegexIterator($iterator, '/^.+\.jpg/i', RecursiveRegexIterator::GET_MATCH);

	foreach ($files as $file) {
		$filename = $file[0];
		$data = getimagesize($filename);
		if($data[0] < 65 || $data[1] < 65) continue;
		if($jpg_driver){

			// создаём копию файла для компресии
			$file_filename = basename($filename);
			$file_filename_res = str_replace('.jpg','_res.jpg',$file_filename);
			$filename_res = str_replace($file_filename,$file_filename_res,$filename);
			if (!copy($filename, $filename_res)) {
				continue;
			}

			$cmd = '/opt/mozjpeg/bin/cjpeg -quality ' . $compress_jpg . ' "' . $filename_res . '" > "' . $filename . '"';
			echo "$cmd\n";
			write_log($cmd);
			$result = shell_exec($cmd);
			echo "$result\n";
			$result = delete_dirty_data($result);
			write_log($result);

			// удаляем файл копию
			unlink($filename_res);
		}else{
			$cmd = 'jpegoptim -m' . $compress_level . ' --all-progressive --strip-all "' . $filename . '"';
			echo "$cmd\n";
			write_log($cmd);
			$result = shell_exec($cmd);
			echo "$result\n";
			$result = delete_dirty_data($result);
			write_log($result);
		}

	}

}

