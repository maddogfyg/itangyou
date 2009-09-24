<?php
!defined('P_W') && exit('Forbidden');
$layout_list = $stopic_service->getLayoutList();
$category_list = $stopic_service->getCategorys();
$styles	= $stopic_service->getStyles();


$ajaxurl = EncodeUrl($stopic_admin_url);

include stopic_use_layout('admin');
?>