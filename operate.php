<?php
if (isset($_GET['ajax'])) {
	define('AJAX','1');
}
require_once('global.php');

!$windid && Showmsg('not_login');
InitGP(array('action'));

$template = 'ajax_operate';

if (empty($_POST['step']) && !defined('AJAX')) {
	require_once(R_P.'require/header.php');
	$template = 'operate';
}

if ($action == 'showping') {

	require_once(R_P.'require/msg.php');
	require_once(R_P.'require/forum.php');
	require_once(R_P.'require/bbscode.php');
	require_once R_P . 'require/pingfunc.php';
	InitGP(array('selid','pid','page'));
	if (empty($selid) && empty($pid)) {
		Showmsg('selid_illegal');
	}
	$jump_pid = $pid ? $pid : $selid[0];

	empty($selid) && $selid = array($pid);
	$pids = $atcdb = array();
	$ptpc = '';
	foreach ($selid as $key => $val) {
		if (is_numeric($val)) {
			$pids[] = $val;
		} else {
			$ptpc = 1;
		}
	}
	$pw_tmsgs = GetTtable($tid);
	$atc = $db->get_one("SELECT t.fid,t.author,t.authorid,t.postdate,t.subject,t.anonymous,t.ptable,tm.ifmark FROM pw_threads t LEFT JOIN $pw_tmsgs tm ON tm.tid=t.tid WHERE t.tid=".pwEscape($tid));
	$fid = $atc['fid'];
	$ptpc && $atcdb['tpc'] = $atc;
	$pw_posts = GetPtable($atc['ptable']);

	if ($pids) {
		$pids = pwImplode($pids);
		$query = $db->query("SELECT pid,fid,author,authorid,postdate,subject,ifmark,anonymous,content FROM $pw_posts WHERE pid IN($pids) AND tid=".pwEscape($tid));
		while ($rt = $db->fetch_array($query)) {
			if (!$rt['subject']) {
				$rt['subject'] = 'RE:'.$atc['subject'];
			}
			$atcdb[$rt['pid']] = $rt;
		}
	}
	empty($atcdb) && Showmsg('data_error');

	if (!($foruminfo = L::forum($fid))) {
		Showmsg('data_error');
	}
	(!$foruminfo || $foruminfo['type'] == 'category') && Showmsg('data_error');
	wind_forumcheck($foruminfo);

	$admincheck = admincheck($foruminfo['forumadmin'],$foruminfo['fupadmin'],$windid);

	require_once(R_P.'require/credit.php');
	$mcredit	= $db->get_one('SELECT credit FROM pw_memberinfo WHERE uid='.pwEscape($winduid));
	$_G['markset'] = unserialize($_G['markset']);

	$creditdb = explode("|",$mcredit['credit']);
	$rcreditdb = array();
	$rcreditnum = 0;
	foreach ($creditdb as $value) {
		$creditvalue = explode("\t",$value);
		$rcreditdb[$creditvalue['2']]['pingdate'] = $creditvalue['0'];
		$rcreditdb[$creditvalue['2']]['pingnum'] = $creditvalue['1'];
		$rcreditdb[$creditvalue['2']]['pingtype'] = $creditvalue['2'];
		$rcreditnum += $creditvalue['1'];
	}

	$i = 0;
	foreach ($_G['markset'] as $key => $value) {
		if ($value['markctype']) {
			if (!$i) {
				$minper = $value['marklimit'][0];
				$maxper = $value['marklimit'][1];
				$maxcredit = $value['maxcredit'];
				if ($rcreditdb[$key]['pingdate'] >= $tdtime) {
					$leavepoint = $jscredit[$key]['leavepoint'] = abs($value['maxcredit'] - $rcreditdb[$key]['pingnum']);
					//$leavepoint == 0 && Showmsg('masigle_nopoint');
				} else {
					$leavepoint = $jscredit[$key]['leavepoint'] = $value['maxcredit'];
				}
				$one = $key;
			}

			$jscredit[$key]['minper'] = $value['marklimit'][0];
			$jscredit[$key]['maxper'] = $value['marklimit'][1];
			$jscredit[$key]['maxcredit'] = $value['maxcredit'];
			if ($rcreditdb[$key]['pingdate'] >= $tdtime) {
				$jscredit[$key]['leavepoint']  = abs($value['maxcredit'] - $rcreditdb[$key]['pingnum']);
				//$jscredit[$key]['leavepoint']  == 0 && Showmsg('masigle_nopoint');
			} else {
				$jscredit[$key]['leavepoint']  = $value['maxcredit'];
			}
			$credittype[] = $key;
			$i++;
		}
	}

	$mright = array();
	if ($winddb['groups']) {
		$gids = array();
		foreach (explode(',',$winddb['groups']) as $key=>$gid) {
			is_numeric($gid) && $gids[] = $gid;
		}
		if ($gids) {
			$gids = pwImplode($gids);
			require_once(R_P.'require/pw_func.php');
			$query = $db->query("SELECT gid,rkey,rvalue FROM pw_permission WHERE uid='0' AND fid='0' AND gid IN($gids) AND rkey IN ('markset','markable') AND type='basic'");
			while ($rt = $db->fetch_array($query)) {
				$mright[$rt['gid']][$rt['rkey']] = $rt['rvalue'];
			}

			foreach ($mright as $key=>$p) {

				if (is_array($p) && $p['markable']) {
					$p['markable'] > $_G['markable'] && $_G['markable'] = $p['markable'];

					$p['markset'] = unserialize($p['markset']);

					if ($p['markset'][$one]['markctype']) {

						is_numeric($p['markset'][$one]['marklimit'][0]) && $p['markset'][$one]['marklimit'][0] < $minper && $minper = $p['markset'][$one]['marklimit'][0];
						is_numeric($p['markset'][$one]['marklimit'][1]) && $p['markset'][$one]['marklimit'][1] > $maxper && $maxper = $p['markset'][$one]['marklimit'][1];
						is_numeric($p['markset'][$one]['maxcredit']) && $p['markset'][$one]['maxcredit'] > $maxcredit && $maxcredit = $p['markset'][$one]['maxcredit'];

						if ($rcreditdb[$one]['pingdate'] >= $tdtime) {
							$leavepoint = $jscredit[$one]['leavepoint'] = abs($maxcredit - $rcreditdb[$one]['pingnum']);
							//$leavepoint == 0 && Showmsg('masigle_nopoint');
						} else {
							$leavepoint = $jscredit[$one]['leavepoint'] = $maxcredit;
						}

					}

					foreach ($credittype as $value) {

						if ($p['markset'][$value]['markctype']) {
							is_numeric($p['markset'][$value]['marklimit'][0]) && $p['markset'][$value]['marklimit'][0] < $jscredit[$value]['minper'] && $jscredit[$value]['minper'] = $p['markset'][$value]['marklimit'][0];
							is_numeric($p['markset'][$value]['marklimit'][1]) && $p['markset'][$value]['marklimit'][1] > $jscredit[$value]['maxper'] && $jscredit[$value]['maxper'] = $p['markset'][$value]['marklimit'][1];
							is_numeric($p['markset'][$value]['maxcredit']) && $p['markset'][$value]['maxcredit'] > $jscredit[$value]['maxcredit'] && $jscredit[$value]['maxcredit'] = $p['markset'][$value]['maxcredit'];

							if ($rcreditdb[$value]['pingdate'] >= $tdtime) {
								$jscredit[$value]['leavepoint']  = abs($jscredit[$value]['maxcredit'] - $rcreditdb[$value]['pingnum']);
								//$jscredit[$value]['leavepoint']  == 0 && Showmsg('masigle_nopoint');
							} else {
								$jscredit[$value]['leavepoint']  = $jscredit[$value]['leavepoint'];
							}

						}
					}
				}
			}
		}
	}

	$creditcheck = $jscredit;
	$jscredit = pwJsonEncode($jscredit);

	if ((!$admincheck && !$_G['markable']) || !$credittype ) {
		Showmsg('no_markright');
	}

	$anonymous = 0;
	foreach ($atcdb as $pid => $atc) {
		if ($db_pingtime && $timestamp-$atc['postdate']>$db_pingtime*3600 && $gp_gptype!='system') {
			Showmsg('pingtime_over');
		}
		if ($winduid == $atc['authorid'] && !CkInArray($windid,$manager)) {
			Showmsg('masigle_manager');
		}

		$has_ping = $db->get_one("SELECT * FROM pw_pinglog WHERE fid=".pwEscape($fid)." AND tid=".pwEscape($tid)." AND pid=" . pwEscape(intval($pid)) . " AND pinger=".pwEscape($windid)." LIMIT 1");
		if ($_POST['step'] == 1 && $_G['markable']<2 && $has_ping) {
			Showmsg('no_markagain');
		}
		if ($_POST['step'] > 1 && !$has_ping) {
			Showmsg('have_not_showping');
		}

		$atc['anonymous'] && $anonymous++;
	}

	$count = count($atcdb);

	if (empty($_POST['step'])) {
		$creditselect = '';
		foreach ($credittype as $key => $cid) {
			if ($creditcheck[$cid]['minper'] && $creditcheck[$cid]['maxper']) {
				if (isset($credit->cType[$cid])) {
					$creditselect .= '<option value="'.$cid.'">'.$credit->cType[$cid].'</option>';
				}
			}
		}

		$reason_sel = '';
		$reason_a = explode("\n",$db_adminreason);
		foreach ($reason_a as $k => $v) {
			if ($v = trim($v)) {
				$reason_sel .= "<option value=\"$v\">$v</option>";
			} else {
				$reason_sel .= "<option value=\"\">-------</option>";
			}
		}
		if ($anonymous == $count && $groupid!='3') {
			$check_Y = 'disabled';
			$check_N = 'checked';
		} else {
			$check_Y = 'checked';
			$check_N = '';
		}
		require_once PrintEot($template);footer();

	} elseif ($_POST['step'] == 1) {

		PostCheck();
		InitGP(array('cid','addpoint','ifmsg','atc_content'),'P');
		!in_array($cid,$credittype) && Showmsg('masigle_credit_right');

		if (isset($credit->cType[$cid])) {
			$name = $credit->cType[$cid];
			$unit = $credit->cUnit[$cid];
		} else {
			Showmsg('all_credit_error');
		}
		$addpoint = (int)$addpoint;
		$addpoint == 0 && Showmsg('member_credit_error');
		$allpoint = $addpoint * $count;
		if(strlen($atc_content) > 100) Showmsg('showping_content_too_long');

		foreach ($mright as $key=>$p) {
			if (is_array($p) && $p['markable']) {
				$p['markset'] = unserialize($p['markset']);
				if ($p['markset'][$cid]['markctype']) {
					is_numeric($p['markset'][$cid]['marklimit'][0]) && $p['markset'][$cid]['marklimit'][0] < $_G['markset'][$cid]['marklimit'][0] && $_G['markset'][$cid]['marklimit'][0] = $p['markset'][$cid]['marklimit'][0];
					is_numeric($p['markset'][$cid]['marklimit'][1]) && $p['markset'][$cid]['marklimit'][1] > $_G['markset'][$cid]['marklimit'][1] && $_G['markset'][$cid]['marklimit'][1] = $p['markset'][$cid]['marklimit'][1];
					!$p['markset'][$cid]['markdt'] && $_G['markset'][$cid]['markdt'] = 0;//正负->负 扣除积分权限
				}
			}
		}

		if ($addpoint > $_G['markset'][$cid]['marklimit'][1] || $addpoint < $_G['markset'][$cid]['marklimit'][0]) {
			Showmsg('masigle_creditlimit');
		}

		if ($mcredit['credit']) {

			$creditdb = explode("|",$mcredit['credit']);
			$rcreditdb = array();
			$rcreditnum = $j = 0;
			foreach ($creditdb as $value) {

				$creditvalue = explode("\t",$value);
				$rcreditdb[$creditvalue['2']]['pingdate'] = $creditvalue['0'];
				$rcreditdb[$creditvalue['2']]['pingnum'] = $creditvalue['1'];
				$rcreditdb[$creditvalue['2']]['pingtype'] = $creditvalue['2'];
				$rcreditnum += $creditvalue['1'];

				if ($creditvalue['2'] == $cid) {
					if ($creditvalue[0] < $tdtime) {
						$creditvalue[0] = $tdtime;
						$creditvalue[1] = abs($allpoint);
						if ($creditvalue[1] > $creditcheck[$creditvalue['2']]['maxcredit']) {
							Showmsg('masigle_point');
						}
					} else {
						if ($creditvalue[1] + abs($allpoint) > $creditcheck[$creditvalue['2']]['maxcredit']) {
							Showmsg('masigle_point');
						} else {
							$creditvalue[0] = $timestamp;
							$creditvalue[1]+= abs($allpoint);
						}
					}
					$rcreditdb[$creditvalue['2']]['pingdate'] = $creditvalue['0'];
					$rcreditdb[$creditvalue['2']]['pingnum'] = $creditvalue['1'];
					$rcreditdb[$creditvalue['2']]['pingtype'] = $creditvalue['2'];
					$j ++;
				}
			}

			$newcreditdb = '';
			foreach ($rcreditdb as $value) {
				$newcreditdb .= $newcreditdb ? '|'.implode("\t",$value) : implode("\t",$value);
			}
			if (!$j) {
				$creditvalue[0] = $tdtime;
				$creditvalue[1] = abs($allpoint);
				if ($creditvalue[1] > $_G['markset'][$cid]['maxcredit']) {
					Showmsg('masigle_point');
				}
				$newcreditdb = $creditvalue[0]."\t".$creditvalue[1]."\t".$cid;
				$mcredit['credit'] && $newcreditdb .= '|'.$mcredit['credit'];
			}

			$db->update('UPDATE pw_memberinfo SET credit='.pwEscape($newcreditdb,false).' WHERE uid='.pwEscape($winduid));
			unset($rcreditdb);
		} else {
			$creditvalue[0] = $tdtime;
			$creditvalue[1] = abs($allpoint);
			if ($creditvalue[1] > $_G['markset'][$cid]['maxcredit']) {
				Showmsg('masigle_point');
			}
			$newcreditdb = $creditvalue[0]."\t".$creditvalue[1]."\t".$cid;

			if (!$mcredit) {

				$db->update("INSERT INTO pw_memberinfo SET " .pwSqlSingle(array('uid'=>$winduid,'credit'=>$newcreditdb),false));
			} elseif (!$mcredit['credit']) {

				$db->update('UPDATE pw_memberinfo SET credit='.pwEscape($newcreditdb,false).' WHERE uid='.pwEscape($winduid));
			}
		}

		if ($_G['markset'][$cid]['markdt'] && $allpoint > 0) {//扣除自身积分
			$credit->get($winduid,$cid) < $allpoint && Showmsg('credit_enough');
			$credit->set($winduid,$cid,-$allpoint,false);
		}

		foreach ($atcdb as $pid => $atc) {
			!$atc['subject'] && $atc['subject'] = substrs(strip_tags(convert($atc['content'])),35);
			$credit->addLog('credit_showping',array($cid => $addpoint),array(
				'uid'		=> $atc['authorid'],
				'username'	=> $atc['author'],
				'ip'		=> $onlineip,
				'operator'	=> $windid,
				'tid'		=> $tid,
				'subject'	=> $atc['subject'],
				'reason'	=> $atc_content
			));
			$credit->set($atc['authorid'], $cid, $addpoint, false);

			if (!is_numeric($pid)) {
				$db->update("UPDATE pw_threads SET ifmark=ifmark+".pwEscape($addpoint)." WHERE tid=".pwEscape($tid));
				$rpid = 0;
			} else {
				$rpid = $pid;
			}
			$pwSQL = pwSqlSingle(array(
				'fid'	=> $fid,
				'tid'	=> $tid,
				'pid'	=> $rpid,
				'name'	=> $name,
				'point'	=> $addpoint,
				'pinger'=> $windid,
				'record'=> $atc_content,
				'pingdate'=> $timestamp,
			));
			$db->update("INSERT INTO pw_pinglog SET $pwSQL");
			update_markinfo($fid, $tid, $rpid);
			$_cache = getDatastore();
			$_cache->delete('UID_'.$atc['authorid']);

			$atcdb[$pid]['ifmark'] = $ifmark;

			if ($ifmsg && !$atc['anonymous']) {
				$msg = array(
					'toUser'	=> $atc['author'],
					'fromUid'	=> $winduid,
					'fromUser'	=> $windid,
					'subject'	=> 'ping_title',
					'content'	=> 'ping_content',
					'other'		=> array(
						'manager'	=> $windid,
						'fid'		=> $atc['fid'],
						'tid'		=> $tid,
						'pid'		=> $pid,
						'subject'	=> $atc['subject'],
						'postdate'	=> get_date($atc['postdate']),
						'forum'		=> strip_tags($foruminfo['name']),
						'affect'    => "$name:$addpoint",
						'admindate'	=> get_date($timestamp),
						'reason'	=> stripslashes($atc_content)
					)
				);
				pwSendMsg($msg);
			}
			if ($gp_gptype == 'system'){
				require_once(R_P.'require/writelog.php');
				$log = array(
					'type'      => 'credit',
					'username1' => $atc['author'],
					'username2' => $windid,
					'field1'    => $fid,
					'field2'    => '',
					'field3'    => '',
					'descrip'   => 'credit_descrip',
					'timestamp' => $timestamp,
					'ip'        => $onlineip,
					'tid'		=> $tid,
					'forum'		=> strip_tags($foruminfo['name']),
					'subject'	=> $atc['subject'],
					'affect'	=> "$name:$addpoint",
					'reason'	=> $atc_content
				);
				writelog($log);
			}
		}
		$credit->runsql();

		if ($db_autoban && $addpoint < 0) {
			require_once(R_P.'require/autoban.php');
			foreach ($atcdb as $pid => $atc) {
				autoban($atc['authorid']);
			}
		}
		if ($foruminfo['allowhtm'] && $page==1) {
			$StaticPage = L::loadClass('StaticPage');
			$StaticPage->update($tid);
		}
		if (defined('AJAX')) {
			echo "success";
			ajax_footer();
		} else {
			refreshto("read.php?tid=$tid&page=$page#$jump_pid",'enter_thread');
		}
	} else {

		PostCheck();
		$groupid == 'guest' && Showmsg('not_login');
		InitGP(array('ifmsg','atc_content'));

		foreach ($atcdb as $pid => $atc) {
			$rpid = $pid == 'tpc' ? '0' : $pid; // delete pinglog
			$pingdata = $db->get_one('SELECT * FROM pw_pinglog WHERE fid='.pwEscape($fid).' AND tid='.pwEscape($tid).' AND pid='.pwEscape($rpid).' AND pinger='.pwEscape($windid).' ORDER BY pingdate DESC LIMIT 1');
			$db->update('DELETE FROM pw_pinglog WHERE fid='.pwEscape($fid).' AND tid='.pwEscape($tid).' AND pid='.pwEscape($rpid).' AND pinger='.pwEscape($windid).' ORDER BY pingdate DESC LIMIT 1');
			update_markinfo($fid, $tid, $rpid);
			$_cache = getDatastore();
			$_cache->delete('UID_'.$atc['authorid']);

			$cName = $pingdata['name'];
			$addpoint = $pingdata['point'];
			foreach ($credit->cType as $k => $v) {
				if ($v == $cName) {
					$cid = $k;break;
				}
			}

			!$atc['subject'] && $atc['subject'] = substrs(strip_tags(convert($atc['content'])),35);
			$addpoint = $addpoint>0 ? -$addpoint : abs($addpoint);

			$credit->addLog('credit_delping',array($cid => $addpoint),array(
				'uid'		=> $atc['authorid'],
				'username'	=> $atc['author'],
				'ip'		=> $onlineip,
				'operator'	=> $windid,
				'tid'		=> $tid,
				'subject'	=> $atc['subject'],
				'reason'	=> $atc_content
			));
			$credit->set($atc['authorid'],$cid,$addpoint);

			if (!is_numeric($pid)) {
				$db->update('UPDATE pw_threads SET ifmark=ifmark+'.pwEscape($addpoint).' WHERE tid='.pwEscape($tid));
			}

			if ($ifmsg) {
				$msg = array(
					'toUser'	=> $atc['author'],
					'fromUid'	=> $winduid,
					'fromUser'	=> $windid,
					'subject'	=> 'delping_title',
					'content'	=> 'delping_content',
					'other'		=> array(
						'manager'	=> $windid,
						'fid'		=> $atc['fid'],
						'tid'		=> $tid,
						'pid'		=> $pid,
						'subject'	=> $atc['subject'],
						'postdate'	=> get_date($atc['postdate']),
						'forum'		=> strip_tags($foruminfo['name']),
						'affect'    => "{$cName}:$addpoint",
						'admindate'	=> get_date($timestamp),
						'reason'	=> stripslashes($atc_content)
					)
				);
				pwSendMsg($msg);
			}
			if ($gp_gptype == 'system'){
				require_once(R_P.'require/writelog.php');
				$log = array(
					'type'      => 'credit',
					'username1' => $atc['author'],
					'username2' => $windid,
					'field1'    => $atc['fid'],
					'field2'    => '',
					'field3'    => '',
					'descrip'   => 'creditdel_descrip',
					'timestamp' => $timestamp,
					'ip'        => $onlineip,
					'tid'		=> $tid,
					'forum'		=> strip_tags($foruminfo['name']),
					'subject'	=> $atc['subject'],
					'affect'	=> "$name:$addpoint",
					'reason'	=> $atc_content
				);
				writelog($log);
			}
		}

		if ($foruminfo['allowhtm'] && $page==1) {
			$StaticPage = L::loadClass('StaticPage');
			$StaticPage->update($tid);
		}
		if (defined('AJAX')) {
			echo "success";
			ajax_footer();
		} else {
			refreshto("read.php?tid=$tid&page=$page#$jump_pid",'enter_thread');
		}
	}

} elseif ($action == 'share') {

	if (empty($_POST['step'])) {//TODO X!

		InitGP(array('type','id'));
		@include_once(D_P.'data/bbscache/o_config.php');

		$atc_name = getLangInfo('other','share_'.$type);
		$friend = getFriends($winduid) ? getFriends($winduid) : array();
		foreach ($friend as $key => $value) {
			$frienddb[$value['ftid']][] = $value;
		}
		$query = $db->query("SELECT * FROM pw_friendtype WHERE uid=".pwEscape($winduid)." ORDER BY ftid");
		$friendtype = array();
		while ($rt = $db->fetch_array($query)) {
			$friendtype[$rt['ftid']] = $rt;
		}
		$no_group_name = getLangInfo('other','no_group_name');
		$friendtype[0] = array('ftid' => 0,'uid' => $winduid,'name' => $no_group_name);
		$share_type_des = getLangInfo('other','share_des_'.$type);
		if ($type == 'diary') {
			$diarydb = $db->get_one("SELECT did,uid,username,subject,content,privacy FROM pw_diary WHERE did=".pwEscape($id));
			if ($diarydb['privacy'] == 2) {
				showmsg('share_privacy');
			}
			$did = $diarydb['did'];
			$subject = $diarydb['subject'];
			$uid = $diarydb['uid'];
			$username = $diarydb['username'];
			$title = "[url=$db_bbsurl/mode.php?m=o&q=diary&space=1&u=$uid&did=$did] $subject [/url]";
			require_once(R_P.'require/bbscode.php');
			$diarydb['content'] = strip_tags(convert($diarydb['content'],$db_windpost));
			$descrip = substrs($diarydb['content'],50);
		} elseif ($type == 'group') {
			$colonydb = $db->get_one("SELECT c.id,c.cname,c.admin,c.descrip,m.uid FROM pw_colonys c LEFT JOIN pw_members m ON c.admin=m.username WHERE c.id=".pwEscape($id));
			$subject = $diarydb['cname'];
			$uid = $colonydb['uid'];
			$username = $colonydb['admin'];
			$cyid = $colonydb['id'];
			$title = "[url=$db_bbsurl/mode.php?m=o&q=group&cyid=$cyid] $colonydb[cname] [/url]";
			$descrip = $colonydb['descrip'];
		} elseif ($type == 'album') {
			$albumdb = $db->get_one("SELECT aid,ownerid,owner,lastphoto,aintro FROM pw_cnalbum WHERE atype='0' AND aid=" . pwEscape($id));
			$photourl	= getphotourl($albumdb['lastphoto']);
			$uid = $albumdb['ownerid'];
			$username = $albumdb['owner'];
			$aid =  $albumdb['aid'];
			$title = "[url=$db_bbsurl/mode.php?m=o&q=photos&space=1&a=album&u=$albumdb[ownerid]&aid=$aid] $username [/url]";
			$descrip = $albumdb['aintro'];
		} elseif ($type == 'photo') {
			$photodb = $db->get_one("SELECT p.pid,p.path as basepath,p.pintro,p.ifthumb,a.ownerid,a.owner FROM pw_cnphoto p LEFT JOIN pw_cnalbum a ON p.aid=a.aid WHERE p.pid=" . pwEscape($id) . " AND a.atype='0'");
			$photourl = getphotourl($photodb['basepath'],$photodb['ifthumb']);
			$uid = $photodb['ownerid'];
			$username = $photodb['owner'];
			$title = "[url=$db_bbsurl/mode.php?m=o&q=photos&space=1&a=view&u=$photodb[ownerid]&pid=$photodb[pid]] $photodb[owner] [/url]";
			$descrip = $photodb['pintro'];
		} elseif ($type == 'user') {
			$userdb = $db->get_one("SELECT uid, username FROM pw_members WHERE uid=".pwEscape($id));
			$uid = $userdb['uid'];
			$username = $userdb['username'];
			$title = "[url=$db_bbsurl/u.php?action=show&uid=$userdb[uid]] $userdb[username] [/url]";
		} elseif ($type == 'topic') {
			$pw_tmsgs = GetTtable($id);
			$topicdb = $db->get_one("SELECT t.tid,t.subject,t.anonymous,t.ifshield,t.authorid,t.author,t.postdate,tm.content FROM pw_threads t LEFT JOIN $pw_tmsgs tm ON t.tid=tm.tid WHERE t.tid=".pwEscape($id));
			$tid = $topicdb['tid'];
			$uid = $topicdb['authorid'];
			$username = ($topicdb['anonymous'] == 1) ? $db_anonymousname : $topicdb['author'];
            $isAnonymous = ($topicdb['anonymous'] == 1) ? true : false;
			$subject = $topicdb['subject'];
			$postdate = get_date($topicdb['postdate']);
			$title = "[url=$db_bbsurl/read.php?tid=$tid]$topicdb[subject][/url]";
			require_once(R_P.'require/bbscode.php');
			$topicdb['content'] = strip_tags(convert($topicdb['content'],$db_windpost));
			$descrip = ($topicdb['ifshield'] == 1) ? "" : stripWindCode(substrs($topicdb['content'],100,'N'));
			$attimages = array();
			$query = $db->query("SELECT attachurl,ifthumb FROM pw_attachs WHERE tid=".pwEscape($topicdb['tid'],false)." AND type='img' LIMIT 4");
			while ($rt = $db->fetch_array($query)) {
				$a_url = geturl($rt['attachurl'],'show',$rt['ifthumb']);
				if ($a_url != 'nopic') {
					$attimages[$rt['attachurl']] = is_array($a_url) ? $a_url[0] : $a_url;
				}
			}


		} elseif ($type == 'reply') {

			InitGP(array('tid'));
			$pw_posts = GetPtable('N',$tid);

			$replydb = $db->get_one("SELECT p.pid,p.tid,p.anonymous,p.ifshield,p.subject as psubject,p.author,p.authorid,p.postdate,p.content,t.subject as tsubject FROM $pw_posts p LEFT JOIN pw_threads t ON p.tid=t.tid WHERE p.pid=".pwEscape($id));

			$uid = $replydb['authorid'];
			$subject = $replydb['psubject'] ? $replydb['psubject'] : 'Re:'.$replydb['tsubject'];
			$username = ($replydb['anonymous'] == 1) ? $db_anonymousname : $replydb['author'];
			$isAnonymous = ($replydb['anonymous'] == 1) ? true : false;
			$postdate = get_date($replydb['postdate']);
			require_once(R_P.'require/bbscode.php');
			$replydb['content'] = strip_tags(convert($replydb['content'],$db_windpost));
			$descrip = ($replydb['ifshield'] == 1) ? "" : stripWindCode(substrs($replydb['content'],100,'N'));

			$attimages = array();
			$query = $db->query("SELECT attachurl FROM pw_attachs WHERE uid=".pwEscape($uid,false)." AND pid=".pwEscape($id,false)." AND type='img' LIMIT 5");
			while ($rt = $db->fetch_array($query)) {
				$a_url = geturl($rt['attachurl'],'show');
				if ($a_url != 'nopic') {
					$attimages[$rt['attachurl']] = is_array($a_url) ? $a_url[0] : $a_url;
				}
			}
			//推荐
			$title = "[url=$db_bbsurl/job.php?action=topost&tid=$tid&pid=$id]{$subject}[/url]";
		}
		require_once PrintEot('ajax_operate');ajax_footer();

	} else {

		InitGP(array('sendtoname','subject','atc_content','touid'),'P');

		require_once(R_P.'require/postfunc.php');
		require_once(R_P.'require/bbscode.php');

		$wordsfb = wordsfb::getInstance();
		if (($banword = $wordsfb->comprise($subject)) !== false) {
			Showmsg('title_wordsfb');
		}
		if (($banword = $wordsfb->comprise($atc_content)) !== false) {
			Showmsg('content_wordsfb');
		}
		require_once(R_P.'require/msg.php');

		$uids = array();
		if ($sendtoname) {
			$rt = $db->get_one('SELECT uid FROM pw_members WHERE username='.pwEscape($sendtoname));
			if (!$rt) {
				$errorname = $sendtoname;
				Showmsg('user_not_exists');
			}
			$uids[] = $rt['uid'];
		}
		if (is_array($touid)) {
			foreach ($touid as $key => $value) {
				if (is_numeric($value)) {
					$uids[] = $value;
				}
			}
		}

		!$uids && Showmsg('msg_empty');
		if (!$subject || !$atc_content) {
			Showmsg('tofriend_msgerror');
		}

		$uids = pwImplode($uids);

		$query = $db->query("SELECT username FROM pw_members WHERE uid IN($uids)");
		while ($rt = $db->fetch_array($query)) {
			$msgdb = array(
				'toUser'	=> $rt['username'],
				'fromUid'	=> $winduid,
				'fromUser'	=> $windid,
				'subject'	=> stripslashes($subject),
				'content'	=> stripslashes($atc_content),
			);
			pwSendMsg($msgdb);
		}
		Showmsg('operate_success');
	}
} elseif ($action == 'report') {

	!$_G['allowreport'] && Showmsg('report_right');
	InitGP(array('pid','page'),'GP',2);
	$rt  = $db->get_one("SELECT tid FROM pw_report WHERE uid=".pwEscape($winduid).' AND tid='.pwEscape($tid).' AND pid='.pwEscape($pid));
	$rt && Showmsg('have_report');

	if (empty($_POST['step'])) {

		require_once PrintEot($template);footer();

	} else {

		PostCheck();
		InitGP(array('ifmsg','type','reason'),'P');

		$pwSQL = pwSqlSingle(array(
			'tid'	=> $tid,
			'pid'	=> $pid,
			'uid'	=> $winduid,
			'type'	=> $type,
			'reason'=> $reason
		));
		$db->update("INSERT INTO pw_report SET $pwSQL");

		if ($ifmsg) {
			if ($pid > 0) {
				$pw_posts = GetPtable('N',$tid);
				$sqlsel = "t.content as subject,t.postdate,";
				$sqltab = "$pw_posts t";
				$sqladd = 'WHERE t.pid='.pwEscape($pid);
			} else {
				$sqlsel = "t.subject,t.postdate,";
				$sqltab = "pw_threads t";
				$sqladd = 'WHERE t.tid='.pwEscape($tid);
			}
			$rs = $db->get_one("SELECT $sqlsel t.fid,f.forumadmin FROM $sqltab LEFT JOIN pw_forums f USING(fid) $sqladd");

			if ($rs['forumadmin']) {
				include_once(D_P.'data/bbscache/forum_cache.php');
				require_once(R_P.'require/msg.php');
				$admin_a = explode(',',$rs['forumadmin']);
				$iftpc = $pid ? '0' : '1';
				$msg = array(
					'toUser'	=> $admin_a,
					'fromUid'	=> $winduid,
					'fromUser'	=> $windid,
					'subject'	=> 'report_title',
					'content'	=> 'report_content_'.$type.'_'.$iftpc,
					'other'		=> array(
						'fid'		=> $rs['fid'],
						'tid'		=> $tid,
						'pid'		=> $pid,
						'postdate'	=> get_date($rs['postdate']),
						'forum'		=> $forum[$rs['fid']]['name'],
						'subject'	=> $rs['subject'],
						'admindate'	=> get_date($timestamp),
						'reason'	=> stripslashes($reason)
					)
				);
				pwSendMsg($msg);
			}
		}
		if (defined('AJAX')) {
			Showmsg('report_success');
		} else {
			refreshto("read.php?tid=$tid&page=$page",'report_success');
		}
	}
} else {
	Showmsg('undefined_action');
}

function getphotourl($path,$thumb = false) {
	global $pwModeImg;
	if (!$path) {
		return "$pwModeImg/nophoto.gif";
	}
	$lastpos = strrpos($path,'/') + 1;
	$thumb && $path = substr($path, 0, $lastpos) . 's_' . substr($path, $lastpos);
	list($path) = geturl($path, 'show');
	if ($path == 'imgurl' || $path == 'nopic') {
		return "$pwModeImg/nophoto.gif";
	}
	return $path;
}
?>