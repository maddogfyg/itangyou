<?php
require_once('wap_global.php');

if($tid){
	$pw_tmsgs = GetTtable($tid);
	$rt = $db->get_one("SELECT t.fid,t.tid,t.subject,t.author,t.replies,t.locked,t.postdate,t.anonymous,t.ptable,tm.content FROM pw_threads t LEFT JOIN $pw_tmsgs tm ON tm.tid=t.tid WHERE t.tid=".pwEscape($tid)." AND ifcheck=1");
	if($rt['locked']==2){
		wap_msg('read_locked');
	}
	if(!$rt){
		wap_msg('illegal_tid');
	}
	$fid = $rt['fid'];
	forumcheck($fid,'read');
	InitGP(array('page'));
	$page == 'e' && $page=65535;
	$per = 5;
	(int)$page<1 && $page=1;
	$totle=ceil($rt['replies']/$per);
	$totle==0 ? $page=1 : ($page > $totle ? $page=$totle : '');
	$pages = wap_numofpage($page,$totle,"read.php?tid=$tid&amp;");
	$rt['subject']  = str_replace('&nbsp;','',wap_cv($rt['subject']));
	if($page==1){
		$rt['content']	= strip_tags($rt['content']);
		$rt['content']  = substrs($rt['content'],$db_waplimit);
		$rt['content']  = wap_cv($rt['content']);
		$rt['content']  = wap_code($rt['content']);
		$rt['postdate']	= get_date($rt['postdate']);
		$rt['author']   = $rt['anonymous'] ? $db_anonymousname : $rt['author'];
		$rt['author']   = wap_cv($rt['author']);
	}

	$satrt=($page-1)*$per;
	$id=$satrt;
	$limit=pwLimit($satrt,$per);
	$posts='';
	$pw_posts = GetPtable($rt['ptable']);
	$query=$db->query("SELECT subject,author,content,postdate,anonymous FROM $pw_posts WHERE tid=".pwEscape($rt[tid])." AND ifcheck=1 ORDER BY postdate $limit");
	while($ct=$db->fetch_array($query)){
		if($ct['content']){
			$id++;
			$ct['subject']  = str_replace('&nbsp;','',wap_cv($ct['subject']));
			$ct['content']	= strip_tags($ct['content']);
			$ct['content']	= substrs($ct['content'],$db_waplimit);
			$ct['content']  = wap_cv($ct['content']);
			$ct['content']  = wap_code($ct['content']);
			$ct['postdate']	= get_date($ct['postdate'],"m-d H:i");
			$ct['id']		= $id;
			$ct['author']   = $ct['anonymous'] ? $db_anonymousname : $ct['author'];
			$ct['author']   = wap_cv($ct['author']);
			$postdb[]		= $ct;
		}
	}
} else{
	wap_msg('illegal_tid');
}
wap_header('read',$db_bbsname);
require_once PrintEot('wap_read');
wap_footer();
?>