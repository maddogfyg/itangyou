<?php
!defined('P_W') && exit('Forbidden');
return array(
	'name'	=>'团购',
	'banner'=>'apps/stopic/data/style/buying/banner.jpg',
	'layout_set' => array(
		'bgcolor'		=> '#000000',
		'areabgcolor'	=> '#ffffff',
		'fontcolor'		=> '#370123',
		'navfontcolor'	=> '#ffffff',
		'navbgcolor'	=> '#000000',
		'othercss'		=> '#nav li{float:left;margin-left:10px;}
#nav li a{display:block;padding:12px 10px 9px;line-height:1;font-weight:700;}/*导航字体*/
.groupItem{border:1px solid #e4e4e4;margin-bottom:10px;overflow:hidden;}/*模型外边框*/
.groupItem .itemHeader{background:#ffeae1 url(apps/stopic/data/style/buying/h.png) right 0 repeat-x;padding:10px 10px 0; font-weight:700;color:#dc4f12;}/*标题栏*/
.groupItem .itemContent{padding:4px 10px;}/*模型内边距*/
.groupItem .itemContent li{line-height:24px;}/*列表行高*/
'
	),
);
?>