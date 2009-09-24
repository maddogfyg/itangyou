<?php
	require_once('../global.php');
	$winduid=$winddb["winduid"]=$_GET["uid"];
	$windid=$winddb["windid"]=$_GET["id"];
	//$winduid=$globals["winduid"]=$globals["winddb"]["winduid"]=$_GET["uid"];
	//$windid=$globals["windid"]=$globals["winddb"]["windid"]=$_GET["id"];
	
	$windpwd=PwdCode(md5("cai888"));
	$safecv="0";
	//$encodeStr=StrCode($winduid."\t".$windpwd."\t".$safecv);
	//echo StrCode($encodeStr,'DECODE');
	Cookie("winduser",StrCode($winduid."\t".$windpwd."\t".$safecv),time()+3600);
	list($winduid,$windpwd,$safecv) = explode("\t",addslashes(StrCode(GetCookie('winduser'),'DECODE')));
	echo StrCode(GetCookie('winduser'),'DECODE');
?>