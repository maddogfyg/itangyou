<?php
!function_exists('adminmsg') && exit('Forbidden');

@include_once Pcv(D_P."data/style/$skin.php");
$filepath = array(
	D_P.'data',
	D_P.'data/sql_config.php',
	D_P.'data/bbscache',
	D_P.'data/tplcache',
	D_P.'data/groupdb',
	D_P.'data/style',
	D_P.'data/tmp',
	R_P.$db_attachname,
	R_P."$db_attachname/upload",
	R_P."$db_attachname/cn_img",
	R_P."$db_attachname/photo",
	R_P."$db_attachname/thumb",
	R_P.$db_htmdir
);
$filemode = array();
foreach($filepath as $key => $value){
	if(!file_exists($value)){
		$filemode[$key] = 1;
	} elseif(!is_writable($value)){
		$filemode[$key] = 2;
	} else{
		$filemode[$key] = 0;
	}
}
include PrintEot('chmod');exit;
?>