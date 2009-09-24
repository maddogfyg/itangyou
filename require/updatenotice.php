<?php
!function_exists('readover') && exit('Forbidden');

function updatecache_i($fid,$aidin=null) {
	global $db,$db_windpost,$timestamp,$forum;
	require_once(R_P.'require/bbscode.php');
	include(D_P.'data/bbscache/forum_cache.php');

	$sql_where = empty($aidin) ? "fid=".pwEscape($fid) : "aid IN ($aidin)";
	$F_ffid = false; $aid = $aidcache = 0; $aids = '';
	$query = $db->query("SELECT aid,startdate,enddate,content FROM pw_announce WHERE $sql_where AND ifopen='1' AND (enddate=0 OR enddate>=".pwEscape($timestamp).") ORDER BY vieworder,startdate DESC");
	while ($rt = $db->fetch_array($query)) {
		if ($rt['startdate']<=$timestamp) {
			if ($F_ffid) {
				continue;
			} elseif (!$rt['enddate']) {
				$F_ffid = true;
			}
		}
		if (!$aid && $rt['startdate']<=$timestamp && (!$rt['enddate'] || $rt['enddate']>=$timestamp)) {
			$aid = $rt['aid'];
			if ($rt['content']!=convert($rt['content'],$db_windpost,2)) {
				$db->update("UPDATE pw_announce SET ifconvert='1' WHERE aid=".pwEscape($aid));
			}
		} else {
			$aids .= ",$rt[aid]";
		}
	}
	if ($aids) {
		$aids = substr($aids,1);
		$aidcache = $timestamp;
	}
	$db->update("UPDATE pw_forumdata SET ".pwSqlSingle(array('aid'=>$aid,'aids'=>$aids,'aidcache'=>$aidcache))."WHERE fid=".pwEscape($fid));

	if ($forum[$fid]['aid']!=$aid) {
		$forum[$fid]['aid'] = $aid;
		$forum[$fid]['aids'] = $aids;
		$forum[$fid]['aidcache'] = $aidcache;
		$forum_cache = "\$forum=".pw_var_export($forum).";";
		writeover(D_P.'data/bbscache/forum_cache.php',"<?php\r\n$forum_cache\r\n?>");
		include(D_P.'data/bbscache/forumcache.php');
		$forum_cache .= "\r\n\$forumcache='".str_replace(array("\\","'"),array("\\\\","\'"),$forumcache)."';\r\n\$cmscache='".str_replace(array("\\","'"),array("\\\\","\'"),$cmscache)."';";

		$cachedb = array();
		$query = $db->query("SELECT name,cache FROM pw_cache WHERE name IN ('forum_cache','md_config','level','gp_right','customfield','medaldb','postcache','thread_announce')");
		while ($rt = $db->fetch_array($query,MYSQL_NUM)) {
			$cachedb[$rt[0]] = "$rt[1]\r\n\r\n";
		}
		$db->free_result($query);
		if ($cachedb['forum_cache']) {
			$db->update("UPDATE pw_cache SET cache=".pwEscape($forum_cache,false)." WHERE name='forum_cache'");
		} else {
			$db->update("INSERT INTO pw_cache(name,cache) VALUES ('forum_cache',".pwEscape($forum_cache,false).")");
		}
		$cachedb['forum_cache'] = "$forum_cache\r\n\r\n";
		writeover(D_P.'data/bbscache/cache_thread.php',"<?php\r\n{$cachedb[forum_cache]}{$cachedb[thread_announce]}?>");
		writeover(D_P.'data/bbscache/cache_read.php',"<?php\r\n{$cachedb[forum_cache]}{$cachedb[md_config]}{$cachedb[level]}{$cachedb[gp_right]}{$cachedb[customfield]}{$cachedb[medaldb]}?>");
		writeover(D_P.'data/bbscache/cache_post.php',"<?php\r\n{$cachedb[forum_cache]}{$cachedb[level]}{$cachedb[postcache]}?>");
	}
}
?>