<?php
!defined('P_W') && exit('Forbidden');
return array(
	'name'	=>'汽车',
	'banner'=>'apps/stopic/data/style/car/banner.jpg',
	'layout_set' => array(
		'bgcolor'		=> '#2c0001',
		'areabgcolor'	=> '#ffffff',
		'fontcolor'		=> '#b93936',
		'navfontcolor'	=> '#ffffff',
		'navbgcolor'	=> '#4e0000',
		'othercss'		=> '#nav li{float:left;margin-left:10px;}
#nav li a{display:block;padding:12px 10px 9px;line-height:1;font-weight:700;}/*导航字体*/
.groupItem{border:1px solid #c9c9c9;margin-bottom:10px;overflow:hidden;}/*模型外边框*/
.groupItem .itemHeader{border-bottom:1px solid #c9c9c9;background:#e3e3e3 url(apps/stopic/data/style/car/h.png) right 0 repeat-x;padding:4px 10px; font-weight:700;color:#555;}/*标题栏*/
.groupItem .itemContent{padding:4px 10px;}/*模型内边距*/
.groupItem .itemContent li{line-height:24px;}/*列表行高*/
'
	),
);
?>