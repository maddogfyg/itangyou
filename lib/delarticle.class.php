<?php
!defined('P_W') && exit('Forbidden');

/* 帖子批量删除操作
* fix by sky_hold@163.com
*
*/

class PW_DelArticle {

	var $db;

	function PW_DelArticle() {
		global $db;
		$this->db =& $db;
	}

	function sqlFormatByIds($ids) {
		if (empty($ids)) {
			return '';
		}
		if (!is_array($ids) && !is_numeric($ids)) {
			$ids = explode(',', $ids);
		}
		return is_array($ids) ? "IN(" . pwImplode($ids) . ')' : "=" . pwEscape($ids);
	}

	function getTopicDb($sqlwhere) {
		$readdb = array();
		$query = $this->db->query("SELECT tid,fid,postdate,author,authorid,subject,replies,topped,special,ifupload,ptable,ifcheck,tpcstatus FROM pw_threads WHERE $sqlwhere");
		while ($read = $this->db->fetch_array($query)) {
			$readdb[] = $read;
		}
		return $readdb;
	}

	function delTopicByUids($uids, $recycle = false) {
		if (!$sqlby = $this->sqlFormatByIds($uids)) {
			return;
		}
		$readdb = $this->getTopicDb("authorid $sqlby");
		$this->delTopic($readdb, $recycle);
	}

	function delTopicByTids($tids, $recycle = false) {
		if (!$sqlby = $this->sqlFormatByIds($tids)) {
			return;
		}
		$readdb = $this->getTopicDb("tid $sqlby");
		$this->delTopic($readdb, $recycle);
	}

	function delTopic($readdb, $recycle = false) {
		global $db_htmdir,$db_guestread;
		if ($db_guestread) {
			require_once(R_P.'require/guestfunc.php');
		}
		$updatetop = 0;
		$specialdb = $tids = $fids = $ttable_a = $ptable_a = $recycledb = $delnum = $cydb = array();

		foreach ($readdb as $key => $read) {
			if ($read['special'] > 0 && $read['special'] < 5) {
				$specialdb[$read['special']][] = $read['tid'];
			}
			if ($read['tpcstatus'] && getstatus($read['tpcstatus'], 1)) {
				$cydb[] = $read['tid'];
			}
			$htmurl = R_P . $db_htmdir . '/' . $read['fid'] . '/' . date('ym',$read['postdate']) . '/' . $read['tid'] . '.html';
			if (file_exists($htmurl)) {
				P_unlink($htmurl);
			}
			if ($db_guestread) {
				clearguestcache($read['tid'], $read['replies']);
			}
			if ($recycle) {
				$recycledb[] = array('pid' => 0, 'tid' => $read['tid'], 'fid' => $read['fid'], 'deltime' => $GLOBALS['timestamp'], 'admin' => $GLOBALS['windid']);
			}
			$read['topped'] > 1 && $updatetop = 1;
			$ttable_a[GetTtable($read['tid'])] = 1;
			$ptable_a[$read['ptable']] = 1;
			$fids[$read['fid']]['tids'][] = $read['tid'];
			if ($read['fid'] > 0) {
				$fids[$read['fid']]['replies'] += $read['replies'];
				$read['ifcheck'] && $fids[$read['fid']]['topic']++;
				$delnum[$read['authorid']]++;
			}
			$tids[] = $read['tid'];
		}
		if (!$tids) {
			return true;
		}
		require_once(R_P.'require/updateforum.php');
		$deltids = pwImplode($tids);

		if ($recycle) {
			$this->db->update("UPDATE pw_threads SET fid='0',ifcheck='1',topped='0' WHERE tid IN($deltids)");
			foreach ($ptable_a as $key => $val) {
				$pw_posts = GetPtable($key);
				$this->db->update("UPDATE $pw_posts SET fid='0' WHERE tid IN($deltids)");
			}
			if ($recycledb) {
				$this->db->update("REPLACE INTO pw_recycle (pid,tid,fid,deltime,admin) VALUES " . pwSqlMulti($recycledb));
			}
			// ThreadManager reflesh memcache
			$threadlist = L::loadClass("threadlist");
			foreach ($fids as $fid => $value) {
				$threadlist->refreshThreadIdsByForumId($fid);
			}
			$threads = L::loadClass('Threads');
			$threads->delThreads($tids);
		} else {
			$threadManager = L::loadClass("threadmanager");
			foreach ($fids as $fid => $value) {
				$threadManager->deleteByThreadIds($fid, $value['tids']);
			}
			foreach ($ttable_a as $pw_tmsgs => $val) {
				$this->db->update("DELETE FROM $pw_tmsgs WHERE tid IN($deltids)");
			}
			foreach ($ptable_a as $key => $val) {
				$pw_posts = GetPtable($key);
				$this->db->update("DELETE FROM $pw_posts WHERE tid IN($deltids)");
			}
			if ($specialdb) {
				$this->_delSpecialTopic($specialdb);
			}
			delete_tag($deltids);
			//TODO 这里不是完整的删贴业务，积分等业务未考虑
		}
		if ($cydb) {
			$this->db->update("DELETE FROM pw_argument WHERE tid IN(" . pwImplode($cydb) . ')');
		}

		$usercache = L::loadDB('Usercache');
		$usercache->delByType('topic',$delnum);
		foreach ($delnum as $key => $value) {
			$this->db->update("UPDATE pw_memberdata SET postnum=postnum-" . pwEscape($value) . " WHERE uid=" . pwEscape($key));
		}
		$pw_attachs = L::loadDB('attachs');
		if ($attachdb = $pw_attachs->getByTid($tids)) {
			delete_att($attachdb, !$recycle);
			pwFtpClose($GLOBALS['ftp']);
		}
		if ($updatetop) {
			updatetop();
		}
		foreach ($fids as $fid => $value) {
			updateForumCount($fid, -$value['topic'], -$value['replies']);
		}
	}

