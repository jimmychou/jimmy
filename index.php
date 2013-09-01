<?php
$datas = array(
	'正式版新服'=> 
	array(
		'inner_prefix'=>'http://10.13.81.229/',
		'outer_prefix'=>'http://admin.app.sohu.com/',
		'lists'=>array(
			array( 'title'=>'安卓','url'=>'androidmgr/v2/www/index.php' )
		)
	)
	,'Ubuntu ON DELL Latitude'=> 
	array(
		'inner_prefix'=>'http://127.0.0.1/',
		'outer_prefix'=>'http://127.0.0.1:8080/',
		'inner_name'=>'Nginx',
		'outer_name'=>'Apache',
		'lists'=>array(
			array( 'title'=>'phpMyAdmin','url'=>'phpmyadmin/index.php' )
			,array( 'title'=>'CakePHP','url'=>'cake/index.php' )
		)
	)
	,'Windows ON DELL Latitude'=> 
	array(
		'inner_prefix'=>'http://127.0.0.1/',
		'outer_prefix'=>'http://127.0.0.1:8080/',
		'inner_name'=>'Nginx',
		'outer_name'=>'Apache',
		'lists'=>array( 
			array( 'title'=>'phpmyadmin','url'=>'phpmyadmin/index.php' )
			,array( 'title'=>'sqlbuddy','url'=>'sqlbuddy/index.php' )
			,array( 'title'=>'webgrind','url'=>'webgrind/index.php' )
		)
	)
	,'CentOS ON VMware of Lenovo IdeaPad'=> 
	array(
		'inner_prefix'=>'http://192.168.0.110/',
		'outer_prefix'=>'http://192.168.0.110:8080/',
		'inner_name'=>'Nginx',
		'outer_name'=>'Apache',
		'lists'=>array(
			array( 'title'=>'phpMyAdmin','url'=>'phpMyAdmin/index.php' )
		)
	)
	,'测试版'=> 
	array( 
		'inner_prefix'=>'http://10.13.81.112/',
		'outer_prefix'=>'http://221.179.173.224/',
		'lists'=>array( 
			array( 'title'=>'安卓','url'=>'androidmgr/v1/www/index.php' )
			,array( 'title'=>'支付','url'=>'paymgr/v1/www/index.php' )
		)
	)
	,'开发版'=> 
	array(
		'inner_prefix'=>'http://10.11.155.23/',
		'outer_prefix'=>'http://123.125.116.124/',
		'lists'=>array( 
			array( 'title'=>'安卓(jimmy)','url'=>'jimmy/android/www/index.php' )
			,array( 'title'=>'安卓(root)','url'=>'androidmgr/v1/www/index.php' )
			,array( 'title'=>'日志上传接口','url'=>'http://192.168.99.93/pigeon/statzrheeuwp/main.php','special'=>'1' )
			,array( 'title'=>'支付','url'=>'paymgr/v1/www/index.php' )
			,array( 'title'=>'BugFree','url'=>'bugfree/Login.php' )
		)
	)
	,'正式版'=> 
	array( 
		'inner_prefix'=>'http://10.13.81.45/',
		'outer_prefix'=>'http://221.179.173.164/',
		'lists'=>array( 
			array( 'title'=>'安卓','url'=>'androidmgr/v2/www/index.php' )
			,array( 'title'=>'支付','url'=>'paymgr/v1/www/index.php' )
		)
	)
);
?>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>搜狐地址导航</title>
		<style type="text/css">
			body{
				font-size:12px;
			}
			h4{
				color:blue;
		        font-size:18px;
			}
			ul.row_style{
				width:100%;
			    list-style:none;
				margin:0px;
				padding:0px;
			}
			ul.row_style li.row_item{
				width:100%;
				border-bottom:dashed 1px gray;
				height:150px;
		        margin-top:10px;
			}
			ul.col_style{
				list-style:none;
			}
			ul.col_style li{
				float:left;
				width:150px;
				height:30px;
			}
			a{
				text-decoration:none;
				color:black;
			}
			a:HOVER {
				color:blue;
				border:dashed 1px gray;
			}
		</style>
	</head>
	<body>
		<div style="margin-left:auto;margin-right:auto;width:90%;">
			<ul class="row_style">
<?php
$html = '';
foreach( $datas as $title=>$data ){
	if( is_array( $data ) && !empty( $data ) ){
		$html .= '<li class="row_item"><h4>'.$title.'</h4><ul class="col_style">';
		$lists = $data['lists'];
		$inner_name = isset( $data['inner_name'] ) ? $data['inner_name'] : '内网';
		$outer_name = isset( $data['outer_name'] ) ? $data['outer_name'] : '公网';
		foreach( $lists as $list ){
			if( isset( $list['special'] ) && $list['special'] === '1' ){
				$html .= '<li><a href="'.$list["url"].'" target="_blank">'.$list["title"]." (".$inner_name.")".'</a><br><br><a href="'.$list["url"].'" target="_blank">'.$list["title"]." (".$outer_name.")".'</a></li>';
			}
			else{
				$html .= '<li><a href="'.$data["inner_prefix"].$list["url"].'" target="_blank">'.$list["title"]." (".$inner_name.")".'</a><br><br><a href="'.$data["outer_prefix"].$list["url"].'" target="_blank">'.$list["title"]." (".$outer_name.")".'</a></li>';
			}
		}
		$html .= "</ul></li>";
	}
}
$html .= "</ul></div></body></html>";
echo $html;
