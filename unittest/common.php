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

$login_array = array();
/*
$login_str = '{"REQ_BROWSER_DIR":1,"NET_TYPE":"WIFI","SUPPLIERS":"d0f6f1cedb47344c5a6bff4c7824a8faadc20d20","IMSI":"000000000000000","MIDAS":"[\"LF76IAndIMN1h7Gd1zP1HHT2W98ALZyCUL7K5YPnEteWDSIN3KLeGslxrjJHi44Q4YT6qtTCPjzmEtbVHwPeeQ==\",\"Rnt4hsBMGkXYVYnHpfQ6KrMvgGLuzOHFOFRZnw52iZsAsp5aNuYLAZMPtUVZOIZ9DpiMR0upKrooGOWlxKBwSw==\",\"BWNLaEMkG49T5u3Kb\\\/eJy8M0xef\\\/OcyfBfSIzmshP2cV9ev\\\/uORQLK30OrsMnFyIkmkiVeKKfoFowoKv9mP31A==\"]","CUSTOM_RESPONSE_CODE":1,"TIME_STAMP":1421376984948,"DEVICEID":"355868051768043","RESOLUTION":"1080*1920","IMEI":"355868051768043","VERSION_CODE":5410,"FIRMWARE":19,"ABI":3,"REQ_WEB_TIMESTAMP":0,"DI":["msm8960",4,"1728000",1789,"3.0",false],"MAC":"e8:99:c4:9b:4c:3b","MD":2,"NATIVE_LOADED":1,"MODEL_NO":"HTC 802w"}';

$login_array = json_decode($login_str,true);
print_r($login_array);
//exit;
*/
$now = time();
$pid = isset($login_array['PID']) ? $login_array['PID']: 1;
$vr = isset($login_array['VR']) ? $login_array['VR'] : 8;   //  5.5改为8
$net_type = isset($login_array['NET_TYPE']) ? $login_array['NET_TYPE']: 'UNIWAP';
$channel =  isset($login_array['SUPPLIERS'])? $login_array['SUPPLIERS']: 'd0f6f1cedb47344c5a6bff4c7824a8faadc20d20';    //  channel debug inner
$imsi = isset($login_array['IMSI']) ? $login_array['IMSI']: '460015880656596';
$custom_response_code = isset($login_array['CUSTOM_RESPONSE_CODE']) ? $login_array['CUSTOM_RESPONSE_CODE']: 1;
$timestamp = isset($login_array['TIME_STAMP']) ? $login_array['TIME_STAMP'] : $now;
$deviceid = isset($login_array['DEVICEID']) ? $login_array['DEVICEID']: '528748979873541';
$resolution = isset($login_array['RESOLUTION']) ? $login_array['RESOLUTION']: "1080*1920";
$imei = $deviceid = isset($login_array['IMEI']) ? $login_array['IMEI']: '528748979873541';
$version = isset($login_array['VERSION_CODE']) ? $login_array['VERSION_CODE']: 5100;
$firmware = isset($login_array['FIRMWARE']) ? $login_array['FIRMWARE']: 18;
$abi = isset($login_array['ABI']) ? $login_array['ABI']: 3;
$req_web_timestamp = isset($login_array['REQ_WEB_TIMESTAMP']) ? $login_array['REQ_WEB_TIMESTAMP']: $now;
$di = isset($login_array['DI']) ? $login_array['DI'] : array("msm8960",4,"1728000",1129,2.0,0);
$mac = isset($login_array['MAC']) ? $login_array['MAC']: '0c:37:dc:68:07:8b';
$md = isset($login_array['MD']) ? $login_array['MD']: 2;
$native_loaded = isset($login_array['NATIVE_LOADED']) ? $login_array['NATIVE_LOADED']: 1;
$model_no = isset($login_array['MODEL_NO']) ? $login_array['MODEL_NO']: 'SPH-L720';



$header = array();
//$header = array('cookie: PHPSESSID=4bf336bffa08fc8d12fe92c0d9d58867');
if (isset($argv[3])) {
    $vr = $argv[3];
}
$plain_body = array('VR' => $vr);
$plain_key = array(
	'LOGIN' => 1,
	'G_LOGIN' => 1,
	'PAD_LOGIN' => 1,
	'LOGIN_NEW' => 1,
	'SYNC_SESSION' => 1,
	'G_LOGIN_NEW' => 1,
	'PAD_LOGIN_NEW' => 1,
	'REGISTER' => 1,
	'G_REGISTER' => 1,
	'PAD_REGISTER' => 1,
	'REGISTER_NEW' => 1,
	'G_REGISTER_NEW' => 1,
	'PAD_REGISTER_NEW' => 1,
	'RK_LN' => 1,
//	'RECOVER_PASSWORD' => 1,
	'LOGIN_TV' => 1,
	'SYNC_SESSION' => 1,
	'SYNC_SESSION_TEST' => 1,
);
$dh_arr = array();

