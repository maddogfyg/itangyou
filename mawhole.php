<?php
if (isset($_GET['ajax'])) {
	define('AJAX','1');
}
require_once('global.php');
$groupid == 'guest' && Showmsg('not_login');

InitGP(array('action','tidarray','seltid','viewbbs'));
$viewbbs = $viewbbs ? "&viewbbs=$viewbbs" : "";

if (!$tidarray && is_numeric($seltid)) {
	$tidarray = array($seltid);
}
if (!in_array($action,array('type','check','del','move','copy','headtopic','digest','lock','pushtopic', 'downtopic','edit','unite','push')) || empty($fid) || empty($tidarray)) {
	Showmsg('undefined_action');
}

require_once(R_P.'require/forum.php');
require_once(R_P.'require/updateforum.php');
require_once(R_P.'require/msg.php');
require_once(R_P.'require/writelog.php');
include_once(D_P.'data/bbscache/forum_cache.php');

if (!($foruminfo = L::forum($fid))) {
	Showmsg('data_error');
}
(!$foruminfo || $foruminfo['type'] == 'category') && Showmsg('data_error');
wind_forumcheck($foruminfo);

$isGM = CkInArray($windid,$manager);
$isBM = admincheck($foruminfo['forumadmin'],$foruminfo['fupadmin'],$windid);
if (!$isGM) {
	switch ($action) {
		case 'type' :
			$admincheck = pwRights($isBM,'tpctype');
			break;
		case 'del' :
			$admincheck = pwRights($isBM,'delatc');
			break;
		case 'check' :
			$admincheck = pwRights($isBM,'tpccheck');
			break;
		case 'move' :
			$admincheck = pwRights($isBM,'moveatc');
			break;
		case 'copy' :
			$admincheck = pwRights($isBM,'copyatc');
			break;
		case 'headtopic' :
			$admincheck = pwRights($isBM,'topped');
			break;
		case 'unite' :
			$admincheck = pwRights($isBM,'unite');
			break;
		case 'push' :
			$admincheck = $isBM || $groupid == '3' || $groupid == '4';
			break;
		case 'digest' :
			$admincheck = pwRights($isBM,'digestadmin');
			break;
		case 'lock' :
			$admincheck = pwRights($isBM,'lockadmin');
			break;
		case 'pushtopic' :
			$admincheck = pwRights($isBM,'pushadmin');
			break;
		case 'edit' :
			$admincheck = pwRights($isBM,'coloradmin');
			break;
		case 'downtopic' :
			$admincheck = pwRights($isBM,'downadmin');
			break;
		default :
			$admincheck = false;
	}
	!$admincheck && Showmsg('mawhole_right');
}


$tids = $threaddb = array();
$mgdate		= get_date($timestamp,'Y-m-d');
$template	= 'ajax_mawhole';

if (empty($_POST['step'])) {
	$reason_sel = '';
	$reason_a   = explode("\n",$db_adminreason);
	foreach ($reason_a as $k => $v) {
		if ($v = trim($v)) {
			$reason_sel .= "<option value=\"$v\">$v</option>";
		} else {
			$reason_sel .= "<option value=\"\">-------</option>";
		}
	}
	foreach ($tidarray as $k => $v) {
		is_numeric($v) && $tids[] = $v;
	}
	if ($tids) {
		$tids = pwImplode($tids);
		$query = $db->query("SELECT * FROM pw_threads WHERE tid IN($tids)");
		while ($rt = $db->fetch_array($query)) {
			if ($rt['fid'] != $fid && $groupid == 5) {
				Showmsg('admin_forum_right');
			}
			if ($groupid != 3 && $groupid != 4) {
				$authordb = $db->get_one('SELECT groupid FROM pw_members WHERE uid='.pwEscape($rt['authorid']));
				if ($authordb['groupid'] == 3 || $authordb['groupid'] == 4) {
					Showmsg('modify_admin');
				}
			}
			$rt['date'] = get_date($rt['postdate']);
			$threaddb[] = $rt;
		}
	}
	empty($threaddb) && Showmsg('data_error');

	if (!defined('AJAX')) {
		require_once(R_P.'require/header.php');
		$template = 'mawhole';
	}
} else {
	InitGP(array('atc_content'),'P');
	if ($db_enterreason && !$atc_content) {
		Showmsg('enterreason');
	}
}

