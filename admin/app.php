<?php
!defined('P_W') && exit('Forbidden');

!$action && $action = 'my';
${'cls_'.$action} = 'class="two"';

/*app info*/
@include_once(D_P.'data/bbscache/o_config.php');
$app_list = 'http://apps.phpwind.net/adminlist.php';
$app_set = 'http://apps.phpwind.net/appset.php';
$param = array(
	'pw_sitehash'	=> $db_sitehash,
	'pw_fromurl'	=> $db_bbsurl . "/$admin_file?adminjob=app",
	'pw_time'		=> $timestamp,
	'pw_user'		=> $admin_name
);
/*app info*/

if ($action == 'my') {
	/*version check*/
	require_once(R_P.'require/posthost.php');
	$verify = md5('pw_bbs_api_action_api_version');
	$app_version = PostHost("http://app.phpwind.com/pw_bbs_api.php?","action=api_version&verify=$verify&","POST");
	list($app_version) = explode("\r\n",substr($app_version,strpos($app_version,'$backdata=')+10));
	if (strpos($app_version,'Not Found') !== false || strpos($app_version,'Error 405 Method Not Allowed') !== false) {
		adminmsg('The Interface is not exist');
	}
	/*version check*/

	/*Personal version check*/
	$partner = md5($db_siteid.$db_siteownerid);
	$verify = md5($partner);
	$host = $db_bbsurl;
	if ($host && strpos($host,'localhost') == false && strpos($host,'127.0') == false && strpos($host,'127.1') == false && strpos($host,'192.168') == false) {
		$personal = PostHost("$host/pw_app.php?","action=&verify=$verify&appadmin=1&","POST");
		list($personal) = explode("\r\n",substr($personal,strpos($personal,'$data=')+6));
		if (strpos($personal,'Not Found') !== false || strpos($personal,'Error 405 Method Not Allowed') !== false) {
			adminmsg('The Interface is not exist');
		}
	}
	/*Personal version check*/

	/*sitehash check*/
	$updatecache = false;
	$query = $db->query("SELECT db_name,db_value FROM pw_config WHERE db_name='db_siteid' OR db_name='db_siteownerid' OR db_name='db_sitehash'");
	while ($rt = $db->fetch_array($query)) {
		if (($rt['db_name'] == 'db_siteid' && $rt['db_value'] != $db_siteid) || ($rt['db_name'] == 'db_siteownerid' && $rt['db_value'] != $db_siteownerid) || ($rt['db_name'] == 'db_sitehash' && $rt['db_value'] != $db_sitehash)) {
			${$rt['db_name']} = preg_replace('/[^\d\w\_]/is','',$rt['db_value']);
			$updatecache = true;
		}
	}
	$db->free_result($query);
	if (!$db_siteid) {
		$db_siteid = generatestr(32);
		setConfig('db_siteid', $db_siteid);

		$db_siteownerid = generatestr(32);
		setConfig('db_siteownerid', $db_siteownerid);

		$db_sitehash = '10'.SitStrCode(md5($db_siteid.$db_siteownerid),md5($db_siteownerid.$db_siteid));
		setConfig('db_sitehash', $db_sitehash);
		$updatecache = true;
	}

	$updatecache && updatecache_c();
	/*sitehash check*/

	/*file check*/
	if(!$files = @readover('admin/safefiles.md5')){
		adminmsg('safefiles_not_exists');
	}
	$md5_a = $md5_c = $md5_m = $md5_d = $dirlist = array();

	safefile('./','\.php',0);
	safefile('api/','\.php|\.html');
	if ($db_modes['o']['ifopen']) {
		safefile('mode/o/','\.php|\.htm');
	}
	safefile('template/wind/','\.htm');

	foreach($files as $value){

		if (strpos($value,'./pw_api.php') !== false || strpos($value,'./pw_app.php') !== false || strpos($value,'api/') !== false || strpos($value,'mode/o/m_app.php') !== false || strpos($value,'mode/o/m_myapp.php') !== false || strpos($value,'mode/o/template/m_app.htm') !== false || strpos($value,'mode/o/template/m_myapp.htm') !== false || strpos($value,'apps.php') !== false || strpos($value,'template/wind/apps.htm') !== false) {

			list($md5key,$file) = explode("\t",$value);
			$file = trim($file);
			if (!isset($md5_a[$file])) {
				$md5_d[$file] = 1;
			} elseif ($md5key != $md5_a[$file]) {
				$md5_m[] = $file;
			} else {
				$md5_c[] = $file;
			}
		}
	}
	$cklog = array('1'=>0,'2'=>0,'3'=>0);
	$md5_a = array_merge($md5_a,$md5_d);

	foreach ($md5_a as $file=>$value) {
		$dir = dirname($file);
		$filename = basename($file);
		if (isset($md5_d[$file])) {
			$cklog[2]++;
			$dirlist[$dir][] = array($filename,'','','2');;
		} else {
			$filemtime = get_date(pwFilemtime($file));
			$filesize  = filesize($file);

			if(in_array($file,$md5_m)){
				$cklog[3]++;
				$dirlist[$dir][] = array($filename,$filesize,$filemtime,'3');
			} if(in_array($file,$md5_c)){
				$cklog[3]++;
				$dirlist[$dir][] = array($filename,$filesize,$filemtime,'4');
			} elseif(!in_array($file,$md5_c)){
				$cklog[1]++;
				$dirlist[$dir][] = array($filename,$filesize,$filemtime,'1');
			}
		}
	}
	/*file check*/
} elseif ($action == 'modify') {
	if ($_POST['step'] == 2) {
		InitGP(array('siteid','siteownerid','sitehash'));
		if (!$siteid || !$siteownerid || !$sitehash) {
			adminmsg('adcode_error',"$basename&action=modify");
		}
		if ($sitehash != '10'.SitStrCode(md5($siteid.$siteownerid),md5($siteownerid.$siteid))) {
			adminmsg('adcode_error',"$basename&action=modify");
		}
		setConfig('db_siteid', $siteid);
		setConfig('db_siteownerid', $siteownerid);
		setConfig('db_sitehash', $sitehash);
		setConfig('db_appid',0);

		updatecache_c();
		adminmsg('operate_success',"$basename&action=my");
	} elseif ($_GET['step']==3) {
		$siteid = generatestr(32);
		$siteownerid = generatestr(32);
		$sitehash = '10'.SitStrCode(md5($siteid.$siteownerid),md5($siteownerid.$siteid));
	}
} elseif ($action == 'app') {
	InitGP(array('job'));
	if(empty($job)){
		!$db_appid && adminmsg('code_appid_error');
		$arg = implode('|',$param);
		ksort($param);
		$url = $app_list . '?';
		foreach ($param as $key => $value) {
			$url .= "$key=" . urlencode($value) . '&';
		}
		$url .= 'pw_sig=' . md5($arg . $db_siteownerid);
	}

} elseif ($action == 'open') {

	require_once(R_P.'require/posthost.php');

	$sqlarray = file_exists(R_P."api/sql.txt") ? FileArray('api') : array();
	!empty($sqlarray) && SQLCreate($sqlarray);
	$param = array_merge($param, array(
		'action'	=> 'open',
		'sitename'	=> $db_bbsname,
		'siteurl'	=> $db_bbsurl,
		'charset'	=> $db_charset,
		'timedf'	=> $db_timedf
	));
	ksort($param);

	$str = $arg = '';
	foreach ($param as $key => $value) {
		if ($value) {
			$str .= "$key=" . urlencode($value) . '&';
			$arg .= "$key=$value&";
		}
	}
	$str .= 'pw_sig=' . md5($arg . $db_siteownerid);

	if ($response = PostHost($app_set, $str, 'POST')) {
		$response = unserialize($response);
	} else {
		$response = array('result' => 'error', 'error' => 3);
	}

	if (empty($response['error'])) {
		setConfig('db_appifopen', 1);
		updatecache_c();
	}

	adminmsg($response['result'],"$basename&action=app");

} elseif ($action == 'close') {

	require_once(R_P.'require/posthost.php');

	$param['action'] = 'close';
	ksort($param);

	$str = $arg = '';
	foreach ($param as $key => $value) {
		if ($value) {
			$str .= "$key=" . urlencode($value) . '&';
			$arg .= "$key=$value&";
		}
	}
	$str .= 'pw_sig=' . md5($arg . $db_siteownerid);

	if ($response = PostHost($app_set, $str, 'POST')) {
		$response = unserialize($response);
	} else {
		$response = array('result' => 'error', 'error' => 3);
	}
	if (empty($response['error'])) {
		setConfig('db_appifopen', 0);
		updatecache_c();
	}

	adminmsg($response['result'],"$basename&action=app");

} elseif ($action == 'blooming') {

	!$db_appid && adminmsg('code_appid_error');
	require_once(R_P.'require/posthost.php');
	InitGP(array('step'));
	$_POST['step'] = $step;

	include_once(D_P.'data/bbscache/info_class.php');
	include_once(D_P.'data/bbscache/info_group.php');
	$partner = md5($db_siteid.$db_siteownerid);

	if (empty($_POST['step'])) {

		$_Ginfo = explode(',',$db_appginfo);

		if (!file_exists(D_P.'data/bbscache/info_class.php')) {
			$verify = md5($db_sitehash.$partner.'getclass');
			$data = PostHost("http://app.phpwind.com/pw_app.php?", "action=getclass&sitehash=$db_sitehash&&verify=$verify&", "POST");

			$backdata = substr($data,strpos($data,'$backdata=')+10);
			if (strpos($backdata,'Not Found') !== false) {
				Showmsg('The Interface is not exist');
			}
			if (strpos($backdata,'}') === false) {
				$backdata = pwConvert($backdata,$db_charset,'gbk');
				Showmsg($backdata);
			}
			$backdatadb = unserialize(stripslashes($backdata));
			$backdatadb = pwConvert($backdatadb,$db_charset,'gbk');
			UpdateClassCache($backdatadb,true);
		}

	} elseif ($_POST['step'] == '2') {

		InitGP(array('ciddb'),'P');
		foreach ($info_class as $key => $value) {
			$info_class[$key]['ifshow']= '0';
		}
		foreach ($ciddb as $val) {
			$info_class[$val]['ifshow']= '1';
		}
		UpdateClassCache($info_class);

		adminmsg('operate_success',"$basename&action=$action");

	} elseif ($_POST['step'] == '3') {

		InitGP(array('groupdb'),'P',2);
		$groupdb = implode(',',$groupdb);
		setConfig('db_appginfo', $groupdb);
		updatecache_c();

		adminmsg('operate_success',"$basename&action=$action");

	} elseif ($_POST['step'] == '4') {

		$verify = md5($db_sitehash.$partner.'getclass');
		$data = PostHost("http://app.phpwind.com/pw_app.php?", "action=getclass&sitehash=$db_sitehash&&verify=$verify&", "POST");
		$backdata = substr($data,strpos($data,'$backdata=')+10);
		if (strpos($backdata,'Not Found') !== false) {
			Showmsg('The Interface is not exist');
		}
		if (strpos($backdata,'}') === false) {
			$backdata = pwConvert($backdata,$db_charset,'gbk');
			Showmsg($backdata);
		}
		$backdatadb = unserialize(stripslashes($backdata));
		$backdatadb = pwConvert($backdatadb,$db_charset,'gbk');
		UpdateClassCache($backdatadb,true);
		adminmsg('operate_success',"$basename&action=$action");
	}
} elseif ($action == 'open_bbs') {

	setConfig('db_appbbs', 1);
	updatecache_c();

	adminmsg('operate_success',"$basename&action=app");

} elseif ($action == 'close_bbs') {

	setConfig('db_appbbs', 0);
	updatecache_c();

	adminmsg('operate_success',"$basename&action=app");

} elseif ($action == 'open_o') {

	setConfig('db_appo', 1);
	updatecache_c();

	adminmsg('operate_success',"$basename&action=app");

} elseif ($action == 'close_o') {

	setConfig('db_appo', 0);
	updatecache_c();

	adminmsg('operate_success',"$basename&action=app");

} else {
	ObHeader($basename);
}

