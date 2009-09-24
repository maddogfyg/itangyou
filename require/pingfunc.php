<?php

function update_markinfo($fid, $tid, $pid) {
	global $db;
	$perpage = 10;
	$pid = intval($pid);
	$whereStr = " fid=".pwEscape($fid)." AND tid=".pwEscape($tid)." AND pid=" . pwEscape($pid) . " AND ifhide=0 ";
	$count = $db->get_value("SELECT COUNT(*) FROM pw_pinglog WHERE $whereStr ");
	$markInfo = "";
	if ($count) {
		$query = $db->query("SELECT id FROM pw_pinglog WHERE $whereStr ORDER BY pingdate DESC LIMIT 0,$perpage");
		$ids = array();
		while ($rt = $db->fetch_array($query)) {
			$ids[] = $rt['id'];
		}
		$markInfo = $count . ":" . implode(",", $ids);
	}
	if ($pid == 0) {
		$pw_tmsgs = GetTtable($tid);
		$db->update("UPDATE $pw_tmsgs SET ifmark=" . pwEscape($markInfo) . " WHERE tid=" . pwEscape($tid));
	} else {
		$db->update("UPDATE ".GetPtable("N",$tid)." SET ifmark=".pwEscape($markInfo)." WHERE pid=".pwEscape($pid));
	}
	return $markInfo;
}
?>