	function _delSpecialTopic($specialdb) {
		if (isset($specialdb[1])) {
			$pollids = pwImplode($specialdb[1]);
			$this->db->update("DELETE FROM pw_polls WHERE tid IN($pollids)");
		}
		if (isset($specialdb[2])) {
			$actids = pwImplode($specialdb[2]);
			$this->db->update("DELETE FROM pw_activity WHERE tid IN($actids)");
			$this->db->update("DELETE FROM pw_actmember WHERE actid IN($actids)");
		}
		if (isset($specialdb[3])) {
			$rewids = pwImplode($specialdb[3]);
			$this->db->update("DELETE FROM pw_reward WHERE tid IN($rewids)");
		}
		if (isset($specialdb[4])) {
			$tradeids = pwImplode($specialdb[4]);
			$this->db->update("DELETE FROM pw_trade WHERE tid IN($tradeids)");
		}
	}

	function delReplyByUids($uids, $recycle = false) {
		if (!$sqlby = $this->sqlFormatByIds($uids)) {
			return;
		}
		global $db_plist;
		$ptable_a = array(0);
		if ($db_plist) {
			$p_list = explode(',', $db_plist);
			foreach ($p_list as $val) {
				$ptable_a[] = $val;
			}
		}
		$replydb = array();
		foreach ($ptable_a as $key => $value) {
			$pw_post = GetPtable($value);
			$query = $this->db->query("SELECT pid,fid,tid,aid,author,authorid,postdate,subject,content,anonymous,ifcheck FROM $pw_post WHERE authorid $sqlby");
			while ($rt = $this->db->fetch_array($query)) {
				$rt['ptable'] = $value;
				$replydb[] = $rt;
			}
		}
		$this->delReply($replydb, false, $recycle);
	}

