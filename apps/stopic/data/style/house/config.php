<?php
!defined('P_W') && exit('Forbidden');
return array(
	'name'	=>'房产',
	'banner'=>'apps/stopic/data/style/house/banner.jpg',
	'layout_set' => array(
		'bgcolor'		=> '#2e0307',
		'areabgcolor'	=> '#ffffff',
		'fontcolor'		=> '#000000',
		'navfontcolor'	=> '#ffffff',
		'navbgcolor'	=> '#862c07',
		'othercss'		=> '#nav li{float:left;margin-left:10px;}
#nav li a{display:block;padding:12px 10px 9px;line-height:1;font-weight:700;}/*导航字体*/
.groupItem{border:1px solid #c9c9c9;margin-bottom:10px;overflow:hidden;}/*模型外边框*/
.groupItem .itemHeader{border-bottom:1px solid #c9c9c9;background:#a33f1b url(apps/stopic/data/style/house/h.png) right 0 repeat-x;padding:4px 10px; font-weight:700;color:#fff;}/*标题栏*/
.groupItem .itemContent{padding:4px 10px;}/*模型内边距*/
.groupItem .itemContent li{line-height:24px;}/*列表行高*/
'
	),
);
?>