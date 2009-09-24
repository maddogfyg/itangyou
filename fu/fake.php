<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	overflow: hidden;
}

form {
	margin: 0;
	padding: 0;
}

.selectThreads {
	float: left;
	margin: 20px;
	padding: 10px;
	background: #FFF;
	width: 150px; /* ie5win fudge begins */
	voice-family: "\"}\"";
	voice-family: inherit;
}
.middle {
	float: left;
	margin: 10px 150px 5px 190px;
}
.tbPosts {
	float: left;
	padding: 10px;
	border: 1px solid #666;
}

.divSubmit {
	float: left;
	padding: 10px;
	width: 100%;
	height: 70px;
}

.selectUser {
	position: absolute;
	top: 120px;
	right: 0px;
	/* Opera5.02 will show a space at right when there is no scroll bar */
	margin: 2px;
	padding: 5px;
	background: #FFF;
	width: 100px; /* ie5win fudge begins */
}

.trTitleAndTime {
	color: #4254c3;
	font-size: 12px;
}
</style>
<script type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("td").click(function() {
		alert("Hello world!");
	});
});
function ajax_init()
{
	var ajax=false;
	try {
		ajax = new ActiveXObject("Msxml2.XMLHTTP");
	} catch (e) {
		try {
		ajax = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (E) {
		ajax = false;
		}
	}
	if (!ajax && typeof XMLHttpRequest!='undefined') {
	ajax = new XMLHttpRequest();
	}
	return ajax;
}
function post_threads(rb){
	var url = "showthreads.php";
	var ajax = ajax_init();
	ajax.open("GET", url, true);
	ajax.onreadystatechange = function(){
		if (ajax.readyState == 4 && ajax.status == 200) {
			var ret = ajax.responseText;
			var threadsArr = eval(ret);
			for(var i=0;i<threadsArr.length;i++) {
$("#selectThreads").append("<option value='"+threadsArr[i]['tId']+"'>"+threadsArr[i]['tSubject']+"</option>");
			}
		}
	}
	
	ajax.send(rb);
}

function threadsOnchange()
{
	var tid = $("#selectThreads").val();
	var showPostsUrl = "showposts.php?tid="+tid;
	var getPosts = ajax_init();
	getPosts.open("GET", showPostsUrl, true);
	getPosts.onreadystatechange = function(){
		if (getPosts.readyState == 4 && getPosts.status == 200) {
			var ret = getPosts.responseText;
			var postsArr = eval(ret);
			$("#tablePosts tr").remove();
			for(var i=0;i<postsArr.length;i++)
			{
				var unixstamp= postsArr[i]['postdate'];
				var commonTime = unixDateExchange(unixstamp);
		var appendStr = "<tr class='trTitleAndTime'><td>"+postsArr[i]['author']+"</td><td>"+commonTime+"</td></tr><tr class='trContent'><td colspan=2>"+postsArr[i]['content']+"</td></tr>";
		$("#tablePosts").append(appendStr);
			}
		}
	}
	getPosts.send(null);
}

function unixDateExchange(timestamp) {
	date=new Date(timestamp * 1000);
	month= date.getMonth()+1;
	day= date.getDate();
	year= date.getYear()+1900;
	var commonTime = (year+"年"+month+"月"+day+"日"+date.toLocaleTimeString());
	return commonTime;
}

function setCheckedValue(radioName, newValue) {
    if(!radioName) return;  
       var radios = document.getElementsByName(radioName);     
       for(var i=0; i<radios.length; i++) {  
          radios[i].checked = false;  
          if(radios[i].value == newValue.toString()) {  
          radios[i].checked = true;  
       }  
    }  
} 
function getRadioValue(radioName){//得到radio的值     
	var obj=document.getElementsByName(radioName);     
	for(var i=0;i<obj.length;i++){     
		if(obj[i].checked)
		{	return obj[i].value;	}     
	}     
}

function clickRB()
{
	var cookieStr = "rb=" + getRadioValue("rb");
	document.cookie = cookieStr;
}


window.onload = function(){	
	var strCookie=document.cookie;     //这将获得以分号隔开的多个名/值对所组成的字符串，这些名/值对包括了该域名下的所有cookie
	var arrCookie=strCookie.split("; ");     //将多cookie切割为多个名/值对
	var rb;	//遍历cookie数组，处理每个cookie对
	for(var i=0;i<arrCookie.length;i++){
	         var arr=arrCookie[i].split("=");
	         if(arr[0]=="rb")    //找到名称为rb的cookie，并返回它的值
	        {     rb=arr[1];    break;    }
	}

	setCheckedValue("rb", rb);
	
	post_threads(1);

};

function loginSubmit() {
	if(($("#username").value == "maddog") & ($("#password").value == "cai888"))	{
		var allDivObj = $("#all");
		allDivObj.show();
	}	
}

</script>
</head>
<?php

?>

<body>
<form id="form1" action="submit.php" method="post"><input type="text"
	name="username" id="username"></input> <input type="text"
	name="password" id="password"></input> <input id="inputSubmit"
	name="inputSubmit" type="button" value="登录" onclick="loginSubmit"></input>
<div id="all" align="center">
<div id="divThreads" class="selectThreads"><select id="selectThreads"
	name="selectThreads" multiple onchange="threadsOnchange();"></select></div>
	
<div id="middle" class="middle">
<div id="divPosts class=" tbPosts" class="tbPosts">
<table id="tablePosts"></table>
</div>
<div id="divSubmit" class="divSubmit"><textArea id="textArea1"
	name="textArea1" style="width: 100%; height: 100%"></textArea></br>
<input id="inputSubmit" name="inputSubmit" type="submit" value="提交"></input>
</div>

</div>

<div id="divFakeUser" class="selectUser"><select id="selectUser"
	name="selectUser" multiple>
<?php
	try{
	$file_handle = fopen("fakeuser", "r");
	while (!feof($file_handle))
	{
		$line = str_replace("\n","",fgets($file_handle));
		$arr=explode(' ',$line);
		if(strlen($line)>0)
			echo "<option value='$arr[0]'>$arr[1]</option>";
	}
	fclose($file_handle);
	}
	catch(Exception $e)
	{}
?>
</select></div>



</form>
</body>
</html>
