<?php
@ $db = new mysqli('localhost','root','root','itangyou');
	$db->query("SET NAMES 'utf8'");
	if(mysqli_connect_errno())
		{ echo 'Error!'; exit; }
	//$fakeuserArray="'admin','123'";
	//$newThreadsSql= "SELECT * FROM pw_threads WHERE lastposter NOT IN ($fakeuserArray) ORDER BY 'lastpost' DESC LIMIT 0 , 20";
	$newThreadsSql= "SELECT * FROM pw_threads ORDER BY 'lastpost' DESC LIMIT 0 , 20";
	try{
		$newThreadsResult = $db->query($newThreadsSql);
		$num_results = $newThreadsResult->num_rows;
	}
	catch(QueryException $e)
	{
		echo $e;
	}
	$arr_data=array();
	for($i=0;$i<$num_results;$i++)
	{
		$threadRow = $newThreadsResult->fetch_assoc();
		$arr_data[$i]['tId']=$threadRow['tid'];
		$arr_data[$i]['tSubject']=$threadRow['subject'];
	}
	$threads = json_encode($arr_data);
	echo $threads;
?>
