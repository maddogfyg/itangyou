<?php
/**
 *
 *  Copyright (c) 2003-09  PHPWind.net. All rights reserved.
 *  Support : http://www.phpwind.net
 *  This software is the proprietary information of PHPWind.com.
 *
 */
file_exists('install.php') && ObHeader('install.php');
error_reporting(E_ERROR | E_PARSE);
set_magic_quotes_runtime(0);
function_exists('date_default_timezone_set') && date_default_timezone_set('Etc/GMT+0');

define('R_P',getdirname(__FILE__));
define('D_P',R_P);
define('P_W','global');
defined('SCR') || define('SCR','other');

$t_array = explode(' ',microtime());
$P_S_T	 = $t_array[0] + $t_array[1];
require_once(R_P.'require/common.php');
pwInitGlobals();

require_once(D_P.'data/bbscache/config.php');
$timestamp = time();
$db_cvtime!=0 && $timestamp += $db_cvtime*60;
$wind_in = $SCR = SCR;

$onlineip = pwGetIp();
if ($db_forcecharset && !defined('W_P') && !defined('AJAX')) {
	@header("Content-Type:text/html; charset=$db_charset");
}
if ($db_loadavg && !defined('W_P') && pwLoadAvg($db_loadavg)) {
	$db_cc = 2;
}
if ($db_cc && !defined('COL')) {
	pwDefendCc($db_cc);
}

if ($db_dir && $db_ext) {
	$_NGET = array();
	$self_array = explode('-',substr($pwServer['QUERY_STRING'],0,strpos($pwServer['QUERY_STRING'],$db_ext)));
	$s_count = count($self_array);
	for ($i=0;$i<$s_count-1;$i++) {
		$_key	= $self_array[$i];
		$_value	= rawurldecode($self_array[++$i]);
		$_NGET[$_key] = addslashes($_value);
	}
	!empty($_NGET) && $_GET = $_NGET;
	unset($_NGET);
}
foreach ($_POST as $_key => $_value) {
	if (!in_array($_key,array('atc_content','atc_title','prosign','pwuser','pwpwd'))) {
		CheckVar($_POST[$_key]);
	}
}
foreach ($_GET as $_key => $_value) {
	CheckVar($_GET[$_key]);
}

$db_debug && error_reporting(E_ALL ^ E_NOTICE ^ E_DEPRECATED);
list($wind_version,$wind_repair,$wind_from) = explode(' ',WIND_VERSION);
$db_olsize    = 96;

if (in_array(SCR,array('index','cate','mode'))) {
	$defaultMode = empty($db_mode) ? 'bbs' : $db_mode;
	$M_domain = $pwServer['HTTP_HOST'];
	($m = GetGP('m')) || ($db_modedomain && $m = array_search($M_domain,$db_modedomain));
	if ($m == 'bbs') {
		$db_mode = '';
	} elseif ($db_modes && isset($db_modes[$m]) && is_array($db_modes[$m]) && $db_modes[$m]['ifopen']) {
		$db_mode = $m;
	}

	if (/*empty($db_mode) && */in_array(SCR,array('cate')) && $db_modes['area']['ifopen']) $db_mode = 'area';
	if (!empty($db_mode) && file_exists(R_P."mode/$db_mode/")) {
		define('M_P',R_P."mode/$db_mode/");
		$m = $db_mode;
		$db_modepages = $db_modepages[$db_mode];
		$pwModeImg = "mode/$db_mode/images";
	} else {
		$db_mode = '';
	}
} else {
	$db_mode = '';
}

$dirstrpos = strpos($pwServer['PHP_SELF'],$db_dir);
if ($dirstrpos !== false) {
	$tmp = substr($pwServer['PHP_SELF'],0,$dirstrpos);
	$pwServer['PHP_SELF'] = "$tmp.php";
} else {
	$tmp = $pwServer['PHP_SELF'];
}
$REQUEST_URI = $pwServer['PHP_SELF'].'?'.$pwServer['QUERY_STRING'];

$index_url = $db_bbsurl;
$R_url = $db_bbsurl = Char_cv("http://".$pwServer['HTTP_HOST'].substr($tmp,0,strrpos($tmp,'/')));
defined('SIMPLE') && SIMPLE && $db_bbsurl = substr($db_bbsurl,0,-7);

if (GetCookie('lastvisit')) {
	list($c_oltime,$lastvisit,$lastpath) = explode("\t",GetCookie('lastvisit'));
	($onbbstime=$timestamp-$lastvisit)<$db_onlinetime && $c_oltime+=$onbbstime;
} else {
	$lastvisit = $lastpath = '';
	$c_oltime = $onbbstime = 0;
	Cookie('lastvisit',$c_oltime."\t".$timestamp."\t".$REQUEST_URI);
}

!is_array($db_bbstitle) && $db_bbstitle = array('index' => $db_bbstitle,'other' => '');
if ($SCR!='index' && $SCR!='other') {
	$db_bbstitle = $db_bbstitle['other'];
} else {
	$db_bbstitle = $db_bbstitle[$SCR];
}
$db_bbsname && $db_bbstitle = $db_bbsname.' '.$db_bbstitle;

InitGP(array('fid','tid'),'GP',2);
$db = $ftp = $credit = null;

require_once(D_P.'data/sql_config.php');
!is_array($manager) && $manager = array();
$newmanager = array();
foreach ($manager as $key => $value) {
	if (!empty($value) && !is_array($value)) {
		$newmanager[$key] = $value;
	}
}
$manager = $newmanager;
if ($database == 'mysqli' && Pwloaddl('mysqli') === false) {
	$database = 'mysql';
}
ObStart();//noizy

if ($db_http != 'N') {
	$imgpath = $db_http;
	if (D_P != R_P) {
		$R_url = substr($db_http,-1)=='/' ?  substr($db_http,0,-1) : $db_http;
		$R_url = substr($R_url,0,strrpos($R_url,'/'));
	}
} else {
	$imgpath = $db_picpath;
}
$attachpath = $db_attachurl != 'N' ? $db_attachurl : $db_attachname;
$imgdir		= R_P.$db_picpath;
$attachdir	= R_P.$db_attachname;
$pw_posts   = 'pw_posts';
$pw_tmsgs   = 'pw_tmsgs';
$runfc		= 'N';