include PrintEot('app');exit;

function generatestr($len) {
	mt_srand((double)microtime()*1000000);
    $keychars = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWYXZ";
	$maxlen = strlen($keychars)-1;
	$str = '';
	for ($i=0;$i<$len;$i++){
		$str .= $keychars[mt_rand(0,$maxlen)];
	}
	return substr(md5($str.microtime().$GLOBALS['HTTP_HOST'].$GLOBALS['pwServer']["HTTP_USER_AGENT"].$GLOBALS['db_hash']),0,$len);
}
function SitStrCode($string,$key,$action='ENCODE'){
	$string	= $action == 'ENCODE' ? $string : base64_decode($string);
	$len	= strlen($key);
	$code	= '';
	for($i=0; $i<strlen($string); $i++){
		$k		= $i % $len;
		$code  .= $string[$i] ^ $key[$k];
	}
	$code = $action == 'DECODE' ? $code : str_replace('=','',base64_encode($code));
	return $code;
}
function SQLCreate($sqlarray) {
	global $db,$charset;
	$query = '';
	foreach ($sqlarray as $value) {
		if ($value[0]!='#') {
			$query .= $value;
			if (substr($value,-1)==';' && !in_array(strtolower(substr($query,0,5)),array('drop ','delet','updat'))) {
				$lowquery = strtolower(substr($query,0,5));
				if (in_array($lowquery,array('creat','alter','inser','repla'))) {
					$next = CheckDrop($query);
					if ($lowquery == 'creat') {
						if (!$next) continue;
						strpos($query,'IF NOT EXISTS')===false && $query = str_replace('TABLE','TABLE IF NOT EXISTS',$query);
						$extra1 = trim(substr(strrchr($value,')'),1));
						$tabtype = substr(strchr($extra1,'='),1);
						$tabtype = substr($tabtype,0,strpos($tabtype,strpos($tabtype,' ') ? ' ' : ';'));
						if ($db->server_info() >= '4.1') {
							$extra2 = "ENGINE=$tabtype".($charset ? " DEFAULT CHARSET=$charset" : '');
						} else {
							$extra2 = "TYPE=$tabtype";
						}
						$query = str_replace($extra1,$extra2.';',$query);
					} elseif (in_array($lowquery,array('inser','repla'))) {
						if (!$next) continue;
						$lowquery == 'inser' && $query = 'REPLACE '.substr($query,6);
					} elseif ($lowquery == 'alter' && !$next && strpos(strtolower($query),'drop')!==false) {
						continue;
					}
					$db->query($query);
					$query = '';
				}
			}
		}
	}
}

