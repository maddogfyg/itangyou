<?php
!defined('M_P') && exit('Forbidden');
include_once(D_P.'data/bbscache/forum_cache.php');
require_once(M_P.'require/invokeconfig.php');
require_once(M_P.'require/tagrelate.php');

InitGP(array('id','step'),'GP');

$push	= $invokeService->getPushDataById($id);
if (!$push)  showmsg('error');


$invokepiece = $invokeService->getInvokePieceByInvokeId($push['invokepieceid']);

if (!$step) {
	if ($push['endtime']) {
		$push['endtime'] = get_date($push['endtime'],'Y-m-d');
	} else {
		$push['endtime'] = '';
	}

	if (isset($invokepiece['param']['tagrelate'])) {
		$iftagrelate = 1;
	} else {
		$iftagrelate = 0;
	}

	include areaLoadFrontView($action);
} else {
	InitGP(array('param','offset','endtime'),'GP');
	$offset = (int) $offset;
	if ($endtime) {
		$endtime	= PwStrtoTime($endtime);
		if ($endtime == -1) {
			$endtime = 0;
		}
	}
	if (isset($invokepiece['param']['tagrelate'])) {
		InitGP(array('tagrelate'));
		$param['tagrelate']	= getTagRelate($tagrelate);
	}
	$invokeService->updatePushData($id,array('starttime'=>$timestamp,'endtime'=>$endtime,'offset'=>$offset,'data'=>$param));

	$loopid		= $push['loopid'];
	if ($invokepiece['rang']!='fid') {
		$fid = 0;
	} else {
		$fid = $push['fid'];
	}
	$invokeService->updateCacheDataPiece($push['invokepieceid'],$fid,$loopid);
}


ajax_footer();
?>