list($winduid,$windpwd,$safecv) = explode("\t",addslashes(StrCode(GetCookie('winduser'),'DECODE')));

$loginhash = GetVerify($onlineip,$db_pptkey);
if ($db_pptifopen && $db_ppttype == 'client') {
	if (strpos($db_pptloginurl,'?') === false) {
		$db_pptloginurl .= '?';
	} elseif (substr($db_pptloginurl,-1) != '&') {
		$db_pptloginurl .= '&';
	}
	if (strpos($db_pptregurl,'?') === false) {
		$db_pptregurl .= '?';
	} elseif (substr($db_pptregurl,-1) != '&') {
		$db_pptregurl .= '&';
	}
	$urlencode	= rawurlencode($db_bbsurl);
	$loginurl	= "$db_pptserverurl/{$db_pptloginurl}forward=$urlencode";
	$loginouturl= "$db_pptserverurl/$db_pptloginouturl&forward=$urlencode&verify=$loginhash";
	$regurl		= "$db_pptserverurl/{$db_pptregurl}forward=$urlencode";
} else {
	$loginurl	= 'login.php';
	$loginouturl= "login.php?action=quit&verify=$loginhash";
	$regurl		= $db_registerfile;
}

$ol_offset = (int)GetCookie('ol_offset');
$skinco	   = GetCookie('skinco');
if ($db_refreshtime && $REQUEST_URI == $lastpath && $onbbstime < $db_refreshtime) {
	!GetCookie('winduser') && $groupid = 'guest';
	$skin = $skinco ? $skinco : $db_defaultstyle;
	Showmsg('refresh_limit');
}
if (!$db_bbsifopen && !defined('CK')) {
	require_once(R_P.'require/bbsclose.php');
}

$H_url =& $db_wwwurl;
$B_url =& $db_bbsurl;
$_time		= array('hours'=>get_date($timestamp,'G'),'day'=>get_date($timestamp,'j'),'week'=>get_date($timestamp,'w'));
$tdtime		= PwStrtoTime(get_date($timestamp,'Y-m-d'));
$montime	= PwStrtoTime(get_date($timestamp,'Y-m').'-1');

if (!defined('CK') && ($_COOKIE || $timestamp%3 == 0)) {
	switch (SCR) {
		case 'thread': $lastpos = "F$fid";break;
		case 'read': $lastpos = "T$tid";break;
		case 'cate': $lastpos = "C$fid";break;
		case 'index': $lastpos = 'index';break;
		case 'mode': $lastpos = $db_mode;break;
		default: $lastpos = 'other';
	}

	if ($timestamp-$lastvisit>$db_onlinetime || $lastpos != GetCookie('lastpos')) {
		$runfc = 'Y';
		Cookie('lastpos',$lastpos);
	}
}
if (is_numeric($winduid) && strlen($windpwd)>=16) {
	$winddb	  = User_info();
	$winduid  = $winddb['uid'];
	$groupid  = $winddb['groupid'];
	$userrvrc = floor($winddb['rvrc']/10);
	$windid	  = $winddb['username'];
	$_datefm  = $winddb['datefm'];
	$_timedf  = $winddb['timedf'];

	$credit_pop = $winddb['creditpop'];
	if ($credit_pop && $db_ifcredit) {//Credit Changes Tips
		$credit_pop = str_replace(array('&lt;','&quot;','&gt;'),array('<','"','>'),$credit_pop);
		$creditdb = explode('|',$credit_pop);
		$credit_pop = Char_cv(GetCreditLang('creditpop',$creditdb['0']));

		unset($creditdb['0']);
		foreach ($creditdb as $val) {
			list($credit_1,$credit_2) = explode(':',$val);
			$credit_pop .= '<span class="b st2 pdD w">'.pwCreditNames($credit_1).'&nbsp;<span class="f24">'.$credit_2.'</span></span>';
		}
		$db->update("UPDATE pw_memberdata SET creditpop='' WHERE uid=".pwEscape($winduid));
	}

	list($winddb['style'],$ifcustomstyle) = explode('|',$winddb['style']);
	$skin	  = $winddb['style'] ? $winddb['style'] : $db_defaultstyle;
	list($winddb['onlineip']) = explode('|',$winddb['onlineip']);
	$groupid == '-1' && $groupid = $winddb['memberid'];
	$curvalue = $db_signcurtype == 'rvrc' ? $userrvrc : $winddb[$db_signcurtype];
	if (getstatus($winddb['userstatus'],10) && (!$winddb['starttime'] && $db_signmoney && strpos($db_signgroup,",$groupid,") !== false && $curvalue > $db_signmoney || $winddb['starttime'] && $winddb['starttime'] != $tdtime)) {
		require_once(R_P.'require/Signfunc.php');
		Signfunc($winddb['starttime'],$curvalue);
	}
	unset($curvalue);
} else {
	$skin	 = $db_defaultstyle;
	$groupid = 'guest';
	$winddb  = $windid = $winduid = $_datefm = $_timedf = '';
}
$verifyhash = GetVerify($winduid);

if ($db_bbsifopen==2 && SCR!='login' && !defined('CK')) {
	require_once(R_P.'require/bbsclose.php');
}
if ($db_ifsafecv && strpos($db_safegroup,",$groupid,") !== false && !$safecv && !defined('PRO')) {
	Showmsg('safecv_prompt');
}
if ($db_ads && !$windid && (is_numeric($_GET['u']) || ($_GET['a'] && strlen($_GET['a'])<16)) && strpos($pwServer['HTTP_REFERER'],$pwServer['HTTP_HOST'])===false) {
	InitGP(array('u','a'));
	Cookie('userads',"$u\t$a\t".md5($pwServer['HTTP_REFERER']));
} elseif (GetCookie('userads') && $db_ads=='1') {
	list($u,$a) = explode("\t",GetCookie('userads'));
	if ((int)$u>0 || ($a && strlen($a)<16)) {
		require_once(R_P.'require/userads.php');
	}
}

