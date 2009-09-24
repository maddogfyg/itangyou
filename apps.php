<?php
define ( 'SCR', 'app' );
require_once ('global.php');
InitGP ( array ('q', 'm' ) );
if (in_array($q,array('ajax','article','diary','galbum','group','groups','hot','photos','sharelink','share','stopic','write'))) {
	#基础APP接口
	require_once R_P . 'require/app_route.php';
} else {
	! $winduid && Showmsg ( 'not_login' );
	if (! $db_appbbs || ! $db_appifopen)
		Showmsg ( 'app_close' );

	$param = array ();

	$pw_query = base64_decode ( urldecode ( str_replace ( '&#61;', '=', $_GET ['pw_query'] ) ) );

	if ($pw_query) {
		$param ['pw_query'] = base64_encode ( $pw_query );
	}
	$param ['pw_appId'] = $_GET ['id'];
	$param ['pw_uid'] = $winduid;
	$param ['pw_siteurl'] = $db_bbsurl;
	$param ['pw_sitehash'] = $db_sitehash;
	$param ['pw_t'] = $timestamp;
	$param ['pw_bbsapp'] = 1;

	$server_url = 'http://apps.phpwind.net';
	$url = $server_url . '/apps.php?';

	foreach ( $param as $key => $value ) {
		$url .= "$key=" . urlencode ( $value ) . '&';
	}
	$hash = $param ['pw_appId'] . '|' . $param ['pw_uid'] . '|' . $param ['pw_siteurl'] . '|' . $param ['pw_sitehash'] . '|' . $param ['pw_t'];
	$url .= 'pw_sig=' . md5 ( $hash . $db_siteownerid );

	require_once (R_P . 'require/header.php');
	require_once PrintEot ( 'apps' );
	footer ();
}
?>