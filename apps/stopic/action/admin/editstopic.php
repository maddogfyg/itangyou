<?php
!defined('P_W') && exit('Forbidden');

InitGP(array('stopic_id'));
$stopic_id = (int) $stopic_id;
if (!$stopic_id) showmsg('undefined_error');

$stopic	= $stopic_service->getSTopicInfoById($stopic_id);
$blocks	= $stopic_service->getBlocks();
$tpl_content	= $stopic_service->getStopicContent($stopic_id,1);
$ajaxurl = EncodeUrl($basename);

include stopic_use_layout ( 'admin' );
?>