<?php
require_once('simpletest/autorun.php');
//require_once('simpletest/web_tester.php');
include 'common.php';

// the subject code
define('TAX_RATE', 0.07);
function calculate_sales_tax($amount) {
    //round($amount * TAX_RATE,2);
    return round($amount * TAX_RATE,2);
}
// include test library
//require_once 'simpletest/unit_tester.php';
//require_once 'simpletest/reporter.php';

// the test
class TestingTestCase extends UnitTestCase {
    function TestingTestCase($name='') {
        //$this->UnitTestCase($name);
        parent::__construct($name);
    }
    function TestSalesTax() {
        $ret = calculate_sales_tax(100);
        $this->assertEqual(7,calculate_sales_tax(100));
        $this->assertEqual(3.5, calculate_sales_tax(50));
    }

    function TestRandomValuesSalesTax() {
        $amount = rand(500,1000);
        $this->assertTrue(defined('TAX_RATE'));
        $tax = round($amount*TAX_RATE*100)/100;
        $this->assertEqual($tax, calculate_sales_tax($amount));
    }

    function TestRandomValuesSalesTaxNew() {
        $amount = rand(500,1000);
        $this->assertTrue(calculate_sales_tax($amount)<$amount*0.20);
    }
}

// run the test
$test = new TestingTestCase('Testing Unit Test');
//$test->run(new HtmlReporter());

/*
class CanAddUp extends UnitTestCase {
//class CanAddUp extends WebTestCase {
    function testOneAndOneMakesTwo() {
        $this->assertEqual(1 + 1, 2);
    }
}
*/
exit;
/*
#v45.PopAd
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"POP_AD","VR":"1"}';
request($query);
*/
