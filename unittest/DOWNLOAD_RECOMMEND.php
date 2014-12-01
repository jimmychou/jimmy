<?php
#v53.GoGetDownloadRecommend
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();

//
/*
$query = '{"KEY":"DOWNLOAD_RECOMMEND","ID":1769025,"PACKAGE_NAME":"com.punchbox.fishingjoy2dcn.anzhi","VR":12"}';
request($query);
*/

//  同一次会话竟然完全相同
/*
$query = '{"LIST_INDEX_SIZE":10,"ID":1769025,"PATH":"4194304,4194313,4325376,4325378,32505856,32505858","VR":13,"KEY":"DOWNLOAD_RECOMMEND","LIST_INDEX_START":0,"PACKAGE_NAME":"com.punchbox.fishingjoy2dcn.anzhi"}';
request($query);
$query = '{"LIST_INDEX_SIZE":10,"ID":1769025,"PATH":"4194304,4194313,4325376,4325378,32505856,32505858","VR":13,"KEY":"DOWNLOAD_RECOMMEND","LIST_INDEX_START":0,"PACKAGE_NAME":"project.zjsc3d.anzhi"}';
request($query);
*/

//  有两个软件名字相同，其实包名不同
/*
$query = '{"LIST_INDEX_SIZE":10,"ID":1404632,"PATH":"3145728,3145731,3538944,3538946","VR":13,"KEY":"DOWNLOAD_RECOMMEND","LIST_INDEX_START":0,"PACKAGE_NAME":"com.feizan.android.snowball"}';
request($query);
*/

//  酷狗音乐和搜狗输入法的推荐有重叠，这个算正常么？
/*
$query = '{"LIST_INDEX_SIZE":10,"ID":1703697,"PATH":"3145728,3145731,3538944,27262977,6291456,6356994","VR":13,"KEY":"DOWNLOAD_RECOMMEND","LIST_INDEX_START":0,"PACKAGE_NAME":"com.kugou.playerHD"}';
request($query);
*/


//  这两个是新上传的包，没有BI的数据，所以会从最热中获取
/*
$query = '{"LIST_INDEX_SIZE":10,"ID":1821998,"PATH":"1048576,1048577,1114112,1114130,32505856,32505858","VR":13,"KEY":"DOWNLOAD_RECOMMEND","LIST_INDEX_START":0,"PACKAGE_NAME":"com.ycgame.thor6m.anzhi"}';
$result1 = request($query);

$query = '{"LIST_INDEX_SIZE":10,"ID":1829983,"PATH":"1048576,1048577,1114112,1114130,32505856,32505858","VR":13,"KEY":"DOWNLOAD_RECOMMEND","LIST_INDEX_START":0,"PACKAGE_NAME":"com.happyhighway.fightbeast.anzhi"}';
$result2 = request($query);
*/

//  同一次session不能相同
//var_export($result1);
//var_export($result2);

//$common = array_intersect($result1['DATA'],$result2['DATA']); //  result['DATA']只能是一维数组
//$common = array_uintersect_assoc($result1['DATA'],$result2['DATA'],"list_compare");
//var_export($common);

//  游戏推荐中也可以包含应用
/*
$query = '{"LIST_INDEX_SIZE":10,"ID":1823235,"PATH":"4194304,4194311,4980736,4980738","VR":13,"KEY":"DOWNLOAD_RECOMMEND","LIST_INDEX_START":0,"PACKAGE_NAME":"com.yinhan.hunter.anzhi"}';
request($query);
*/

//  //  全军出击
$query = '{"LIST_INDEX_SIZE":10,"ID":1836554,"PATH":"1048576,1048578,2031616,2031618","VR":13,"KEY":"DOWNLOAD_RECOMMEND","LIST_INDEX_START":0,"PACKAGE_NAME":"changyuan.game.td.anzhi"}';
//request($query);

//  媚三国
$query = '{"LIST_INDEX_SIZE":10,"ID":1838017,"PATH":"1048576,1048578,2031616,2031618","VR":13,"KEY":"DOWNLOAD_RECOMMEND","LIST_INDEX_START":0,"PACKAGE_NAME":"com.joypiegame.msg.anzhi"}';
//request($query);

$query = '{"LIST_INDEX_SIZE":10,"ID":1898693,"PATH":"1048576,1048578,2031616,2031618","VR":13,"KEY":"DOWNLOAD_RECOMMEND","LIST_INDEX_START":0,"PACKAGE_NAME":"com.ejiuwu.qpbuyu.anzhi"}';
request($query);

function list_compare($a,$b)
{
    $total_a = count($a);
    $total_b = count($b);
    $status = ($total_a>$total_b) ? 1 : (($total_a<$total_b)? -1 : 0);
    echo "status is $status\n";
    return $status;
    echo "count a is ".count($a)." and count b is ".count($b)."\n";
}
