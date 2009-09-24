<?php
define('SCR','read');
require_once('global.php');
require_once(R_P.'require/forum.php');
require_once(R_P.'require/bbscode.php');
include_once(D_P.'data/bbscache/cache_read.php');

InitGP(array('fpage','uid','toread'),2);
$fieldadd = $tablaadd = $sqladd = $fastpost = $special = $ifmagic = $urladd = '';
$_uids    = $_pids = array();

$page = GetGP('page');
/*
if ($page > 1) {
	$read = $db->get_one("SELECT * FROM pw_threads WHERE tid=".pwEscape($tid));
} else {
	$page < 1 && $page != 'e' && $page = 1;
	$start_limit = 0;
	$pw_tmsgs = GetTtable($tid);
	$read = $db->get_one("SELECT t.* ,tm.* FROM pw_threads t LEFT JOIN $pw_tmsgs tm ON t.tid=tm.tid WHERE t.tid=".pwEscape($tid));
}
!$read && Showmsg('illegal_tid');
*/
$page < 1 && $page != 'e' && $page = 1;
$threads = L::loadClass('Threads');
$read = $threads->getThreads($tid,!($page>1));
!$read && Showmsg('illegal_tid');

$_uids[$read['authorid']] = 'UID_'.$read['authorid'];#用户
$fid      = $read['fid'];
$ptable   = $read['ptable'];
$ifcheck  = $read['ifcheck'];
$pw_posts = GetPtable($ptable);
$openIndex 	= getstatus($read['tpcstatus'], 2);

//读取版块信息及权限判断
if (!($foruminfo = L::forum($fid))) {
	$foruminfo	= $db->get_one("SELECT f.*,fe.creditset,fe.forumset,fe.commend FROM pw_forums f LEFT JOIN pw_forumsextra fe ON f.fid=fe.fid WHERE f.fid=".pwEscape($fid));
	if ($foruminfo) {
		$foruminfo['creditset'] = unserialize($foruminfo['creditset']);
		$foruminfo['forumset'] = unserialize($foruminfo['forumset']);
		$foruminfo['commend'] = unserialize($foruminfo['commend']);
	}
}
!$foruminfo && Showmsg('data_error');
wind_forumcheck($foruminfo);
$forumset  = $foruminfo['forumset'];

if (!$foruminfo['allowvisit'] && $_G['allowread']==0 && $_COOKIE) {
	Showmsg('read_group_right');
}

//帖子浏览及管理权限
$isGM = $isBM = $admincheck = $managecheck = $pwPostHide = $pwSellHide = $pwEncodeHide = 0;
$pwSystem = array();
if ($groupid != 'guest') {
	$isGM = CkInArray($windid,$manager);
	$isBM = admincheck($foruminfo['forumadmin'],$foruminfo['fupadmin'],$windid);
	$admincheck = ($isGM || $isBM) ? 1 : 0;
	if (!$isGM) {#非创始人权限获取
		$pwSystem = pwRights($isBM);
		if ($pwSystem && ($pwSystem['tpccheck'] || $pwSystem['digestadmin'] || $pwSystem['lockadmin'] || $pwSystem['pushadmin'] || $pwSystem['coloradmin'] || $pwSystem['downadmin'] || $pwSystem['delatc'] || $pwSystem['moveatc'] || $pwSystem['copyatc'] || $pwSystem['topped'] || $pwSystem['unite'] || $pwSystem['pingcp'] || $pwSystem['areapush'])) {
			$managecheck = 1;
		}
		$pwPostHide = $pwSystem['posthide'];
		$pwSellHide = $pwSystem['sellhide'];
		$pwEncodeHide = $pwSystem['encodehide'];
	} else {
		$managecheck = $pwPostHide = $pwSellHide = $pwEncodeHide = 1;
	}
}

//版块查看权限
if ($foruminfo['allowread'] && !$admincheck && !allowcheck($foruminfo['allowread'],$groupid,$winddb['groups'])) {
	Showmsg('forum_read_right');
}
if (!$admincheck) {
	!$foruminfo['allowvisit'] && forum_creditcheck();
	$foruminfo['forumsell'] && forum_sell($fid);
}
if ($read['ifcheck'] == 0 && !$isGM && $windid != $read['author'] && !$pwSystem['viewcheck']) {
	Showmsg('read_check');
}
if ($read['locked']%3==2 && !$isGM && !$pwSystem['viewclose']) {
	Showmsg('read_locked');
}
unset($S_sql,$J_sql,$foruminfo['forumset']);

$creditnames = pwCreditNames();

$rewardtype = null; /*** 悬赏 ***/
//过滤匿名作者相关动态
if ($db_threadrelated && $forumset['ifrelated'] && !($read['anonymous'] && in_array($forumset['relatedcon'],array('ownpost', 'owndigest', 'ownhits', 'ownreply', 'oinfo')))) {
	if ($forumset['relatedcon'] == 'custom') {
		$relatedb = $forumset['relatedcustom'];
	} else {
		$relatedb = threadrelated($forumset['relatedcon']);
	}
}

list(,,$downloadmoney,$downloadimg) = explode("\t",$forumset['uploadset']);
$subject  = $read['subject'];
$authorid = $read['authorid'];
if ($read['ifmagic'] && $db_windmagic) {
	$ifmagic = 1;
	list($magicid,$magicname) = explode("\t",$read['magic']);
}
if (is_numeric($uid) && $read['replies'] > 0) {#只看作者回复数统计
	$rt = $db->get_one("SELECT COUNT(*) AS n FROM $pw_posts WHERE tid=".pwEscape($tid)." AND authorid=".pwEscape($uid)." AND anonymous='0' AND ifcheck='1'");
	$read['replies'] = $rt['n'];
	$sqladd = 'AND t.authorid='.pwEscape($uid)." AND t.anonymous='0'";
	$urladd = "&uid=$uid";
}
if ($openIndex) {#高楼帖子索引
	$count = $db->get_value("SELECT max(floor) FROM pw_postsfloor WHERE tid =". pwEscape($tid));
}else{
	$count = $read['replies']+1;
}

