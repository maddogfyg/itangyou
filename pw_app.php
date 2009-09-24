<?php
define('SCR','pw_app');
if (isset($_GET['ajax'])) {
	define('AJAX','1');
}
if (isset($_POST['content'])) {
	$_POST['atc_content'] = $_POST['content'];
}
require_once('global.php');
require_once(R_P.'admin/cache.php');
InitGP(array('action','verify'));

$version = "2009/7/20";
$partner = md5($db_siteid.$db_siteownerid);

if ($action == 'insert') {

	InitGP(array('username','fid','topped','dates','subject','tags','verify'));
	InitGP('atc_content',null,0);

	$para = array(
		'username'	=> $username,
		'fid'       => $fid,
		'topped'    => $topped,
		'dates'     => $dates,
		'subject'	=> $subject,
		'action'	=> $action,
	);

	ksort($para);
	reset($para);

	$arg = '';
	foreach ($para as $key => $value) {
		$arg .= "$key=".urlencode($value)."&";
	}

	$pw_verify = md5(substr($arg,0,-1).$partner);

	if ($pw_verify != $verify) {
		echo '$tid=verify_fail';exit;
	}

	$username		= pwConvert($username,$db_charset,'gbk');
	$subject		= pwConvert($subject,$db_charset,'gbk');
	$atc_content	= pwConvert($atc_content,$db_charset,'gbk');
	$tags			= pwConvert($tags,$db_charset,'gbk');

	$foruminfo = $db->get_one('SELECT * FROM pw_forums f LEFT JOIN pw_forumsextra fe USING(fid) WHERE f.fid='.pwEscape($fid)." AND type<>'category'");
	if (!$foruminfo) {
		echo '$tid=forum_noexist';exit;
	}

	$rt = $db->get_one('SELECT uid FROM pw_members WHERE username='.pwEscape($username));

	if (!$rt['uid']) {
		echo '$tid=username_noexist';exit;
	}

	require_once(R_P.'require/postfunc.php');
	$ipfrom = Char_cv(cvipfrom($onlineip));
	if ($dates) {
		$toolfield = $timestamp + 24*3600*$dates.',';
	}
	$topped == '4' && $topped = '0';

	$pwSQL = pwSqlSingle(array(
		'fid'		=> $fid,		'icon'		=> 0,
		'author'	=> $username,	'authorid'	=> $rt['uid'],
		'subject'	=> $subject,	'toolfield'	=> $toolfield,
		'type'		=> 0,			'postdate'	=> $timestamp,
		'lastpost'	=> $timestamp,	'lastposter'=> $username,
		'hits'		=> 1,			'replies'	=> 0,
		'topped'	=> $topped,		'digest'	=> 0,
		'special '	=> 0,			'state'		=> 0,
		'ifupload'	=> 0,			'ifmail'	=> 0,
		'anonymous'	=> 0,			'ptable'	=> $db_ptable,
		'ifmagic'	=> 0,			'ifcheck'	=> 1,
		'ifhide'	=> 0
	));
	$db->update("INSERT INTO pw_threads SET $pwSQL");
	$tid = $db->insert_id();
        # memcache reflesh
        $threadList = L::loadClass("threadlist");
        $threadList->updateThreadIdsByForumId($fid,$tid);
	$pw_tmsgs = GetTtable($tid);
	$atc_title = $subject;
	$windid = $username;

	$pwSQL = pwSqlSingle(array(
		'tid'		=> $tid,
		'aid'		=> '',
		'userip'	=> $onlineip,
		'ifsign'	=> 3,
		'buy'		=> '',
		'ipfrom'	=> $ipfrom,
		'tags'		=> $tags,
		'ifconvert'	=> 2,
		'ifwordsfb'	=> 1,
		'content'	=> $atc_content,
		'magic'		=> ''
	));
	$db->update("INSERT INTO $pw_tmsgs SET $pwSQL");

	lastinfo($fid,0,'new');

	if ($topped) {
		require_once(R_P.'require/updateforum.php');
		setConfig('db_topped',1);
		updatecache_c();
		updatetop();
	}
	//论坛积分设置
	require_once(R_P.'require/credit.php');
	$fm = $db->get_one("SELECT creditset FROM pw_forumsextra WHERE fid=".pwEscape($fid));
	$creditset = $credit->creditset($fm['creditset'],$db_creditset);
	$credit->addLog('topic_Post',$creditset['Post'],array(
		'uid'		=> $rt['uid'],
		'username'	=> $windid,
		'ip'		=> $onlineip,
		'fname'		=> $forum[$fid]['name']
	));
	$credit->sets($rt['uid'],$creditset['Post']);
	$sqladd  = $tdtime  >= $winddb['lastpost'] ? 'todaypost=1,' : 'todaypost=todaypost+1,';
	$sqladd .= $montime >= $winddb['lastpost'] ? 'monthpost=1,' : 'monthpost=monthpost+1,';

	$db->update("UPDATE pw_memberdata SET {$sqladd}postnum=postnum+1,lastpost=".pwEscape($timestamp)." WHERE uid=".pwEscape($rt['uid']));

	echo '$tid='.$tid;exit;

} elseif ($action == 'getdata') {
	InitGP(array('tid'));

	$pw_verify = md5('tid='.$tid.$partner.$action);

	if ($pw_verify != $verify) {
		echo '$tid=verify_fail';exit;
	}
	$pw_tmsgs = GetTtable($tid);
	$rt = $db->get_one("SELECT t.toolfield,t.hits,t.replies,ts.content FROM pw_threads t LEFT JOIN $pw_tmsgs ts USING(tid) WHERE t.tid=".pwEscape($tid));
	echo '$countdb='.serialize($rt);exit;
} elseif ($action == 'downdata') {
	InitGP(array('tid'));

	$pw_verify = md5('tid='.$tid.$partner);

	if ($pw_verify != $verify) {
		echo '$tid=verify_fail';exit;
	}

	$rt = $db->get_one('SELECT tid FROM pw_threads WHERE tid='.pwEscape($tid));

	if (!$rt['tid']) {
		echo '$tid=post_noexist';exit;
	}

	$db->update('UPDATE pw_threads SET topped=0 WHERE tid='.pwEscape($tid));
	require_once(R_P.'require/updateforum.php');
	updatetop();

	echo '$tid=stop_topped';exit;
} elseif ($action == 'updata') {
	require_once(R_P.'require/posthost.php');
	include_once(D_P.'data/bbscache/level.php');
	InitGP(array('tid','cid'));

	$pw_tmsgs = GetTtable($tid);
	$rt = $db->get_one("SELECT t.tid,subject,content FROM pw_threads t LEFT JOIN $pw_tmsgs tm ON t.tid=tm.tid WHERE t.tid=".pwEscape($tid));

	$systitle = $winddb['groupid']=='-1' ? '' : $ltitle[$winddb['groupid']];
	$memtitle = $ltitle[$winddb['memberid']];
	$uptitle = $systitle ? $systitle : $memtitle;

	!$cid && Showmsg('Please select class');

	$content	= pwConvert($rt['content'],'gbk',$db_charset);
	$subject	= pwConvert($rt['subject'],'gbk',$db_charset);
	$windid		= pwConvert($windid,'gbk',$db_charset);
	$uptitle	= pwConvert($uptitle,'gbk',$db_charset);

	$para = array(
		'tid'		=> $rt['tid'],
		'cid'		=> $cid,
		'upposter'	=> $windid,
		'uptitle'	=> $uptitle,
		'subject'	=> $subject,
		'rf'		=> $pwServer['HTTP_REFERER'],
		'sitehash'	=> $db_sitehash,
		'action'	=> 'updata',
	);

	ksort($para);
	reset($para);

	$arg = '';
	foreach ($para as $key => $value) {
		$arg .= "$key=".urlencode($value)."&";
	}

	$verify = md5(substr($arg,0,-1).$partner);

	if (strpos($content,'[attachment=') !== false) {
		preg_replace("/\[attachment=([0-9]+)\]/eis","upload('\\1')",$content,$db_cvtimes);
	}

	$data = PostHost("http://app.phpwind.com/pw_app.php?","action=updata&tid=$rt[tid]&cid=$cid&upposter=$windid&uptitle=$uptitle&sitehash=$db_sitehash&subject=".urlencode($subject)."&content=".urlencode($content)."&verify=$verify&rf=".urlencode($pwServer['HTTP_REFERER'])."","POST");

	$backdata = substr($data,strpos($data,'$backdata=')+10);
	$backdata = pwConvert($backdata,$db_charset,'gbk');

	Showmsg($backdata);

} elseif ($action == 'toapp') {
	InitGP(array('tid'));
	if (!$db_appid) Showmsg('app_not_register');
	@include_once(D_P.'data/bbscache/info_class.php');
	!is_array($info_class) && $info_class = array();
	require_once PrintEot('pw_app');ajax_footer();
} elseif ($action == 'sendmsg') {

	InitGP(array('toname','fromname','subject','content'));

	$para = array(
		'toname'	=> $toname,
		'fromname'  => $fromname,
		'subject'	=> $subject,
		'content'	=> $content,
	);

	ksort($para);
	reset($para);

	$arg = '';
	foreach ($para as $key => $value) {
		$arg .= "$key=".urlencode($value)."&";
	}

	$pw_verify = md5(substr($arg,0,-1).$partner);

	if ($pw_verify != $verify) {
		echo '$tid=verify_fail';exit;
	}

	$toname		= pwConvert($toname,$db_charset,'gbk');
	$fromname	= pwConvert($fromname,$db_charset,'gbk');
	$subject	= pwConvert($subject,$db_charset,'gbk');
	$content	= pwConvert($content,$db_charset,'gbk');

	require_once(R_P."require/msg.php");
	$msg = array(
 		'toUser'	=> $toname,
 		'toUid'		=> '',
 		'fromUid'	=> '-1',
 		'fromUser'	=> 'PHPWind.App',
 		'subject'	=> $subject,
 		'content'	=> $content,
 		'other'		=> array()
 	);
	pwSendMsg($msg,0);

} elseif ($action == 'getforums') {
	$pw_verify = md5($partner.$action);
	if ($pw_verify != $verify) {
		echo '$backdata=verify_fail';exit;
	}
	$forumsdb = array();
	$query = $db->query("SELECT fid,name FROM pw_forums WHERE type IN ('forum','sub') ORDER BY fid");
	while ($rt = $db->fetch_array($query)) {
		$rt['name'] = pwConvert($rt['name'],'gbk',$db_charset);
		$forumsdb[$rt['fid']] = $rt;
	}
	$data = addslashes(serialize($forumsdb));
	echo '$backdata='.$data;exit;
} elseif ($action == 'wordsfb') {
	InitGP(array('content'));
	$pw_verify = md5($partner.$action);

	if ($pw_verify != $verify) {
		echo '$data=verify_fail';exit;
	}

	$content = str_replace('&quot;','"',stripslashes($content));
	$content = pwConvert(unserialize($content),$db_charset,'gbk');
	foreach($content as $key=>$value){
		if($value){
			$rt=$db->get_one("SELECT * FROM pw_wordfb WHERE word='".pwEscape($value)."'");
			if(!$rt){
				$pwSQL = pwSqlSingle(array(
					'word'		=> $value,
					'type'		=> 1
				));
				$db->update("INSERT INTO pw_wordfb SET $pwSQL");
			}

		}
	}

	updatecache_w();
	echo '$data=step_success';exit;
} elseif ($action == 'sharelinks') {
	InitGP(array('job'));
	if ($job == 'getsharelinks') {
		$pw_verify = md5($partner);
		if ($pw_verify != $verify) {
			echo '$backdata=verify_fail';exit;
		}
		$sharelinkdb = array();
		$query = $db->query("SELECT * FROM pw_sharelinks");
		while ($rt = $db->fetch_array($query)) {
			$sharelinkdb[$rt['sid']] = $rt;
		}
		$data = addslashes(serialize(pwConvert($sharelinkdb,'gbk',$db_charset)));
		echo '$data='.$data;exit;
	} elseif ($job == 'upsharelinks') {
		InitGP(array('sid','sharelinkdb','name','url','logo','descrip','threadorder','ifcheck'));
		$pw_verify = md5("$action$partner");
		if ($pw_verify != $verify) {
			echo "$backdata=verify_fail";exit;
		}
		$sharelinkdb	= pwConvert($sharelinkdb,$db_charset,'gbk');
		$name			= pwConvert($name,$db_charset,'gbk');
		$descrip		= pwConvert($descrip,$db_charset,'gbk');
		$rt = $db->get_one('SELECT * FROM pw_sharelinks WHERE sid='.pwEscape($sid).' limit 1');
		if ($rt) {
			$pwSQL = pwSqlSingle(array(
				'name'			=> $name,
				'url'			=> $url,
				'logo'			=> $logo,
				'descrip'		=> $descrip,
				'threadorder'	=> $threadorder,
				'ifcheck'		=> $ifcheck
			));
			$db->update("UPDATE pw_sharelinks SET $pwSQL WHERE sid=".pwEscape($sid));
			updatecache_i();
			echo '$sid='.$sid;exit;
		} else {
			$pwSQL = pwSqlSingle(array(
				'threadorder'	=> $threadorder,
				'name'			=> $name,
				'url'			=> $url,
				'logo'			=> $logo,
				'descrip'		=> $descrip,
				'ifcheck'		=> $ifcheck
			));
			$db->update("INSERT INTO pw_sharelinks SET $pwSQL");
			$sid = $db->insert_id();
			updatecache_i();
			echo '$sid='.$sid;exit;
		}
	} elseif ($job == 'remove') {
		InitGP(array('sid'));
		$pw_verify=md5("$action$sid$partner");
		if ($pw_verify != $verify) {
			echo '$backdata=verify_fail';exit;
		}
		$db->update('DELETE FROM pw_sharelinks WHERE sid='.pwEscape($sid));
		updatecache_i();
		echo '$data='.$sid;exit;
	} elseif ($job == 'state') {
		InitGP(array('sid'));
		$pw_verify = md5("$action$partner");
		if ($pw_verify != $verify) {
			echo '$backdata=verify_fail';exit;
		}
		$rt = $db->get_one('SELECT sid FROM pw_sharelinks WHERE sid='.pwEscape($sid));

		echo '$sid='.$rt['sid'];exit;
	}

} elseif ($action == 'cnzz') {
	$pw_verify = md5($partner.$action);

	if ($pw_verify != $verify) {
		echo '$data=verify_fail';exit;
	}
	if ($db_ystats_ifopen == '0') {
		setConfig('db_ystats_ifopen', 1);
		updatecache_c();
	}

} elseif ($action == 'survey') {
	InitGP(array('itemdb'));
	$pw_verify = md5("$action$partner");
	if ($pw_verify != $verify) {
		echo '$backdata=verify_fail';exit;
	}
	$survey_cache = "<?php\r\n";
	if (!empty($itemdb) && is_array($itemdb)) {
		$survey_cache .= "\$db_survey='1';\r\n";
	} else {
		$survey_cache .= "\$db_survey='0';\r\n";
	}
	$itemdb = unserialize(str_replace('&quot;','"',stripcslashes($itemdb)));
	foreach ($itemdb as $key=> $item) {
		$item['url'] = rawurldecode($item['url']);
		$itemd[$key] = $item;
	}
	if (is_array($itemd)) {
		$survey_cache.="\$survey_cache=".pw_var_export($itemd);
		$survey_cache.=';';
	}
	$survey_cache .= "\r\n?>";
	$survey_cache = pwConvert($survey_cache,$db_charset,'gbk');
	writeover(D_P."data/bbscache/survey_cache.php",$survey_cache);
	echo "\$data=ok";exit;
}  elseif ($action == 'thread') {
	InitGP(array('job'));
	if($job == 'adthread'){
		InitGP(array('username','fid','topped','subject','verify'));
		InitGP('atc_content',null,0);

		$para = array(
			'username'	=> $username,
			'fid'       => $fid,
			'topped'    => $topped,
			'subject'	=> $subject,
		);

		ksort($para);
		reset($para);

		$arg = '';
		foreach ($para as $key => $value) {
			$arg .= "$key=".urlencode($value)."&";
		}

		$pw_verify = md5(substr($arg,0,-1).$partner);

		if ($pw_verify != $verify) {
			echo '$tid=verify_fail';exit;
		}
		$username		= pwConvert($username,$db_charset,'gbk');
		$subject		= pwConvert($subject,$db_charset,'gbk');
		$atc_content	= pwConvert($atc_content,$db_charset,'gbk');

		$foruminfo = $db->get_one('SELECT * FROM pw_forums f LEFT JOIN pw_forumsextra fe USING(fid) WHERE f.fid='.pwEscape($fid)." AND type<>'category'");
		if (!$foruminfo) {
			echo '$tid=forum_noexist';exit;
		}

		$rt = $db->get_one('SELECT uid FROM pw_members WHERE username='.pwEscape($username));

		if (!$rt['uid']) {
			echo '$tid=username_noexist';exit;
		}

		require_once(R_P.'require/postfunc.php');
		$ipfrom  = Char_cv(cvipfrom($onlineip));

		$topped == '4' && $topped = '0';

		$pwSQL = pwSqlSingle(array(
			'fid'		=> $fid,		'icon'		=> 0,
			'author'	=> $username,	'authorid'	=> $rt['uid'],
			'subject'	=> $subject,	'toolfield'	=> $toolfield,
			'type'		=> 0,			'postdate'	=> $timestamp,
			'lastpost'	=> $timestamp,	'lastposter'=> $username,
			'hits'		=> 1,			'replies'	=> 0,
			'topped'	=> $topped,		'digest'	=> 0,
			'special '	=> 0,			'state'		=> 0,
			'ifupload'	=> 0,			'ifmail'	=> 0,
			'anonymous'	=> 0,			'ptable'	=> $db_ptable,
			'ifmagic'	=> 0,			'ifcheck'	=> 1,
			'ifhide'	=> 0
		));
		$db->update("INSERT INTO pw_threads SET $pwSQL");
		$tid = $db->insert_id();
		# memcache refresh
		$threadList = L::loadClass("threadlist");
		$threadList->updateThreadIdsByForumId($fid,$tid);

		$pw_tmsgs = GetTtable($tid);
		$atc_title = $subject;
		$windid = $username;

		$pwSQL = pwSqlSingle(array(
			'tid'		=> $tid,
			'aid'		=> '',
			'userip'	=> $onlineip,
			'ifsign'	=> 3,
			'buy'		=> '',
			'ipfrom'	=> $ipfrom,
			'tags'		=> '',
			'ifconvert'	=> 2,
			'ifwordsfb'	=> 1,
			'content'	=> $atc_content,
			'magic'		=> ''
		));
		$db->update("INSERT INTO $pw_tmsgs SET $pwSQL");

		lastinfo($fid,0,'new');

		if ($topped) {
			require_once(R_P.'require/updateforum.php');
			setConfig('db_topped',1);
			updatecache_c();
			updatetop();
		}

		echo '$tid='.$tid;exit;
	} elseif ($job == 'checkthread') {
		InitGP(array('tid','verify'));
		$pw_verify = md5($partner.$tid);
		if ($pw_verify != $verify) {
			echo '$tid=verify_fail';exit;
		}
		$thread = $db->get_one('SELECT author AS username,fid,topped,subject FROM pw_threads WHERE tid='.pwEscape($tid));
		ksort($thread);
		reset($thread);
		$arg = '';
		foreach ($thread as $key => $value) {
			$arg .= "$key=".urlencode($value)."&";
		}
		$verify = md5(substr($arg,0,-1).$partner);

		$pw_tmsgs	= GetTtable($tid);
		$content	= $db->get_value("SELECT content FROM $pw_tmsgs WHERE tid=".pwEscape($tid));
		$content	= pwConvert($content,'gbk',$db_charset);
		$hashnumber	= md5($verify.urlencode($content));
		echo '$tid='.$hashnumber;exit;
	} elseif ($job == 'getposts') {
		InitGP(array('sip_timestamp','verify'));
		$pw_verify = md5($partner.$sip_timestamp);
		if ($pw_verify != $verify) {
			echo '$tid=verify_fail';exit;
		}
		$rs=$db->get_one("SELECT SUM(fd.article) as article FROM pw_forums f LEFT JOIN pw_forumdata fd USING(fid) WHERE f.ifsub='0' AND f.cms!='1'");
		$article = $rs['article'];
		$rs = $db->get_one("SELECT yposts FROM pw_bbsinfo WHERE id=1");
		$yposts = $rs['yposts'];
		echo '$tid='.$article."\t".$yposts;
	} elseif ($job == 'down') {
		InitGP(array('tid','verify'));
		$pw_verify = md5($tid.$partner);
		if ($pw_verify != $verify) {
			echo '$tid=verify_fail';exit;
		}
		$db->query("UPDATE pw_threads SET topped='0' WHERE tid=".pwEscape($tid));
	}
} else {
	InitGP(array('appid','appadmin'));
	$pw_verify = md5($partner);
	if ($pw_verify != $verify) {
		echo '$data='.'Failure';exit;
	}
	if (!$appadmin) {
		$appid = pwConvert($appid, $db_charset, 'gbk');
		setConfig('db_appid', $appid);
		updatecache_c();
	}
	echo '$data=20090720';exit;
}

function upload($aid) {
	global $db,$content,$db_bbsurl,$attachpath;
	$rt = $db->get_one("SELECT attachurl,type FROM pw_attachs WHERE aid='$aid'");
	if ($rt['attachurl']) {
		if ($rt['type'] == 'img') {
			$img = "[img]$db_bbsurl/$attachpath/".$rt['attachurl']."[/img]";
			$content = addslashes(str_replace("[attachment=$aid]",$img,$content));
		} else {
			$content = addslashes(str_replace("[attachment=$aid]",'',$content));
		}
	}
}
?>