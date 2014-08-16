<?php
require_once 'CombineImage.class.php';
$src_dir = '/home/jimmychou/workspace/selected/';
if(!chdir($src_dir))
	exit('No such dirctory!');
$files = scandir($src_dir);
//$new_img = imagecreatetruecolor(10000,10000);
$deal_files = array();
$i = 0;
if(!empty($files)){
	foreach($files as $file){
		if($file==='.'||$file==='..'){
			continue;
		}
		if($i>=10){
			continue;
		}
		$i++;
		echo "file is $file\n";
		$deal_files[]=$file;
	}
}
$ci = new CombineImage($deal_files);
$ci->combine2();
//$ci->show();
$ci->output_file('/home/jimmychou/workspace/jimmy/php/try.jpg');
