<?php
//echo '<pre>';
//print_r( $_REQUEST );
echo "the request_headers are just like this as following\n";
print_r( http_get_request_headers() );
echo http_get_request_body()."\n";
echo HttpResponse::getContentType()."\n";
echo "\nand the request_body are just like this as following".http_get_request_body()."\n";
echo "\nthe buffersize is ".HttpResponse::getBufferSize()."\n";
echo "\nthe content type is ".HttpResponse::getContentType()."\n";
echo "\nthe lastmodify type is ".HttpResponse::getLastModified()."\n";
print_r( HttpResponse::getRequestHeaders() );
//echo "\nthe Request Body is ".HttpResponse::getRequestBody()."\n";
//echo "\nthe Request Method is ".HttpMessage::getRequestMethod()."\n";
//echo "\nthe ResponeCode is ".HttpMessage::getResponseCode()."\n";
//header('Content-type: application/pdf');
////header("Status: 404 Not Found");
//header("Status: 302 Not Found Try Again Ba");  //此时已经通过web服务器处理了，正要把此头返回……所以可以更改
//print_r( headers_list() );