if ($_POST['skinco']) {
	$skinco = $_POST['skinco'];
} elseif ($_GET['skinco']) {
	$skinco = $_GET['skinco'];
}
if ($skinco && file_exists(D_P."data/style/$skinco.php") && strpos($skinco,'..')===false) {
	$skin = $skinco;
	Cookie('skinco',$skin);
}

if ($db_columns && !defined('W_P') && !defined('SIMPLE') && !defined('COL')) {
	$j_columns = GetCookie('columns');
	if (!$j_columns) {
		$db_columns==2 && $j_columns = 2;
		Cookie('columns',$j_columns);
	}
	if ($j_columns==2 && (strpos($pwServer['HTTP_REFERER'],$db_bbsurl)===false || strpos($pwServer['HTTP_REFERER'],$db_adminfile)!==false)) {
		strpos($REQUEST_URI,'index.php')===false ? Cookie('columns','1') : ObHeader('columns.php?action=columns');
	}
}
Ipban();
Cookie('lastvisit',$c_oltime."\t".$timestamp."\t".$REQUEST_URI);

if ($groupid == 'guest' && $db_guestdir && GetGcache()) {
	require_once(R_P.'require/guestfunc.php');
	getguestcache();
}
PwNewDB();

unset($db_whybbsclose,$db_whycmsclose,$db_ipban,$db_diy,$dbhost,$dbuser,$dbpw,$dbname,$pconnect,$manager_pwd,$newmanager);

if ($groupid == 'guest') {
	require_once(D_P.'data/groupdb/group_2.php');
} elseif (file_exists(D_P."data/groupdb/group_$groupid.php")) {
	require_once Pcv(D_P."data/groupdb/group_$groupid.php");
} else {
	require_once(D_P.'data/groupdb/group_1.php');
}

if ($_G['pwdlimitime'] && !CkInArray($windid,$manager) && $timestamp-86400*$_G['pwdlimitime']>$winddb['pwdctime'] && !defined('PRO')) {
	Showmsg('pwdchange_prompt');
}
/*
$header_ad = $footer_ad = $navbanner_ad = '';

if (SCR != 'read') {
	$advertdb = AdvertInit(SCR,$fid);
	if (is_array($advertdb['header'])) {
		$header_ad = $advertdb['header'][array_rand($advertdb['header'])]['code'];
	}
	if (is_array($advertdb['navbanner'])) {
		$navbanner_ad = $advertdb['navbanner'][array_rand($advertdb['navbanner'])]['code'];
	}
	if (is_array($advertdb['footer'])) {
		$footer_ad = $advertdb['footer'][array_rand($advertdb['footer'])]['code'] .'<br />';
	}
	unset($advertdb['header'],$advertdb['footer']);
}
*/
function refreshto($URL,$content,$statime=1,$forcejump=false){
	if (defined('AJAX')) Showmsg($content);
	global $db_ifjump;

	if ($forcejump || ($db_ifjump && $statime>0)) {
		ob_end_clean();
		global $expires,$db_charset,$tplpath,$fid,$imgpath,$db_obstart,$db_bbsname,$B_url,$forumname,$tpctitle,$db_bbsurl;
		$index_name =& $db_bbsname;
		$index_url =& $B_url;
		ObStart();//noizy
		extract(L::style());

		$content = getLangInfo('refreshto',$content);
		@require PrintEot('refreshto');
		$output = str_replace(array('<!--<!---->','<!---->',"\r\n\r\n"),'',ob_get_contents());
		echo ObContents($output);exit;
	} else {
		ObHeader($URL);
	}
}
function ObHeader($URL){
	global $db_obstart,$db_bbsurl;

	ob_end_clean();
	if (!$db_obstart) {
		ob_start();
		echo "<meta http-equiv='refresh' content='0;url=$URL'>";exit;
	}
	header("Location: $URL");exit;
}
function Showmsg($msg_info,$dejump=0){
	@extract($GLOBALS, EXTR_SKIP);
	global $stylepath,$tablewidth,$mtablewidth,$tplpath,$db;
	define('PWERROR',1);
	$msg_info = getLangInfo('msg',$msg_info);
	if (defined('AJAX')) {
		echo $msg_info;ajax_footer();
	}
	$showlogin = false;
	if ($dejump!='1' && $groupid=='guest' && $REQUEST_URI==str_replace(array('register','login'),'',$REQUEST_URI) && (!$db_pptifopen || $db_ppttype != 'client')) {
		if (strpos($REQUEST_URI,'post.php')!==false || strpos($REQUEST_URI,'job.php?action=vote') !== false || strpos($REQUEST_URI,'job.php?action=pcjoin') !== false) {
			$tmpTid = (int)GetGP('tid','GP');
			$tmpTid && $REQUEST_URI = substr($REQUEST_URI,0,strrpos($REQUEST_URI,'/'))."/read.php?tid=$tmpTid&toread=1";
		}
		$jumpurl = "http://".$pwServer['HTTP_HOST'].$REQUEST_URI;
		list(,$qcheck)=explode("\t",$db_qcheck);
		$qkey = $qcheck && $db_question ? array_rand($db_question) : '';
		$showlogin = true;
	}
	extract(L::style());
	list($_Navbar,$_LoginInfo) = pwNavBar();
	ob_end_clean();ObStart();
	require_once PrintEot('showmsg');exit;
}
function GetLang($lang,$EXT='php'){
	global $tplpath;
	
	if (file_exists(R_P."template/$tplpath/lang_$lang.$EXT")) {
		return R_P."template/$tplpath/lang_$lang.$EXT";
	} elseif (file_exists(R_P."template/wind/lang_$lang.$EXT")) {
		return R_P."template/wind/lang_$lang.$EXT";
	} else {
		exit("Can not find lang_$lang.$EXT file");
	}
}
function PrintEot($template,$EXT='htm'){
	//Copyright (c) 2003-09 PHPWind
	global $db_mode,$db_modes,$pwModeImg,$db_tplstyle,$appdir,$tplapps;
	$tplpath = L::style('tplpath');
	!$template && $template = 'N';
	
	//apps template render
	if(!defined('PWERROR')) {
		if(defined('A_P') && $appdir && in_array($template,$tplapps) && file_exists(A_P."$appdir/template/$template.$EXT")){
			return A_P."$appdir/template/$template.$EXT";
		}
		if (defined('F_M')/* || ($db_mode && $db_mode != 'bbs')*/) {
			$temp = modeEot($template,$EXT);
			if ($temp) return $temp;
		}
	}
	//if (defined('A_P') && !in_array($template,array('header','footer'))/* || ($db_mode && $db_mode != 'bbs')*/) {
	//	return A_P."$appdir/template/$template.$EXT";
	//}
	if (file_exists(R_P."template/$tplpath/$template.$EXT")) {
		return R_P."template/$tplpath/$template.$EXT";
	} elseif (file_exists(R_P."template/wind/$template.$EXT")) {
		return R_P."template/wind/$template.$EXT";
	} else {
		exit("Can not find $template.$EXT file");
	}
}

