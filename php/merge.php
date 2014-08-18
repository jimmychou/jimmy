<?php
require_once 'CombineImage.class.php';
ini_set("memory_limit", "2048M");
$src_dir = '/home/jimmychou/workspace/selected/';
if(!chdir($src_dir))
	exit('No such dirctory!');
$files = scandir($src_dir);
$deal_files = array();
$i = 0;
if(!empty($files)){
	foreach($files as $file){
		if($file==='.'||$file==='..'){
			continue;
		}
		if($i>=10){
//			continue;
		}
		$i++;
		echo "file is $file\n";
		$deal_files[]=$file;
	}
}
$size = 10;
$deal_files = array_chunk($deal_files,$size);
print_r($deal_files);exit;
$ci = new CombineImage($deal_files);
//$ci->combine();
$ci->combine_ratio();
//$ci->combine_ratio_array();
//$ci->show();
$ci->output_file('/home/jimmychou/workspace/jimmy/php/try.jpg');
