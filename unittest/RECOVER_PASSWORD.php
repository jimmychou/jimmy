<?php
#ucenter.GoRecoverPassword
session_start();
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
$login_data = login();
//$query = '{"PATH":"","EMAIL":"zhouxiaomin@anzhi.com","PWF":"bL2u2nOS5aPXXwHjRl+tjvnkx0v1pK3TxWpN4IIHeUjBsOvbccY17jm99X+HRstBw1O1\/y7nbaOyGuKQEdn9QC4Bz2WTGwI\/+WHGhonSPwR7ArGpN9fJH1KNKQoPOluUxxCauX8PS\/7iW\/7EYvfX9rXKtur1B7DuqtzpDUgEZ7U=","VR":1,"KEY":"RECOVER_PASSWORD","CUSTOM_RESPONSE_CODE":1}';
$query = '{"PATH":"","EMAIL":"jimmychou@ustc.edu","USER":"jimmychou","VR":1,"KEY":"RECOVER_PASSWORD","CUSTOM_RESPONSE_CODE":1}';
//$query = '{"PATH":"","EMAIL":"zhouxiaomin@anzhi.com","USER":"jimmychou1","VR":1,"KEY":"RECOVER_PASSWORD","CUSTOM_RESPONSE_CODE":1}';
request($query);
