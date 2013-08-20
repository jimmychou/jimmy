<?php
    require_once dirname(__FILE__)."/base.php";
// Get these from http://developers.facebook.com
/*
class Config
{
   public static  $api_key = '3f6f78f8529db263f479979272b1bdb2';
   public static  $secret  = 'f4a5da8a2664cffc9d9421f92257dab9';
   public static  $callback_url = "http://m1.hotel.6waves.com/";
   public static  $resource_url = "http://m1.hotel.6waves.com/";
   public static  $canvas_name = "homepage";
   public static  $canvas_host  = "http://blog.playcrab.com/";
   public static  $canvas_url =  $this->canvas_host.$this->canvas_name;
   public static  $group_url = "http://m1.hotel.6waves.com/forum/";
   public static  $app_id = '192024279836';
}
*/
    class Config
    {
        public static  $api_key = '3f6f78f8529db263f479979272b1bdb2';
        public static  $secret  = 'f4a5da8a2664cffc9d9421f92257dab9';
        public static  $callback_url = "http://m1.hotel.6waves.com/";
        public static  $resource_url = "http://192.168.190/";
        public static  $canvas_name = "homepage";
        public static  $canvas_host  = "http://blog.playcrab.com/";
//        public static  $canvas_url =  $this->canvas_host.$this->canvas_name;
        public static  $group_url = "http://m1.hotel.6waves.com/forum/";
        public static  $app_id = '192024279836';
    }