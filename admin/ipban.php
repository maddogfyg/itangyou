<?php
!function_exists('adminmsg') && exit('Forbidden');
$basename="$admin_file?adminjob=ipban";

if (!$action) {

	$ipban=$db->get_one("SELECT db_value FROM pw_config WHERE db_name='db_ipban'");
	$baninfo=str_replace(",","\n",$ipban['db_value']);
	include PrintEot('ipban');exit;

} elseif($action == "unsubmit") {

	InitGP(array('baninfo'),'P');
	$baninfo = str_replace("\n", ",", $baninfo);
	setConfig('db_ipban', $baninfo);
	updatecache_c();
	adminmsg('operate_success');
} elseif ($action == "addone") {
	InitGP(array('baninfo'),'G');
	$baninfo = str_replace("\n", ",", $baninfo);
	$baninfo = $baninfo ? $baninfo.','.$db_ipban : $db_ipban;
	setConfig('db_ipban', $baninfo);
	updatecache_c();
	adminmsg('operate_success');
}
?>