//门户阅读方式
if ($foruminfo['ifcms'] && $db_modes['area']['ifopen']) {
	InitGP(array('viewbbs'));
	if (!$viewbbs) {
		require_once R_P. 'mode/area/area_read.php';exit;
	}
	$viewbbs = $viewbbs ? "&viewbbs=$viewbbs" : "";
}
if ($winddb['p_num']) {
	$db_readperpage = $winddb['p_num'];
} elseif ($forumset['readnum']) {
	$db_readperpage = $forumset['readnum'];
}
$numofpage = ceil($count/$db_readperpage);

if ($page == 'e' || $page > $numofpage) {
	$numofpage == 1 && $page > 1 && ObHeader("read.php?tid=$tid&toread=$toread");
	$page = $numofpage;
}

$page == 1 && $read['aid'] && $_pids['tpc'] = 0;#附件 TODO 首页才读

//当前位置导航
list($guidename,$forumtitle) = getforumtitle(forumindex($foruminfo['fup'],1),1);
$guidename .= " &raquo; <a href=\"read.php?tid=$tid{$viewbbs}\">$subject</a>";
$forumtitle = '|'.$forumtitle;

//SEO关键字及描述
$db_metakeyword = substr($read['tags'],0,strpos($read['tags'],"\t"));
$db_metakeyword = (empty($db_metakeyword) ? $subject : $db_metakeyword).','.$forumtitle;
$db_metakeyword = trim(str_replace(array('|',' - ',"\t",' ',',,,',',,'),',',$db_metakeyword),',');
if ($groupid == 'guest' && !$read['ifshield']/* && !isban($read,$fid)*/) {
	$metadescrip = stripWindCode($read['content']);
	$metadescrip = strip_tags($metadescrip);
	$metadescrip = str_replace(array('"',"\n","\r",'&nbsp;','&amp;','&lt;','','&#160;'),'',$metadescrip);
	$metadescrip = substrs($metadescrip,255);
	if ($read['ifwordsfb'] != $db_wordsfb) {
		//$metadescrip = wordsfb($metadescrip,$read['ifwordsfb']);
		$wordsfb = wordsfb::getInstance();
		$metadescrip = $wordsfb->convert($metadescrip);
	}
	if (trim($metadescrip)) {
		$db_metadescrip = $metadescrip;
	}
	unset($metadescrip,$tmpAllow);
}
$db_metadescrip = $db_metadescrip.' '.$db_bbsname;
if ($db_htmifopen) {
	$link_ref_canonical = ($fpage || $uid || $toread || $skinco) ? "read{$db_dir}tid-$tid".($page>1 ? "-page-$page" : '').$db_ext : '';
} else {
	$link_ref_canonical = ($fpage || $uid || $toread || $skinco) ? "read.php?tid=$tid".($page>1 ? "&page=$page" : '') : '';
}
require_once(R_P.'require/header.php');
require_once(R_P.'require/showimg.php');
Update_ol();
$readdb = $authorids = array();

//分类信息主题帖
if ($read['modelid']) {
	$modelid = $read['modelid'];
	require_once(R_P.'lib/posttopic.class.php');
	$postTopic = new postTopic($read);
	$topicvalue = $postTopic->getTopicvalue($read['modelid']);
	$initSearchHtml = $postTopic->initSearchHtml($read['modelid']);

	foreach ($postTopic->topicmodeldb as $key => $value) {
		if ($value['cateid'] == $foruminfo['cateid']){
			$modeldb[$key] = $value;
		}
	}
}

//团购活动主题帖
$pcid = $read['special'] - 20;
if (is_numeric($pcid) && $pcid > 0) {
	require_once(R_P.'lib/postcate.class.php');
	$postCate = new postCate($read);
	list($fieldone,$topicvalue) = $postCate->getCatevalue($pcid);
	$initSearchHtml = $postCate->initSearchHtml($pcid);
	is_array($fieldone) && $read = array_merge($read,$fieldone);
	$isadminright = $postCate->getAdminright($pcid,$read['authorid']);
	list($pcuid) = $postCate->getViewright($pcid,$tid);
	$payway = $fieldone['payway'];
	$ifend = $read['endtime'] < $timestamp ? 1 : 0;
}

//特殊主题帖
if ($read['special'] == 1 && ($foruminfo['allowtype'] & 2) && ($page == 1 || $numofpage == 1)) {#投票帖
	require_once(R_P.'require/readvote.php');
} elseif ($read['special'] == 2 && ($foruminfo['allowtype'] & 4) && ($page == 1 || $numofpage == 1)) {#活动帖
	require_once(R_P.'require/readact.php');
} elseif ($read['special'] == 3 && ($foruminfo['allowtype'] & 8)) {#悬赏帖
	require_once(R_P.'require/readrew.php');
} elseif ($read['special'] == 4 && ($foruminfo['allowtype'] & 16)) {#交易帖
	require_once(R_P.'require/readtrade.php');
} elseif ($read['special'] == 5 && ($foruminfo['allowtype'] & 32)) {#辩论帖
	require_once(R_P.'require/readdebate.php');
}