	function delReply($replydb, $recount = true, $recycle = false) {
		$tids = $pids = $_tids = $_pids = $ptable_a = $recycledb = $delfids = $deltids = $deluids = $attachdb = $deltpc = array();
		foreach ($replydb as $key => $reply) {
			$tids[$reply['tid']] = 1;
			if ($reply['pid'] == 'tpc') {
				$reply['pid'] = 0;
			}
			if ($recycle) {
				$recycledb[] = array('pid' => $reply['pid'], 'tid' => $reply['tid'], 'fid' => $reply['fid'], 'deltime' => $GLOBALS['timestamp'], 'admin' => $GLOBALS['windid']);
			}
			if ($reply['pid'] > 0) {
				if ($reply['aid']) {
					$_tids[$reply['tid']] = $reply['tid'];
					$_pids[$reply['pid']] = $reply['pid'];
				}
				if ($reply['fid'] > 0 && $reply['ifcheck']) {
					$deluids[$reply['authorid']]++;
					$delfids[$reply['fid']]['replies']++;
					$deltids[$reply['tid']]++;
				}
				$ptable_a[$reply['ptable']] = 1;
				$pids[] = $reply['pid'];
			} else {
				$reply['fid'] > 0 && $reply['ifcheck'] && $deluids[$reply['authorid']]++;
				$deltpc[] = $reply['tid'];
			}
		}
		if (!$tids) {
			return true;
		}
		require_once(R_P.'require/updateforum.php');
		$delpids = pwImplode($pids);

		if ($recycle) {
			foreach ($ptable_a as $key => $val) {
				$pw_posts = GetPtable($key);
				$this->db->update("UPDATE $pw_posts SET tid='0',fid='0' WHERE pid IN($delpids)");
			}
			if ($recycledb) {
				$this->db->update("REPLACE INTO pw_recycle (pid,tid,fid,deltime,admin) VALUES " . pwSqlMulti($recycledb));
			}
		} else {
			foreach ($ptable_a as $key => $val) {
				$pw_posts = GetPtable($key);
				$this->db->update("DELETE FROM $pw_posts WHERE pid IN($delpids)");
			}
		}
		if ($deltpc) {
			$this->db->update("UPDATE pw_threads SET ifshield='2' WHERE tid IN (" . pwImplode($deltpc) . ')');
			$pw_attachs = L::loadDB('attachs');
			$attachdb += $pw_attachs->getByTid($deltpc, 0);
			!$recycle && delete_tag(pwImplode($deltpc));
		}
		if ($_tids) {
			$pw_attachs = L::loadDB('attachs');
			$attachdb += $pw_attachs->getByTid($_tids, $_pids);
		}
		if ($attachdb) {
			delete_att($attachdb, !$recycle);
			pwFtpClose($GLOBALS['ftp']);
		}
		foreach ($deluids as $uid => $value) {
			$this->db->update("UPDATE pw_memberdata SET postnum=postnum-" . pwEscape($value) . " WHERE uid=" . pwEscape($uid));
		}
		if ($deltopic = $this->delReplyTopic(array_keys($tids), $deltpc, $recount, $recycle)) {
			foreach ($deltopic as $fid => $value) {
				$delfids[$fid]['topic'] = $value;
			}
		}
		if ($delfids) {
			$threadlist = L::loadClass("threadlist");
			foreach ($delfids as $fid => $value) {
				$threadlist->refreshThreadIdsByForumId($fid);
				updateForumCount($fid, -$value['topic'], -$value['replies']);
			}
		}
		if ($deltids && !$recount) {
			foreach ($deltids as $tid => $value) {
				$this->db->update("UPDATE pw_threads SET replies=replies-" . pwEscape($value) . " WHERE tid=" . pwEscape($tid));
			}
		}
		return !empty($deltopic);
	}

	function delReplyTopic($tids, $deltpc, $recount, $recycle = false) {
		if (!$tids) {
			return array();
		}
		global $db_htmdir,$db_guestread;
		$db_guestread && require_once(R_P.'require/guestfunc.php');
		$deltopic = array();
		$query = $this->db->query("SELECT tid,fid,postdate,author,replies,anonymous,ptable FROM pw_threads WHERE tid IN(" . pwImplode($tids) . ")");
		while ($read = $this->db->fetch_array($query)) {
			$htmurl = $db_htmdir.'/'.$read['fid'].'/'.date('ym',$read['postdate']).'/'.$read['tid'].'.html';
			if (file_exists(R_P . $htmurl)) {
				P_unlink(R_P . $htmurl);
			}
			if ($db_guestread) {
				clearguestcache($read['tid'], $read['replies']);
			}
			if ($recount) {
				if ($ret = $this->recountTopic($read, in_array($read['tid'], $deltpc), $recycle)) {
					$deltopic[$read['fid']] += 1;
				}
			}
		}
		$threads = L::loadClass('Threads');
		$threads->delThreads($tids);

		return $deltopic;
	}

	function recountTopic($read, $ifdel, $recycle) {
		global $db_anonymousname;
		$ret = 0;
		$tid = $read['tid'];
		$pw_posts = GetPtable($read['ptable']);
		$replies = $this->db->get_value("SELECT COUNT(*) AS replies FROM $pw_posts WHERE tid='$tid' AND ifcheck='1'");
		if (!$replies) {
			$read['anonymous'] && $read['author'] = $db_anonymousname;
			if ($ifdel) {
				if ($recycle) {
					$this->db->update("UPDATE pw_threads SET fid='0',ifshield='0' WHERE tid='$tid'");
				} else {
					$threadManager = L::loadClass("threadmanager");
					$threadManager->deleteByThreadId($read['fid'], $tid);
					$pw_tmsgs = GetTtable($tid);
					$this->db->update("DELETE FROM $pw_tmsgs WHERE tid='$tid'");
				}
				$ret = 1;
			} else {
				$this->db->update("UPDATE pw_threads SET replies='0',lastpost=postdate,lastposter=".pwEscape($read['author'])." WHERE tid='$tid'");
			}
		} else {
			$pt = $this->db->get_one("SELECT postdate,author,anonymous FROM $pw_posts WHERE tid='$tid' ORDER BY postdate DESC LIMIT 1");
			$pt['anonymous'] && $pt['author'] = $db_anonymousname;
			$pwSQL = pwSqlSingle(array(
				'replies'	=> $replies,
				'lastpost'	=> $pt['postdate'],
				'lastposter'=> $pt['author']
			),false);
			$this->db->update("UPDATE pw_threads SET $pwSQL WHERE tid='$tid'");
		}
		return $ret;
	}
}
?>