<?php
!defined('M_P') && exit('Forbidden');
include_once(D_P.'data/bbscache/forum_cache.php');
require_once(M_P.'require/invokeconfig.php');
require_once(M_P.'require/tagrelate.php');

InitGP(array('invokepieceid','loopid','step'));

$invokepiece = $invokeService->getInvokePieceByInvokeId($invokepieceid);

$tempfid	= $fid;
if ($invokepiece['rang']!='fid') {
	$tempfid = 0;
}

if (!$step) {
	InitGP(array('pushtid'));
	$default	= array();
	if ($pushtid) {
		require(R_P.'lib/tplgetdata.class.php');
		$default	= getSubjectByTid($pushtid,$invokepiece['param']);
	} else {
		foreach ($invokepiece['param'] as $key=>$value) {
			$default[$key] = '';
		}
	}
	if (isset($invokepiece['param']['tagrelate'])) {
		$iftagrelate = 1;
	} else {
		$iftagrelate = 0;
	}
	include areaLoadFrontView($action);
} else {
	InitGP(array('param','offset','endtime'),'GP');
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
	$offset = (int) $offset;
	$invokeService->insertPushData(array('invokepieceid'=>$invokepieceid,'fid'=>$tempfid,'loopid'=>$loopid,'starttime'=>$timestamp,'endtime'=>$endtime,'offset'=>$offset,'data'=>$param));

	$invokeService->updateCacheDataPiece($invokepieceid,$tempfid,$loopid);
}


ajax_footer();
?>