//帖子回复短消息提醒
if ($db_replysitemail && $read['authorid']==$winduid && $read['ifmail']==4) {
	$sqluid = pwEscape($winduid);
	$rt = $db->get_one('SELECT replyinfo FROM pw_memberinfo WHERE uid='.$sqluid);
	$rt['replyinfo'] = str_replace(",$tid,",',',$rt['replyinfo']);
	if ($rt['replyinfo'] == ',') {
		if (getstatus($winddb['userstatus'],6)) {
			$db->update('UPDATE pw_members SET userstatus=userstatus&~(1<<5) WHERE uid='.$sqluid);
		}
		$rt['replyinfo'] = '';
	}
	$db->update('UPDATE pw_memberinfo SET replyinfo='.pwEscape($rt['replyinfo']).' WHERE uid='.$sqluid);
	$db->update("UPDATE pw_threads SET ifmail='2' WHERE tid=".pwEscape($tid));
}

if ($page == 1) {
	$read['pid'] = 'tpc';
	if ($foruminfo['allowhtm'] == 1) {#纯静态页面生成
		$htmurl = $db_htmdir.'/'.$fid.'/'.date('ym',$read['postdate']).'/'.$read['tid'].'.html';
		if (!$foruminfo['cms'] && !$toread && file_exists(R_P.$htmurl)) {
			ObHeader("$R_url/$htmurl");
		}
	}
	if (getstatus($read['tpcstatus'], 1)) {#帖子是否来自群组
		$rt = $db->get_one("SELECT a.cyid,c.cname FROM pw_argument a LEFT JOIN pw_colonys c ON a.cyid=c.id WHERE tid=" . pwEscape($tid));
		if($rt) {
			$read = $read + $rt;
		}
	}
	$readdb[] = $read;
}
$toread && $urladd .= "&toread=$toread";
$fpage > 1 && $urladd .= "&fpage=$fpage";
$pages = numofpage($count,$page,$numofpage,"read.php?tid=$tid{$urladd}$viewbbs&");

$tpc_locked = $read['locked']%3<>0 ? 1 : 0;

//更新帖子点击
if (!$db_hithour) {
	$db->update('UPDATE pw_threads SET hits=hits+1 WHERE tid='.pwEscape($tid));
} else {
	writeover(D_P.'data/bbscache/hits.txt',$tid."\t",'ab');
}

//帖子浏览记录
$readlog = str_replace(",$tid,",',',GetCookie('readlog'));
$readlog.= ($readlog ? '' : ',').$tid.',';
substr_count($readlog,',')>11 && $readlog = preg_replace("/[\d]+\,/i",'',$readlog,3);
Cookie('readlog',$readlog);

$favortitle = str_replace(array("&#39;","'","\"","\\"),array("‘","\\'","\\\"","\\\\"),$subject);
$db_bbsname_a = addslashes($db_bbsname);#模版内用到

//帖子回复信息
if ($read['replies'] > 0) {
	if ($openIndex) {#高楼索引处理
		$start_limit = (int)($page-1)*$db_readperpage-1;
		$start_limit < 0 && $start_limit = 0;
		$end = $start_limit + $db_readperpage;
		$sql_floor = " AND f.floor > " . $start_limit ." AND f.floor <= ".$end." ";
		$query = $db->query("SELECT f.pid FROM pw_postsfloor f WHERE f.tid = ". pwEscape($tid) ." $sql_floor ORDER BY f.floor");
		while ($rt = $db->fetch_array($query)) {
			$postIds[] = $rt['pid'];
		}
		if ($postIds) {
			$order = $rewardtype != null ? "t.ifreward DESC,t.postdate" : "t.postdate";
			$postIds && $sql_postId = " AND t.pid IN ( ". pwImplode($postIds,false) ." ) ";
			$query = $db->query("SELECT t.* $fieldadd FROM $pw_posts t $tablaadd WHERE t.tid=".pwEscape($tid)." $sql_postId $sqladd ORDER BY $order ");
			while ($read = $db->fetch_array($query)) {
				if ($read['ifcheck']!='1') {
					$read['subject'] = '';
					$read['content'] = getLangInfo('bbscode','post_unchecked');
				}
				$currentPostsId[] = $read['pid'];
				$currentPosts[$read['pid']] = $read;
				$_uids[$read['authorid']] = 'UID_'.$read['authorid'];
				$read['aid'] && $_pids[$read['pid']] = $read['pid'];
			}
			foreach ($postIds as $key => $value) {
				if (in_array($value,$currentPostsId)) {
					$readdb[] = $currentPosts[$value];
				}else{
					$readdb[] = array('postdate'=>'N','content'=>getLangInfo('bbscode','post_deleted'));
				}
			}
		}
	} else {#正常分页
		$readnum	 = $db_readperpage;
		$pageinverse = $page > 20 && $page > ceil($numofpage/2) ? true : false;

		if ($pageinverse) {
			$start_limit = $count-$page*$db_readperpage;
			$order = $rewardtype != null ? "t.ifreward ASC,t.postdate DESC" : "t.postdate DESC";
		} else {
			$start_limit = ($page-1)*$db_readperpage-1;
			$order = $rewardtype != null ? "t.ifreward DESC,t.postdate" : "t.postdate";
		}
		if ($start_limit < 0) {
			$readnum += $start_limit;
			$start_limit = 0;
		}
		$limit = pwLimit($start_limit,$readnum);
		$query = $db->query("SELECT t.* $fieldadd FROM $pw_posts t $tablaadd WHERE t.tid=".pwEscape($tid)." AND t.ifcheck='1' $sqladd ORDER BY $order $limit");
		while ($read = $db->fetch_array($query)) {
			$_uids[$read['authorid']] = 'UID_'.$read['authorid'];
			$read['aid'] && $_pids[$read['pid']] = $read['pid'];
			$readdb[] = $read;
		}
	}

	$db->free_result($query);
	$pageinverse && $readdb = array_reverse($readdb);
}

