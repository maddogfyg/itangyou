<?php
!defined('M_P') && exit('Forbidden');
InitGP(array('step','selid','back'));
$fid = (int)$fid;
$selid = (int)$selid;
if (empty($fid) || empty($selid)) {
	define('AJAX',1);
	Showmsg('undefined_action');
}
require_once(R_P.'require/forum.php');
require_once(R_P.'require/msg.php');
require_once(R_P.'require/writelog.php');
include_once(D_P.'data/bbscache/forum_cache.php');

if (!($foruminfo = L::forum($fid))) {
	define('AJAX',1);
	Showmsg('data_error');
}

(!$foruminfo || $foruminfo['type'] == 'category') && Showmsg('data_error');
wind_forumcheck($foruminfo);

$isGM = CkInArray($windid,$manager);
$isBM = admincheck($foruminfo['forumadmin'],$foruminfo['fupadmin'],$windid);
if (!pwRights($isBM,'areapush') && !$isGM) {
	define('AJAX',1);
	Showmsg('mawhole_right');
}
//TODO 用户操作权限
if (empty($step)) {
	$areaPage = array();
	$mConfig = L::loadDB('mpageconfig');
	$tmpArray = $mConfig->getInvokesByMode('area');
	if (empty($tmpArray)) {
		define('AJAX',1);
		Showmsg('undefined_action');
	}
	$thisCateId = getCateid($fid);
	foreach ($tmpArray as $key => $value) {
		$index = $value['mode'].'_'.$value['scr'].'_';
		if ($value['scr'] == 'index') {
			if (!checkEditAdmin($windid,$groupid,'index')) continue;
			$areaPage[$index.'0'] = $db_modes[$value['mode']]['m_name'].getLangInfo('other','pushto_index');
		} elseif ($value['scr'] == 'cate') {
			if ($value['fid'] == 0) {
				foreach ($forum as $v) {
					if ($v['type'] == 'category' && $v['fid']==$thisCateId && !isset($areaPage[$index.$v['fid']])) {
						if (!checkEditAdmin($windid,$groupid,$v['fid'])) continue;
						$areaPage[$index.$v['fid']] = $forum[$v['fid']]['name'];
					}
				}
			} else {
				if (!checkEditAdmin($windid,$groupid,$value['fid']) || $value['fid']!=$thisCateId) continue;
				$areaPage[$index.$value['fid']] = $forum[$value['fid']]['name'];
			}
		}
	}
	if (!$areaPage){
		define('AJAX',1);
		Showmsg('area_push_right');
	}
	if (!$back && count($areaPage) == 1) {
		$_GET['index'] = key($areaPage);
		$step = 1;
	} else {
		define('AJAX','1');
		include areaLoadFrontView($action);
		ajax_footer();
	}
}
if ($step == 1) {
	InitGP(array('index'));
	list($keyid['mode'],$keyid['scr'],$keyid['fid']) = explode('_',$index);
	$keyid['fid'] = (int)$keyid['fid'];
	if (!isset($db_modes[$keyid['mode']]) || ($keyid['scr'] == 'cate' && !$keyid['fid'])) {
		Showmsg('undefined_action');
	}
	$paramfid = 0;
	if ($keyid['fid']) {
		include_once(D_P.'data/bbscache/area_config.php');
		if ($area_cateinfo && isset($area_cateinfo[$keyid['fid']]) && isset($area_cateinfo[$keyid['fid']]['tpl'])) {
			$paramfid = $keyid['fid'];
		}
	}
	$areaPage = array();$selTitle = '';
	$mConfig = L::loadDB('mpageconfig');
	$areaPage = $mConfig->getInvokes($keyid['mode'],$keyid['scr'],$paramfid);
	if (empty($areaPage)) {
		$areaPage = $mConfig->getInvokes($keyid['mode'],$keyid['scr']);
		if (empty($areaPage)) {
			Showmsg('undefined_action');
		}
	}
	$pw_invoke	= L::loadDB('invoke');
	$invokedata	= $pw_invoke->getDatasByNames($areaPage);
	foreach ($areaPage as $key=>$value) {
		if (!in_array($invokedata[$value]['type'],array('subject','image','player'))) {
			unset($areaPage[$key]);
		} elseif ($invokedata[$value]['ifloop']) {
			if ($invokedata[$value]['loops']) {
				foreach ($invokedata[$value]['loops'] as $v) {
					$areaPage[$areaPage[$key].','.$v] = $forum[$v]['name'];
				}
			}
			unset($areaPage[$key]);
		}
	}
	if ($keyid['scr'] == 'index') {
		$selTitle = $db_modes[$keyid['mode']]['m_name'].getLangInfo('other','pushto_index');
	} elseif ($keyid['scr'] == 'cate') {
		$selTitle = $forum[$keyid['fid']]['name'];
	}
	$index = $keyid['mode'].'_'.$keyid['scr'].'_'.$keyid['fid'];
	if (!$back && count($areaPage) == 1) {
		$_GET['name'] = current($areaPage);
		$_GET['index'] = $index;
		$step = 2;
	} else {
		define('AJAX','1');
		include areaLoadFrontView($action);
		ajax_footer();
	}
}
if ($step == 2) {
	InitGP(array('name','index'));
	list($keyid['mode'],$keyid['scr'],$keyid['fid']) = explode('_',$index);
	$keyid['fid'] = (int)$keyid['fid'];
	if (!isset($db_modes[$keyid['mode']]) || ($keyid['scr'] == 'cate' && !$keyid['fid'])) {
		Showmsg('undefined_action');
	}
	list($tname,$loopid) = explode(',',$name);
	$pw_invokepiece	= L::loadDB('invokepiece');
	$invokepiece = $pw_invokepiece->getDatasByInvokeName($tname);
	empty($invokepiece) && Showmsg('undefined_action');
	$subtitle = $mInvok = array();$invokeparam = $firstKey = '';
	if (count($invokepiece)>1) {
		foreach ($invokepiece as $value) {
			$invokeparam .= $value['id'].':'.$value['num'].',';
			$subtitle[$value['id']] = $value['title'];
			if ($firstKey === '') {
				$firstKey = $value['id'];
				$mInvok = $value;
			}
		}
	} else{
		$mInvok = current($invokepiece);
	}
	$invokeparam = '{'.trim($invokeparam,',').'}';

	$attimages = array();
	$read = $db->get_one("SELECT * FROM pw_threads WHERE tid=".pwEscape($selid));
	empty($read) && Showmsg('data_error');
	$cateid = getCateid($read['fid']);
	if (!checkEditAdmin($windid,$groupid,$cateid)) {
		Showmsg('admin_forum_right');
	}
	$read['postdate'] = get_date($read['postdate']);
	$read['url'] = 'read.php?tid='.$read['tid'];
	$pw_tmsgs = GetTtable($read['tid']);
	$content = $db->get_value("SELECT content FROM $pw_tmsgs WHERE tid=".pwEscape($read['tid'],false));
	require_once R_P.'require/bbscode.php';
	$content = convert($content, $db_windpost);
	$content = substrs(strip_tags($content),300,'N');
	$query = $db->query("SELECT attachurl FROM pw_attachs WHERE uid=".pwEscape($read['authorid'],false)." AND tid=".pwEscape($read['tid'],false)." AND type='img' LIMIT 5");
	while ($rt = $db->fetch_array($query)) {
		$a_url = geturl($rt['attachurl'],'show');
		if ($a_url != 'nopic') {
			$attimages[$rt['attachurl']] = is_array($a_url) ? $a_url[0] : $a_url;
		}
	}
	$selTitle = '';
	if ($keyid['scr'] == 'index') {
		$selTitle = $db_modes[$keyid['mode']]['m_name'].getLangInfo('other','pushto_index');
	} elseif ($keyid['scr'] == 'cate') {
		$selTitle = $forum[$keyid['fid']]['name'];
	}
	$selTitle .= ' -&gt; '.$tname . ($loopid ? ' -&gt; ' . $forum[$loopid]['name'] : '');
	$index = $keyid['mode'].'_'.$keyid['scr'].'_'.$keyid['fid'];

	$reason_sel = '';
	$reason_a   = explode("\n",$db_adminreason);
	foreach ($reason_a as $k => $v) {
		if ($v = trim($v)) {
			$reason_sel .= "<option value=\"$v\">$v</option>";
		} else {
			$reason_sel .= "<option value=\"\">-------</option>";
		}
	}

	require_once R_P.'require/header.php';
	require_once areaLoadFrontView($action);
	footer();

} elseif ($step == 3) {
	InitGP(array('subject','content','ifmsg','titleid','offset','index','invokename','endtime'));
	InitGP(array('url','attachurl','cimgurl'),'P',0);
	$url 		= str_replace('&#61;','=',$url);
	$attachurl 	= str_replace('&#61;','=',$attachurl);
	$cimgurl 	= str_replace('&#61;','=',$cimgurl);
	list($invoke,$loopid) = explode(',',$invokename);
	$loopid = intval($loopid);
	$pw_invokepiece	= L::loadDB('invokepiece');
	$invokepiece = $pw_invokepiece->getDatasByInvokeName($invoke);
	(empty($invokepiece) || !isset($invokepiece[$titleid])) && Showmsg('undefined_action');
	$offset = (int)$offset;
	$mInvoke = $invokepiece[$titleid];
	if ($offset < 1 || $offset > $mInvoke['num']) {
		$offset = 1;
	}
	if ($endtime) {
		$endtime	= PwStrtoTime($endtime);
		if ($endtime == -1) {
			$endtime = 0;
		}
	}
	$read = $db->get_one("SELECT * FROM pw_threads WHERE tid=".pwEscape($selid));
	empty($read) && Showmsg('data_error');
	$cateid = getCateid($read['fid']);
	$cateid = getCateid($read['fid']);
	if (!checkEditAdmin($windid,$groupid,$cateid)) {
		Showmsg('admin_forum_right');
	}
	$custom = array();
	foreach ($mInvoke['param'] as $key=>$value) {
		switch ($key) {
			case 'title':
				$custom[$key] = $subject;
				break;
			case 'url':
				$custom[$key] = $url;
				break;
			case 'descrip':
				$custom[$key] = $content;
				break;
			case 'image':
				$custom[$key] = $cimgurl;
				break;
			case 'author':
				$custom[$key] = $read['author'];
				break;
			case 'forumname':
				$custom[$key] = $forum[$read['fid']]['name'];
				break;

		}
	}
	if ($custom) {
		$mInvoke['rang'] != 'fid' && $cateid = 0;
		$pw_pushdata	= L::loadDB('pushdata');
		$pw_cachedata	= L::loadDB('cachedata');
		$pw_pushdata->insertData(array('invokepieceid'=>$mInvoke['id'],'fid'=>$cateid,'loopid'=>$loopid,'uid'=>$winduid,'offset'=>$offset-1,'starttime'=>$timestamp,'endtime'=>$endtime,'data'=>$custom));
		$pw_cachedata->deleteData($mInvoke['id'],$cateid,$loopid);
	}
	if ($ifmsg) {
		$msgdb = array(
			'toUser'	=> $read['author'],
			'subject'	=> 'pushto_title',
			'content'	=> 'pushto_content',
			'other'		=> array(
				'manager'	=> $windid,
				'fid'		=> $read['fid'],
				'tid'		=> $read['tid'],
				'subject'	=> $read['subject'],
				'postdate'	=> get_date($read['postdate']),
				'forum'		=> strip_tags($forum[$fid]['name']),
				'admindate'	=> get_date($timestamp),
				'reason'	=> stripslashes($atc_content)
			)
		);
		pwSendMsg($msgdb);
	}
	$logdb[] = array(
		'type'      => 'pushto',
		'username1' => $read['author'],
		'username2' => $windid,
		'field1'    => $read['fid'],
		'field2'    => $read['tid'],
		'field3'    => '',
		'descrip'   => 'pushto_descrip',
		'timestamp' => $timestamp,
		'ip'        => $onlineip,
		'tid'		=> $read['tid'],
		'subject'	=> substrs($read['subject'],28),
		'forum'		=> $forum[$read['fid']]['name'],
		'reason'	=> stripslashes($atc_content)
	);
	writelog($log);
	refreshto("read.php?tid=".$read['tid'],'operate_success');
}

include areaLoadFrontView($action);

footer();
?>