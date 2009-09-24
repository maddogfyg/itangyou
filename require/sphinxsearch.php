<?php
InitGP(array('pwuser','sch_time','method','orderway','asc','ptable'));
if($sch_type=='user'){
	$pwuser=$keyword;
	$keyword='';
}
$q=$method=='AND' ? str_replace('|',' ',$keyword) : $keyword;

if ($sch_area==0) {
	$index='threadsindex';
	$groupby='';
}elseif($sch_area==1){
	$index='tmsgsindex';
	$groupby='';
}else{
	$index=$ptable ? 'posts1index' : 'postsindex';
	$groupby='tid';
}
if ($seekfid!='all') {
	if ($forum[$seekfid]['type']=='category') {
		Showmsg('search_cate');
	}
	$fidout=str_replace(' ','',$fidout);
	if (strpos(",$fidout,",",'$seekfid',")!==false) {
		Showmsg('search_forum_right');
	}
	$fids=array($seekfid);
	$fidexclude = false;
} elseif ($fidout) {
	$fids = explode(',',str_replace('\'','',$fidout));
	$fidexclude = true;
}else{
	$fids = '';
	$fidexclude = false;
}
$sortby=($orderway!='replies' && $orderway!='hits') ? 'lastpost' : $orderway;
$asc!='ASC' && $asc = 'DESC';
if ($pwuser) {
	!str_replace('*','',$pwuser) && Showmsg('illegal_author');
	$uids = array();
	$pwuser = str_replace(array('%','_'),array('\%','\_'),addslashes(trim($pwuser)));
	$pwuser = str_replace('*','_',$pwuser);//noizyfeng
	$query = $db->query("SELECT uid FROM pw_members WHERE username LIKE ".pwEscape($pwuser));
	while ($rt = $db->fetch_array($query)) {
		$uids[] = $rt['uid'];
	}
	!$uids && Showmsg('user_not_exists');
} elseif (is_numeric($authorid)) {
	$uids = array($authorid);
}
if ($sch_time && $sch_time!='all') {
	!is_numeric($sch_time) && $sch_time = 86400;
	$sch_timemin=$timestamp-$sch_time;
	$sch_timemax=$timestamp+86400;
}
$result=searchfunc($q,$method,$index,$digest,$fids,$fidexclude,$sortby,$asc,$uids,$sch_timemin,$sch_timemax,$groupby,$db_perpage);
$total=$result[0];
if(!$result[1]){
	Showmsg('search_none');
}
$keyword_A=$result[2];

$query = $db->query("SELECT tid,fid,titlefont,author,authorid,subject,postdate,lastpost,lastposter,hits,replies,locked,special,anonymous FROM pw_threads WHERE tid IN($result[1]) ORDER BY $sortby $asc");
while ($rt = $db->fetch_array($query)) {
	if ($rt['anonymous'] && $rt['author']!=$windid) {
		if ($groupid!='3') continue;
		$rt['author'] = $db_anonymousname;
		$rt['authorid'] = 0;
	}
	if ($rt['titlefont']) {
		$titledetail = explode('~',$rt['titlefont']);
		if ($titledetail[0]) $rt['subject'] = "<font color=\"$titledetail[0]\">$rt[subject]</font>";
		if ($titledetail[1]) $rt['subject'] = "<b>$rt[subject]</b>";
		if ($titledetail[2]) $rt['subject'] = "<i>$rt[subject]</i>";
		if ($titledetail[3]) $rt['subject'] = "<u>$rt[subject]</u>";
	}
	foreach ($keyword_A as $value) {
		$value && $rt['subject'] = preg_replace('/(?<=[^\w=]|^)('.preg_quote($value,'/').')(?=[^\w=]|$)/si','<font color="red"><u>\\1</u></font>',$rt['subject']);
	}
	if ($rt['special']==1) {
		$rt['status'] = !$rt['locked'] ? 'vote' : 'votelock';
	} elseif ($rt['locked']>0) {
		$rt['status'] = $rt['locked']==1 ? 'topiclock' : 'topicclose';
	} else {
		$rt['status'] = $rt['replies']>=10 ? 'topichot' : 'topicnew';
	}
	$rt['forumname'] = $forum[$rt['fid']]['name'];
	$rt['postdate'] = get_date($rt['postdate'],"Y-m-d");
	$rt['lastpost'] = get_date($rt['lastpost']);
	$rt['lastposterraw'] = rawurlencode($rt['lastposter']);
	$schdb[] = $rt;
}
$db->free_result($query);
if ($newatc && $total > 50) {
	$total = 500;
}
if ($total > $db_perpage) {
	$addpage="&method=$method&sch_area=$sch_area&seekfid=$seekfid&orderway=$orderway&asc=$asc";
	$keyword && $addpage .= "&keyword=".rawurlencode($keyword);
	$ptable && $addpage .= "&ptable=$ptable";
	$digest && $addpage .= "&digest=$digest";
	$pwuser && $addpage .= "&pwuser=".rawurlencode($pwuser);
	$authorid && $addpage .= "&authorid=$authorid";
	$sch_time && $addpage .= "&sch_time=$sch_time";
	$newatc && $addpage .= "&newatc=$newatc";

	require_once(R_P.'require/forum.php');
	$numofpage = ceil($total/$db_perpage);
	(int)$page<1 && $page = 1;
	$pages = numofpage($total,$page,$numofpage,"search.php?step=2$addpage&");
}
require_once PrintEot('search');footer();