//读取帖子及回复的附件信息
$attachdb = $pwMembers = $colonydb = $customdb = array();
if ($_pids) {
	$query = $db->query('SELECT * FROM pw_attachs WHERE tid='.pwEscape($tid)."AND pid IN (".pwImplode($_pids).")");
	while($rt=$db->fetch_array($query)){
		if ($rt['pid'] == '0') $rt['pid'] = 'tpc';
		$attachdb[$rt['pid']][$rt['aid']] = $rt;
	}
}

//读取用户信息
if ($_uids) {
	$skey = array();
	foreach ($_uids as $key=>$value) {
		$skey[$value] = $key;
		$db_showcolony && $skey['UID_GROUP_'.$key] = $key;
		$db_showcustom && $skey['UID_CREDIT_'.$key] = $key;
	}

	$_cache = getDatastore();
	$arrValues = $_cache->get(array_keys($skey));

	$tmpUIDs = $tmpGROUPs = $tmpGROUPs = $tmpCacheData = $tmpColonydb = $tmpCustomdb = array();
	foreach ($skey as $key=>$value) {
		$prefix = substr($key,0,strrpos($key,'_'));

		switch ($prefix) {
			case 'UID' :
				if (!isset($arrValues[$key])) {
					$tmpUIDs[$key] = $value;
					$tmpCacheData[$key] = '';
				} else {
					$pwMembers[$value] = $arrValues[$key];
				}
				break;
			case 'UID_CREDIT' :
				if (!isset($arrValues[$key])) {
					$tmpCREDITs[$key] = $value;
					$tmpCustomdb[$key] = '';
				} else {
					$customdb[$value] = $arrValues[$key];
				}
				break;
			case 'UID_GROUP' :
				if (!isset($arrValues[$key])) {
					$tmpGROUPs[$key] = $value;
					$tmpColonydb[$key] = '';
				} else {
					$colonydb[$value] = $arrValues[$key];
				}
				break;
		}
	}
	if ($db_showcolony && $tmpGROUPs) {#会员群组信息
		$query = $db->query("SELECT c.uid,cy.id,cy.cname"
							. " FROM pw_cmembers c LEFT JOIN pw_colonys cy ON cy.id=c.colonyid"
							. " WHERE c.uid IN(".pwImplode($tmpGROUPs,false).") AND c.ifadmin!='-1'");
		while ($rt = $db->fetch_array($query)) {
			$colonydb[$rt['uid']] = $tmpColonydb['UID_GROUP_'.$rt['uid']] = $rt;
		}
		is_object($_cache) && $_cache->update($tmpColonydb,3600);
		$db->free_result($query);
	}

	if ($db_showcustom && $tmpCREDITs) {#自定义积分显示
		$query = $db->query("SELECT uid,cid,value FROM pw_membercredit WHERE uid IN(".pwImplode($tmpCREDITs,false).")");
		while ($rt = $db->fetch_array($query)) {
			$customdb[$rt['uid']][$rt['cid']] = $rt['value'];
			$tmpCustomdb['UID_CREDIT_'.$rt['uid']][$rt['cid']] = $rt['value'];
		}
		is_object($_cache) && $_cache->update($tmpCustomdb,300);
		$db->free_result($query);
	}

	if ($tmpUIDs) {#会员信息
		$query = $db->query("SELECT m.uid,m.username,m.gender,m.oicq,m.aliww,m.groupid,m.memberid,m.icon AS micon ,m.hack,m.honor,m.signature,m.regdate,m.medals,m.userstatus,md.postnum,md.digests,md.rvrc,md.money,md.credit,md.currency,md.thisvisit,md.lastvisit,md.onlinetime,md.starttime FROM pw_members m LEFT JOIN pw_memberdata md ON m.uid=md.uid WHERE m.uid IN (".pwImplode($tmpUIDs,false).") ");
		while ($rt = $db->fetch_array($query)) {
			is_array($pwMembers[$rt['uid']]) ? $pwMembers[$rt['uid']] += $rt : $pwMembers[$rt['uid']] = $rt;
			$tmpCacheData['UID_'.$rt['uid']] = $rt;
		}
		is_object($_cache) && $_cache->update($tmpCacheData,600);
		$db->free_result($query);
	}
	unset($skey,$_uids,$_cache,$tmpUIDs,$tmpCREDITs,$tmpGROUPs,$tmpColonydb,$tmpCustomdb,$tmpCacheData);
}
//用户禁言及词语过滤
$bandb = isban($pwMembers,$fid);
$start_limit = ($page - 1) * $db_readperpage;
$wordsfb = wordsfb::getInstance();

//帖子详细内容
$ping_logs = array();
foreach ($readdb as $key => $read) {
	$read = array_merge((array)$read,(array)$pwMembers[$read['authorid']]);
	isset($bandb[$read['authorid']]) && $read['groupid'] = 6;
	$readdb[$key] = viewread($read,$start_limit++);
	if ($db_mode == 'area') {
		$db_menuinit .= ",'td_read_".$read['pid']."':'menu_read_".$read['pid']."'";
	}
}
$wordsfb->updateWordsfb();
unset($_cache,$sign,$ltitle,$lpic,$lneed,$_G['right'],$_MEDALDB,$fieldadd,$tablaadd,$read,$order,$readnum,$pageinverse,$pwMembers,$attachdb);

