<?php
if (php_sapi_name() != 'cli') {
	exit('Access denied');
}
if (!function_exists('gzdecode')) {
	function gzdecode($data) 
	{ 
		return gzinflate(substr($data,10,-8)); 
	}
}
error_reporting(E_ALL);
ini_set('dislay_errors', 'on');

if (isset($argv[1])) {
	$url = "http://{$argv[1]}/api.php?DEBUG=1&XHPROF_DEBUG=1";
}
$version = 5100;
$header = array();
//$header = array('host:gomarket.goapk.com');
//$header = array('host:hd.goapk.com');
//$header = array('cookie: PHPSESSID=4bf336bffa08fc8d12fe92c0d9d58867');
$vr = 2;
if (isset($argv[2])) {
$vr = $argv[2];
}
$plain_body = array('VR' => $vr);
$imei = $deviceid = '528748979873541';

$channel =  'd0f6f1cedb47344c5a6bff4c7824a8faadc20d20'; //debug inner
$timestamp = time();

$plain_key = array(
	'LOGIN_NEW' => 1,
	'G_LOGIN_NEW' => 1,
	'PAD_LOGIN_NEW' => 1,
	'RK_LN' => 1,
	'LOGIN_TV' => 1,
	'SYNC_SESSION' => 1,
	'SYNC_SESSION_TEST' => 1,
);
$dh_arr = array();
function r()
{
	$y = gmp_random(8);
	gmp_setbit($y, 0);
	return $y;
}

function myhash($k)
{
	$hex = gmp_strval($k, 16);
	if (strlen($hex) % 2)
		$hex = "0${hex}";
	$str = pack("H*", $hex);
	return $str;
}

function go_decrypt_linear($str, $name, $timestamp) {
	$name = (string) $name;
	$timestamp = (string) $timestamp;
	
	$name_len = strlen($name);
	$timestamp_len = strlen($timestamp);
	$name_idx = 0;
	$timestamp_idx = 0;
	$len = strlen($str);
	$ret = array();
	for ($idx = 0;$idx < $len;$idx+= 1) {
		$ch = substr($str, $idx, 1);
		$digit = ord($ch) + ord($name[$name_idx]) + ord($timestamp[$timestamp_idx]);
		$digit = $digit % 256;
		$ret[] = chr($digit);
		$name_idx = ($name_idx + 1) % $name_len;
		$timestamp_idx = ($timestamp_idx + 1) % $timestamp_len;
	}
	$encrypted = implode('', $ret);
	return $encrypted;
}

function request($data, $jsoned = true)
{
	global $deviceid, $imei, $timestamp, $plain_key, $vr, $version, $plain_body, $dh_arr;
	
	if ($jsoned) {
		$data = str_replace("'", '"', $data);
		$post_data = $data;
		$data = json_decode($data, true);
	} else {
		$post_data = json_encode($data);
	}
	$gzcompress = false;
	if ($vr > 0) {
		$gzcompress = true;
	}
	if ($gzcompress) {
		$post_data = gzencode($post_data);
	}
	$plain_txt = json_encode($plain_body);
	
	if (!isset($plain_key[$data['KEY']])) {
		switch($vr) {
			case 2:
				$post_data = rc4_crypt($dh_arr['K'][1], $post_data);
			break;
			
			default:
				$post_data = go_decrypt_linear($post_data, $deviceid, $timestamp);
		}
	} else {
		if ($vr ==0) {
			$plain_txt = $post_data;
			$post_data = '';
		}
	}
	$plain_size = strlen($plain_txt);
	$request = 'AnZhiM';
	$request .= int2bin($version, 4);
	$request .= int2bin($plain_size, 4);
	$request .= $plain_txt;
	$request .= $post_data;
	//file_put_contents($data['KEY']. '-'.time().'.log', $request);
	$raw = post($request);
	$return = $raw;
	if (!isset($plain_key[$data['KEY']])) {
		switch($vr) {
			case 2:
				$return = rc4_crypt($dh_arr['K'][1], $raw);
			break;
			
			default:
				$return = go_decrypt_linear($raw, $imei, $timestamp);
		}
	}
	if ($gzcompress) {
		$return = gzdecode($return);
	}
	echo $return, "\n";
	$result = json_decode($return, true);
	echo "------------------------------------- response {$data['KEY']} -----------------------\n";
	if (!$result) {
		echo $raw, "\n";
	} else {
		var_export(json_decode($return, true));
		//echo $return, "\n";
	}
	return $result;
}