function searchfunc($q,$method,$index,$digest,$fid,$exclude,$sortby,$asc,$authorids,$sch_timemin,$sch_timemax,$groupby,$db_perpage){
	global $db_sphinx;
	require ( "lib/sphinx.class.php" );
	$mode=($method=='AND' || strpos($q,'|')===false)? SPH_MATCH_ALL : SPH_MATCH_ANY;
	$q=str_replace('|',' ',$q);
	$host = $db_sphinx['host'];
	$port = intval($db_sphinx['port']);
	$groupsort = "@group desc";
	$distinct = "";
	$ranker = SPH_RANK_PROXIMITY_BM25;
	$cl = new SphinxClient ();
	$cl->SetServer ( $host, $port );
	$cl->SetConnectTimeout ( 1 );
	//$cl->SetWeights ( array ( 100, 1 ) );
	$cl->SetMatchMode ( $mode );
	$digest && $cl->SetFilter ('digest',array(1,2));
	$fid && $cl->SetFilter ('fid',$fid,$exclude);
	$authorids && $cl->SetFilter ('authorid',$authorids);
	if($sch_timemin && $sch_timemax){
		$cl->SetFilterRange('postdate',$sch_timemin,$sch_timemax);
	}
	$groupby && $cl->SetGroupBy ( $groupby, SPH_GROUPBY_ATTR, $groupsort );
	$sortby && $cl->SetSortMode ( ($asc=='DESC' ? SPH_SORT_ATTR_DESC : SPH_SORT_ATTR_ASC), $sortby );
	if(isset($_GET['page'])){
		$page = $_GET['page'];
	}else{
		$page = 1;
	}
	$page = max(1, intval($page));
	$start_limit = intval(($page - 1) * $db_perpage);
	$cl->SetLimits ( $start_limit, intval($db_perpage), ( $db_perpage>1000 ) ? $db_perpage : 1000 );
	$cl->SetRankingMode ( $ranker );
	$cl->SetArrayResult ( true );
	$res = $cl->Query ( $q, $index );

	if ( $res===false ){
		return false;
	} else{
		require_once(R_P.'wap/chinese.php');
		$chs = new Chinese('utf8','gbk');
		foreach ( $res["words"] as $word => $info ){
			$words[]=$chs->Convert($word);
		}
		$totals=$res['total'];
		if ( is_array($res["matches"]) ){
			$tids='';
			foreach ( $res["matches"] as $docinfo ){
				$tids && $tids.=',';
				if(strpos($index,'tmsgs')!==false || strpos($index,'threads')!==false){
					$tids .= $docinfo['id'];
				}else{
					$tids .= $docinfo['attrs']['tid'];
				}
			}
			return array($totals,$tids,$words);
		}else{
			return false;
		}
	}
}
?>