//快速回复
if ($groupid != 'guest' && !$tpc_locked && ($admincheck || !$foruminfo['allowrp'] || allowcheck($foruminfo['allowrp'],$groupid,$winddb['groups'],$fid,$winddb['reply']))) {
	$psot_sta = 'reply';//control the faster reply
	$titletop1= substrs('Re:'.str_replace('&nbsp;',' ',$subject),$db_titlemax-2);
	$fastpost = 'fastpost';
	$db_forcetype = 0;
} else if($groupid == 'guest' && !$tpc_locked){//显示快速回复表单
    $fastpost = 'fastpost';
    $psot_sta = 'reply';
    $titletop1= substrs('Re:'.str_replace('&nbsp;',' ',$subject),$db_titlemax-2);
    $db_forcetype = 0;
    if((!$_G['allowrp'] && !$foruminfo['allowrp'])  || $foruminfo['allowrp']) {
        $anonymity = true;
    }
}
$db_menuinit .= ",'td_post' : 'menu_post','td_post1' : 'menu_post','td_admin' : 'menu_admin'";

//allowtype onoff

if ($foruminfo['forumcate'] == 1) {
	if ($foruminfo['allowtype'] && (($foruminfo['allowtype'] & 1) || ($foruminfo['allowtype'] & 2 && $_G['allownewvote']) || ($foruminfo['allowtype'] & 4 && $_G['allowactive']) || ($foruminfo['allowtype'] & 8 && $_G['allowreward'])|| ($foruminfo['allowtype'] & 16) || $foruminfo['allowtype'] & 32 && $_G['allowdebate'])) {
		$N_allowtypeopen = true;
	} else {
		$N_allowtypeopen = false;
	}
} elseif ($foruminfo['forumcate'] == 2) {
	if ($foruminfo['cateid'] && $foruminfo['modelid']) {
		$modelids = explode(",",$foruminfo['modelid']);
		$N_allowtopicopen = true;
	} else {
		$N_allowtopicopen = false;
	}
} elseif ($foruminfo['forumcate'] == 3) {
	if ($foruminfo['pcid']) {
		$modelids = explode(",",$foruminfo['pcid']);
		$N_allowpostcateopen = true;
	} else {
		$N_allowpostcateopen = false;
	}
}

if (defined('M_P') && file_exists(M_P.'read.php')) {
	require_once(M_P.'read.php');
}
$msg_guide = headguide($guidename);
unset($fourm,$guidename);

//评价功能开启
$rateSets = unserialize($db_ratepower);
if(!$forumset['rate'] && $rateSets[1] && isset($db_hackdb['rate'])){
	list($noAjax,$objectid,$typeid,$elementid) = array(TRUE,$tid,1,'vote_box');
	require_once 'hack/rate/index.php';
}

require_once R_P . 'require/pingfunc.php';
$ping_logs = get_pinglogs($tid, $ping_logs);
require_once PrintEot('read');
footer();

