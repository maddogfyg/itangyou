<?php
define('AREA_SCR','frontadmin');
define('AJAX','1');

InitGP(array('action','cateid'));
$allow_actions = array(
	'default',
	'invokeconfig',
	'editcontent',
	'editpush',
	'addpush',
	'deletepush'

);
$scr = $SCR	= getSCR($cateid);
$fid	= (int)$cateid;

$action = in_array($action, $allow_actions) ? $action : 'default';
if (!checkEditAdmin($windid,$groupid,$cateid)) showmsg('error');
$thisBaseName	= $basename.'q=frontadmin&cateid='.$cateid;

$invokeService = L::loadClass('InvokeService');

include(M_P."require/frontadmin/$action.php");

function getSCR($cateid) {
	if ((int)$cateid) {
		return 'cate';
	}
	return 'index';
}
?>