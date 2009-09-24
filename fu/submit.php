<?php
@ $db = new mysqli('localhost','root','root','itangyou');
	$db->query("SET NAMES 'utf8'");
	if(mysqli_connect_errno())
		{ echo 'Error!'; exit; }

if($_POST['username']!="maddog" && $_POST['password']!="cai888") {
	//exit;
}

$threadId=$_POST['selectThreads'];
$userId=$_POST['selectUser'];
if(!get_magic_quotes_gpc()) {
	$textArea1=addcslashes($_POST['textArea1']);
}
else{
	$textArea1=$_POST['textArea1'];
}
$postdate=time();

$getUserName="(SELECT username FROM pw_members WHERE uid=$userId)";
$getForumID="(SELECT fid FROM pw_threads WHERE tid = $threadId)";
$addPostSql="INSERT INTO pw_posts (pid ,fid ,tid ,aid ,author ,authorid ,icon ,postdate ,subject ,userip ,ifsign ,buy ,alterinfo ,remindinfo ,leaveword ,ipfrom ,ifconvert ,ifwordsfb ,ifcheck ,content ,ifmark ,ifreward ,ifshield ,anonymous ,ifhide) VALUES (NULL , $getForumID, $threadId, '', $getUserName, $userId, '0', $postdate, '', '', '1', '', '', '', '', '', '1', '1', '1', '$textArea1', '', '0', '0', '0', '0');";
$addPostResult=$db->query($addPostSql);
echo $addPostResult;
$updateThreadSql="UPDATE pw_threads SET lastpost = $postdate, lastposter = $getUserName WHERE pw_threads.tid =$threadId;";
$updateThreadResult=$db->query($updateThreadSql);
echo $updateThreadResult;

header("Location: fake.php"); 
?>