function viewread($read,$start_limit) {
	global $db,$_G,$isGM,$pwSystem,$groupid,$attach_url,$winduid,$tablecolor,$tpc_author,$tpc_buy,$tpc_pid,$tpc_tag,$count,$timestamp,$db_onlinetime,$attachdir,$attachpath,$readcolorone,$readcolortwo,$lpic,$ltitle,$imgpath,$db_ipfrom,$db_showonline,$stylepath,$db_windpost,$db_windpic,$db_signwindcode,$fid,$tid,$pid,$md_ifopen,$_MEDALDB,$rewardtype,$db_shield,$wordsfb,$db_iftag,$db_readtag;
	global $ping_logs;
	$read['lou']    = $start_limit;
	$read['jupend'] = $start_limit==$count-1 ? "<a name=a></a><a name=$read[pid]></a>" : "<a name=$read[pid]></a>";
	$tpc_buy = $read['buy'];
	$tpc_pid = $read['pid'];
	$tpc_tag = NULL;
	$tpc_shield = 0;

	$read['ifsign']<2 && $read['content'] = str_replace("\n","<br />",$read['content']);

	if ($read['anonymous']) {
		$anonymous = (!$isGM && $winduid != $read['authorid'] && !$pwSystem['anonyhide']);
		$read['anonymousname'] = $GLOBALS['db_anonymousname'];
	} else {
		$anonymous = false;
		$read['anonymousname'] = $read['username'];
	}
	$read['ipfrom'] = $db_ipfrom==1 && $_G['viewipfrom'] ? $read['ipfrom'] : '';
	$read['ip'] = ($isGM || $pwSystem['viewip']) ? 'IP:'.$read['userip'] : '';

	if ($read['groupid'] && !$anonymous) {
		$read['groupid'] == '-1' && $read['groupid'] = $read['memberid'];
		!array_key_exists($read['groupid'],(array)$lpic) && $read['groupid'] = 8;
		$read['lpic']		= $lpic[$read['groupid']];
		$read['level']		= $ltitle[$read['groupid']];
		$read['regdate']	= get_date($read['regdate'],"Y-m-d");
		$read['lastlogin']	= get_date($read['lastvisit'],"Y-m-d");
		$read['aurvrc']		= floor($read['rvrc']/10);
		$read['author']		= $read['username'];
		$tpc_author			= $read['author'];

		if (!empty($GLOBALS['showfield'])) {
			$customdata = $read['customdata'] ? (array)unserialize($read['customdata']) : array();
			$read['customdata'] = array();
			foreach ($customdata as $key => $val) {
				if ($val && in_array($key,$GLOBALS['showfield'])) {
					$read['customdata'][$key] = $val;
				}
			}
		}
		$read['ontime'] = (int)($read['onlinetime']/3600);
		$read['groupid'] == 6 && $read['honor'] = '';

		if ($read['groupid'] <> 6 && ($read['ifsign'] == 1 || $read['ifsign'] == 3)) {
			global $sign;
			if (!$sign[$read['author']]) {
				global $db_signmoney,$db_signgroup,$tdtime,$db_signcurtype;
				$curvalue = $db_signcurtype=='rvrc' ? $read['aurvrc'] : $read[$db_signcurtype];
				if ($db_signmoney && strpos($db_signgroup,",$read[groupid],") !== false && (!getstatus($read['userstatus'],10) || !$read['starttime'] || $curvalue < (($tdtime-$read['starttime'])/86400)*$db_signmoney)) {
					$read['signature'] = '';
				} else {
					if ($db_signwindcode && getstatus($read['userstatus'],9)) {
						if ($_G['right'][$read['groupid']]['imgwidth'] && $_G['right'][$read['groupid']]['imgheight']) {
							$db_windpic['picwidth']  = $_G['right'][$read['groupid']]['imgwidth'];
							$db_windpic['picheight'] = $_G['right'][$read['groupid']]['imgheight'];
						}
						if ($_G['right'][$read['groupid']]['fontsize']) {
							$db_windpic['size'] = $_G['right'][$read['groupid']]['fontsize'];
						}
						$read['signature'] = convert($read['signature'],$db_windpic,2);
					}
					$read['signature'] = str_replace("\n","<br />",$read['signature']);
				}
				$sign[$read['author']] = $read['signature'];
			} else {
				$read['signature'] = $sign[$read['author']];
			}
		} else {
			$read['signature'] = '';
		}
	} else {
		$read['lpic']   = '8';
		$read['level']  = $read['digests']   = $read['postnum'] = $read['money'] = $read['currency'] = '*';
		$read['aurvrc'] = $read['lastlogin'] = $read['credit']  = $read['regdate'] = '*';
		$read['honor']  = $read['signature'] = $read['micon']   = $read['aliww']   = '';
		if ($anonymous) {
			$read['oicq']		= $read['ip'] = $read['medals'] = $read['ipfrom'] = '';
			$read['author']		= $GLOBALS['db_anonymousname'];
			$read['authorid']	= 0;
			foreach ($GLOBALS['customfield'] as $key => $val) {
				$field = "field_".(int)$val['id'];
				$read[$field] = '*';
			}
		}
	}
	$read['face'] = showfacedesign($read['micon']);
	list($read['posttime'],$read['postdate']) = getLastDate($read['postdate']);
	$read['mark'] = $read['reward'] = $read['tag'] = NULL;
	if ($read['ifmark']) {
		$ping_logs[$read['pid']] = $read['ifmark'];
	}
	if ($rewardtype != null) {
		if ($read['lou'] == 0 || $read['ifreward'] > 0 || ($rewardtype == '0' && $winduid == $GLOBALS['authorid'] && $winduid != $read['authorid'])) {
			$read['reward'] = Getrewhtml($read['lou'],$read['ifreward'],$read['pid']);
		}
	}
	if ($read['icon']) {
		$read['icon'] = "<img src=\"$imgpath/post/emotion/$read[icon].gif\" align=\"left\" border=\"0\" />";
	} else{
		$read['icon'] = '';
	}
	if ($md_ifopen && $read['medals']) {
		$medals = $ifMedalNotExist = '';
		$md_a = explode(',',$read['medals']);
		foreach ($md_a as $key => $value) {
			if ($value && $_MEDALDB[$value]) {
				$medals .= "<img src=\"hack/medal/image/{$_MEDALDB[$value][picurl]}\" title=\"{$_MEDALDB[$value][name]}\" /> ";
			} else {
				unset($md_a[$key]);
				$ifMedalNotExist = 1;
			}
		}
		if ($ifMedalNotExist == 1) {
			$newMedalInfo = implode(',',$md_a);
			$db->update("UPDATE pw_members SET medals=".pwEscape($newMedalInfo)." WHERE uid=".pwEscape($read['authorid']));
		}
		$read['medals'] = $medals.'<br />';
	} else {
		$read['medals'] = '';
	}
	$read['leaveword'] && $read['content'] .= leaveword($read['leaveword'],$read['pid']);

	if ($db_iftag && $read['tags']) {
		list($tagdb,$tpc_tag) = explode("\t",$read['tags']);
		$tagdb = explode(' ',$tagdb);
		foreach ($tagdb as $key => $tag) {
			$tag && $read['tag'] .= "<a href=\"job.php?action=tag&tagname=".rawurlencode($tag)."\"><span class=\"s3\">$tag</span></a> ";
		}
	}
	if ($read['ifshield'] || $read['groupid'] == 6 && $db_shield) {
		if ($read['ifshield'] == 2) {
			$read['content'] = shield('shield_del_article');
			$read['subject'] = '';
			$tpc_shield = 1;
		} else {
			if ($groupid == '3') {
				$read['subject'] = shield('shield_title');
			} else {
				$read['content'] = shield($read['ifshield'] ? 'shield_article' : 'ban_article');
				$read['subject'] = '';
				$tpc_shield = 1;
			}
		}
		$read['icon'] = '';
	}
	if (!$tpc_shield) {
		$aids = array();
		if ($read['aid']) {
			$attachs = $GLOBALS['attachdb'][$read['pid']];
			$read['ifhide'] > 0 && ifpost($tid) >= 1 && $read['ifhide'] = 0;
			if (is_array($attachs) && !$read['ifhide']) {
				$aids = attachment($read['content']);
			}
		}
		if (!$wordsfb->equal($read['ifwordsfb'])) {
			$wdstruct = new wdstruct($tpc_pid == 'tpc' ? $tid : $tpc_pid, $tpc_pid == 'tpc' ? 'topic' : 'posts', $read['ifwordsfb']);
			$read['content'] = $wordsfb->convert($read['content'], $wdstruct);
		}

		if ($read['ifconvert'] == 2) {
			$read['content'] = convert($read['content'], $db_windpost);
		} else {
			$tpc_tag && $db_readtag && $read['content'] = relatetag($read['content'], $tpc_tag);
			strpos($read['content'],'[s:') !== false && $read['content'] = showface($read['content']);
		}
		if ($attachs && is_array($attachs) && !$read['ifhide']) {
			if ($winduid == $read['authorid'] || $isGM || $pwSystem['delattach']) {
				$dfadmin = 1;
			} else {
				$dfadmin = 0;
			}
			foreach ($attachs as $at) {
				$atype = '';
				$rat = array();
				if ($at['type'] == 'img' && $at['needrvrc'] == 0 && (!$GLOBALS['downloadimg'] || !$GLOBALS['downloadmoney'] || $_G['allowdownload'] == 2)) {
					$a_url = geturl($at['attachurl'],'show');
					if (is_array($a_url)) {
						$atype = 'pic';
						$dfurl = '<br>'.cvpic($a_url[0], 1, $db_windpost['picwidth'], $db_windpost['picheight'], $at['ifthumb']);
						$rat = array('aid' => $at['aid'], 'img' => $dfurl, 'dfadmin' => $dfadmin, 'desc' => $at['descrip']);
					} elseif ($a_url == 'imgurl') {
						$atype = 'picurl';
						$rat = array('aid' => $at['aid'], 'name' => $at['name'], 'dfadmin' => $dfadmin, 'verify' => md5("showimg{$tid}{$read[pid]}{$fid}{$at[aid]}{$GLOBALS[db_hash]}"));
					}
				} else {
					$atype = 'downattach';
					if ($at['needrvrc'] > 0) {
						!$at['ctype'] && $at['ctype'] = $at['special'] == 2 ? 'money' : 'rvrc';
						$at['special'] == 2 && $GLOBALS['db_sellset']['price'] > 0 && $at['needrvrc'] = min($at['needrvrc'], $GLOBALS['db_sellset']['price']);
					}
					$rat = array('aid' => $at['aid'], 'name' => $at['name'], 'size' => $at['size'], 'hits' => $at['hits'], 'needrvrc' => $at['needrvrc'], 'special' => $at['special'], 'cname' => $GLOBALS['creditnames'][$at['ctype']], 'type' => $at['type'], 'dfadmin' => $dfadmin, 'desc' => $at['descrip'], 'ext' => strtolower(substr(strrchr($at['name'],'.'),1)));
				}
				if (!$atype) continue;
				if (in_array($at['aid'], $aids)) {
					$read['content'] = attcontent($read['content'], $atype, $rat);
				} else {
					$read[$atype][$at['aid']] = $rat;
				}
			}
		}
	}
	/**
	* convert the post content
	*/
	$read['alterinfo'] && $read['content'] .= "<div id=\"alert_$read[pid]\" style=\"color:gray;margin-top:30px\">[ $read[alterinfo] ]</div>";
	if ($read['remindinfo']) {
		$remind = explode("\t",$read['remindinfo']);
		$remind[0] = str_replace("\n","<br />",$remind[0]);
		$remind[2] && $remind[2] = get_date($remind[2]);
		$read['remindinfo'] = $remind;
	}
	if ($_GET['keyword']) {
		$keywords = explode("|",$_GET['keyword']);
		foreach ($keywords as $key => $value) {
			if ($value) $read['content'] = preg_replace("/(?<=[\s\"\]>()]|[\x7f-\xff]|^)(".preg_quote($value,'/').")([.,:;-?!()\s\"<\[]|[\x7f-\xff]|$)/siU","<u><font color=\"red\">\\1</font></u>\\2",$read['content']);
		}
	}
	$GLOBALS['foruminfo']['copyctrl'] && $read['content'] = preg_replace("/<br \/>/eis","copyctrl()",$read['content']);

	return $read;
}