function my_export($data)
{
    if($data!==NULL){
        var_export($data);
    }
}

function list_element_compare($element_a,$element_b)
{
    if(is_array($element_a)){
        return ($element_a === $element_b) ? 0 : 1 ;
    }
    elseif(gettype($element_a) === 'string'){
        return strcmp($element_a,$element_b);
    }
}

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
//	echo $return, "\n"; //  暂时不打印源数据，XShell源于此
	$result = json_decode($return, true);
	echo "------------------------------------- response {$data['KEY']} -----------------------\n";
    global $argv;
    if(isset($argv[2])&&$argv[2]==1){   //  解决go_dump无输出的问题
        if(!$result){
            echo $raw, "\n";
        }
        else{
            var_export(json_decode($return, true));
        }
    }
	return $result;
}

function requestnew($data, $jsoned = true)
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
    /*
    echo "vr=$vr\n";
    print_r($data);
    print_r($plain_key);
    print_r($post_data);
    */
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
//	echo $return, "\n"; //  暂时不打印源数据，XShell源于此
	$result = json_decode($return, true);
	echo "------------------------------------- response {$data['KEY']} -----------------------\n";
    global $argv;
    if(isset($argv[2])&&$argv[2]==1){   //  解决go_dump无输出的问题
        if(!$result){
            echo $raw, "\n";
        }
        else{
            var_export(json_decode($return, true));
        }
    }
	return $result;
}

function login()
{
	global $header, $plain_body, $dh_arr, $login_key;
    global $pid,$vr,$net_type,$channel,$imsi,$custom_response_code,$timestamp,$deviceid,$resolution,$imei,$version,$firmware,$abi,$req_web_timestamp,$di,$mac,$md,$native_loaded,$model_no;
	$merge_data = array(
		'USER' => 'jimmychou2',
		'PWD' => '123456',
//        'USER' => 'GOAPKGFUSER_@#!',
		'VERSION_CODE' => $version,
		'SUPPLIERS' => $channel,
		'FIRMWARE' => $firmware,
		'MODEL_NO' => $model_no,
		'DEVICEID' => $deviceid,
		'IMEI' => $imei,
		'ABI' => $abi,
		'VR' => $vr,
		'PID' => $pid,
		'NET_TYPE' => $net_type,
		'IMSI' => $imsi,
		'MAC' => $mac,
		'TIME_STAMP' => $timestamp,
		'RESOLUTION' => $resolution,
		'DI' => $di,
	);
    $data = array_merge( $login_key,$merge_data );
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
//		echo 'k:'.gmp_strval($k)."\n" ;
//		echo "md5:{$md5}\n";
		$dh_arr['K'] = array($hex, $md5);
	}
	if(!$result) exit('登陆错误');
//	$header[] = 'cookie: PHPSESSID='. $result['SESSIONID'];
//    $header[] = 'cookie: PHPSESSID=4bf336bffa08fc8d12fe92c0d9d58867';
	$plain_body['SID'] = $result['SESSIONID'];
    return $result;
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
	for ($i = 0; $i < 256; $i++){
		$key[$i] = ord($pwd[$i % $pwd_length]);
		$box[$i] = $i;
	}
	for ($j = $i = 0; $i < 256; $i++){
		$j = ($j + $box[$i] + $key[$i]) % 256;
		$tmp = $box[$i];
		$box[$i] = $box[$j];
		$box[$j] = $tmp;
	}
	for ($a = $j = $i = 0; $i < $data_length; $i++){
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
    
//    $cookie = 'PHPSESSID=bpne9i5iu62s921eeqnnc2vo04';   //  @todo:  will read from /tmp/session
//    $cookie = 'PHPSESSID:bpne9i5iu62s921eeqnnc2vo04';   //  @todo:  will read from /tmp/session
//	curl_setopt($ch, CURLOPT_COOKIE, $cookie);
    
    /*
    $post_header = array('PHPSESSID'=>'0gce3gjl0keolnn10rjj615ls6');
    $post_header = array('Cookie'=>'PHPSESSID=3bphjudskg5fspiphg2poni0c6');
	curl_setopt($ch, CURLOPT_HTTPHEADER, $post_header);
    */
//    print_r($post_data);
//    exit;
	$content = curl_exec($ch);
//    print_r($content);
	$info = curl_getinfo($ch);
//    print_r($info);
//    echo curl_error($ch);exit;
	echo "\nStatus {$info['http_code']}\t{$info['size_download']} Bytes\n";
	curl_close($ch);
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
