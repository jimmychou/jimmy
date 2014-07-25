<?php
include 'common.php';
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_REGISTER' : 'REGISTER'; //  pad not use this interface
$login_key = array(
    'KEY'=>$key
);
function register()
{
	global $header, $imei, $deviceid, $timestamp, $channel, $version, $plain_body, $vr, $dh_arr, $login_key;
	$merge_data = array(
		'USER' => 'zhuxuefei',
		'PWD' => '042311',
		'EMAIL'=> 'zhouxiaomin@anzhi.com',
		"RESOLUTION" => "1080*1920",
		'DEVICEID' => $deviceid,
		'FIRMWARE'=> '18',
		'CUSTOM_RESPONSE_CODE' => 'CUSTOM_RESPONSE_CODE',
	);
    $data = array_merge($login_key,$merge_data);
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
		echo 'k:'.gmp_strval($k)."\n" ;
		echo "md5:{$md5}\n";
		$dh_arr['K'] = array($hex, $md5);
	}
	if($result===null) exit('注册成功');
//        $header[] = 'cookie: PHPSESSID='. $result['SESSIONID'];
//        $header[] = 'cookie: PHPSESSID=4bf336bffa08fc8d12fe92c0d9d58867';
//        $plain_body['SID'] = $result['SESSIONID'];
}
register();