function FileArray($hackdir){
	if (function_exists('file_get_contents')) {
		$filedata = @file_get_contents(Pcv(R_P."$hackdir/sql.txt"));
	} else {
		$filedata = readover(R_P."$hackdir/sql.txt");
	}
	$filedata = trim(str_replace(array("\t","\r","\n\n",';'),array('','','',";\n"),$filedata));
	$sqlarray = $filedata ? explode("\n",$filedata) : array();
	return $sqlarray;
}
function CheckDrop($query){
	global $db;
	require_once(R_P.'admin/table.php');
	list($pwdb) = N_getTabledb();
	$next = true;
	foreach ($pwdb as $value) {
		if (strpos(strtolower($query),strtolower($value))!==false) {
			$next = false;
			break;
		}
	}
	return $next;
}
function safefile($dir,$ext='',$sub=1){
	global $md5_a;
	$exts = '/('.$ext.')$/i';
	$fp = opendir($dir);
	while($filename = readdir($fp)){
		$path = $dir.$filename;
		if($filename!='.' && $filename!='..' && (preg_match($exts, $filename) || $sub && is_dir($path))){
			if($sub && is_dir($path)){
				safefile($path.'/',$ext);
			} else{
				if (strpos($path,'./pw_api.php') !== false || strpos($path,'./pw_app.php') !== false || strpos($path,'api/') !== false || strpos($path,'mode/o/m_app.php') !== false || strpos($path,'mode/o/m_myapp.php') !== false || strpos($path,'mode/o/template/m_app.htm') !== false || strpos($path,'mode/o/template/m_myapp.htm') !== false || strpos($path,'apps.php') !== false || strpos($path,'template/wind/apps.htm') !== false) {
					$md5_a[$path] = md5_file($path);
				}
			}
		}
	}
	closedir($fp);
}

function UpdateClassCache($classdb=array(),$flag=false) {
	global $info_class;
	$classcache = "<?php\r\n\$info_class=array(\r\n";

	foreach ($classdb as $key => $class) {

		!$class['ifshow'] && $class['ifshow'] = '0';
		$flag && $info_class[$class['cid']]['ifshow'] && $class['ifshow'] = '1';

		$class['name'] = str_replace(array('"',"'"),array("&quot;","&#39;"),$class['name']);
		$classcache .= "'$class[cid]'=>".pw_var_export($class).",\r\n\r\n";
	}
	$classcache .= ");\r\n?>";
	writeover(D_P."data/bbscache/info_class.php",$classcache);
}
?>