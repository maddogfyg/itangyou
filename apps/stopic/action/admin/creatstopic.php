<?php
!defined('P_W') && exit('Forbidden');
define('AJAX',1);
InitGP(array('stopic_id','block_config'));

$stopic_id = (int) $stopic_id;
if (!$stopic_id) showmsg('undefined_error');

$stopic_service->updateSTopicById($stopic_id,array('block_config'=>$block_config));

$stopic_service->creatStopicHtml($stopic_id);

$stopicUrl	= $stopic_service->getStopicUrl($stopic_id);

include stopic_use_layout ('ajax');
?>