<?php
!function_exists('adminmsg') && exit('Forbidden');
$basename="$admin_file?adminjob=updatecache";

if(empty($action)){
	include PrintEot('update');exit;
} elseif($_POST['action']=='cache'){
	updatecache();
	adminmsg('operate_success');
} elseif($_POST['action']=='topped'){
	require_once(R_P.'require/updateforum.php');
	updatetop();
	adminmsg('operate_success');
} elseif($_POST['action']=='bbsinfo'){
	@extract($db->get_one("SELECT COUNT(*) AS count FROM pw_members"));
	@extract($db->get_one("SELECT username FROM pw_members ORDER BY uid DESC LIMIT 1"));
	$db->update("UPDATE pw_bbsinfo SET newmember=".pwEscape($username).", totalmember=".pwEscape($count)."WHERE id='1'");
	adminmsg('operate_success');
} elseif($_POST['action']=='online'){
	$writeinto=str_pad("<?php die;?>",96)."\n";
	writeover(D_P.'data/bbscache/online.php',$writeinto);
	writeover(D_P.'data/bbscache/guest.php',$writeinto);
	writeover(D_P.'data/bbscache/olcache.php',"<?php\n\$userinbbs=0;\n\$guestinbbs=0;\n?>");
	adminmsg('operate_success');
} elseif($action=='member'){
	$pwServer['REQUEST_METHOD']!='POST' && PostCheck($verify);
	InitGP(array('step','percount'));
	if(!$step){
		$db->update("UPDATE pw_memberdata SET postnum=0");
	    $step=1;
	}
	!$percount && $percount=300;
	$start=($step-1)*$percount;
	$next=$start+$percount;
	$step++;
	$j_url="$basename&action=$action&step=$step&percount=$percount";
	$goon=0;
	$query=$db->query("SELECT authorid,COUNT(*) as count FROM pw_threads GROUP BY authorid LIMIT $start,$percount");
	while($rt=$db->fetch_array($query)){
		$goon=1;
		$db->update("UPDATE pw_memberdata SET postnum=postnum+".pwEscape($rt['count'],false)."WHERE uid=".pwEscape($rt['authorid'],false));
	}
	$ptable_a=array('pw_posts');
	if($db_plist){
		$p_list=explode(',',$db_plist);
		foreach($p_list as $val){
			$ptable_a[]='pw_posts'.$val;
		}
	}
	foreach($ptable_a as $val){
		$query=$db->query("SELECT authorid,COUNT(*) as count FROM $val GROUP BY authorid LIMIT $start,$percount");
		while($rt=$db->fetch_array($query)){
			$goon=1;
			$db->update("UPDATE pw_memberdata SET postnum=postnum+".pwEscape($rt['count'],false)."WHERE uid=".pwEscape($rt['authorid'],false));
		}
	}
	$basename="$admin_file?adminjob=setuser";
	if($goon){
		adminmsg('updatecache_step',EncodeUrl($j_url));
	} else{
		adminmsg('operate_success');
	}
} elseif($action=='digest'){
	$pwServer['REQUEST_METHOD']!='POST' && PostCheck($verify);
	InitGP(array('step','percount'));
	!$step && $step=1;
	!$percount && $percount=300;
	$start=($step-1)*$percount;
	$next=$start+$percount;
	$step++;
	$j_url="$basename&action=$action&step=$step&percount=$percount";
	$goon=0;
	$query=$db->query("SELECT authorid,COUNT(*) as count FROM pw_threads WHERE digest>0 AND ifcheck='1' GROUP BY authorid LIMIT $start,$percount");
	while($rt=$db->fetch_array($query)){
		$goon=1;
		$db->update("UPDATE pw_memberdata SET digests=".pwEscape($rt['count'],false)."WHERE uid=".pwEscape($rt['authorid'],false));
	}
	if($goon){
		adminmsg('updatecache_step',EncodeUrl($j_url));
	} else{
		adminmsg('operate_success');
	}
} elseif($action=='forum'){
	$pwServer['REQUEST_METHOD']!='POST' && PostCheck($verify);
	InitGP(array('step','percount'));
	include_once(D_P.'data/bbscache/forum_cache.php');
	if(!$step){
		$db->update("UPDATE pw_forumdata SET topic=0,article=0,subtopic=0");
	    $step=1;
	}
	!$percount && $percount=30;
	$start=($step-1)*$percount;
	$next=$start+$percount;
	$step++;
	$j_url="$basename&action=$action&step=$step&percount=$percount";
	$goon=0;
	$query=$db->query("SELECT fid,fup,type,allowhtm,cms FROM pw_forums LIMIT $start,$percount");
	while(@extract($db->fetch_array($query))){
		$goon=1;
		@extract($db->get_one("SELECT COUNT(*) AS topic,SUM( replies ) AS replies FROM pw_threads WHERE fid=".pwEscape($fid)."AND ifcheck='1' AND topped<=3"));
		$article=$topic+$replies;
		if($type=='sub2' || $type=='sub'){
			$db->update("UPDATE pw_forumdata SET article=article+".pwEscape($article).",subtopic=subtopic+".pwEscape($topic)."WHERE fid=".pwEscape($fup));
			if($type == 'sub2'){
				$fup=$forum[$fup]['fup'];
				$db->update("UPDATE pw_forumdata SET article=article+".pwEscape($article).',subtopic=subtopic+'.pwEscape($topic).'WHERE fid='.pwEscape($fup));
			}
		} elseif($type=='category'){
			$topic=$article=0;
		}
		$lt = $db->get_one("SELECT tid,author,postdate,lastpost,lastposter,subject FROM pw_threads WHERE fid=".pwEscape($fid)."AND topped=0 AND ifcheck=1 AND lastpost>0 ORDER BY lastpost DESC LIMIT 0,1");
		if($lt['tid']){
			$lt['subject'] = substrs($lt['subject'],21);
			if($lt['postdate']!=$lt['lastpost']){
				$lt['subject']='Re:'.$lt['subject'];
				$add='&page=e#a';
			}
			$toread=$cms ? '&toread=1' : '';
			$htmurl=$db_htmdir.'/'.$fid.'/'.date('ym',$lt['postdate']).'/'.$lt['tid'].'.html';
			$new_url=file_exists(R_P.$htmurl) && $allowhtm==1 && !$cms ? "$R_url/$htmurl" : "read.php?tid=$lt[tid]$toread$add";
			$lastinfo=addslashes(Char_cv($lt['subject'])."\t".$lt['lastposter']."\t".$lt['lastpost']."\t".$new_url);
		} else{
			$lastinfo='';
		}
		$db->update("UPDATE pw_forumdata SET topic=".pwEscape($topic).',article=article+'.pwEscape($article).',lastpost='.pwEscape($lastinfo).' WHERE fid='.pwEscape($fid));
	}
	if($goon){
		adminmsg('updatecache_step',EncodeUrl($j_url));
	} else{
		adminmsg('operate_success');
	}
} elseif($action=='thread'){
	$pwServer['REQUEST_METHOD']!='POST' && PostCheck($verify);
	InitGP(array('step','percount'));
	!$step && $step=1;
	!$percount &&$percount=300;
	$start=($step-1)*$percount;
	$next=$start+$percount;
	$step++;
	$j_url="$basename&action=$action&step=$step&percount=$percount";
	$goon=0;
	$query=$db->query("SELECT tid,replies,ifcheck,ptable FROM pw_threads LIMIT $start,$percount");
	while($rt=$db->fetch_array($query)){
		$goon=1;
		if($rt['ifcheck']){
			$pw_posts = GetPtable($rt['ptable']);
			@extract($db->get_one("SELECT COUNT(*) AS replies FROM $pw_posts WHERE tid=".pwEscape($rt['tid'])."AND ifcheck='1'"));
			if($rt['replies']!=$replies){
				$db->update("UPDATE pw_threads SET replies=".pwEscape($replies)."WHERE tid=".pwEscape($rt['tid']));
			}
		}
	}
	if($goon){
		adminmsg('updatecache_step',EncodeUrl($j_url));
	} else{
		adminmsg('operate_success');
	}
} elseif ($action == 'group') {

	$pwServer['REQUEST_METHOD']!='POST' && PostCheck($verify);
	InitGP(array('step','percount'));
	!$step && $step=1;
	!$percount && $percount=300;
	$start=($step-1)*$percount;
	$next=$start+$percount;
	$step++;
	$j_url="$basename&action=$action&step=$step&percount=$percount";
	$goon=0;
	$query = $db->query("SELECT uid,postnum,digests,rvrc,money,credit as credits,currency,onlinetime FROM pw_memberdata LIMIT $start,$percount");
	while (@extract($db->fetch_array($query))) {
		$goon = 1;
		$usercredit = array(
			'postnum'	=> $postnum,
			'digests'	=> $digests,
			'rvrc'		=> $rvrc,
			'money'		=> $money,
			'credit'	=> $credits,
			'currency'	=> $currency,
			'onlinetime'=> $onlinetime,
		);
		$upgradeset = unserialize($db_upgrade);
		foreach ($upgradeset as $key => $val) {
			if (is_numeric($key)) {
				require_once(R_P.'require/credit.php');
				foreach ($credit->get($uid,'CUSTOM') as $key => $value) {
					$usercredit[$key] = $value;
				}
				break;
			}
		}
		$memberid = getmemberid(CalculateCredit($usercredit,$upgradeset));
		$db->update("UPDATE pw_members SET memberid=".pwEscape($memberid)."WHERE uid=".pwEscape($uid));
	}
	if ($goon) {
		adminmsg('updatecache_step',EncodeUrl($j_url));
	} else{
		adminmsg('operate_success');
	}
} elseif($_POST['action'] == 'usergroup') {
	/*
	* 更新系统组成员头衔
	*/
	$forumadmin = array();
	$query = $db->query("SELECT forumadmin FROM pw_forums WHERE forumadmin!=''");
	while ($rt = $db->fetch_array($query)) {
		if ($rt['forumadmin']) {
			$forumadmin += explode(",",$rt['forumadmin']);
		}
	}
	if ($forumadmin) {
		$forumadmin = array_unique($forumadmin);
		$query = $db->query("SELECT uid,groupid FROM pw_members WHERE username IN (".pwImplode($forumadmin,false).")");
		while ($rt = $db->fetch_array($query)) {
			if ($rt['groupid']=='-1') {
				$db->update("UPDATE pw_members SET groupid='5' WHERE uid=".pwEscape($rt['uid'],false));
			}
		}
	}

	$glist = array('-99');
	$gids  = array();
	$query = $db->query("SELECT gid FROM pw_usergroups WHERE gptype IN('default','system','special') AND gid>2");
	while (@extract($db->fetch_array($query))) {
		$gids[] = $gid;
		$glist[] = $gid;
	}
	$query = $db->query("SELECT uid,username,groupid,groups FROM pw_members WHERE groupid<>'-1'");
	while (@extract($db->fetch_array($query))) {
		$username = addslashes($username);
		if (!in_array($groupid,$gids)) {
			$db->update("UPDATE pw_members SET groupid='-1' WHERE uid=".pwEscape($uid,false));
			if ($groups == '') {
				admincheck($uid,$username,$groupid,$groups,'delete');
			}
		} else {
			admincheck($uid,$username,$groupid,$groups,'update');
		}
	}
	$db->update("DELETE FROM pw_administrators WHERE groupid NOT IN(".pwImplode($glist,false).") AND groups=''");
	adminmsg('operate_success');
} elseif ($action == 'appcount') {
	$pwServer['REQUEST_METHOD']!='POST' && PostCheck($verify);
	InitGP(array('step','percount'));
	!$step && $step=1;
	!$percount && $percount=300;
	$start=($step-1)*$percount;
	$next=$start+$percount;
	$step++;
	$j_url="$basename&action=$action&step=$step&percount=$percount";
	$goon=0;
	$query = $db->query("SELECT uid,username FROM pw_members WHERE uid>".pwEscape($start)." AND uid <= ".pwEscape($next));
	while ($rt = $db->fetch_array($query)) {
		$goon = 1;
		$diarynum = $photonum = $owritenum = $groupnum = $sharenum = 0;
		$uid = (int)$rt['uid'];
		$username = $rt['username'];
		$diarynum = $db->get_value("SELECT COUNT(*) FROM pw_diary WHERE uid=".pwEscape($uid));
		//此处连表为用到索引
		$photonum = $db->get_value("SELECT COUNT(*) FROM pw_cnphoto cn LEFT JOIN pw_cnalbum ca ON cn.aid=ca.aid WHERE ca.atype='0' AND ca.ownerid=".pwEscape($uid));
		$owritenum = $db->get_value("SELECT COUNT(*) FROM pw_owritedata WHERE uid=".pwEscape($uid));
		$groupnum = $db->get_value("SELECT COUNT(*) FROM pw_colonys WHERE admin=".pwEscape($username));
		$sharenum = $db->get_value("SELECT COUNT(*) FROM pw_share WHERE uid=".pwEscape($uid));
		$allnum = $diarynum + $photonum + $owritenum + $groupnum + $sharenum;
		if ($allnum > 0) {
			$db->pw_update(
				"SELECT * FROM pw_ouserdata WHERE uid=".pwEscape($uid),
				"UPDATE pw_ouserdata SET ".pwSqlSingle(array('diarynum' => $diarynum,'photonum' => $photonum,'owritenum' => $owritenum,'groupnum' => $groupnum,'sharenum' => $sharenum))." WHERE uid=".pwEscape($uid),
				"INSERT INTO pw_ouserdata SET ".pwSqlSingle(array('uid' => $uid,'diarynum' => $diarynum,'photonum' => $photonum,'owritenum' => $owritenum,'groupnum' => $groupnum,'sharenum' => $sharenum))
			);
		}
	}
	if ($goon) {
		adminmsg('updatecache_step',EncodeUrl($j_url));
	} else{
		adminmsg('operate_success');
	}
}
?>