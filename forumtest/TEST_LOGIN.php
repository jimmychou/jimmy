<?php
#forum.community_list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
//$query = '{"PATH":"","VR":6,"ED":"fdPv7XjQahvpRWO5DjoqrOCjTN9J4eqgOzu6UAh30J81rxlOhzLe7RZjlZY+IEGPUIkVDCZLQaSxIr+++XZLlDzuW7imfhfH6YOJtuNoZeKPofsJkT\/A4Hv7je6\/sljAbEJKD5B9WLsUnEswcLBuKvY2apoIGxLtFfmjNhncxMABgVvDoSkBvoMN0zkQcTJRdChDn\/64j36hpFVW1gkd\/bRDwwxgWpeLYPP6EekMzgfUwNOxjar1FMT8V3oga7OHtoo+Ihu+Dfa11MTuEjmpdjTTygrZ\/gyYXbwoTsW2qWqFrOBYm\/yw\/Nlh2\/dWemtgHuxhDskjVRs2nptAoYiMsA4f4o7uMg01ewxfx+vdMW6zRUjNhlvoRWAMdL9GlGrLDK+Y4XMl8uVEk1CWnlK5Bb4L2Yfvo7N\/T2VbvRSaYutoLkDJQw9PfchDlzccQnOhCMdO4NUUuOicCyEyWcey2D8BZ53nChPl813+b8gbkX73cUJgNmm\/hHSFj8\/B6V8RUhJGW3tzRm8jwEZfTh28oJMzwiB4upVGl3ND\/JPF6tRCT3R44euuS3LCtvyEnjXJr0Qt5iTh\/b2TYJTwx3DnLLq2\/4WP5XzcNSnhnrnmj89X2Q2Rkc1\/XSDboIWR\/DldCzjC2hgK93Ovmp9RBnaLiA9gVo9HB9AoZYzqiP4obgtWke1T4qn75M2cn6wwBFQlrEi\/Pb2oox8F+4NVH0BVgrGjj0u9atbXJDrP7KWeNpCOW4niQgDCvaytV500\/JPCRhVdt73Woc7FzqbuENa4B9ZkN6sXBU6kvWC0zZDBRbixKHAHcNmzcUD1YP1CiL7RmtZ+oesZA9wiA4nbzqDHdVzDDq8p+9KOUxqsDyUVBZi8ubJgyPu8t3w8EVEjabSs6RpRz1MMAkVCAt8Nhaj5xPwZ5uM241OanojLxR61iX1Kl3WCTtLwon9od0Yorq3dNZdyb8ZHrQ1MtROxbcB8CVTnOnCS1h\/m3QiLze1blUIyIjM6KTPM\/njx86\/lubQk","KEY":"SYNC_SESSION"}';
$query = '{"PATH":"","VR":6,"ED":{"NET_TYPE":"WIFI","PID":10,"SUPPLIERS":"f167d0e62545dedd0e4848095df20f407b01826b","IMSI":"460036111373274","MIDAS":"[\"GZESUwyrWNMrEm4wZZwYV52KGyRGdJ4BMB7FEyASJzS52AIWtpHsK9YaKW3rSftbeVV2L3q\\\/3sTgjlQDpBXI3w==\",\"d3N2Z0k31UpoRF04Gb1Xc\\\/SES8a0CcMKy2JzovFCq7br42rOrkeyluOzI\\\/3Nk05TY2HZik7Aoi57iFzXqQOesQ==\",\"MmkG1nqNYGJzTwfhD3FtWUc2cxY0SahGAXLeSb2HwMcz0VDXTzqC9oBnn7hH0sxmox+lyXAngMi5gt9stElItA==\"]","CUSTOM_RESPONSE_CODE":1,"ICCID":"89860309910105719388","USER":"wangyl","TIME_STAMP":1415436838047,"DEVICEID":"A000003940FE7B","SID":"NTM5MnwxNDE1MzUxODEyfDAwMnxNT1ZFX1RFUk1JTkFMfDQyMjY1NQ==","RESOLUTION":"1080*1920","IMEI":"A000003940FE7B","VERSION_CODE":1000,"FIRMWARE":17,"ABI":3,"DI":["exynos5",4,"1800000",1862,"3.0",false],"MAC":"60:21:C0:C8:A9:25","MD":2,"MODEL_NO":"SCH-I959"},"KEY":"SYNC_SESSION"}
';
request($query);
