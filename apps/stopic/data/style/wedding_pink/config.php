<?php
!defined('P_W') && exit('Forbidden');
return array(
	'name'	=>'婚庆_粉',
	'banner'=>'apps/stopic/data/style/wedding_pink/banner.jpg',
	'layout_set' => array(
		'bgcolor'		=> '#cd6587',
		'areabgcolor'	=> '#ffffff',
		'fontcolor'		=> '#e46882',
		'navfontcolor'	=> '#ffffff',
		'navbgcolor'	=> '#ce5683',
		'othercss'		=> '#nav li{float:left;margin-left:10px;}
#nav li a{display:block;padding:12px 10px 9px;line-height:1;font-weight:700;}/*导航字体*/
.groupItem{border:1px solid #eaebe6;margin-bottom:10px;overflow:hidden;}/*模型外边框*/
.groupItem .itemHeader{background:#ce5683 url(apps/stopic/data/style/wedding_pink/h-pink.png) right 0 repeat-x;padding:4px 10px; font-weight:700;color:#fff;}/*标题栏*/
.groupItem .itemContent{padding:4px 10px;}/*模型内边距*/
.groupItem .itemContent li{line-height:24px;}/*列表行高*/
'
	),
);
?>