function threadrelated ($relatedcon) {

	global $db,$db_iftag,$db_threadrelated,$forumset,$fid,$read,$tid,$db_modes,$db_dopen,$db_phopen,$db_share_open,$db_groups_open,$groupid,$timestamp;

	$relatedb = array();

	if (in_array($relatedcon,array('allpost','alldigest','allhits','allreply','forumpost','forumdigest','forumhits','forumreply'))) {
		//require_once(R_P.'require/element.class.php');
		//$element = new Element($forumset['relatednums']);
		$element = L::loadClass('element');
		$element->setDefaultNum($forumset['relatednums']);
		switch ($relatedcon) {
			case 'allpost' :
				$relatedb = $element->newSubject();break;
			case 'alldigest' :
				$relatedb = $element->digestSubject();break;
			case 'allhits' :
				$relatedb = $element->hitSort();break;
			case 'allreply' :
				$relatedb = $element->replySort();break;
			case 'forumpost' :
				$relatedb = $element->newSubject($fid);break;
			case 'forumdigest' :
				$relatedb = $element->digestSubject($fid);break;
			case 'forumhits' :
				$relatedb = $element->hitSort($fid);break;
			case 'forumreply' :
				$relatedb = $element->replySort($fid);break;
		}
	} elseif ($relatedcon == 'oinfo') {//继续改进
		if ($db_modes['o']['ifopen']) {
			require_once("require/app_core.php");
			$addwhere = '';
			if (!$db_dopen) {
				$addwhere .= " AND type!='diary'";
			}
			if (!$db_phopen) {
				$addwhere .= " AND type!='photo'";
			}
			if (!$db_share_open) {
				$addwhere .= " AND type!='share'";
			}
			if (!$db_groups_open) {
				$addwhere .= " AND type!='colony'";
			}
			$query = $db->query("SELECT type,descrip FROM pw_feed WHERE uid=".pwEscape($read['authorid']).$addwhere." ORDER BY timestamp DESC  ".pwLimit(0,$forumset['relatednums']));
			while ($rt = $db->fetch_array($query)) {
				$rt['title'] = parseFeedRead($rt['descrip']);
				$rt['url'] = "u.php?uid=$read[authorid]";
				unset($rt['type']);
				$relatedb[] = $rt;
			}
		}

	} elseif (in_array($relatedcon,array('pictags','hottags'))) {
		$tagid = $tagdbs = array();
		$endtime = $timestamp - 30*24*3600;
		$sql = 'WHERE t.ifcheck=1 AND t.tid !='.pwEscape($tid). ' AND t.postdate >='.pwEscape($endtime);
		$fidout = array('0');
		$query = $db->query("SELECT fid,allowvisit,password FROM pw_forums WHERE type<>'category'");
		while ($rt = $db->fetch_array($query)) {
			$allowvisit = (!$rt['allowvisit'] || $rt['allowvisit'] != str_replace(",$groupid,",'',$rt['allowvisit'])) ? true : false;
			if ($rt['password'] || !$allowvisit) {
				$fidout[] = $rt['fid'];
			}
		}
		$fidout = pwImplode($fidout);
		$fidout && $sql .= " AND fid NOT IN ($fidout)";

		if ($db_iftag) {
			if ($read['tags'] && $relatedcon == 'pictags') {
				list($tagdb,$tpc_tag) = explode("\t",$read['tags']);
				$tagdbs = explode(' ',$tagdb);
			} elseif ($relatedcon == 'hottags') {
				@include_once(D_P.'data/bbscache/tagdb.php');
				$j = 0;
				foreach ($tagdb as $key => $val) {
					$j++;
					if ($j > 5) break;
					$tagdbs[] = $key;
				}
				unset($tagdb);
			}

			if ($tagdbs) {
				$query = $db->query("SELECT tagid FROM pw_tags WHERE tagname IN(" . pwImplode($tagdbs) . ')');
				while ($rt = $db->fetch_array($query)) {
					$tagid[] = $rt['tagid'];
				}
			}
			if ($tagid) {
				$query = $db->query("SELECT t.tid,t.subject FROM pw_tagdata tg LEFT JOIN pw_threads t USING(tid) $sql AND tg.tagid IN(" . pwImplode($tagid) . ") GROUP BY tid ORDER BY postdate DESC ".pwLimit(0,$forumset['relatednums']));
				while ($rt = $db->fetch_array($query)) {
					$rt['title'] = $rt['subject'];
					$rt['url'] = "read.php?tid=".$rt['tid'];
					unset($rt['subject']);
					unset($rt['tid']);
					$relatedb[] = $rt;
				}
			}
		}
	} elseif (in_array($relatedcon,array('ownpost','owndigest','ownhits','ownreply'))) {
		$endtime = $timestamp - 15*24*3600;
		$sql = "WHERE ifcheck=1 AND tid !=".pwEscape($tid). "AND postdate >=".pwEscape($endtime)." AND authorid=".pwEscape($read['authorid']);
		$orderby = '';

		switch ($relatedcon) {
			case 'ownpost' :
				$orderby .= " ORDER BY postdate DESC";
				break;
			case 'owndigest' :
				$sql .= " AND digest>0";
				$orderby .= " ORDER BY postdate DESC";
				break;
			case 'ownhits' :
				$orderby .= " ORDER BY hits DESC";
				break;
			case 'ownreply' :
				$orderby .= " ORDER BY replies DESC";
				break;
		}
		$query = $db->query("SELECT tid,subject FROM pw_threads FORCE INDEX(postdate) $sql $orderby".pwLimit(0,$forumset['relatednums']));
		while ($rt = $db->fetch_array($query)) {
			$rt['title'] = $rt['subject'];
			$rt['url'] = "read.php?tid=".$rt['tid'];
			unset($rt['subject']);
			unset($rt['tid']);
			$relatedb[] = $rt;
		}
	}

	return $relatedb;
}

