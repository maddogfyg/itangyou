<?php
!function_exists('adminmsg') && exit('Forbidden');
$basename="$admin_file?adminjob=urlcheck";

if ($action != "unsubmit") {

	$urlcheck=$db->get_one("SELECT db_value FROM pw_config WHERE db_name='db_urlcheck'");
	$urlinfo=str_replace(",","\n",$urlcheck['db_value']);
	include PrintEot('urlcheck');exit;

} elseif ($_POST['action'] == "unsubmit") {

	InitGP(array('urlinfo'),'P');
	$urlinfo = str_replace("\n",",",$urlinfo);
	setConfig('db_urlcheck', $urlinfo);
	updatecache_c();
	adminmsg('operate_success');
}
?>