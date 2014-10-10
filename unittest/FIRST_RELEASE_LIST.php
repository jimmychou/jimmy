<?php
#v53.GoGetFirstRelease
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$page_count = 2;
$types = array(1);//,2);// 1.首发 2.安智精选
$type_page_list = array();
foreach($types as $type){
    $start = 0;
    $size = 5;
    $max = $size * $page_count;
    $page = 0;
    for($start;$start<$max;$start+=$size,$page++){
        $query = "{'KEY':'FIRST_RELEASE_LIST','LIST_INDEX_START':'".$start."','LIST_INDEX_SIZE':'".$size."','TYPE':'".$type."','VR':'13'}";
        $var_name = 'result'.$page;
        $$var_name= request($query);
//        my_export($$var_name);
        $type_page_list[$type][$page] = $$var_name;
    }
}

foreach($type_page_list as $type=>$page_list){
    for($page=0;$page<$page_count-1;$page++){
        $max_j = count($page_list[$page]['DATA']);
        for($j=0;$j<$max_j;$j++){
            if(isset($page_list[$page+1]['DATA'])){
//                $diff = array_udiff($page_list[$page]['DATA'][$j],$page_list[$page+1]['DATA'][$j],'list_element_compare');//  array_udiff是用自身函数，但是不仅仅是比较索引相同的值
//                $diff = array_diff_uassoc($page_list[$page]['DATA'][$j],$page_list[$page+1]['DATA'][$j],'list_element_compare');
                $diff = array_udiff_assoc($page_list[$page]['DATA'][$j],$page_list[$page+1]['DATA'][$j],'list_element_compare');
                if(empty($diff)){
                    echo "the data type $type page $page index $j is the same\n";
                }
            }
        }
    }
}