function get_pinglogs($tid, $pingIdArr) {
	if (empty($pingIdArr)) return ;

	global $db,$fid;
	$pingIds = array();
	$pingLogs = array();
	foreach ($pingIdArr as $pid => $markInfo) {
		if (!preg_match("/^[0-9\:\,]*$/", $markInfo)) {
			//$markInfo = update_markinfo($fid, $tid, $pid);
			continue;
		}
		list($count, $ids) = explode(":", $markInfo);
		$pingLogs[$pid]['count'] = $count;
		$pingIds = array_merge($pingIds, explode(",", $ids));
	}
	if (!count($pingIds)) return array();
	$query = $db->query("SELECT a.*,b.uid,b.icon FROM pw_pinglog a LEFT JOIN pw_members b ON a.pinger=b.username WHERE a.id IN (".pwImplode($pingIds).") ");
	while ($rt = $db->fetch_array($query)) {
		$rt['pid'] = $rt['pid'] ? $rt['pid'] : 'tpc';
		list($rt['pingtime'],$rt['pingdate']) = getLastDate($rt['pingdate']);
		$rt['record'] = $rt['record'] ? $rt['record'] : "-";
		if ($rt['point'] > 0) $rt['point'] = "+" . $rt['point'];
		$tmp = showfacedesign($rt['icon'],true);
		$rt['icon'] = $tmp[0];
		$pingLogs[$rt['pid']]['data'][$rt['id']] = $rt;
	}
	foreach ($pingLogs as $pid => $data) {
		if (is_array($pingLogs[$pid]['data'])) krsort($pingLogs[$pid]['data']);
	}
	return $pingLogs;
}


?>