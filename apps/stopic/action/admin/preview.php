<?php
!defined('P_W') && exit('Forbidden');
define('AJAX',1);
InitGP(array('stopic_id','block_config'));

$stopic_id = (int) $stopic_id;
if (!$stopic_id) showmsg('undefined_error');
$stopic_service->updateSTopicById($stopic_id,array('block_config'=>$block_config));

$stopic	= $stopic_service->getSTopicInfoById($stopic_id);
$stopic['block_config'] = $block_config;

$tpl_content	= $stopic_service->getStopicContent($stopic_id,0);
@extract($stopic, EXTR_SKIP);

include(A_P.'template/stopic.htm');
afooter(1);
?>