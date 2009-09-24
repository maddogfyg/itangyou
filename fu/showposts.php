<?php
@ $db = new mysqli('localhost','root','root','itangyou');
	$db->query("SET NAMES 'utf8'");
	if(mysqli_connect_errno())
		{ echo 'Error!'; exit; }
	$tId=$_GET["tid"];
	$newpostsSql= "SELECT * FROM pw_posts WHERE tid = $tId ORDER BY 'postdate' DESC LIMIT 0 , 20";
	try{
		$newpostsResult = $db->query($newpostsSql);
		$num_results = $newpostsResult->num_rows;
	}
	catch(QueryException $e)
	{
		echo $e;
	}
	$arr_data=array();
	for($i=0;$i<$num_results;$i++)
	{
		$threadRow = $newpostsResult->fetch_assoc();
		$arr_data[$i]['author']=$threadRow['author'];
		$arr_data[$i]['content']=$threadRow['content'];
		$arr_data[$i]['postdate']=$threadRow['postdate'];
	}
	$posts = json_encode($arr_data);
	echo $posts;
?>
