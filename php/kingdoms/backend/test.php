<?php
    require_once dirname(__FILE__).'/generals.php';
    class Test
    {   
        static public function test_three_kingdoms()
        { 
            $names = array("赵雲","曹操","诸葛亮","吕布","周瑜","关羽","张角","刘禅","庞统","司马懿","陆逊","张飞","刘备","孙策","张辽","马超","黄忠","太史慈","黄月英","周泰","邓艾");//诡异的编码，一半繁体，一半简体
            /*
            $numbers = array(1,2,3,4,5);
            foreach( $numbers as $number ){
                $general = Generals::getGeneralByNumber( $number );
                echo "第 $number 位将军的数据如下: \n";
                print_r( $general );
            }
            */
            foreach( $names as $name ){
                $general = Generals::getGeneralByName( $name );
                echo "$name 的数据如下: \n";
                print_r( $general );
            }
        }
    }
    Test::test_three_kingdoms();