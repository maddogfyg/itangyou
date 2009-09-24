<?php
InitGP(array('jobact'));

if ("showbg" == $jobact) {
	$bg_perpage = 6;
	InitGP(array('page', 'cid', 'bgid'), null, 2);

	$sum = $stopic_service->countPictures($cid);
	$total = ceil($sum/$bg_perpage);

	if ($page <= 0) $page = 1;
	if ($page > $total) $page = $total;
	//$bg_list = $stopic_service->getPictures($page, $bg_perpage, $cid);
	$bg_list = $stopic_service->getPicturesAndDefaultBGs($cid);
	//writeover(D_P.'data/test.txt',print_r($bg_list,1));

	$is_lastpage = $page == $total || !$sum;
} elseif ("showcopy" == $jobact) {
	InitGP(array('cid'));
	$cid = intval($cid);
	$useful_stopics = $stopic_service->findUsefulSTopicInCategory(5, $cid);
}


include stopic_use_layout('ajax');
?>