function Ipban(){
	global $db_ipban;
	if ($db_ipban) {
		global $onlineip,$imgpath,$stylepath;
		$baniparray = explode(',',$db_ipban);
		foreach ($baniparray as $banip) {
			if ($banip && strpos(",$onlineip.",','.trim($banip).'.')!==false) {
				Showmsg('ip_ban');
			}
		}
	}
}
function Update_ol(){
	global $runfc,$db_online;
	if ($runfc == 'Y') {
		if ($db_online) {
			Sql_ol();
		} else {
			Txt_ol();
		}
		$runfc = 'N';
	}
}
function Txt_ol(){
	global $ol_offset,$winduid,$db_ipstates,$isModify;
	require_once(R_P.'require/userglobal.php');
	if ($winduid>0) {
		list($alt_offset,$isModify) = addonlinefile($ol_offset,$winduid);
	} else {
		list($alt_offset,$isModify) = addguestfile($ol_offset);
	}
	$alt_offset!=$ol_offset && Cookie('ol_offset',$alt_offset);
	$ipscookie = GetCookie('ipstate');
	if ($db_ipstates && ((!$ipscookie && $isModify===1) || ($ipscookie && $ipscookie<$GLOBALS['tdtime']))) {
		require_once(R_P.'require/ipstates.php');
	}
}
function Sql_ol(){
	global $db,$fid,$tid,$timestamp,$windid,$winduid,$onlineip,$groupid,$wind_in,$db_onlinetime,$db_ipstates,$db_today,$lastvisit;
	$olid	= (int)GetCookie('olid');
	$ifhide = $GLOBALS['_G']['allowhide'] && GetCookie('hideid') ? 1 : 0;
	$isModify = 0;
	PwNewDB();
	if ($olid) {
		$sqladd = $winduid ? '(uid='.pwEscape($winduid).' OR olid='.pwEscape($olid).' AND uid=0 AND ip='.pwEscape($onlineip).')' : 'olid='.pwEscape($olid).' AND ip='.pwEscape($onlineip);
		$pwSQL = pwSqlSingle(array(
			'username'	=> $windid,
			'lastvisit'	=> $timestamp,
			'fid'		=> $fid,
			'tid'		=> $tid,
			'groupid'	=> $groupid,
			'action'	=> $wind_in,
			'ifhide'	=> $ifhide,
			'uid'		=> $winduid,
			'ip'		=> $onlineip
		));
		$db->update("UPDATE pw_online SET $pwSQL WHERE $sqladd");
		if ($winduid && $db->affected_rows() > 1) {
			$db->update('DELETE FROM pw_online WHERE uid='.pwEscape($winduid).' AND olid!='.pwEscape($olid));
		}
	} elseif (!$_COOKIE) {
		$pwSQL = pwSqlSingle(array(
			'username'	=> $windid,
			'lastvisit'	=> $timestamp,
			'fid'		=> $fid,
			'tid'		=> $tid,
			'groupid'	=> $groupid,
			'action'	=> $wind_in,
			'ifhide'	=> $ifhide,
			'uid'		=> $winduid
		));
		$db->update("UPDATE pw_online SET $pwSQL WHERE ip=".pwEscape($onlineip));
	}
	if (!$olid && $_COOKIE || $db->affected_rows()==0) {
		$db->update('DELETE FROM pw_online WHERE uid!=0 AND uid='.pwEscape($winduid).' OR lastvisit<'.pwEscape($timestamp-$db_onlinetime));
		$rt = $db->get_one("SELECT MAX(olid) FROM pw_online",MYSQL_NUM);
		$olid = $rt[0]+1;
		$pwSQL = pwSqlSingle(array(
			'olid'		=> $olid,
			'username'	=> $windid,
			'lastvisit'	=> $timestamp,
			'ip'		=> $onlineip,
			'fid'		=> $fid,
			'tid'		=> $tid,
			'groupid'	=> $groupid,
			'action'	=> $wind_in,
			'ifhide'	=> $ifhide,
			'uid'		=> $winduid
		));
		$db->update("REPLACE INTO pw_online SET $pwSQL");
		Cookie('olid',$olid);
		$isModify = 1;
	}
	$ipscookie = GetCookie('ipstate');
	if ($db_ipstates && ((!$ipscookie && $isModify===1) || ($ipscookie && $ipscookie<$GLOBALS['tdtime']))) {
		require_once(R_P.'require/ipstates.php');
	}
	if ($db_today && $timestamp-$lastvisit>$db_onlinetime) {
		require_once(R_P.'require/today.php');
	}
}
function footer() {
	global $db,$db_obstart,$db_footertime,$db_htmifopen,$P_S_T,$mtablewidth,$db_ceoconnect,$wind_version,$imgpath, $stylepath,$footer_ad,$db_union,$timestamp,$db_icp,$db_icpurl,$db_advertdb,$groupid,$SCR,$db_ystats_ifopen,$db_ystats_unit_id,$db_ystats_style,$db_redundancy,$pwServer,$db_ifcredit,$credit_pop,$db_foot,$db_mode,$db_modes,$shortcutforum,$_G,$winddb,$db_toolbar,$winduid,$db_menuinit;

	defined('AJAX') && ajax_footer();
	Update_ol();
	$wind_spend	= '';
	$ft_gzip = ($db_obstart ? 'Gzip enabled' : 'Gzip disabled').$db_union[3];
	if ($db_footertime == 1){
		$t_array	= explode(' ',microtime());
		$totaltime	= number_format(($t_array[0]+$t_array[1]-$P_S_T),6);
		$qn = $db ? $db->query_num : 0;
		$wind_spend	= "Total $totaltime(s) query $qn,";
		
	}
	$ft_time = get_date($timestamp,'m-d H:i');
	$db_icp && $db_icp = "<a href=\"http://www.miibeian.gov.cn\" target=\"_blank\">$db_icp</a>";
	if ($db_toolbar) {
		if ($_COOKIE['toolbarhide']) {
			$toolbarstyle = 'style="display:none"';
			$openbarstyle = '';
			$closebarstyle = 'style="display:none"';
		} else {
			$toolbarstyle = '';
			$openbarstyle = 'style="display:none"';
			$closebarstyle = '';
		}
	}

	$appshortcut = explode(',',trim($winddb['appshortcut'],','));
	if ($winddb['appshortcut']) {
		$query = $db->query("SELECT appid,appname FROM pw_userapp WHERE uid=".pwEscape($winduid)." AND appid IN (".pwImplode($appshortcut).")");
		while ($rt = $db->fetch_array($query)) {
			$bottom_appshortcut[$rt['appid']] = $rt['appname'];
		}
	}

	$db_menuinit = trim($db_menuinit,',');

	require PrintEot('footer');
	if ($db_advertdb['Site.PopupNotice'] || $db_advertdb['Site.FloatLeft'] || $db_advertdb['Site.FloatRight'] || $db_advertdb['Site.FloatRand']) {
		require PrintEot('advert');
	}
	$output = ob_get_contents();
	if ($db_htmifopen) {
		$output = preg_replace(
			"/\<a(\s*[^\>]+\s*)href\=([\"|\']?)((index|cate|thread|read|faq|rss)\.php\?[^\"\'>\s]+\s?)[\"|\']?/ies",
			"Htm_cv('\\3','<a\\1href=\"')",
			$output
		);
	}
	if ($db_redundancy && $SCR!='post') {
		/*
		$output = str_replace(
			array("\r","\n\n","\n\t","\n ",">\n","\n<","}\n","{\n",";\n","/\n","\t ",">\t","\t<","}\t","{\t",";\t","/\t",'  ','<!--<!---->','<!---->'),
			array('',"\n",' ',' ','>','<','}','{',';','/',' ','>','<','}','{',';','/',' ','',''),
			$output
		);
		*/
		$output = str_replace(array("\r","\t\t",'<!--<!---->',"<!---->\r\n",'<!---->','<!-- -->',"<!--\n-->","\n\t","\n\n"),array('','','','','','',"\n","\n"),$output);
	} else {
		$output = str_replace(array('<!--<!---->',"<!---->\r\n",'<!---->','<!-- -->',"\t\t\t"),'',$output);
	}
	if ($SCR!='post') {
		$ceversion = defined('CE') ? 1 : 0;
		$output .= "<script language=\"JavaScript\" src=\"http://init.phpwind.net/init.php?sitehash={$GLOBALS[db_sitehash]}&v=$wind_version&c=$ceversion\"></script>";
	}
	if ($groupid == 'guest' && !defined('MSG') && GetGcache()) {
		require_once(R_P.'require/guestfunc.php');
		creatguestcache($output);
	}
	updateCacheData();
	echo ObContents($output);
	unset($output);
	N_flush();
	exit;
}
function updateCacheData(){
	$pw_tplgetdata = L::loadClass('tplgetdata','',true);
	if ($pw_tplgetdata) {
		if ($pw_tplgetdata->updates) {
			$pw_cachedata = L::loadDB('cachedata');
			$pw_cachedata->updates($pw_tplgetdata->updates);
		}
	}
}
function Htm_cv($url,$tag){
	global $db_dir,$db_ext;
	$tmppos = strpos($url,'#');
	$add = $tmppos!==false ? substr($url,$tmppos) : '';
	$url = str_replace(
		array('.php?','=','&amp;','&',$add),
		array($db_dir,'-','-','-',''),
		$url
	).$db_ext.$add;
	return stripslashes($tag).$url.'"';
}
function getUserByUid($uid) {
	global $db;
	$sqladd = $sqltab = '';
	if (in_array(SCR, array('index','read','thread','post'))) {
		$sqladd = (SCR == 'post') ? ',md.postcheck,sr.visit,sr.post,sr.reply' : ',sr.visit';
		$sqltab = "LEFT JOIN pw_singleright sr ON m.uid=sr.uid";
	}
	$detail = $db->get_one("SELECT m.uid,m.username,m.password,m.safecv,m.email,m.oicq,m.groupid,m.memberid,m.groups,m.icon,m.regdate,m.honor,m.timedf,m.style,m.datefm,m.t_num,m.p_num,m.yz,m.newpm,m.userstatus,m.shortcut,md.postnum,md.rvrc,md.money,md.credit,md.currency,md.lastvisit,md.thisvisit,md.onlinetime,md.lastpost,md.todaypost,md.monthpost,md.onlineip,md.uploadtime,md.uploadnum,md.starttime,md.pwdctime,md.monoltime,md.digests,md.f_num,md.creditpop $sqladd FROM pw_members m LEFT JOIN pw_memberdata md ON m.uid=md.uid $sqltab WHERE m.uid=" . pwEscape($uid) . ' AND md.uid IS NOT NULL');
	return $detail;
}
function User_info() {
	global $db,$timestamp,$db_onlinetime,$winduid,$windpwd,$safecv,$db_ifonlinetime,$c_oltime,$onlineip,$db_ipcheck,$tdtime,$montime,$db_ifsafecv, $db_ifpwcache,$uc_server;
	PwNewDB();
	$detail = getUserByUid($winduid);
	if (empty($detail) && $uc_server) {
		require_once(R_P . 'require/ucuseradd.php');
	}
	$loginout = 0;
	if ($db_ipcheck && strpos($detail['onlineip'],$onlineip) === false) {
		$iparray = explode('.',$onlineip);
		strpos($detail['onlineip'],$iparray[0].'.'.$iparray[1]) === false && $loginout = 1;
	}
	if (!$detail || PwdCode($detail['password']) != $windpwd || ($db_ifsafecv && $safecv != $detail['safecv']) || $loginout || $detail['yz'] > 1) {
		$GLOBALS['groupid'] = 'guest';
		require_once(R_P.'require/checkpass.php');
		Loginout();
		if ($detail['yz'] > 1) {
			$GLOBALS['jihuo_uid'] = $detail['uid'];
			Showmsg('login_jihuo');
		}
		Showmsg('ip_change');
	} else {
		list($detail['shortcut'], $detail['appshortcut']) = explode("\t",$detail['shortcut']);
		unset($detail['password']);
		$detail['honor'] = substrs($detail['honor'],90);
		$distime = $timestamp - $detail['lastvisit'];
		if ($distime > $db_onlinetime || $distime > 3600) {
			//Start elementupdate
			if ($db_ifpwcache & 1 && SCR != 'post' && SCR != 'thread') {
				require_once(R_P.'lib/elementupdate.class.php');
				$elementupdate = new ElementUpdate();
				$elementupdate->userSortUpdate($detail);
			}
			//End elementupdate
			if (!GetCookie('hideid')) {
				$ecpvisit = pwEscape($timestamp,false);
				$ct = 'lastvisit='.$ecpvisit.',thisvisit='.$ecpvisit;
				if ($db_ifonlinetime) {
					$c_oltime = $c_oltime <= 0 ? 0 : ($c_oltime > $db_onlinetime*1.2 ? $db_onlinetime : intval($c_oltime));
					$s_oltime = pwEscape($c_oltime,false);
					$ct .= ',onlinetime=onlinetime+'.$s_oltime;
					if ($detail['lastvisit'] > $montime) {
						$ct .= ',monoltime=monoltime+'.$s_oltime;
					} else {
						$ct .= ',monoltime='.$s_oltime;
					}
					$c_oltime && updateDatanalyse($winduid,'memberOnLine',$c_oltime);
					$c_oltime = 0;
				}
				$db->update("UPDATE pw_memberdata SET $ct WHERE uid=".pwEscape($winduid));
				$detail['lastvisit'] = $detail['thisvisit'] = $timestamp;
			}
		}
	}
	return $detail;
}

