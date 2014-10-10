<?php
#soft.GoSearchSoft
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$search_query = '百度';
//$search_query = '快播1';
//$search_query = '播不快';
//$search_query = '水果';
//$search_query = '播快';
//$search_query = '梦想海贼王之大战僵尸归来';
//$search_query = '快播';
$search_query = 'jdklajlkfdjsl';
$query = "{'KEY':'SEARCH_FUZZY_QUERY','SEARCH_QUERY':'".$search_query."','QUERY_CONDITION':'1234','LIST_INDEX_START':'0','LIST_INDEX_SIZE':'7','ADAPTER':'0','VR':'13','FROM':'1'}";
request($query);
