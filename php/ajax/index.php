<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
<script type="text/javascript">
function ajaxFunction()
{
    var xmlHttp;
    try{// Firefox, Opera 8.0+, Safari
        xmlHttp=new XMLHttpRequest();
    }
    catch (e){// Internet Explorer
        try{
            xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e){
            try{
                xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch (e){
                alert("您的浏览器不支持AJAX！");
                return false;
            }
        }
    }
    xmlHttp.onreadystatechange=function(){
        if(xmlHttp.readyState==4){
            console.log( xmlHttp.responseText );
        }
    }
    var url = "respone.php";
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
</script>
<form name="myForm">
    用户: <input type="text" name="username" onkeyup="ajaxFunction();" />
    时间: <input type="text" name="time" />
</form>
</body>
</html>
