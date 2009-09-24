<?php
define ( 'SCR', 'mode' );
require_once ('global.php');
InitGP ( array ('q', 'space' ) );

/*APP 应用跳转*/
if (!$db_modes['o']['ifopen'] && $m == 'o') {
	if ($q == 'user') {
		InitGP(array('u'));
		ObHeader ( "u.php?uid=$u");
	} elseif ($q == 'app') {
		InitGP ( array ('id' ), 'G', 2 );
		ObHeader ( "apps.php?id=$id" );
	} elseif ($q == 'friend') {
		ObHeader ( "u.php?action=friend" );
	} elseif (!in_array($q ,array('user', 'friend', 'browse','invite','board','myapp','home') )) {
		$QUERY_STRING = substr($pwServer['QUERY_STRING'],4);
		ObHeader ( "apps.php?".$QUERY_STRING);
	}
	Showmsg ( 'undefined_action' );
}

if (strpos ( $q, '..' ) !== false)
	Showmsg ( 'undefined_action' );

if($m == 'o') $pwModeImg = "$imgpath/apps";

# app
if ($m == 'o' && $q && ! in_array ( $q, array ('user', 'friend', 'browse','invite','board','myapp','home','app' ) )) {
	require_once 'apps.php';
} else {

	empty ( $q ) && $q = 'home';
	if(!$q && $m == 'o'){
		require_once M_P . 'require/header.php';
	}
	if (CkInArray ( $pwServer ['HTTP_HOST'], $db_modedomain )) {
		$baseUrl = "mode.php";
		$basename = "mode.php?";
	} else {
		$baseUrl = "mode.php?m=$m";
		$basename = "mode.php?m=$m&";
	}

	if (file_exists ( M_P . "m_{$q}.php" )) {
		@include_once (D_P . 'data/bbscache/' . $db_mode . '_config.php');
		if ($groupid != 3 && $o_share_groups && strpos ( $o_share_groups, ",$groupid," ) === false) {
			$shareGM = 1;
		}
		if (file_exists ( M_P . 'require/core.php' )) {
			require_once (M_P . 'require/core.php');
		}
		require_once Pcv ( M_P . "m_{$q}.php" );
	} else {
		Showmsg ( 'undefined_action' );
	}

}

?>
