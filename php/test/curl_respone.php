<?php
//  客户端header无，即默认为oct
$image = file_get_contents('php://input');
//print_r($image);
print_r($_FILES);
//print_r($_POST);

/*
<html><head><title>Object moved</title></head><body>
<h2>Object moved to <a href="http://www.jimmychou.com/name.aspx">here</a>.</h2>
</body></html>

因为centos.jimmychou.com未写入/etc/hosts
*/