function pwAdvert($ckey,$fid=0,$lou=-1,$scr=0) {
	global $timestamp,$db_advertdb,$db_mode,$_time;
	if (empty($db_advertdb[$ckey])) return false;
	$hours = $_time['hours'] + 1;
	$fid || $fid = $GLOBALS['fid'];
	$scr || $scr = SCR;
	$lou = (int)$lou;
	$tmpAdvert = $db_advertdb[$ckey];
	if ($db_advertdb['config'][$ckey] == 'rand') {
		shuffle($tmpAdvert);
	}
	$arrAdvert = array();$advert = '';
	foreach ($tmpAdvert as $key=>$value) {
            if ($value['stime'] > $timestamp ||
                $value['etime'] < $timestamp ||
                ($value['dtime'] && strpos(",{$value['dtime']},",",{$hours},")===false) ||
		($value['mode'] && strpos($value['mode'],($db_mode?$db_mode:'bbs'))===false) ||
		($value['page'] && strpos($value['page'],$scr)===false) ||
		($value['fid'] && strpos(",{$value['fid']},",",$fid,")===false) ||
		($value['lou'] && strpos(",{$value['lou']},",",$lou,")===false)
            ) {
		continue;
            }
            if ((!$value['ddate'] && !$value['dweek']) ||
                ($value['ddate'] && strpos(",{$value['ddate']},",",{$_time['day']},")!==false) ||
                ($value['dweek'] && strpos(",{$value['dweek']},",",{$_time['week']},")!==false)) {
                $arrAdvert[] = $value['code'];
                $advert .= is_array($value['code']) ? $value['code']['code'] : $value['code'];
                if ($db_advertdb['config'][$ckey] != 'all') break;
            }
	}
	return array($advert,$arrAdvert);
}

