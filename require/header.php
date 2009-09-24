<?php
!function_exists('readover') && exit('Forbidden');
!defined('USED_HEAD') && define('USED_HEAD', 1);

extract(L::style('',$skinco));

@include(D_P."data/bbscache/apps_list_cache.php");
!$appsdb && $appsdb = array();
$db_appsdb = array();

foreach ($appsdb as $value) {
	if ($value['appstatus'] == 1 && $value['status'] == 1) {
		$db_appsdb[$value['appid']]['appid'] = $value['appid'];
		$db_appsdb[$value['appid']]['name'] = $value['name'];
	}
}

if (!$db_appsdb || !$db_appbbs || !$db_appifopen) {
	$db_appsdb = array();
}

list($_Navbar,$_LoginInfo) = pwNavBar();

if ($winduid) $db_menuinit .= ",'td_u' : 'menu_u'";
if ($db_menu) $db_menuinit .= ",'td_sort' : 'menu_sort'";
if (!is_array($db_union)) {
	$db_union = $db_union ? explode("\t",stripslashes($db_union)) : array();
}
$db_union[0] && $db_union[0] = unserialize($db_union[0]);
if (isset($db_navinfo['KEYhack']) && !empty($db_union[0])) {
	$db_navinfo['KEYhack']['child']['app_union'] = '<a href="hack.php?H_name='.$db_union[0][1].'" >'.$db_union[0][0].'</a>';
}
empty($db_navinfo) && $db_navinfo = array();
foreach ($db_navinfo as $key => $value) {
	if (isset($value['child']) || $key == 'KEYapp') {
		$db_menuinit .= ",'td_".$key."' : 'menu_".$key."'";
	}
}
if (!in_array(SCR,array('register','login'))) {
	$shortcutforum = pwGetShortcut();
}

$msgsound = $head_pop = '';
if ($groupid == 'guest' && $db_regpopup == '1') {
	$head_pop = 'head_pop';
} elseif ($winddb['newpm']>0 && $db_msgsound && $secondurl!='message.php' && $_G['maxmsg']>0) {
	$msgsound = "<bgsound src=\"$imgpath/$stylepath/msg.wav\" border=\"0\">";
}

$db_skindb = array();
empty($db_styledb) && $db_styledb['wind'] = array('0' => 'wind','1' => '1');
if(is_array($db_styledb)){
    foreach ($db_styledb as $key => $value) {
            $cname = $value[0] ? $value[0] : $key;
            $value[1] === '1' && $db_skindb[$key] = $cname;
    }
}
$skincount = count($db_skindb);
if ($skincount > 1){
	$db_menuinit .= ",'td_skin' : 'menu_skin'";
}
$db_menuinit .= ",'td_userinfomore' : 'menu_userinfomore'";
$s_url = $pwServer['PHP_SELF'].'?';
foreach ($_GET as $key => $value) {
	$key!='skinco' && $value && $s_url .= "$key=".rawurlencode($value).'&';
}
$s_url = Char_cv($s_url);

if (file_exists(D_P."data/style/{$tplpath}_css.htm")) {
	$css_path = D_P."data/style/{$tplpath}_css.htm";
} else {
	$css_path = D_P.'data/style/wind_css.htm';
}
require PrintEot('header');
unset($css_path,$s_url,$pwModeCss);
?>