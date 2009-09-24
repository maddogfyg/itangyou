<?php
!defined('P_W') && exit('Forbidden');

return array(
	"bgUploadPath" => R_P . "attachment/stopic/",
	"bgBaseUrl" => $GLOBALS['db_bbsurl'] . "/attachment/stopic/",

	"bgDefalutPath" => A_P . "data/uploadbg/",
	"bgDefalutUrl" => $GLOBALS['db_bbsurl'] . "/apps/stopic/data/uploadbg/",

	"layoutPath" => A_P."data/layout/",
	"layoutBaseUrl" => $GLOBALS['db_bbsurl'] . "/apps/stopic/data/layout/",

	"stylePath" => A_P."data/style/",
	"styleBanner" => "banner.jpg",
	"stylePreview" => "preview.jpg",
	"styleMiniPreview" => "mini_preview.jpg",
	"styleBaseUrl"	=> $GLOBALS['db_bbsurl'] . "/apps/stopic/data/style/",

	"layoutConfig" => array(
		"logo" => "logo.png",
		"html" => "layout.htm",
	),
	"layoutTypes" => array(
		"type1v0" => "直列",
		"type1v1" => "1:1",
		"type1v2" => "1:2",
		"type2v1" => "2:1",
		"type1v1v1" => "1:1:1",
	),
	"layout_set" => array(
		"bgcolor"		=> "#ffffff",
		"areabgcolor"	=> "#ffffff",
		"fontcolor"		=> "#006699",
		"navfontcolor"	=> "#000000",
		"navbgcolor"	=> "#f7f7f7",
		"othercss"		=> <<<EOT
#nav li{float:left;margin:0 10px;display:inline;}
#nav li a{float:left;white-space:nowrap;padding:10px 0;line-height:1;font-weight:700;}/*导航字体*/
.groupItem{border:1px solid #cccccc;margin-bottom:10px;overflow:hidden;}/*模型外边框*/
.groupItem .itemHeader{background:#f7f7f7 url(apps/stopic/image/box-a.png) repeat-x;padding:4px 10px; font-weight:700;}/*标题栏*/
.groupItem .itemContent{padding:4px 10px;}/*模型内边距*/
.groupItem .itemContent li{line-height:24px;}/*列表行高*/
EOT
	),

	'htmlSuffix'=>'.html',

	"htmlDir" => R_P.$GLOBALS['db_htmdir'].'/stopic',
	"htmlUrl" => $GLOBALS['db_bbsurl'].'/'.$GLOBALS['db_htmdir'].'/stopic',
);

?>