
<!--html>
    <head>
        <meta charset="gbk">
    </head>
    <body>
        <p>你好</p>
        <form id="productSearchForm" action="http://127.0.0.1:8080/test.html" method="post">
            <input name="keyword" class="keyword" value="T恤" maxlength="30">
            <button type="submit">搜索</button>
        </form>
    </body>
</html-->

<?php


//header('Cache-control: max-age=500');

//header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
//header("Expires: Sat, 11 Oct 2014 00:00:00 GMT"); // Date in the past

//header("Last-Modified: Thu, 09 Oct 2014 00:00:00 GMT");
//print_r($_SERVER);
if(isset($_SERVER['HTTP_IF_MODIFIED_SINCE'])){
    header("Last-Modified: Sat, 11 Oct 2014 00:00:00 GMT");
//    header("Last-Modified: Tue, 07 Oct 2014 00:00:00 GMT");
}
header('Cache-control: public');
echo date('Y-m-d H:i:s',time())."\n";

/*
function callback($buffer)
{
      // replace all the apples with oranges
        return (str_replace("apples", "oranges", $buffer));
}
ob_start("callback");
*/

?>
<!--html>
<body>
<p>It's like comparing apples to oranges.</p>
</body>
</html-->
<?php
/*
ob_end_flush();
echo "after flush\n";
*/

/*
set_time_limit(2);
ignore_user_abort(true);
sleep(3);
$status = connection_status();
file_put_contents('/tmp/status',"the status is $status\n",FILE_APPEND);
*/
/*
$hostname = gethostname();
$IP = gethostbyname($hostname);
echo "Hostname is $hostname and IP is $IP\n";
*/
/*
phpinfo();
exit;
*/

/*
header("Connection: close");
ob_start();
phpinfo();
$size=ob_get_length();
header("Content-Length: $size");
ob_end_flush();
flush();
sleep(13);
error_log("do something in the background");
*/
/*
ob_end_clean();
header("Connection: close");
ignore_user_abort(); // optional
ob_start();
echo ('Text the user will see');
$size = ob_get_length();
header("Content-Length: $size");
ob_end_flush(); // Strange behaviour, will not work
flush();            // Unless both are called !
// Do processing here 
sleep(30);
echo('Text user will never see');
*/
