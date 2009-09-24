<?php
!function_exists('adminmsg') && exit('Forbidden');
$basename="$admin_file?adminjob=ptable";

if (!$action) {

	if (!$_POST['step']) {

		$tmsgdb  = $postdb = array();
		$tlistdb = unserialize($db_tlist);
		$query = $db->query("SHOW TABLE STATUS LIKE 'pw_tmsgs%'");
		while($rs=$db->fetch_array($query)){
			if($GLOBALS['PW']){
				$key = substr(str_replace($GLOBALS['PW'],'pw_',$rs['Name']),8);
			}else{
				$key = substr($rs['Name'],5);
			}
			if ($key && !is_numeric($key)) continue;
			$pw_tmsgs = 'pw_tmsgs'.$key;
			@extract($db->get_one("SELECT MIN(tid) AS tmin,MAX(tid) AS tmax FROM $pw_tmsgs"));
			$rs['tmin'] = $tmin;
			$rs['tmax'] = $tmax;
			list($rs['tidmin'],$rs['tidmax'])=maxmin($key);
			$rs['Data_length'] = round(($rs['Data_length']+$rs['Index_length'])/1048576,2);
			$tmsgdb[$key] = $rs;
		}

		$query = $db->query("SHOW TABLE STATUS LIKE 'pw_posts%'");
		while($rs=$db->fetch_array($query)){
			if($GLOBALS['PW']){
				$key = substr(str_replace($GLOBALS['PW'],'pw_',$rs['Name']),8);
			}else{
				$key = substr($rs['Name'],5);
			}
			if ($key && !is_numeric($key)) continue;
			$rs['sel'] = $key==$db_ptable ? 'checked' : '';
			$pw_posts  = GetPtable($key);
			@extract($db->get_one("SELECT MIN(tid) AS tmin,MAX(tid) AS tmax FROM $pw_posts"));
			$rs['tmin'] = $tmin;
			$rs['tmax'] = $tmax;
			$rs['Data_length'] = round(($rs['Data_length']+$rs['Index_length'])/1048576,2);
			$postdb[$key] = $rs;
		}
		require_once PrintEot('ptable');

	} elseif ($_POST['step'] == '3') {

		InitGP(array('ttable'),'P');
		if (is_array($ttable)) {
			arsort($ttable);
			foreach ($ttable as $key => $value) {
				!is_numeric($value) && adminmsg('numerics_checkfailed');
			}
			$ttable = serialize($ttable);
		} else {
			$ttable = '';
		}
		setConfig('db_tlist', $ttable);
		updatecache_c();
		adminmsg('operate_success');

	} elseif ($_POST['step'] == '5') {

		InitGP(array('ktable'),'P');
		setConfig('db_ptable', $ktable);

		$plist = '';
		$query = $db->query("SHOW TABLE STATUS LIKE 'pw_posts%'");
		while ($rs = $db->fetch_array($query)) {
			$j = str_replace($PW.'posts','',$rs['Name']);
			$j && $plist .= $j.',';
		}
		$plist = substr($plist,0,-1);
		setConfig('db_plist', $plist);
		updatecache_c();
		adminmsg('operate_success');
	}
} elseif ($action == 'create') {

	$num_a = array();
	if ($type == 1) {
		$query = $db->query("SHOW TABLE STATUS LIKE 'pw_tmsgs%'");
		while ($rs = $db->fetch_array($query)) {
			$j = str_replace($PW.'tmsgs','',$rs['Name']);
			$num_a[] = (int)$j;
		}
		$num = max($num_a)+1;
		$table = 'pw_tmsgs'.$num;
		$CreatTable = $db->get_one("SHOW CREATE TABLE pw_tmsgs");
		$sql = str_replace($CreatTable['Table'],$table,$CreatTable['Create Table']);
		$db->query($sql);
		if ($db_tlist) {
			$tlistdb = unserialize($db_tlist);
			$tidmax  = max($tlistdb);
		} else {
			$tlistdb = array();
			$tidmax  = 0;
		}
		@extract($db->get_one("SELECT MAX(tid) AS tid FROM pw_threads"));
		$tidmax = max($tidmax,$tid);
		$tlistdb[$num] = $tidmax + 100;
		arsort($tlistdb);
		$db_tlist = serialize($tlistdb);
		setConfig('db_tlist', $db_tlist);
	} else {
		$i = 0;
		$plist = '';
		$query = $db->query("SHOW TABLE STATUS LIKE 'pw_posts%'");
		while ($rs = $db->fetch_array($query)) {
			$i++;
			$j = str_replace($PW.'posts','',$rs['Name']);
			$j && $plist .= $j.',';
			$num_a[]=$j;
		}
		if ($i == 1) {
			extract($db->get_one("SELECT MAX(pid) AS pid FROM pw_posts"));
			$db->update("REPLACE INTO pw_pidtmp SET pid=".pwEscape($pid,false));
			$num = 1;
		} else{
			$num = max($num_a)+1;
		}
		$table = 'pw_posts'.$num;
		$CreatTable = $db->get_one("SHOW CREATE TABLE pw_posts");
		$sql = str_replace($CreatTable['Table'],$table,$CreatTable['Create Table']);
		$db->query($sql);

		$plist .= $num;
		setConfig('db_ptable', $num);
		setConfig('db_plist', $plist);
	}
	updatecache_c();
	adminmsg('operate_success');

} elseif ($action == 'movedata') {

	InitGP(array('step'));

	if (!$step) {

		$table_sel = '';
		$query = $db->query("SHOW TABLE STATUS LIKE 'pw_posts%'");
		while ($rs = $db->fetch_array($query)) {
			$key = substr(str_replace($GLOBALS['PW'],'pw_',$rs['Name']),8);
			if ($key && !is_numeric($key)) continue;
			$table_sel .= "<option value=\"$key\">$rs[Name]</option>";
		}
		require_once PrintEot('ptable');

	} else {

		$pwServer['REQUEST_METHOD'] != 'POST' && PostCheck($verify);
		set_time_limit(0);
		$db_bbsifopen && adminmsg('bbs_open');
		InitGP(array('tstart','tend','tfrom','tto','lines'));

		$tfrom = (int) $tfrom;
		$tto   = (int) $tto;
		if ($tfrom == $tto) {
			adminmsg('table_same');
		}
		!$lines && $lines=200;
		!$tstart && $tstart=0;

		$ftable = $tfrom ? 'pw_posts'.$tfrom : 'pw_posts';
		$ttable = $tto   ? 'pw_posts'.$tto   : 'pw_posts';
		if (!$tend) {
			@extract($db->get_one("SELECT MAX(tid) AS tend FROM $ftable"));
		}
		$end = $tstart + $lines;
		$end > $tend && $end = $tend;
		$db->update("INSERT INTO $ttable SELECT * FROM $ftable WHERE tid>".pwEscape($tstart).'AND tid<='.pwEscape($end));
		$db->update("DELETE FROM $ftable WHERE tid>".pwEscape($tstart)."AND tid<=".pwEscape($end));
		$db->update("UPDATE pw_threads SET ptable=".pwEscape($tto)."WHERE tid>".pwEscape($tstart)."AND tid<=".pwEscape($end)."AND ptable=".pwEscape($tfrom));

		if ($end < $tend) {
			$step++;
			$j_url="$basename&action=$action&step=$step&tstart=$end&tend=$tend&tfrom=$tfrom&tto=$tto&lines=$lines";
			adminmsg('table_change',EncodeUrl($j_url),2);
		} else {

			$_cache = getDatastore();
			$_cache->flush();

			adminmsg('operate_success');
		}
	}
} elseif ($action == 'movetmsg') {

	InitGP(array('step','id'));
	$tlistdb = unserialize($db_tlist);

	if (!$step) {

		$id < 1 && $id = '';
		$pw_tmsgs = 'pw_tmsgs'.$id;
		@extract($db->get_one("SELECT MIN(tid) AS tmin,MAX(tid) AS tmax FROM $pw_tmsgs"));
		list($tidmin,$tidmax) = maxmin($id);
		$tiderror = '';
		$tmin<=$tidmin && $tiderror .= "$tmin - ".($tmax > $tidmin ? $tidmin : $tmax)." &nbsp;&nbsp;";
		$tidmax && $tmax > $tidmax && $tiderror .= ($tidmax+1)." - $tmax";
		$tiderror=='' && adminmsg('operate_undefined');
		require_once PrintEot('ptable');

	} else {

		$pwServer['REQUEST_METHOD']!='POST' && PostCheck($verify);
		set_time_limit(0);
		$db_bbsifopen && adminmsg('bbs_open');
		InitGP(array('tstart','lines','tmax','tmin'));
		list($tidmin,$tidmax) = maxmin($id);
		!$lines && $lines=5000;

		if ($tmin <= $tidmin && $step < 3) {
			!$tstart && $tstart = $tmin-1;
			$end  = $tstart + $lines;
			$tend = $tmax > $tidmin ? $tidmin : $tmax;
			$end > $tend && $end = $tend;
			$ttable = GetTtable($end);
			$step = 2;
		} else {
			!$tstart && $tstart = $tidmax;
			$end  = $tstart + $lines;
			$tend = $tmax;
			$end > $tend && $end = $tend;
			$ttable = GetTtable($tstart+1);
			$step = 3;
		}
		$ftable = 'pw_tmsgs'.$id;
		$ftable == $ttable && adminmsg('table_same');

		$db->update("INSERT INTO $ttable SELECT * FROM $ftable WHERE tid>".pwEscape($tstart).'AND tid<='.pwEscape($end));
		$db->update("DELETE FROM $ftable WHERE tid>".pwEscape($tstart).'AND tid<='.pwEscape($end));

		if ($end < $tend) {
			$j_url = "$basename&action=$action&step=$step&tstart=$end&lines=$lines&tmax=$tmax&tmin=$tmin&id=$id";
			adminmsg('table_change',EncodeUrl($j_url),2);
		} elseif ($step == 2 && $tidmax && $tmax > $tidmax) {
			$step  = 3;
			$j_url = "$basename&action=$action&step=$step&lines=$lines&tmax=$tmax&tmin=$tmin&id=$id";
			adminmsg('table_change',EncodeUrl($j_url),2);
		} else {
			adminmsg('operate_success');
		}
	}
} elseif ($action == 'delttable') {

	InitGP('id','GP',2);
	$rt = $db->get_one("SHOW TABLE STATUS LIKE 'pw_tmsgs$id'");
	if ($rt && $rt['Rows']) {
		adminmsg('deltable_error2');
	}
	$rt && $db->update("DROP TABLE pw_tmsgs$id",0);
	$tlistdb = unserialize($db_tlist);
	unset($tlistdb[$id]);
	$db_tlist = $tlistdb ? serialize($tlistdb) : '';
	setConfig('db_tlist', $db_tlist);
	updatecache_c();
	adminmsg('operate_success');

} elseif ($action == 'delptable') {

	InitGP('id','GP',2);
	if ($id == $db_ptable) {
		adminmsg('delptable_error');
	}
	$rt = $db->get_one("SHOW TABLE STATUS LIKE 'pw_posts$id'");
	if ($rt && $rt['Rows']) {
		adminmsg('deltable_error2');
	}
	$rt && $db->update("DROP TABLE pw_posts$id",0);
	$plist = '';
	$query = $db->query("SHOW TABLE STATUS LIKE 'pw_posts%'");
	while ($rs = $db->fetch_array($query)) {
		$j = str_replace($PW.'posts','',$rs['Name']);
		$j && $plist .= $j.',';
	}
	$plist = substr($plist,0,-1);
	setConfig('db_plist', $plist);
	updatecache_c();
	adminmsg('operate_success');
}
?>