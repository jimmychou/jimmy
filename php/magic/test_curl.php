http://127.0.0.1/program/hschool/index.php?m=Game&a=listbuildings

注意：ThinkPHP框架的所有文件都是采用UTF-8编码保存，但是这不影响你的项目中使用其他编码开发和浏览。请注意确保文件保存的时候去掉UTF-8的BOM头信息，防止因产生隐藏的输出而导致程序运行不正常。


http://localhost/appName/index.php?m=moduleName&a=actionName&id=1

http://127.0.0.1/program/hschool/index.php?m=Loginsvr&a=findsvr_bynames&usernames=h1,h2,h3


SELECT * FROM `user_id` WHERE username in ('h1','h2');

SELECT * FROM `user_id` WHERE username in ('h1');

SELECT * FROM `user_id` WHERE username in (h1);


http://127.0.0.1/program/hschool/index.php



grant select,update,insert,delete on *.* to root@localhost identified by "root";
grant select,update,insert,delete on *.* to root@127.0.0.1 identified by "root";


php
mysql都要加在环境变量里，然后重启机器



Administrator@GUOLIANG e:/
$ php db.php
totaly cost 1.1756401062012 second

Administrator@GUOLIANG e:/
$ php db.php
totaly cost 10.409193992615 second

Administrator@GUOLIANG e:/
$ php db.php
totaly cost 7.3523399829865 second

Administrator@GUOLIANG e:/
$ php db.php
totaly cost 101.70730495453 second


$ php db.php
totaly cost 79.020977020264 second


SELECT * FROM `user_id` WHERE username like '%nice'
SELECT * FROM `user_id` WHERE username like 'nice%'
SELECT * FROM `user_id` WHERE username like '%nice%'


<?php
        $params = array( 'nice'=>'ok','beauty'=>'ok','byebye'=>'ok' );
//	    $params = array( 'nice1'=>'ok','beauty'=>'ok','byebye'=>'ok' );
		
		$url = "http://127.0.0.1/curl.php";
		
		$ch = curl_init();
		$queryList = http_build_query($params, null, '&');

		$opts = array();
		$opts[CURLOPT_RETURNTRANSFER] = true;
		$opts[CURLOPT_TIMEOUT] = 30;
		$opts[CURLOPT_POST] = 1;
		$opts[CURLOPT_POSTFIELDS] = $queryList;
		$opts[CURLOPT_USERAGENT] = 'test';
		$opts[CURLOPT_URL] = $url;

		curl_setopt_array($ch, $opts);
		
		$result = curl_exec($ch);

		if (false === $result){
			// cURL 网络错误, 返回错误码为 cURL 错误码加偏移量
			// 详见 http://curl.haxx.se/libcurl/c/libcurl-errors.html
			$err = array(
                'ret' => 'error for'.curl_errno($ch),				
				'msg' => curl_error($ch));
			curl_close($ch);
			return $err;
		}
		curl_close($ch);
		
		$result_array = json_decode($result, true);
		
		// 远程返回的不是 json 格式, 说明返回包有问题
		if (is_null($result_array)) {
			print_r( array(
				'ret' => 'data_invalid',				
				'msg' => $result)
				);
		}
		print_r( $result_array );	
		