function login()
{
	global $header, $imei, $deviceid, $timestamp, $channel, $version, $plain_body, $vr, $dh_arr;
	$data = array(
		'KEY' => 'SYNC_SESSION',
		'KEY' => 'PAD_LOGIN_NEW',
		'KEY' => 'LOGIN_NEW',
		'USER' => 'honking',
		'USER' => 'zhuxuefei',
		'PWD' => '654321hq',
		'PWD' => '042311',
		//'USER' => 'GOAPKGFUSER_@#!',
		//'PWD' => '123456',
		'VERSION_CODE' => $version,
		'SUPPLIERS' => $channel,
		'FIRMWARE' => 18,
		'MODEL_NO' => 'SPH-L720',
		'DEVICEID' => $deviceid,
		'IMEI' => $imei,
		//'IMEI' => '99000052039979',
		'ABI' => 3,
		'VR' => 11,
		'PID' => 1,
		"NET_TYPE" => "UNIWAP",
		//'IMSI' => 460021169216690,
		'IMSI' => 460015880656596,
		'MAC' => '0c:37:dc:68:07:8b',
		'TIME_STAMP' => $timestamp,
		"RESOLUTION" => "1080*1920",
		'DI' => array("msm8960",4,"1728000",1129),
	);
	if ($vr > 1) {
		$g = r();
		$p = r();
		$a = r();
		$A = gmp_powm($g, $a, $p);
		
		$dh_arr['g'] = $g;
		$dh_arr['p'] = $p;
		$dh_arr['a'] = $a;
		$dh_arr['A'] = $A;
		
		$data['MIDAS'] = json_encode(array(
			base64_encode(myhash($g)),
			base64_encode(myhash($p)),
			base64_encode(myhash($A)),
		));
		/*
		echo '$g=\''. gmp_strval($g),"';\n";
		echo '$p=\''. gmp_strval($p),"';\n";
		echo '$A=\''. gmp_strval($A),"';\n";
		echo '$a=\''. gmp_strval($a),"';\n";
		*/
	}
	
	$result = request($data, false);
	if ($vr > 1) {
		$B = base64_decode($result['MIDAS']);
		$B = bin2hex($B);
		$len = strlen($B);

		if ($len % 2)
			$B = "0${B}";
		$B = "0x${B}";
		$B = gmp_init($B);
		$k = gmp_powm($B, $dh_arr['a'], $dh_arr['p']);
		$hex = gmp_strval($k, 16);
		if (strlen($hex) % 2)
			$hex = "0${hex}";
		$str = pack("H*", $hex);
		$str = str_pad($str, 64, chr(0), STR_PAD_LEFT);
		$md5 = md5($str);

		
		echo 'k:'.gmp_strval($k)."\n" ;
		echo "md5:{$md5}\n";
		//echo "md51:{$md51}\n";
//		echo "\$b='{$result['b']}';\n";
//		echo "\$B='{$result['B']}';\n";
//		if (gmp_strval($k)!=$result['K']) {
//			exit;
//		}
		$dh_arr['K'] = array($hex, $md5);
	}
	if(!$result) exit('登陆错误');
	//$header[] = 'cookie: PHPSESSID='. $result['SESSIONID'];
	$header[] = 'cookie: PHPSESSID=4bf336bffa08fc8d12fe92c0d9d58867';
	$plain_body['SID'] = $result['SESSIONID'];
}
function rc4_crypt($key, $msg) {
    return rc4($key, $msg);
    $td = mcrypt_module_open('arcfour', '' , 'stream', '');
    mcrypt_generic_init($td, $key, null);
    $encrypted = mcrypt_generic($td, $msg);
    mcrypt_generic_deinit($td);
    mcrypt_module_close($td);
    return $encrypted;
}

function rc4 ($pwd, $data)
{
	$key[] ="";
	$box[] ="";
 
	$pwd_length = strlen($pwd);
	$data_length = strlen($data);
 
	for ($i = 0; $i < 256; $i++)
	{
		$key[$i] = ord($pwd[$i % $pwd_length]);
		$box[$i] = $i;
	}
 
	for ($j = $i = 0; $i < 256; $i++)
	{
		$j = ($j + $box[$i] + $key[$i]) % 256;
		$tmp = $box[$i];
		$box[$i] = $box[$j];
		$box[$j] = $tmp;
	}
 
	for ($a = $j = $i = 0; $i < $data_length; $i++)
	{
		$a = ($a + 1) % 256;
		$j = ($j + $box[$a]) % 256;
 
		$tmp = $box[$a];
		$box[$a] = $box[$j];
		$box[$j] = $tmp;
 
		$k = $box[(($box[$a] + $box[$j]) % 256)];
		$cipher .= chr(ord($data[$i]) ^ $k);
	}
	 
	return $cipher;
}

function post($post_data)
{
	global $header, $timestamp, $imei, $url, $plain_body;
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);   
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_POST, true);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
	curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	$content = curl_exec($ch);
	$info = curl_getinfo($ch);
	echo "{$info['http_code']} {$info['size_download']}\n";
	curl_close($ch);
	file_put_contents("1.log", $post_data);
	return $content;
}

function int2bin($val, $align) {
    $str = "";
    $n = 0;
    do {
        $chr = $val % 256;
        $str .= chr($chr);
        $val = $val >> 8;
        $n += 1;
    } while ($val != 0);
    for (; $n < $align; $n++)
        $str .= "\0";
    return strrev($str);
}

login();
$query = "{'KEY':'HOME_NEW','LIST_INDEX_START':'0','LIST_INDEX_SIZE':'20','VR':'12'}";
$query = '{"CATE_TYPE":0,"PATH":"13631488,3145728,3145730","VR":12,"KEY":"SOFT_CATEGORY_LIST_TAG"}';
request($query);
