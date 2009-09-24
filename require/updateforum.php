<?php
!function_exists('readover') && exit('Forbidden');

function updateforum($fid,$lastinfo='') {//TODO 慢查询
	global $db,$db_fcachenum;
	$fm = $db->get_one("SELECT fup,type,password,allowvisit,f_type FROM pw_forums WHERE fid=".pwEscape($fid));
	if ($fm['type'] != 'category') {
		$subtopics = $subrepliess = 0;
		$query = $db->query("SELECT fid FROM pw_forums WHERE fup=".pwEscape($fid));
		while ($subinfo = $db->fetch_array($query)) {
			@extract($db->get_one("SELECT COUNT(*) AS subtopic,SUM( replies ) AS subreplies FROM pw_threads WHERE fid=".pwEscape($subinfo['fid'])." AND ifcheck='1'"));
			$subtopics   += $subtopic;
			$subrepliess += $subreplies;
			$query2 = $db->query("SELECT fid FROM pw_forums WHERE fup=".pwEscape($subinfo['fid']));
			while ($subinfo2 = $db->fetch_array($query2)) {
				@extract($db->get_one("SELECT COUNT(*) AS subtopic,SUM( replies ) AS subreplies FROM pw_threads WHERE fid=".pwEscape($subinfo2['fid'])." AND ifcheck='1'"));
				$subtopics   += $subtopic;
				$subrepliess += $subreplies;
			}
		}
		$rs       = $db->get_one("SELECT COUNT(*) AS topic,SUM( replies ) AS replies FROM pw_threads WHERE fid=".pwEscape($fid)."AND ifcheck='1' AND topped<=3");
		$topic    = $rs['topic'];
		$replies  = $rs['replies'];
		$article  = $topic + $replies + $subtopics + $subrepliess;
		if (!$lastinfo) {
			$lt = $db->get_one("SELECT tid,author,postdate,lastpost,lastposter,subject FROM pw_threads WHERE fid=".pwEscape($fid)." AND topped=0 AND ifcheck=1 AND lastpost>0 ORDER BY lastpost DESC LIMIT 1");
			if ($lt['postdate'] == $lt['lastpost']) {
				$subject = addslashes(substrs($lt['subject'],26));
			} else {
				$subject = 'Re:'.addslashes(substrs($lt['subject'],26));
			}
			$author  = addslashes($lt['lastposter']);
			$lastinfo = $lt['tid'] ? $subject."\t".$author."\t".$lt['lastpost']."\t"."read.php?tid=$lt[tid]&page=e#a" : '' ;
		}
		$db->update("UPDATE pw_forumdata"
			. " SET ".pwSqlSingle(array(
					'topic'		=> $topic,
					'article'	=> $article,
					'subtopic'	=> $subtopics,
					'lastpost'	=> $lastinfo
				))
			. " WHERE fid=".pwEscape($fid));
		if ($fm['password'] != '' || $fm['allowvisit'] != '' || $fm['f_type'] == 'hidden') {
			$lastinfo = '';
		}
		delfcache($fid,$db_fcachenum);
		if ($fm['type'] == 'sub' || $fm['type'] == 'sub2') {
			updateforum($fm['fup'],$lastinfo);
		}
	}
}

function updateForumCount($fid, $topic, $replies) {
	global $db,$db_fcachenum;
	$fm = $db->get_one("SELECT fup,type,password,allowvisit,f_type FROM pw_forums WHERE fid=" . pwEscape($fid));
	if ($fm['type'] == 'category') {
		return false;
	}
	delfcache($fid,$db_fcachenum);
	$topic = intval($topic);
	$article = $topic + intval($replies);
	
	$lastpost = '';
	$lt = $db->get_one("SELECT tid,author,postdate,lastpost,lastposter,subject FROM pw_threads WHERE fid=" . pwEscape($fid) . " AND topped='0' AND ifcheck='1' AND lastpost>0 ORDER BY lastpost DESC LIMIT 1");
	if ($lt) {
		if ($lt['postdate'] == $lt['lastpost']) {
			$subject = substrs($lt['subject'], 26);
		} else {
			$subject = 'Re:'.substrs($lt['subject'],26);
		}
		$lastpost = ",lastpost=" . pwEscape($subject."\t".$lt['lastposter']."\t".$lt['lastpost']."\t"."read.php?tid=$lt[tid]&page=e#a");
	}
	$db->update("UPDATE pw_forumdata SET article=article+'$article',topic=topic+'$topic'{$lastpost} WHERE fid=" . pwEscape($fid));

	if (($fm['type'] == 'sub' || $fm['type'] == 'sub2') && $fids = getUpFids($fid)) {
		if ($fm['password'] != '' || $fm['allowvisit'] != '' || $fm['f_type'] == 'hidden') {
			$lastpost = '';
		}
		$db->update("UPDATE pw_forumdata SET article=article+'$article',subtopic=subtopic+'$topic'{$lastpost} WHERE fid IN(" . pwImplode($fids) . ')');
	}
}

function getUpFids($fid) {
	global $forum;
	isset($forum) || include_once(D_P . 'data/bbscache/forum_cache.php');
	$upfids = array();
	$fid = $forum[$fid]['fup'];
	while (in_array($forum[$fid]['type'], array('sub2','sub','forum'))) {
		$upfids[] = $fid;
		$fid = $forum[$fid]['fup'];
	}
	return $upfids;
}