if ($action == 'type') {
	include_once(D_P.'data/bbscache/cache_post.php');
	$t_db = $topic_type_cache[$fid];
	if (empty($_POST['step'])) {

		$typesel  = '';
		if ($t_db) {
			foreach ($t_db as $value) {
				if ($value['upid'] == 0) {
					$t_typedb[$value['id']] = $value;
				} else {
					$t_subtypedb[$value['upid']][$value['id']] = $value['name'];
				}
				$t_exits = 1;
			}
		} else {
			Showmsg('mawhole_notype');
		}

		if ($t_subtypedb) {
			$t_subtypedb = pwJsonEncode($t_subtypedb);
			$t_sub_exits = 1;
		}

		require_once PrintEot($template);footer();

	} else {

		PostCheck();
		InitGP(array('type','subtype','ifmsg'));
		count($tidarray) > 500 && Showmsg('mawhole_count');
		$tids = array();
		if (is_array($tidarray)) {
			foreach ($tidarray as $key => $value) {
				is_numeric($value) && $tids[] = $value;
			}
		}
		$type = $subtype ? $subtype : $type;
		!$tids && Showmsg('mawhole_nodata');
		$db->update('UPDATE pw_threads SET type='.pwEscape($type)." WHERE tid IN(".pwImplode($tids).") AND fid=".pwEscape($fid));

		$threads = L::loadClass('Threads');
		$threads->delThreads($tids);

		if ($ifmsg) {
			$query = $db->query("SELECT tid,fid,author,authorid,subject,postdate FROM pw_threads WHERE tid IN(".pwImplode($tids).")");
			while (@extract($db->fetch_array($query))) {
				$msgdb[] = array(
					'toUser'	=> $author,
					'subject'	=> 'change_type_title',
					'content'	=> 'change_type_content',
					'other'		=> array(
						'manager'	=> $windid,
						'fid'		=> $fid,
						'tid'		=> $tid,
						'postdate'	=> get_date($postdate),
						'subject'	=> $subject,
						'forum'		=> strip_tags($forum[$fid]['name']),
						'admindate'	=> get_date($timestamp),
						'reason'	=> stripslashes($atc_content),
						'type'		=> $t_db[$type]['name'],
					)
				);
			}
			foreach ($msgdb as $key => $val) {
				pwSendMsg($val);
			}
		}
		refreshto("thread.php?fid=$fid{$viewbbs}",'operate_success');
	}
} elseif ($action == 'check') {

	if (empty($_POST['step'])) {

		require_once PrintEot('mawhole');footer();

	} else {

		PostCheck();
		InitGP(array('ifmsg'));
		count($tidarray) > 500 && Showmsg('mawhole_count');
		$tids  = array();
		$count = 0;
		if (is_array($tidarray)) {
			foreach ($tidarray as $key => $value) {
				if (is_numeric($value)) {
					$tids[] = $value;
					$count++;
				}
			}
		}
		!$tids && Showmsg('mawhole_nodata');
		$db->update("UPDATE pw_threads SET ifcheck='1' WHERE tid IN(".pwImplode($tids).") AND fid=".pwEscape($fid));
		$threadList = L::loadClass("threadlist");
		$threadList->refreshThreadIdsByForumId($fid);
		$threads = L::loadClass('Threads');
		$threads->delThreads($tids);
		$rt = $db->get_one("SELECT tid,author,postdate,subject,lastpost,lastposter FROM pw_threads WHERE fid='$fid' AND ifcheck='1' AND topped='0' AND lastpost>0 ORDER BY lastpost DESC LIMIT 0,1");
		if ($rt['postdate'] == $rt['lastpost']) {
			$subject = substrs($rt['subject'],21);
			$author  = $rt['author'];
		} else {
			$subject = 'Re:'.substrs($rt['subject'],21);
			$author  = $rt['lastposter'];
		}
		$new_url  = "read.php?tid=$rt[tid]&page=e#a";
		$lastpost = $subject."\t".$author."\t".$rt['lastpost']."\t".$new_url;
		$db->update('UPDATE pw_forumdata '
			. ' SET lastpost='.pwEscape($lastpost,false)
			. ',tpost=tpost+'.$count
			. ',article=article+'.$count
			. ',topic=topic+'.$count
			. ' WHERE fid='.pwEscape($fid)
		);
		P_unlink(D_P.'data/bbscache/c_cache.php');

		if ($ifmsg) {
			$query = $db->query("SELECT tid,fid,author,authorid,subject,postdate FROM pw_threads WHERE tid IN(".pwImplode($tids).")");
			while (@extract($db->fetch_array($query))) {
				$msgdb[] = array(
					'toUser'	=> $author,
					'subject'	=> 'check_title',
					'content'	=> 'check_content',
					'other'		=> array(
						'manager'	=> $windid,
						'fid'		=> $fid,
						'tid'		=> $tid,
						'postdate'	=> get_date($postdate),
						'subject'	=> $subject,
						'forum'		=> strip_tags($forum[$fid]['name']),
						'admindate'	=> get_date($timestamp),
						'reason'	=> stripslashes($atc_content),
					)
				);
			}
			foreach ($msgdb as $key => $val) {
				pwSendMsg($val);
			}
		}
		refreshto("thread.php?fid=$fid{$viewbbs}",'operate_success');
	}
} elseif ($action == 'del') {

	if (empty($_POST['step'])) {

		require_once PrintEot($template);footer();

	} else {

		PostCheck();
		InitGP(array('ifdel','ifmsg'));
		count($tidarray) > 500 && Showmsg('mawhole_count');

		$delids = $msgdb = array();
		foreach ($tidarray as $key => $value) {
			if (is_numeric($value)) {
				$delids[] = $value;
			}
		}
		!$delids && Showmsg('mawhole_nodata');

		require_once(R_P.'require/credit.php');
		$creditset = $credit->creditset($foruminfo['creditset'],$db_creditset);
		$msg_delrvrc  = $ifdel ? abs($creditset['Delete']['rvrc']) : 0;
		$msg_delmoney = $ifdel ? abs($creditset['Delete']['money']) : 0;
		
		$delarticle = L::loadClass('DelArticle');
		$readdb = $delarticle->getTopicDb('tid ' . $delarticle->sqlFormatByIds($delids));

		foreach ($readdb as $key => $read) {
			$read['fid'] != $fid && Showmsg('admin_forum_right');
			if ($ifmsg) {
				$msgdb[] = array(
					'toUser'	=> $read['author'],
					'subject'	=> 'del_title',
					'content'	=> 'del_content',
					'other'		=> array(
						'manager'	=> $windid,
						'fid'		=> $read['fid'],
						'tid'		=> $read['tid'],
						'subject'	=> $read['subject'],
						'postdate'	=> get_date($read['postdate']),
						'forum'		=> strip_tags($forum[$fid]['name']),
						'affect'    => "{$db_rvrcname}:-{$msg_delrvrc},{$db_moneyname}:-{$msg_delmoney}",
						'admindate'	=> get_date($timestamp),
						'reason'	=> stripslashes($atc_content)
					)
				);
			}
			$logdb[] = array(
				'type'      => 'delete',
				'username1' => $read['author'],
				'username2' => $windid,
				'field1'    => $fid,
				'field2'    => $read['tid'],
				'field3'    => '',
				'descrip'   => 'del_descrip',
				'timestamp' => $timestamp,
				'ip'        => $onlineip,
				'affect'    => "{$db_rvrcname}：-{$msg_delrvrc}，{$db_moneyname}：-{$msg_delmoney}",
				'tid'		=> $read['tid'],
				'subject'	=> substrs($read['subject'],28),
				'forum'		=> $forum[$fid]['name'],
				'reason'	=> stripslashes($atc_content)
			);
			if ($ifdel) {
				$credit->addLog('topic_Delete', $creditset['Delete'], array(
					'uid'		=> $read['authorid'],
					'username'	=> $read['author'],
					'ip'		=> $onlineip,
					'fname'		=> strip_tags($forum[$fid]['name']),
					'operator'	=> $windid
				));
				$credit->sets($read['authorid'], $creditset['Delete'], false);
			}
		}
		$delarticle->delTopic($readdb, $db_recycle);
		$credit->runsql();

		foreach ($msgdb as $key => $val) {
			pwSendMsg($val);
		}
		foreach ($logdb as $key => $val) {
			writelog($val);
		}
		if ($db_ifpwcache ^ 1) {
			$db->update("DELETE FROM pw_elements WHERE type !='usersort' AND id IN(" . pwImplode($delids) . ')');
		}
		P_unlink(D_P.'data/bbscache/c_cache.php');

		if (!defined('AJAX')) {
			refreshto("thread.php?fid=$fid{$viewbbs}",'operate_success');
		} else {
			Showmsg('ajax_operate_success');
		}
	}
} elseif ($action == 'move') {

	if (empty($_POST['step'])) {
		include_once(D_P.'data/bbscache/cache_post.php');
		if ($topic_type_cache) {
			foreach ($topic_type_cache as $key => $value) {
				foreach ($value as $k => $v) {
					if ($v['upid'] == 0) {
						$t_typedb[$key][$k] = $v['name'];
					} else {
						$t_subtypedb[$key][$v['upid']][$k] = $v['name'];
					}
				}
			}
		}

		if ($t_typedb) {
			$t_typedb = pwJsonEncode($t_typedb);
		}
		if ($t_subtypedb) {
			$t_subtypedb = pwJsonEncode($t_subtypedb);
		}


		$forumadd = '';
		$query = $db->query("SELECT fid,t_type,name,allowvisit,f_type FROM pw_forums");
		while ($rt = $db->fetch_array($query)) {
			if ($rt['f_type'] == 'hidden' && strpos($rt['allowvisit'],','.$groupid.',') !== false) {
				$forumadd .= "<option value='$rt[fid]'> &nbsp;|- $rt[name]</option>";
			}
		}
		@include_once(D_P.'data/bbscache/forumcache.php');
		require_once PrintEot($template);footer();

	} else {

		PostCheck();
		InitGP(array('to_id','ifmsg','to_threadcate','to_subtype'));

		if ($forum[$to_id]['type'] == 'category') {
			Showmsg('mawhole_error');
		}
		count($tidarray) > 500 && Showmsg('mawhole_count');
		$mids = $ttable_a = $ptable_a = $msgdb = array();
		if (is_array($tidarray)) {
			foreach ($tidarray as $key => $value) {
				if (is_numeric($value)) {
					$mids[] = $value;
					$ttable_a[GetTtable($value)][] = $value;
				}
			}

		}

		!$mids && Showmsg('mawhole_nodata');

		$threads = L::loadClass('Threads');
		$threads->delThreads($mids);

		$pw_attachs = L::loadDB('attachs');
		$pw_attachs->updateByTid($mids,array('fid'=>$to_id));

		$mids = pwImplode($mids);
		$updatetop = 0;
		$query     = $db->query("SELECT tid,fid as tfid,author,postdate,subject,replies,topped,ptable FROM pw_threads WHERE tid IN($mids)");
		while ($rt = $db->fetch_array($query)) {
			Add_S($rt);
			@extract($rt);
			$tfid != $fid && Showmsg('admin_forum_right');
			$ptable_a[$ptable] = 1;
			$topped > 1 && $updatetop = 1;
			// 静态模版更新
			if ($foruminfo['allowhtm'] == 1) {
				$date = date('ym',$postdate);
				$htmurldel = R_P.$db_htmdir.'/'.$fid.'/'.$date.'/'.$tid.'.html';
				P_unlink($htmurldel);
			}
			$toname = strip_tags($forum[$to_id]['name']);
			if ($ifmsg) {
				$msgdb[] = array(
					'toUser'	=> $author,
					'subject'	=> 'move_title',
					'content'	=> 'move_content',
					'other'		=> array(
						'manager'	=> $windid,
						'fid'		=> $fid,
						'tid'		=> $tid,
						'tofid'		=> $to_id,
						'subject'	=> $subject,
						'postdate'	=> get_date($postdate),
						'forum'		=> strip_tags($forum[$fid]['name']),
						'toforum'	=> $toname,
						'admindate'	=> get_date($timestamp),
						'reason'	=> stripslashes($atc_content)
					)
				);
			}
			$logdb[] = array(
				'type'      => 'move',
				'username1' => $author,
				'username2' => $windid,
				'field1'    => $fid,
				'field2'    => $tid,
				'field3'    => '',
				'descrip'   => 'move_descrip',
				'timestamp' => $timestamp,
				'ip'        => $onlineip,
				'tid'		=> $tid,
				'subject'	=> substrs($subject,28),
				'tofid'		=> $to_id,
				'toforum'	=> $toname,
				'forum'		=> $forum[$fid]['name'],
				'reason'	=> stripslashes($atc_content)
			);
		}
		foreach ($msgdb as $key => $val) {
			pwSendMsg($val);
		}
		foreach ($logdb as $key => $val) {
			writelog($val);
		}
		$remindinfo = strip_tags(getLangInfo('other','mawhole_move'));
		$to_threadcate = $to_subtype ? $to_subtype : $to_threadcate;
		$db->update("UPDATE pw_threads SET fid=".pwEscape($to_id).",type=".pwEscape($to_threadcate)." WHERE tid IN($mids)");

		foreach ($ttable_a as $pw_tmsgs => $val) {
			$val = pwImplode($val);
			$db->update("UPDATE $pw_tmsgs SET remindinfo=".pwEscape($remindinfo)." WHERE tid IN($val)");
		}
		foreach ($ptable_a as $key => $val) {
			$pw_posts = GetPtable($key);
			$db->update("UPDATE $pw_posts SET fid=".pwEscape($to_id)." WHERE tid IN($mids)");
		}
		updateforum($fid);
		updateforum($to_id);
		if ($updatetop) {
			updatetop();
		}
		P_unlink(D_P.'data/bbscache/c_cache.php');
		if (!defined('AJAX')) {
			refreshto("thread.php?fid=$fid{$viewbbs}",'operate_success');
		} else {
			Showmsg("ajax_operate_success");
		}
	}
} elseif ($action == 'copy') {

	if (empty($_POST['step'])) {

		include_once(D_P.'data/bbscache/cache_post.php');
		if ($topic_type_cache) {
			foreach ($topic_type_cache as $key => $value) {
				foreach ($value as $k => $v) {
					if ($v['upid'] == 0) {
						$t_typedb[$key][$k] = $v['name'];
					} else {
						$t_subtypedb[$key][$v['upid']][$k] = $v['name'];
					}
				}
			}
		}

		if ($t_typedb) {
			$t_typedb = pwJsonEncode($t_typedb);
		}
		if ($t_subtypedb) {
			$t_subtypedb = pwJsonEncode($t_subtypedb);
		}

		$forumadd  = '';

		$query = $db->query("SELECT fid,t_type,name,allowvisit,f_type FROM pw_forums");
		while ($rt = $db->fetch_array($query)) {
			if ($rt['f_type'] == 'hidden' && strpos($rt['allowvisit'],','.$groupid.',') !== false) {
				$forumadd .= "<option value='$rt[fid]'> &nbsp;|- $rt[name]</option>";
			}
		}
		@include_once(D_P.'data/bbscache/forumcache.php');
		require_once PrintEot($template);footer();

	} else {

		PostCheck();
		InitGP(array('to_id','ifmsg','to_threadcate','to_subtype'));
		if ($forum[$to_id]['type'] == 'category') {
			Showmsg('mawhole_error');
		}
		count($tidarray) > 500 && Showmsg('mawhole_count');
		$selids = '';
		$readdb = $ttable_a = array();
		foreach ($tidarray as $k=>$v) {
			if (is_numeric($v)) {
				$selids .= $selids ? ','.$v : $v;
				$ttable_a[GetTtable($v)][] = $v;
			}
		}
		!$selids && Showmsg('mawhole_nodata');
		$updatetop = 0;
		$ufid = $fid;
		$to_threadcate = $to_subtype ? $to_subtype : $to_threadcate;
		foreach ($ttable_a as $pw_tmsgs => $val) {
			$val = pwImplode($val);
			$query = $db->query("SELECT * FROM pw_threads t LEFT JOIN $pw_tmsgs tm ON tm.tid=t.tid WHERE t.tid IN($val)");
			while ($rt = $db->fetch_array($query)) {
				$ufid != $rt['fid'] && Showmsg('admin_forum_right');
				$readdb[] = $rt;
			}
		}
		foreach ($readdb as $key => $read) {
			@extract($read);
			$topped > 1 && $updatetop = 1;
			$toname = $forum[$to_id]['name'];
			if ($ifmsg) {
				$msgdb[] =array(
					'toUser'	=> $author,
					'subject'	=> 'copy_title',
					'content'	=> 'copy_content',
					'other'		=> array(
						'manager'	=> $windid,
						'fid'		=> $fid,
						'tid'		=> $tid,
						'tofid'		=> $to_id,
						'subject'	=> $subject,
						'postdate'	=> get_date($postdate),
						'forum'		=> strip_tags($forum[$fid]['name']),
						'toforum'	=> $toname,
						'admindate'	=> get_date($timestamp),
						'reason'	=> stripslashes($atc_content)
					)
				);
			}
			$logdb[] = array(
				'type'      => 'copy',
				'username1' => $author,
				'username2' => $windid,
				'field1'    => $fid,
				'field2'    => $tid,
				'field3'    => '',
				'descrip'   => 'copy_descrip',
				'timestamp' => $timestamp,
				'ip'        => $onlineip,
				'tid'		=> $tid,
				'subject'	=> substrs($subject,28),
				'tofid'		=> $to_id,
				'toforum'	=> $toname,
				'forum'		=> $forum[$fid]['name'],
				'reason'	=> stripslashes($atc_content)
			);
			$pwSQL = pwSqlSingle(array(
				'fid'		=> $to_id,		'icon'		=> $icon,
				'titlefont'	=> $titlefont,	'author'	=> $author,
				'authorid'	=> $authorid,	'subject'	=> $subject,
				'ifcheck'	=> $ifcheck,	'type'      => $to_threadcate,
				'postdate'	=> $postdate,   'lastpost'	=> $lastpost,
				'lastposter'=> $lastposter, 'hits'		=> $hits,
				'replies'	=> $replies,    'topped'	=> $topped,
				'locked'	=> $locked,     'digest'	=> $digest,
				'special'	=> $special,    'ifupload'	=> $ifupload,
				'ifmail'	=> $ifmail,     'ifshield'	=> $ifshield,
				'anonymous'	=> $anonymous,  'ptable'	=> $db_ptable
			),false);

			$db->update("INSERT INTO pw_threads SET $pwSQL");
			$newtid = $db->insert_id();
			# memcache refresh
			$threadList = L::loadClass("threadlist");
                        $threadList->updateThreadIdsByForumId($to_id,$newtid);

			$aid    = str_replace("'","\'",$aid);
			/*
			if ($special == 1) {
				$rs = $db->get_one("SELECT voteopts,state,modifiable,previewable,timelimit FROM pw_polls WHERE tid=".pwEscape($tid));
				$pwSQL = pwSqlSingle(array(
					'tid'			=> $newtid,
					'voteopts'		=> $rs['voteopts'],
					'state'			=> $rs['state'],
					'modifiable'	=> $rs['modifiable'],
					'previewable'	=> $rs['previewable'],
					'timelimit'		=> $rs['timelimit']
				),false);
				$db->update("INSERT INTO pw_polls SET $pwSQL");
			}
			*/
			if ($special == 1) {
				$rs = $db->get_one("SELECT voteopts,modifiable,previewable,multiple,mostvotes,voters,timelimit,leastvotes,regdatelimit,creditlimit,postnumlimit FROM pw_polls WHERE tid=".pwEscape($tid));
				$pwSQL = pwSqlSingle(array(
					'tid'			=> $newtid,
					'voteopts'		=> $rs['voteopts'],
					'modifiable'	=> $rs['modifiable'],
					'previewable'	=> $rs['previewable'],
					'multiple'		=> $rs['multiple'],
					'mostvotes'		=> $rs['mostvotes'],
					'voters'		=> $rs['voters'],
					'timelimit'		=> $rs['timelimit'],
					'leastvotes'	=> $rs['leastvotes'],
					'regdatelimit'	=> $rs['regdatelimit'],
					'creditlimit'	=> $rs['creditlimit'],
					'postnumlimit'	=> $rs['postnumlimit']
				),false);
				$db->update("INSERT INTO pw_polls SET $pwSQL");

				$query = $db->query("SELECT * FROM pw_voter WHERE tid=".pwEscape($tid));
				while ($rt = $db->fetch_array($query)) {
					$rt['tid'] = $newtid;
					$voterdb[] = $rt;
				}
				$voterdb && $db->update("INSERT INTO pw_voter(tid,uid,username,vote,time) VALUES".pwSqlMulti($voterdb));
			}



			$remindinfo = strip_tags(getLangInfo('other','mawhole_copy'));
			$pw_tmsgs   = GetTtable($newtid);
			$pwSQL = pwSqlSingle(array(
				'tid'		=> $newtid,		'aid'		=> $aid,
				'userip'	=> $userip,		'ifsign'	=> $ifsign,
				'buy'		=> $buy,		'ipfrom'	=> $ipfrom,
				'remindinfo'=> $remindinfo,	'ifconvert'	=> $ifconvert,
				'content'	=> $content
			),false);
			$db->update("INSERT INTO $pw_tmsgs SET $pwSQL");

			$pw_posts = GetPtable($ptable);
			$query2   = $db->query("SELECT * FROM $pw_posts WHERE tid=".pwEscape($tid));
			$pw_posts = GetPtable($db_ptable);
			while ($rt = $db->fetch_array($query2)) {
				@extract($rt);
				if ($db_plist) {
					$db->update("INSERT INTO pw_pidtmp(pid) values('')");
					$pid = $db->insert_id();
				} else {
					$pid = '';
				}
				$pwSQL = pwSqlSingle(array(
					'pid'		=> $pid,		'fid'		=> $to_id,
					'tid'		=> $newtid,		'aid'		=> $aid,
					'author'	=> $author,		'authorid'	=> $authorid,
					'icon'		=> $icon,		'postdate'	=> $postdate,
					'subject'	=> $subject,	'userip'	=> $userip,
					'ifsign'	=> $ifsign,		'alterinfo'	=> $alterinfo,
					'remindinfo'=> $remindinfo,	'ipfrom'	=> $ipfrom,
					'ifconvert'	=> $ifconvert,	'ifcheck'	=> $ifcheck,
					'content'	=> $content,	'ifshield'	=> $ifshield,
					'anonymous'	=> $anonymous
				),false);
				$db->update("INSERT INTO $pw_posts SET $pwSQL");
			}
		}
		foreach ($msgdb as $key => $val) {
			pwSendMsg($val);
		}
		foreach ($logdb as $key => $val) {
			writelog($val);
		}
		updateforum($to_id);
		if ($updatetop) {
			updatetop();
		}
		refreshto("thread.php?fid=$fid{$viewbbs}",'operate_success');
	}
} elseif ($action == 'headtopic') {

	if (empty($_POST['step'])) {

		if (is_numeric($seltid)) {
			$rt = $db->get_one('SELECT fid,topped FROM pw_threads WHERE tid='.pwEscape($seltid));
			if ($fid != $rt['fid']) {
				Showmsg('admin_forum_right');
			}
			${'topped_'.$rt['topped']} = 'checked';
		}
		require_once PrintEot($template);footer();

	} else {

		PostCheck();
		InitGP(array('topped','ifmsg','timelimit','nextto'));
		$topped = intval($topped);
		$pwTopped = $isGM ? '3' : pwRights($isBM,'topped');
		if ($topped > $pwTopped) {
			Showmsg('masigle_top');
		}
		count($tidarray) > 500 && Showmsg('mawhole_count');
		$tids = $selids = $ttable_a = array();
		if (is_array($tidarray)) {
			foreach ($tidarray as $k => $v) {
				if (is_numeric($v)) {
					$selids[] = $v;
					$ttable_a[GetTtable($v)][] = $v;
				}
			}
			$selids = pwImplode($selids);
		}
		!$selids && Showmsg('mawhole_nodata');

		$msgdb = $logdb = array();
		$updatetop = 0;
		$toolfield = $timelimit>0 && $topped ? $timelimit*86400 + $timestamp : '';

		$query = $db->query("SELECT tid,fid,postdate,author,authorid,subject,topped,toolfield FROM pw_threads WHERE tid IN($selids)");
		while ($rt = $db->fetch_array($query)) {
			if ($rt['topped'] > $pwTopped) {
				Showmsg('masigle_top');
			}
			if ($fid != $rt['fid']) {
				Showmsg('admin_forum_right');
			}
			if ($topped > 1 || $rt['topped'] > 1) {
				$updatetop = 1;
			}
			if ($topped && $topped != $rt['topped']) {
				if ($ifmsg) {
					$msgdb[] = array(
						'toUser'	=> $rt['author'],
						'subject'	=> 'top_title',
						'content'	=> 'top_content',
						'other'		=> array(
							'manager'	=> $windid,
							'fid'		=> $fid,
							'tid'		=> $rt['tid'],
							'subject'	=> $rt['subject'],
							'postdate'	=> get_date($rt['postdate']),
							'forum'		=> strip_tags($forum[$fid]['name']),
							'admindate'	=> get_date($timestamp),
							'reason'	=> stripslashes($atc_content)
						)
					);
				}
				$logdb[] = array(
					'type'      => 'topped',
					'username1' => $rt['author'],
					'username2' => $windid,
					'field1'    => $fid,
					'field2'    => $tid,
					'field3'    => '',
					'descrip'   => 'topped_descrip',
					'timestamp' => $timestamp,
					'ip'        => $onlineip,
					'topped'	=> $topped,
					'tid'		=> $rt['tid'],
					'subject'	=> substrs($rt['subject'],28),
					'forum'		=> $forum[$fid]['name'],
					'reason'	=> stripslashes($atc_content)
				);
			} elseif ($rt['topped'] && !$topped) {
				if ($ifmsg) {
					$msgdb[] = array(
						'toUser'	=> $rt['author'],
						'subject'	=> 'untop_title',
						'content'	=> 'untop_content',
						'other'		=> array(
							'manager'	=> $windid,
							'fid'		=> $fid,
							'tid'		=> $rt['tid'],
							'subject'	=> $rt['subject'],
							'postdate'	=> get_date($rt['postdate']),
							'forum'		=> strip_tags($forum[$fid]['name']),
							'admindate'	=> get_date($timestamp),
							'reason'	=> stripslashes($atc_content)
						)
					);
				}
				$logdb[] = array(
					'type'      => 'topped',
					'username1' => $rt['author'],
					'username2' => $windid,
					'field1'    => $fid,
					'field2'    => $rt['tid'],
					'field3'    => '',
					'descrip'   => 'untopped_descrip',
					'timestamp' => $timestamp,
					'ip'        => $onlineip,
					'tid'		=> $rt['tid'],
					'subject'	=> substrs($rt['subject'],28),
					'forum'		=> $forum[$fid]['name'],
					'reason'	=> stripslashes($atc_content)
				);
			}
			if ($toolfield || $rt['toolfield']) {
				$t = explode(',',$rt['toolfield']);
				$rt['toolfield'] = $toolfield.','.$t[1];
				$pwSQL = pwSqlSingle(array(
					'topped'	=> $topped,
					'toolfield'	=> $rt['toolfield']
				));
				$db->update("UPDATE pw_threads SET $pwSQL WHERE tid=".pwEscape($rt['tid']));
				$threads = L::loadClass('Threads');
				$threads->delThreads($rt['tid']);
			} else {
				$tids[] = $rt['tid'];
			}
		}
		foreach ($msgdb as $key => $val) {
			pwSendMsg($val);
		}
		foreach ($logdb as $key => $val) {
			writelog($val);
		}
		$remindinfo = $topped ? getLangInfo('other','mawhole_top_2') : getLangInfo('other','mawhole_top_1');

		if ($tids) {
			$threads = L::loadClass('Threads');
			$threads->delThreads($tids);
			$tids = pwImplode($tids);
			$db->update("UPDATE pw_threads SET topped=".pwEscape($topped)."WHERE tid IN($tids)");
			$threadList = L::loadClass("threadlist");
			$threadList->refreshThreadIdsByForumId($fid);
		}
		foreach ($ttable_a as $pw_tmsgs => $val) {
			$val = pwImplode($val);
			$db->update("UPDATE $pw_tmsgs SET remindinfo=".pwEscape($remindinfo)."WHERE tid IN($val)");
		}
		$updatetop && updatetop();
		delfcache($fid,$db_fcachenum);

		if ($nextto && count($tidarray) == 1) {
			$selids = reset($tidarray);
			if (!defined('AJAX')) {
				refreshto("mawhole.php?action=$nextto&fid=$fid&seltid=$selids{$viewbbs}",'operate_success');
			} else {
				Showmsg("ajax_nextto");
			}
		} else {
			refreshto("thread.php?fid=$fid{$viewbbs}",'operate_success');
		}
	}
} elseif ($action == 'digest') {

	if (empty($_POST['step'])) {

		if (is_numeric($seltid)) {
			$rt = $db->get_one('SELECT fid,digest FROM pw_threads WHERE tid='.pwEscape($seltid));
			if ($fid != $rt['fid']) {
				Showmsg('admin_forum_right');
			}
			${'digest_'.intval($rt['digest'])} = 'checked';
		}
		require_once PrintEot($template);footer();

	} else {

		PostCheck();
		InitGP(array('digest','ifmsg','nextto'));
		count($tidarray) > 500 && Showmsg('mawhole_count');
		$selids = $ttable_a = array();
		if (is_array($tidarray)) {
			foreach ($tidarray as $k => $v) {
				if (is_numeric($v)) {
					$selids[] = $v;
					$ttable_a[GetTtable($v)][] = $v;
				}
			}
		}
		!$selids && Showmsg('mawhole_nodata');

		$threads = L::loadClass('Threads');
		$threads->delThreads($selids);
		$selids = pwImplode($selids);
		require_once(R_P.'require/credit.php');
		$creditset = $credit->creditset($foruminfo['creditset'],$db_creditset);

		$add_rvrc  = (int)$creditset['Digest']['rvrc'];
		$add_money = (int)$creditset['Digest']['money'];
		$del_rvrc  = abs($creditset['Undigest']['rvrc']);
		$del_money = abs($creditset['Undigest']['money']);

		$msgdb = $logdb = array();
		$query = $db->query("SELECT tid,fid,postdate,author,authorid,subject,digest FROM pw_threads WHERE tid IN($selids)");
		while ($rt = $db->fetch_array($query)) {
			if ($fid != $rt['fid']) {
				Showmsg('admin_forum_right');
			}
			if (!$rt['digest'] && $digest) {
				if ($ifmsg) {
					$msgdb[] = array(
						'toUser'	=> $rt['author'],
						'subject'	=> 'digest_title',
						'content'	=> 'digest_content',
						'other'		=> array(
							'manager'	=> $windid,
							'fid'		=> $fid,
							'tid'		=> $rt['tid'],
							'subject'	=> $rt['subject'],
							'postdate'	=> get_date($rt['postdate']),
							'forum'		=> strip_tags($forum[$fid]['name']),
							'affect'    => "{$db_rvrcname}：+{$add_rvrc}，{$db_moneyname}：+{$add_money}",
							'admindate'	=> get_date($timestamp),
							'reason'	=> stripslashes($atc_content)
						)
					);
				}
				$credit->addLog('topic_Digest',$creditset['Digest'],array(
					'uid'		=> $rt['authorid'],
					'username'	=> $rt['author'],
					'ip'		=> $onlineip,
					'fname'		=> strip_tags($forum[$fid]['name']),
					'operator'	=> $windid
				));
				$credit->sets($rt['authorid'],$creditset['Digest'],false);
				$credit->setMdata($rt['authorid'],'digests',1);

				$logdb[] = array(
					'type'      => 'digest',
					'username1' => $rt['author'],
					'username2' => $windid,
					'field1'    => $fid,
					'field2'    => $rt['tid'],
					'field3'    => '',
					'descrip'   => 'digest_descrip',
					'timestamp' => $timestamp,
					'ip'        => $onlineip,
					'digest'	=> $digest,
					'affect'    => "{$db_rvrcname}：+{$add_rvrc}，{$db_moneyname}：+{$add_money}",
					'tid'		=> $rt['tid'],
					'digest'	=> $digest,
					'subject'	=> substrs($rt['subject'],28),
					'forum'		=> $forum[$fid]['name'],
					'reason'	=> stripslashes($atc_content)
				);
			} elseif ($rt['digest'] && !$digest) {
				if ($ifmsg) {
					$msgdb[] = array(
						'toUser'	=> $rt['author'],
						'subject'	=> 'undigest_title',
						'content'	=> 'undigest_content',
						'other'		=> array(
							'manager'	=> $windid,
							'fid'		=> $fid,
							'tid'		=> $rt['tid'],
							'subject'	=> $rt['subject'],
							'postdate'	=> get_date($rt['postdate']),
							'forum'		=> strip_tags($forum[$fid]['name']),
							'affect'    => "{$db_rvrcname}：-{$del_rvrc}，{$db_moneyname}：-{$del_money}",
							'admindate'	=> get_date($timestamp),
							'reason'	=> stripslashes($atc_content)
						)
					);
				}
				$credit->addLog('topic_Undigest',$creditset['Undigest'],array(
					'uid'		=> $rt['authorid'],
					'username'	=> $rt['author'],
					'ip'		=> $onlineip,
					'fname'		=> strip_tags($forum[$fid]['name']),
					'operator'	=> $windid
				));
				$credit->sets($rt['authorid'],$creditset['Undigest'],false);
				$credit->setMdata($rt['authorid'],'digests',-1);

				$logdb[] = array(
					'type'      => 'digest',
					'username1' => $rt['author'],
					'username2' => $windid,
					'field1'    => $fid,
					'field2'    => $rt['tid'],
					'field3'    => '',
					'descrip'   => 'undigest_descrip',
					'timestamp' => $timestamp,
					'ip'        => $onlineip,
					'affect'    => "{$db_rvrcname}：-{$del_rvrc}，{$db_moneyname}：-{$del_money}",
					'tid'		=> $rt['tid'],
					'subject'	=> substrs($rt['subject'],28),
					'forum'		=> $forum[$fid]['name'],
					'reason'	=> stripslashes($atc_content)
				);
			}
		}
		$credit->runsql();

		foreach ($msgdb as $key => $val) {
			pwSendMsg($val);
		}
		foreach ($logdb as $key => $val) {
			writelog($val);
		}
		$remindinfo = $digest ? getLangInfo('other','mawhole_digest_2') : getLangInfo('other','mawhole_digest_1');
		$db->update("UPDATE pw_threads SET digest=".pwEscape($digest)." WHERE tid IN($selids)",0);
		foreach ($ttable_a as $pw_tmsgs=>$val) {
			$val = pwImplode($val);
			$db->update("UPDATE $pw_tmsgs SET remindinfo=".pwEscape($remindinfo)." WHERE tid IN($val)");
		}

		if ($nextto && count($tidarray) == 1) {
			$selids = reset($tidarray);
			if (!defined('AJAX')) {
				refreshto("mawhole.php?action=$nextto&fid=$fid&seltid=$selids{$viewbbs}",'operate_success');
			} else {
				Showmsg("ajax_nextto");
			}
		} else {
			refreshto("thread.php?fid=$fid{$viewbbs}",'operate_success');
		}
	}
} elseif ($action == 'lock') {

	if (empty($_POST['step'])) {

		if (is_numeric($seltid)) {
			$rt = $db->get_one('SELECT fid,locked FROM pw_threads WHERE tid='.pwEscape($seltid));
			if ($fid != $rt['fid']) {
				Showmsg('admin_forum_right');
			}
			$rt['locked'] %= 3;
			${'lock_'.$rt['locked']} = 'checked';
		}
		require_once PrintEot($template);footer();

	} else {

		PostCheck();
		InitGP(array('locked','ifmsg'));
		count($tidarray) > 500 && Showmsg('mawhole_count');
		$selids = $ttable_a = array();
		if (is_array($tidarray)) {
			foreach ($tidarray as $k => $v) {
				if (is_numeric($v)) {
					$selids[] = $v;
					$ttable_a[GetTtable($v)][] = $v;
				}
			}
		}
		!$selids && Showmsg('mawhole_nodata');

		$threads = L::loadClass('Threads');
		$threads->delThreads($selids);

		$selids = pwImplode($selids);
		$msgdb = $logdb = array();
		$query = $db->query("SELECT tid,fid,postdate,author,authorid,subject,locked FROM pw_threads WHERE tid IN($selids)");
		while ($rt = $db->fetch_array($query)) {
			if ($fid != $rt['fid']) {
				Showmsg('admin_forum_right');
			}
			if ($rt['locked']%3 <> $locked && $locked) {
				if ($locked == 2) {
					P_unlink(R_P."$db_htmdir/$fid/".date('ym',$rt['postdate'])."/$tid.html");
				}
				$s = $rt['locked'] > 2 ? $locked + 3 : $locked;
				$db->update('UPDATE pw_threads SET locked='.pwEscape($s).' WHERE tid='.pwEscape($rt['tid']));
				if ($ifmsg) {
					$msgdb[] = array(
						'toUser'	=> $rt['author'],
						'subject'	=> 'lock_title',
						'content'	=> 'lock_content',
						'other'		=> array(
							'manager'	=> $windid,
							'fid'		=> $fid,
							'tid'		=> $rt['tid'],
							'subject'	=> $rt['subject'],
							'postdate'	=> get_date($rt['postdate']),
							'forum'		=> strip_tags($forum[$fid]['name']),
							'admindate'	=> get_date($timestamp),
							'reason'	=> stripslashes($atc_content)
						)
					);
				}
				$logdb[] = array(
					'type'      => 'locked',
					'username1' => $rt['author'],
					'username2' => $windid,
					'field1'    => $fid,
					'field2'    => $rt['tid'],
					'field3'    => '',
					'descrip'   => 'lock_descrip',
					'timestamp' => $timestamp,
					'ip'        => $onlineip,
					'tid'		=> $rt['tid'],
					'subject'	=> substrs($rt['subject'],28),
					'forum'		=> $forum[$fid]['name'],
					'reason'	=> stripslashes($atc_content)
				);
			} elseif ($rt['locked']%3 <> 0 && !$locked) {
				$s = $rt['locked'] > 2 ? 3 : 0;
				$db->update("UPDATE pw_threads SET locked='$s' WHERE tid=".pwEscape($rt['tid']));
				if ($ifmsg) {
					$msgdb[] = array(
						'toUser'	=> $rt['author'],
						'subject'	=> 'unlock_title',
						'content'	=> 'unlock_content',
						'other'		=> array(
							'manager'	=> $windid,
							'fid'		=> $fid,
							'tid'		=> $rt['tid'],
							'subject'	=> $rt['subject'],
							'postdate'	=> get_date($rt['postdate']),
							'forum'		=> strip_tags($forum[$fid]['name']),
							'admindate'	=> get_date($timestamp),
							'reason'	=> stripslashes($atc_content)
						)
					);
				}
				$logdb[] = array(
					'type'      => 'locked',
					'username1' => $rt['author'],
					'username2' => $windid,
					'field1'    => $fid,
					'field2'    => $rt['tid'],
					'field3'    => '',
					'descrip'   => 'unlock_descrip',
					'timestamp' => $timestamp,
					'ip'        => $onlineip,
					'tid'		=> $rt['tid'],
					'subject'	=> substrs($rt['subject'],28),
					'forum'		=> $forum[$fid]['name'],
					'reason'	=> stripslashes($atc_content)
				);
			}
		}
		foreach ($msgdb as $key => $val) {
			pwSendMsg($val);
		}
		foreach ($logdb as $key => $val) {
			writelog($val);
		}
		$remindinfo = getLangInfo('other','mawhole_locked_'.$locked);
		foreach ($ttable_a as $pw_tmsgs => $val) {
			$val = pwImplode($val);
			$db->update("UPDATE $pw_tmsgs SET remindinfo=".pwEscape($remindinfo)."WHERE tid IN($val)");
		}
		refreshto("thread.php?fid=$fid{$viewbbs}",'operate_success');
	}
} elseif ($action == 'pushtopic') {

	if (empty($_POST['step'])) {

		require_once PrintEot($template);footer();

	} else {

		PostCheck();
		InitGP(array('ifmsg','nextto','pushtime'));
		count($tidarray) > 500 && Showmsg('mawhole_count');
		$selids = $ttable_a = array();
		if (is_array($tidarray)) {
			foreach ($tidarray as $k => $v) {
				if (is_numeric($v)) {
					$selids[] = $v;
					$ttable_a[GetTtable($v)][] = $v;
				}
			}
			$selids = pwImplode($selids);
		}
		!$selids && Showmsg('mawhole_nodata');
		$msgdb = $logdb = array();
		$query = $db->query("SELECT tid,fid,postdate,author,authorid,subject FROM pw_threads WHERE tid IN($selids)");
		while ($rt = $db->fetch_array($query)) {
			if ($fid != $rt['fid']) {
				Showmsg('admin_forum_right');
			}
			if ($ifmsg) {
				$msgdb[] = array(
					'toUser'	=> $rt['author'],
					'subject'	=> 'push_title',
					'content'	=> 'push_content',
					'other'		=> array(
						'manager'	=> $windid,
						'fid'		=> $fid,
						'tid'		=> $rt['tid'],
						'subject'	=> $rt['subject'],
						'postdate'	=> get_date($rt['postdate']),
						'forum'		=> strip_tags($forum[$fid]['name']),
						'admindate'	=> get_date($timestamp),
						'reason'	=> stripslashes($atc_content)
					)
				);
			}
			$logdb[] = array(
				'type'      => 'push',
				'username1' => $rt['author'],
				'username2' => $windid,
				'field1'    => $fid,
				'field2'    => $rt['tid'],
				'field3'    => '',
				'descrip'   => 'push_descrip',
				'timestamp' => $timestamp,
				'ip'        => $onlineip,
				'tid'		=> $rt['tid'],
				'subject'	=> substrs($rt['subject'],28),
				'forum'		=> $forum[$fid]['name'],
				'reason'	=> stripslashes($atc_content)
			);
		}
		foreach ($msgdb as $key => $val) {
			pwSendMsg($val);
		}
		foreach ($logdb as $key => $val) {
			writelog($val);
		}
		$remindinfo = getLangInfo('other','mawhole_push');
		$pushtime < 0 && $pushtime = 1;
		$uptime = $timestamp+$pushtime*3600;
		$db->update("UPDATE pw_threads SET lastpost=".pwEscape($uptime)."WHERE tid IN($selids)");
		# memcache refresh
		$threadList = L::loadClass("threadlist");
		$threadList->refreshThreadIdsByForumId($fid);

		foreach ($ttable_a as $pw_tmsgs => $val) {
			$val = pwImplode($val);
			$db->update("UPDATE $pw_tmsgs SET remindinfo=".pwEscape($remindinfo)."WHERE tid IN($val)");
		}
		delfcache($fid,$db_fcachenum);

		if ($nextto && count($tidarray) == 1) {
			$selids = reset($tidarray);
			if (!defined('AJAX')) {
				refreshto("mawhole.php?action=$nextto&fid=$fid&seltid=$selids{$viewbbs}",'operate_success');
			} else {
				Showmsg("ajax_nextto");
			}
		} else {
			refreshto("thread.php?fid=$fid{$viewbbs}",'operate_success');
		}
	}
} elseif ($action == 'downtopic') {

	if (empty($_POST['step'])) {

		if (is_numeric($seltid)) {
			$rt = $db->get_one("SELECT locked FROM pw_threads WHERE tid=".pwEscape($seltid));
			if ($rt['locked']>2) {$lock_1 = 'checked';}else {$lock_0 = 'checked';}
		} else {
			$lock_0 = 'checked';
		}
		require_once PrintEot($template);footer();

	} else {

		PostCheck();
		InitGP(array('ifmsg','nextto','timelimit','ifpush'));
		count($tidarray) > 500 && Showmsg('mawhole_count');
		$selids = $ttable_a = array();
		if (is_array($tidarray)) {
			foreach ($tidarray as $k => $v) {
				if (is_numeric($v)) {
					$selids[] = $v;
					$ttable_a[GetTtable($v)][] = $v;
				}
			}
			$selids = pwImplode($selids);
		}
		!$selids && Showmsg('mawhole_nodata');
		$timelimit < 0 && $timelimit = 24;
		$downtime = $timelimit * 3600;
		$msgdb = $logdb = array();
		$query = $db->query("SELECT tid,fid,postdate,author,authorid,subject,locked FROM pw_threads WHERE tid IN($selids)");
		while ($rt = $db->fetch_array($query)) {
			if ($fid != $rt['fid']) {
				Showmsg('admin_forum_right');
			}
			$sql = ",locked='".($ifpush ? ($rt['locked']%3 + 3) : $rt['locked']%3)."'";
			$db->update("UPDATE pw_threads SET lastpost=lastpost-".pwEscape($downtime)." $sql WHERE tid=".pwEscape($rt['tid']));
			# memcache refresh
			$threadList = L::loadClass("threadlist");
                        $threadList->updateThreadIdsByForumId($fid,$tid);

			if ($ifmsg) {
				$msgdb[] = array(
					'toUser'	=> $rt['author'],
					'subject'	=> 'down_title',
					'content'	=> 'down_content',
					'other'		=> array(
						'manager'	=> $windid,
						'timelimit'	=> $timelimit,
						'fid'		=> $fid,
						'tid'		=> $rt['tid'],
						'subject'	=> $rt['subject'],
						'postdate'	=> get_date($rt['postdate']),
						'forum'		=> strip_tags($forum[$fid]['name']),
						'admindate'	=> get_date($timestamp),
						'reason'	=> stripslashes($atc_content)
					)
				);
			}
			$logdb[] = array(
				'type'      => 'down',
				'username1' => $rt['author'],
				'username2' => $windid,
				'field1'    => $fid,
				'field2'    => $rt['tid'],
				'field3'    => '',
				'descrip'   => 'down_descrip',
				'timestamp' => $timestamp,
				'ip'        => $onlineip,
				'tid'		=> $rt['tid'],
				'subject'	=> substrs($rt['subject'],28),
				'forum'		=> $forum[$fid]['name'],
				'reason'	=> stripslashes($atc_content)
			);
		}
		foreach ($msgdb as $key => $val) {
			pwSendMsg($val);
		}
		foreach ($logdb as $key => $val) {
			writelog($val);
		}
		$remindinfo = getLangInfo('other','mawhole_down');

		foreach ($ttable_a as $pw_tmsgs => $val) {
			$val = pwImplode($val);
			$db->update("UPDATE $pw_tmsgs SET remindinfo=".pwEscape($remindinfo)." WHERE tid IN($val)");
		}
		delfcache($fid,$db_fcachenum);
		refreshto("thread.php?fid=$fid{$viewbbs}",'operate_success');
	}
} elseif ($action == 'edit') {

	if (empty($_POST['step'])) {

		if (is_numeric($seltid)) {
			$rt = $db->get_one("SELECT fid,titlefont,author FROM pw_threads WHERE tid=".pwEscape($seltid));
			if ($fid != $rt['fid']) {
				Showmsg('admin_forum_right');
			}
			$titledetail = explode("~",$rt['titlefont']);
			$titlecolor = $titledetail[0];
			if ($titlecolor && !preg_match('/\#[0-9A-F]{6}/is',$titlecolor)) {
				$titlecolor = '';
			}
			if ($titledetail[1]=='1') {
				$stylename[1]='b one';
			} else {
				$stylename[1]='b';
			}
			if ($titledetail[2]=='1') {
				$stylename[2]='u one';
			} else {
				$stylename[2]='u';
			}
			if ($titledetail[3]=='1') {
				$stylename[3]='one';
			} else {
				$stylename[3]='';
			}
		}
		require_once PrintEot($template);footer();

	} else {
		PostCheck();
		InitGP(array('title1','title2','title3','title4','nextto','ifmsg','timelimit'));
		count($tidarray) > 500 && Showmsg('mawhole_count');

		$selids = $tids = $ttable_a = array();
		if (is_array($tidarray)) {
			foreach ($tidarray as $k => $v) {
				if (is_numeric($v)) {
					$selids[] = $v;
					$ttable_a[GetTtable($v)][] = $v;
				}
			}
		}
		$selids = pwImplode($selids);
		if ($title1 && !preg_match('/#[0-9A-F]{6}/is',$title1)) {
			Showmsg('mawhole_nodata');
		}
		!$selids && Showmsg('mawhole_nodata');

		$threads = L::loadClass('Threads');
		$threads->delThreads($selids);

		$titlefont = Char_cv("$title1~$title2~$title3~$title4~$title5~$title6~");
		$ifedit = (!$title1 && !$title2 && !$title3 && !$title4) ? 0 : 1;
		$toolfield = $timelimit>0 && $ifedit ? $timelimit*86400 + $timestamp : '';

		$msgdb = $logdb = array();
		$query = $db->query("SELECT tid,fid,postdate,author,authorid,subject,toolfield FROM pw_threads WHERE tid IN($selids)");
		while ($rt = $db->fetch_array($query)) {
			if ($fid != $rt['fid']) {
				Showmsg('admin_forum_right');
			}
			if ($ifmsg) {
				$msgdb[] = array(
					'toUser'	=> $rt['author'],
					'subject'	=> $ifedit ? 'highlight_title' : 'unhighlight_title',
					'content'	=> $ifedit ? 'highlight_content' : 'unhighlight_content',
					'other'		=> array(
						'manager'	=> $windid,
						'fid'		=> $fid,
						'tid'		=> $rt['tid'],
						'subject'	=> $rt['subject'],
						'postdate'	=> get_date($rt['postdate']),
						'forum'		=> strip_tags($forum[$fid]['name']),
						'admindate'	=> get_date($timestamp),
						'reason'	=> stripslashes($atc_content)
					)
				);
			}
			$logdb[] = array(
				'type'      => 'highlight',
				'username1' => $rt['author'],
				'username2' => $windid,
				'field1'    => $fid,
				'field2'    => $rt['tid'],
				'field3'    => '',
				'descrip'   => $ifedit ? 'highlight_descrip' : 'unhighlight_descrip',
				'timestamp' => $timestamp,
				'ip'        => $onlineip,
				'tid'		=> $rt['tid'],
				'subject'	=> substrs($rt['subject'],28),
				'forum'		=> $forum[$fid]['name'],
				'reason'	=> stripslashes($atc_content)
			);
			if ($toolfield || $rt['toolfield']) {
				$t = explode(',',$rt['toolfield']);
				$rt['toolfield'] = $t[0].','.$toolfield;
				$db->update("UPDATE pw_threads SET titlefont=".pwEscape($titlefont).',toolfield='.pwEscape($rt['toolfield']).' WHERE tid='.pwEscape($rt['tid']));
			} else {
				$tids[] = $rt['tid'];
			}
		}
		foreach ($msgdb as $key => $val) {
			pwSendMsg($val);
		}
		foreach ($logdb as $key => $val) {
			writelog($val);
		}
		$remindinfo = getLangInfo('other','mawhole_edit_'.$ifedit);

		if ($tids) {
			$tids = pwImplode($tids);
			$db->update("UPDATE pw_threads SET titlefont=".pwEscape($titlefont)." WHERE tid IN($tids)");
		}
		foreach ($ttable_a as $pw_tmsgs => $val) {
			$val = pwImplode($val);
			$db->update("UPDATE $pw_tmsgs SET remindinfo=".pwEscape($remindinfo)." WHERE tid IN($val)");
		}
		if ($nextto && count($tidarray) == 1) {
			$selids = reset($tidarray);
			if (!defined('AJAX')) {
				refreshto("mawhole.php?action=$nextto&fid=$fid&seltid=$selids{$viewbbs}",'operate_success');
			} else {
				Showmsg("ajax_nextto");
			}
		} else {
			refreshto("thread.php?fid=$fid{$viewbbs}",'operate_success');
		}
	}
} elseif ($action == 'unite') {

	if (empty($_POST['step'])) {

		if (is_numeric($seltid)) {
			$unitetype = 'from';
		} else {
			foreach ($threaddb as $key => $value) {
				if ($value['topped'] || $value['special'] || $value['digest'] || $value['toolinfo']) {
					Showmsg('unite_limit');
				}
			}
			$unitetype = 'to';
		}
		require_once PrintEot($template);footer();

	} else {

		PostCheck();
		InitGP(array('unitetid','unitetype','ifmsg'));
		$totid	  = '';
		$ttable_a = $readdb = array();

		if ($unitetype == 'to') {
			$totid = (int)$unitetid;
			$tidarray[] = $totid;
		} else {
			count($tidarray) > 1 && Showmsg('mawhole_count');
			$totid = $tidarray[0];
			$tidarray = array_merge($tidarray,explode(',',$unitetid));
		}
		foreach ($tidarray as $k => $v) {
			if (is_numeric($v)) {
				$ttable_a[GetTtable($v)][] = $v;
			}
		}
		if (empty($totid) || count($tidarray) < 2) {
			Showmsg('unite_data_error');
		}

		foreach ($ttable_a as $pw_tmsgs => $val) {
			if (empty($val)) continue;
			$val = pwImplode($val);
			$query = $db->query("SELECT * FROM pw_threads t LEFT JOIN $pw_tmsgs tm USING(tid) WHERE t.tid IN($val)");
			while ($rt = $db->fetch_array($query)) {
				$rt['fid'] != $fid && Showmsg('unite_fid_error');
				if ($rt['tid']<>$totid && ($rt['topped'] || $rt['special'] || $rt['digest'] || $rt['toolinfo'])) {
					Showmsg('unite_limit');
				}
				$readdb[$rt['tid']] = $rt;
			}
		}
		$todb = $readdb[$totid];
		unset($readdb[$totid]);

		if (!$todb || !$readdb) {
			Showmsg('data_error');
		}

		$pw_attachs = L::loadDB('attachs');
		$pw_posts = GetPtable($todb['ptable']);
		$remindinfo = getLangInfo('other','mawhole_unite');
		$replies = 0;
		foreach ($readdb as $key => $fromdb) {
			if ($db_plist) {
				$db->update("INSERT INTO pw_pidtmp(pid) values('')");
				$pid = $db->insert_id();
			} else {
				$pid = '';
			}
			$pwSQL = pwSqlSingle(array(
				'pid'		=> $pid,				'fid'		=> $fid,
				'tid'		=> $totid,				'aid'		=> $fromdb['aid'],
				'author'	=> $fromdb['author'],	'authorid'	=> $fromdb['authorid'],
				'icon'		=> $fromdb['icon'],		'postdate'	=> $fromdb['postdate'],
				'subject'	=> $fromdb['subject'],	'userip'	=> $fromdb['userip'],
				'ifsign'	=> $fromdb['ifsign'],	'alterinfo'	=> $fromdb['alterinfo'],
				'ipfrom'	=> $fromdb['ipfrom'],	'ifconvert'	=> $fromdb['ifconvert'],
				'ifcheck'	=> $fromdb['ifcheck'],	'content'	=> $fromdb['content'],
				'ifmark'	=> $fromdb['ifmark'],	'ifshield'	=> $fromdb['ifshield']
			),false);
			$db->update("INSERT INTO $pw_posts SET $pwSQL");
			!$pid && $pid = $db->insert_id();
			$replies += $fromdb['replies']+1;

			# $db->update('DELETE FROM pw_threads WHERE tid='.pwEscape($fromdb['tid']));
			# ThreadManager
                        $threadManager = L::loadClass("threadmanager");
			$threadManager->deleteByThreadId($fromdb['fid'],$fromdb['tid']);

			$pw_tmsgsf = GetTtable($fromdb['tid']);
			$db->update("DELETE FROM $pw_tmsgsf WHERE tid=".pwEscape($fromdb['tid']));

			if ($db_guestread) {
				require_once(R_P.'require/guestfunc.php');
				clearguestcache($fromdb['tid'],$replies);
			}
			if ($todb['ptable'] == $fromdb['ptable']) {
				$db->update("UPDATE $pw_posts SET tid=".pwEscape($totid).' WHERE tid='.pwEscape($fromdb['tid']));
			} else {
				$pw_postsf = GetPtable($fromdb['ptable']);
				$db->update("INSERT INTO $pw_posts SELECT * FROM $pw_postsf WHERE tid=".pwEscape($fromdb['tid']));
				$db->update("UPDATE $pw_posts SET tid=".pwEscape($totid)." WHERE tid=".pwEscape($fromdb['tid']));
				$db->update("DELETE FROM $pw_postsf WHERE tid=".pwEscape($fromdb['tid']));
			}
			if ($fromdb['aid']) {
				$pw_attachs->updateByTid($fromdb['tid'],0,array('pid' => $pid,'tid' => $totid));
			}
			$pw_attachs->updateByTid($fromdb['tid'],array('tid' => $totid));
			if ($ifmsg) {
				$msgdb = array(
					'toUser'	=> $fromdb['author'],
					'subject'	=> 'unite_title',
					'content'	=> 'unite_content',
					'other'		=> array(
						'manager'	=> $windid,
						'fid'		=> $fid,
						'tid'		=> $totid,
						'subject'	=> $todb['subject'],
						'postdate'	=> get_date($todb['postdate']),
						'forum'		=> strip_tags($forum[$fid]['name']),
						'admindate'	=> get_date($timestamp),
						'reason'	=> stripslashes($atc_content)
					)
				);
				pwSendMsg($msgdb);
			}
			$log = array(
				'type'      => 'unite',
				'username1' => $fromdb['author'],
				'username2' => $windid,
				'field1'    => $fid,
				'field2'    => '',
				'field3'    => '',
				'descrip'   => 'unite_descrip',
				'timestamp' => $timestamp,
				'ip'        => $onlineip,
				'tid'		=> $totid,
				'subject'	=> substrs($todb['subject'],28),
				'forum'		=> $forum[$fid]['name'],
				'reason'	=> stripslashes($atc_content)
			);
			writelog($log);
		}
		$db->update("UPDATE pw_threads SET replies=replies+".pwEscape($replies,false)." WHERE tid=".pwEscape($totid));
		$pw_tmsgs = GetTtable($totid);
		$db->update("UPDATE $pw_tmsgs SET remindinfo=".pwEscape($remindinfo,false)." WHERE tid=".pwEscape($totid));

		updateforum($fid);

		$threads = L::loadClass('Threads');
		$threads->delThreads($totid);
		$threads->delThreads($fromdb['tid']);
		if (!defined('AJAX')) {
			refreshto("read.php?tid=$totid{$viewbbs}",'operate_success');
		} else {
			Showmsg('ajax_unite_success');
		}
	}
} elseif ($action == 'getthreadcates') {

	$fid = (int)GetGP('fid');
	if (!($foruminfo = L::forum($fid))) {
		Showmsg('data_error');
	}
	$tcoptions = '';
	if ($foruminfo['t_type']) {
		$t_typedb = explode("\t",$foruminfo['t_type']);
		$t_typedb = array_unique ($t_typedb);
		foreach ($t_typedb as $key => $value) {
			$value && $tcoptions .= '<option value="'.$key.'">'.$value.'</option>';
		}
	}
	echo $tcoptions;exit;
}
?>