function admincheck($forumadmin,$fupadmin,$username){
	if (!$username) {
		return false;
	}
	if ($forumadmin && strpos($forumadmin,",$username,")!==false) {
		return true;
	}
	if ($fupadmin && strpos($fupadmin,",$username,")!==false) {
		return true;
	}
	return false;
}
function getdirname($path=null){
	if (!empty($path)) {
		if (strpos($path,'\\')!==false) {
			return substr($path,0,strrpos($path,'\\')).'/';
		} elseif (strpos($path,'/')!==false) {
			return substr($path,0,strrpos($path,'/')).'/';
		}
	}
	return './';
}
function allowcheck($allowgroup,$groupid,$groups,$fid='',$allowforum=''){
	if ($allowgroup && strpos($allowgroup,",$groupid,")!==false) {
		return true;
	}
	if ($allowgroup && $groups) {
		$groupids = explode(',',substr($groups,1,-1));
		foreach ($groupids as $value) {
			if (strpos($allowgroup,",$value,")!==false) {
				return true;
			}
		}
	}
	if ($fid && $allowforum && strpos(",$allowforum,",",$fid,")!==false) {
		return true;
	}
	return false;
}
function GetGcache() {
	global $db_fguestnum,$db_tguestnum,$db_guestindex;
	$page = isset($GLOBALS['page']) ? $GLOBALS['page'] : (int)$_GET['page'];
	if (SCR == 'thread' && $page < $db_fguestnum && !isset($_GET['type']) && !GetGP('search')) {
		return true;
	} elseif (SCR == 'read' && $page < $db_tguestnum && !isset($_GET['uid'])) {
		return true;
	} elseif (SCR == 'index' && $db_guestindex && !isset($_GET['cateid'])) {
		return true;
	}
	return false;
}
function GetVerify($str,$app = null) {
	empty($app) && $app = $GLOBALS['db_siteid'];
	return substr(md5($str.$app.$GLOBALS['pwServer']['HTTP_USER_AGENT']),8,8);
}
function PostCheck($verify = 1,$gdcheck = 0,$qcheck = 0,$refer = 1) {
	global $pwServer;
	$verify && checkVerify();
	if ($refer && $pwServer['REQUEST_METHOD'] == 'POST') {
		$referer_a = @parse_url($pwServer['HTTP_REFERER']);
		if ($referer_a['host']) {
			list($http_host) = explode(':',$pwServer['HTTP_HOST']);
			if ($referer_a['host'] != $http_host) {
				Showmsg('undefined_action');
			}
		}
	}
	$gdcheck && GdConfirm($_POST['gdcode']);
	$qcheck && Qcheck($_POST['qanswer'],$_POST['qkey']);
}
function checkVerify($hash = 'verifyhash') {
	GetGP('verify') <> $GLOBALS[$hash] && Showmsg('illegal_request');
}
function GdConfirm($code) {
	Cookie('cknum','',0);
	if (!$code || !SafeCheck(explode("\t",StrCode(GetCookie('cknum'),'DECODE')),strtoupper($code),'cknum',1800)) {
		Showmsg('check_error');
	}
}
function Qcheck($answer,$qkey) {
	global $db_question,$db_answer;
	if ($db_question && (!isset($db_answer[$qkey]) || $answer!=$db_answer[$qkey])) {
		Showmsg('qcheck_error');
	}
}
function PwNewDB() {
	if (!is_object($GLOBALS['db'])) {
		global $db,$database,$dbhost,$dbuser,$dbpw,$dbname,$PW,$charset,$pconnect;
		require_once Pcv(R_P."require/db_$database.php");
		$db = new DB($dbhost, $dbuser, $dbpw, $dbname, $PW, $charset, $pconnect);
	}
}
function Pwloaddl($mod,$ckfunc='mysqli_get_client_info') {
	return extension_loaded($mod) && $ckfunc && function_exists($ckfunc) ? true : false;
}
function setstatus(&$status,$b,$setv = '1') {
	--$b;
	for ($i = strlen($setv)-1; $i >= 0 ; $i--) {
		if ($setv[$i]) {
			$status |= 1 << $b;
		} else {
			$status &= ~(1 << $b);
		}
		++$b;
	}
	//return $status;
}
function sendHeader($num,$rtarr=null){
	static $sapi = null;
	if ($sapi===null) {
		$sapi = php_sapi_name();
	}
	$header_a = array(
		'200' => 'OK',
		'206' => 'Partial Content',
		'304' => 'Not Modified',
		'404' => '404 Not Found',
		'416' => 'Requested Range Not Satisfiable',
	);
	if ($header_a[$num]) {
		if ($sapi=='cgi' || $sapi=='cgi-fcgi') {
			$headermsg = "Status: $num ".$header_a[$num];
		} else {
			$headermsg = "HTTP/1.1: $num ".$header_a[$num];
		}
		if (empty($rtarr)) {
			header($headermsg);
		} else {
			return $headermsg;
		}
	}
	return '';
}
/**
 * 添加会员最新动作
 *
 * @param int $uid		动作会员UID
 * @param string $type	动作类型
 * @param mixed $log	动作描述
 */
