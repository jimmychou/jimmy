<?php
    require_once dirname(__FILE__)."/config.php";
/*
    $myloc=dirname(__FILE__);
    $ts = filemtime( $myloc."/css/style.css.php");
*/
    $ts = filemtime( "resources/css/style.css.php");
    print "<link rel='stylesheet' type='text/css' href='resources/css/style.css.php?v=$ts' />";
?>
<html>
  
  <head>

    <div>
      <img src="resources/img/logo.jpg">
    </div>
	
  </head>
  
  <body>
    
	<!--div style="background:url(resources/img/background.jpg)  0 0; height:2700;"-->
	<div class="main">
	
      <div>
        如此萌萌为哪般<br>
        <a href="resources/img/meng.jpg">  <img src="resources/img/meng.jpg"> </a>
      </div>
	        <div>
        如此萌萌为哪般<br>
        <a href="resources/img/memory001.jpg">  <img src="resources/img/memory001.jpg"> </a>
      </div>
	        <div>
        如此萌萌为哪般<br>
        <a href="resources/img/memory002.jpg">  <img src="resources/img/memory002.jpg"> </a>
      </div>
	        <div>
        如此萌萌为哪般<br>
        <a href="resources/img/memory003.jpg">  <img src="resources/img/memory003.jpg"> </a>
      </div>
	        <div>
        如此萌萌为哪般<br>
        <a href="resources/img/memory004.gif">  <img src="resources/img/memory004.gif"> </a>
      </div>
      <div>
        如此萌萌为哪般<br>
        <a href="resources/img/memory005.jpg">  <img src="resources/img/memory005.jpg"> </a>
      </div>
      <!--div>
	    如此八卦为哪般<br>
        <a href="resources/img/meng.jpg">  <img src="resources/img/beauties.jpg"> </a>
      </div>
	  
      <div>
	    如此销魂为哪般<br>
        <a href="resources/img/meng.jpg">  <img src="resources/img/nice.jpg"> </a>
      </div>
	  
      <div>
	    如此可爱为哪般<br>
        <a href="resources/img/meng.jpg"> <img src="resources/img/cute.gif"> </a>
      </div-->
	  
      <div>
        <embed src="resources/audio/duandian.mp3" loop=2>
      </div>
	  
      <!--div>
        <embed src="resources/vedio/9520.rmvb">
      </div>
	  
      <div>
        <embed src="resources/vedio/cutebear.avi">
	  </div-->
	  
    </div>
	
  </body>
  
</html>