function updateshortcut() {
	global $db,$db_shortcutforum;
	PwNewDB();
	$array = array();
	$query = $db->query("SELECT f.fid,f.name FROM pw_forums f LEFT JOIN pw_forumdata fd ON f.fid=fd.fid WHERE f.f_type='forum' AND f.password='' AND f.allowvisit='' ORDER BY fd.tpost DESC LIMIT 6");
	while ($rt = $db->fetch_array($query)) {
		$array[$rt['fid']] = strip_tags($rt['name']);
	}
	empty($array) && $array[0] = '';

	if ($db_shortcutforum <> $array) {
		require_once(R_P.'admin/cache.php');
		setConfig('db_shortcutforum', $array);
		updatecache_c();
	}
	return $array;
}
function delfcache($fid,$num) {
	if ($num < 1) return;
	for ($i=1;$i<=$num;$i++) {
		P_unlink(D_P."data/bbscache/fcache_{$fid}_{$i}.php");
	}
}
function updatetop() {
	global $db;
	include(D_P.'data/bbscache/forum_cache.php');

	$fids = $toppeddb = $fupdb = $topfid = $fups = array();
	foreach ($forum as $f => $v) {
		if ($v['type'] == 'category') continue;
		$fids[] = $f;
		$fup = $v['fup'];
		if ($forum[$fup]['type'] == 'category') {
			$cateid = $fup;
		} elseif ($forum[$fup]['type'] == 'forum') {
			$cateid = $forum[$fup]['fup'];
		} elseif ($forum[$fup]['type'] == 'sub') {
			$fup = $forum[$fup]['fup'];
			$cateid = $forum[$fup]['fup'];
		}
		$fupdb[$f] = $cateid;
		$fups[$cateid][] = $f;
	}
	if ($fids) {
		$fids = pwImplode($fids);
		$query = $db->query("SELECT tid,fid,topped FROM pw_threads WHERE fid IN($fids) AND ifcheck='1' AND topped>'1'");
		while ($rt = $db->fetch_array($query)) {
			$topfid[$rt['fid']]['0']++;
			if ($rt['topped'] == '3') {
				$toppeddb['3'][0]++;
				$toppeddb['3'][1] .= $toppeddb['3'][1] ? ','.$rt['tid'] : $rt['tid'];
			} elseif ($rt['topped'] == '2') {
				$cateid = $fupdb[$rt['fid']];
				$toppeddb['2'][$cateid][0]++;
				$toppeddb['2'][$cateid][1] .= $toppeddb['2'][$cateid][1] ? ','.$rt['tid'] : $rt['tid'];
				foreach ($fups[$cateid] as $k => $f) {
					$topfid[$f]['1']++;
				}
			}
		}
		writeover(D_P.'data/bbscache/toppeddb.php',"<?php\r\n\$toppeddb=".pw_var_export($toppeddb).";\r\n?>");

		$db->update("UPDATE pw_forumdata SET ".pwSqlSingle(array('top1'=>$toppeddb['3'][0],'top2'=>0)));
		foreach ($topfid as $key => $v) {
			$top2 = $v['0'];
			$top1 = $toppeddb['3'][0] + $v['1'] - $v['0'];
			$db->update("UPDATE pw_forumdata SET ".pwSqlSingle(array('top1'=>(int)$top1,'top2'=>(int)$top2))." WHERE fid=".pwEscape($key));
		}
	}
}
function getattachtype($tid) {
	global $db;
	$type = $db->get_value("SELECT type FROM pw_attachs WHERE tid=".pwEscape($tid,false)."ORDER BY aid LIMIT 1");
	if ($type) {
		switch($type) {
			case 'img': $r=1;break;
			case 'txt': $r=2;break;
			case 'zip': $r=3;break;
			default:$r=0;
		}
	} else {
		$r = false;
	}
	return $r;
}
function delete_tag($tids) {
	global $db;
	if ($tids) {
		$tagdb = array();
		$query = $db->query("SELECT tagid FROM pw_tagdata WHERE tid IN($tids)");
		while (@extract($db->fetch_array($query))) {
			$tagdb[$tagid]++;
		}
		foreach ($tagdb as $tagid=>$num) {
			$db->update("UPDATE pw_tags SET num=num-".pwEscape($num)." WHERE tagid=".pwEscape($tagid));
		}
		$db->update("DELETE FROM pw_tagdata WHERE tid IN($tids)");
	}
}
function delete_att($attachdb,$ifdel = true) {
	$delaids = array();
	foreach ($attachdb as $key => $value) {
		is_numeric($key) && $delaids[] = $key;
		if ($ifdel) {
			pwDelatt($value['attachurl'],$GLOBALS['db_ifftp']);
			$value['ifthumb'] && pwDelatt("thumb/$value[attachurl]",$GLOBALS['db_ifftp']);
		}
	}
	if ($delaids) {
		$pw_attachs = L::loadDB('attachs');
		if ($ifdel) {
			$pw_attachs->delete($delaids);
		} else {
			$pw_attachs->updateById($delaids,array('fid'=>0));
		}
	}
	return $delaids;
}
?>