function pwAddFeed($uid,$type,$typeid,$log) {
	global $db,$timestamp;

	//判断该用户的该操作是否要要生成动态
	if (in_array($type,array('post','write','diary','share','photo'))){
		$fieldname = $type == 'post' ? 'article_isfeed' : ($type == 'photo' ? 'photos_isfeed' : $type.'_isfeed');
		$isfeed = $db->get_value("SELECT $fieldname FROM pw_ouserdata WHERE uid=".pwEscape($uid));
		if(!$isfeed) return false;
	}
	if (is_array($log)) {
		empty($log['lang']) && $log['lang'] = $type;
		$descrip = Char_cv(getLangInfo('feed',$log['lang'],$log));
	} else {
		$descrip = Char_cv($log);
	}
	$typeid = (int)$typeid;
	$db->update("INSERT INTO pw_feed SET " . pwSqlSingle(array(
		'uid'		=> $uid,
		'type'		=> $type,
		'typeid'	=> $typeid,
		'descrip'	=> $descrip,
		'timestamp'	=> $timestamp
	),false));
	return true;
}
function getLastDate($time,$type = 1){
	global $timestamp,$tdtime;
	static $timelang = false;
	if ($timelang==false) {
		$timelang = array(
			'second'	=>getLangInfo('other','second'),
			'yesterday'	=>getLangInfo('other','yesterday'),
			'hour'		=>getLangInfo('other','hour'),
			'minute'	=>getLangInfo('other','minute'),
			'qiantian'	=>getLangInfo('other','qiantian'),
		);
	}
	$decrease = $timestamp-$time;
	$thistime = PwStrtoTime(get_date($time,'Y-m-d'));
	$thisyear = PwStrtoTime(get_date($time,'Y'));
	$thistime_without_day = get_date($time,'H:i');
	$yeartime = PwStrtoTime(get_date($timestamp,'Y'));
	$result = get_date($time);
	if ($thistime == $tdtime) {
		if ($type == 1){
			if ($decrease <= 60) {
				return array($decrease.$timelang['second'],$result);
			} if ($decrease <= 3600) {
				return array(ceil($decrease/60).$timelang['minute'],$result);
			} else {
				return array(ceil($decrease/3600).$timelang['hour'],$result);
			}
		} else {
			return array(get_date($time,'H:i'),$result);
		}
	} elseif ($thistime == $tdtime-86400) {
		if ($type == 1) {
			return array($timelang['yesterday']." ".$thistime_without_day,$result);
		} else {
			return array(get_date($time,'m-d'),$result);
		}
	} elseif ($thistime == $tdtime-172800) {
		if ($type == 1) {
			return array($timelang['qiantian']." ".$thistime_without_day,$result);
		} else {
			return array(get_date($time,'m-d'),$result);
		}
	} elseif ($thisyear == $yeartime){
		return array(get_date($time,'m-d'),$result);
	} else {
		if ($type == 1) {
			return array(get_date($time,'Y-m-d'),$result);
		} else {
			return array(get_date($time,'y-n-j'),$result);
		}
	}
}
function procLock($t, $u = 0) {
	global $db,$timestamp;
	if ($db->query("INSERT INTO pw_proclock (uid,action,time) VALUES ('$u','$t','$timestamp')",'U',false)) {
		return true;
	}
	$db->update("DELETE FROM pw_proclock WHERE uid='$u' AND action='$t' AND time < '$timestamp' - 30");
	return false;
}
function procUnLock($t = '', $u = 0) {
	$GLOBALS['db']->update("DELETE FROM pw_proclock WHERE uid='$u' AND action='$t'");
}
function pwNavBar() {
	global $winduid,$db_mainnav,$db_menu,$groupid,$winddb,$SCR,$db_modes,$db_mode,$defaultMode,$db_menuinit;

	$tmpLogin = $tmpNav = array();
	if ($groupid != 'guest') {
		require_once(R_P.'require/showimg.php');
		list($tmpLogin['faceurl']) = showfacedesign($winddb['icon'],1,'s');
		$tmpLogin['lastlodate'] = get_date($winddb['lastvisit'],'Y-m-d');
	} else {
		global $db_question,$db_logintype,$db_qcheck;
		if ($db_question) {
			list(,$tmpLogin['qcheck']) = explode("\t",$db_qcheck);
			if ($tmpLogin['qcheck']) $tmpLogin['qkey'] = array_rand($db_question);
		}
		if ($db_logintype) {
			for ($i = 0; $i < 3; $i++) {
				if ($db_logintype & pow(2,$i)) $tmpLogin['logintype'][] = $i;
			}
		} else {
			$tmpLogin['logintype'][0] = 0;
		}
	}
	if (in_array(SCR,array('index','cate','mode')) || $SCR == 'm_home') {
		$tmpSel= empty($db_mode) ? 'KEYbbs' : 'KEY'.$db_mode;
	} elseif (in_array(SCR,array('read','thread'))){
		$tmpSel = 'KEYbbs';
	} else {
		$tmpSel = '';
	}
	empty($db_mainnav) && $db_mainnav = array();
	foreach ($db_mainnav as $key=>$value) {
		if ($value['pos'] == '-1' || strpos(",{$value['pos']},",','.($db_mode?$db_mode:'bbs').',') !== false) {
			$tmpNav['main']['html'] .= $tmpSel == $key ? "<li class=\"current\">{$value['html']}</li>" : "<li>{$value['html']}</li>";
		}
	}
	return array($tmpNav,$tmpLogin);
}
function pwGetShortcut() {
	static $shortcutforum = array();
	if (empty($shortcutforum)) {
		global $winddb,$forum,$winduid,$db_shortcutforum;
		if (trim($winddb['shortcut'],',')) {
			isset($forum) || require(D_P.'data/bbscache/forum_cache.php');
			$tempshortcut = explode(',',$winddb['shortcut']);
			foreach ($tempshortcut as $value) {
				if ($value && isset($forum[$value])) {
					$shortcutforum[$value] = strip_tags($forum[$value]['name']);
				}
			}
		}
		if (empty($shortcutforum)) {
			if (!$db_shortcutforum && $winduid) {
				require_once(R_P.'require/updateforum.php');
				$shortcutforum = updateshortcut();
			} else {
				$shortcutforum = $db_shortcutforum;
			}
		}
	}
	return $shortcutforum;
}

/**
 * 更新数据缓存库
 *
 */
function updateDatanalyse($tag, $action, $num) {
	global $db,$tdtime;
	$tag = (int)$tag; $num = (int)$num;
	$history = mktime ( 0, 0, 0, 0, 0, 0);
	if (!empty($tag) && !empty($action)) {
		$db->pw_update(
			"SELECT num FROM pw_datanalyse WHERE tag=".pwEscape($tag,false)."AND action=".pwEscape($action,false)."AND timeunit=".pwEscape($tdtime,false),
			"UPDATE pw_datanalyse SET num=num+".pwEscape($num,false) ." WHERE tag=".pwEscape($tag,false)."AND action=".pwEscape($action,false)."AND timeunit=".pwEscape($tdtime,false),
			"INSERT INTO pw_datanalyse SET tag=".pwEscape($tag,false).",action=".pwEscape($action,false).",timeunit=".pwEscape($tdtime,false).",num=".pwEscape($num,false)
		);
		$db->pw_update(
			"SELECT num FROM pw_datanalyse WHERE tag=".pwEscape($tag,false)."AND action=".pwEscape($action,false)."AND timeunit=".pwEscape($history,false),
			"UPDATE pw_datanalyse SET num=num+".pwEscape($num,false) ." WHERE tag=".pwEscape($tag,false)."AND action=".pwEscape($action,false)."AND timeunit=".pwEscape($history,false),
			"INSERT INTO pw_datanalyse SET tag=".pwEscape($tag,false).",action=".pwEscape($action,false).",timeunit=".pwEscape($history,false).",num=".pwEscape($num,false)
		);
	}
}

?>