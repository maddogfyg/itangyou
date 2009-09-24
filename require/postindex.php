<?php
! defined ( 'P_W' ) && exit ( 'Forbidden' );

class PostIndexDB {
	var $db;
	var $db_perpage;
	var $basename;
	
	function PostIndexDB(){
		$this->__construct();
	}
	/**
	 * @return unknown_type
	 */
	function __construct() {
		global $db;
		global $db_perpage;
		global $basename;
		$this->db = & $db;
		$this->db_perpage = $db_perpage;
		$this->basename = & $basename;
	}
	
	/**
	 * @param $perpage
	 * @return unknown_type
	 */
	function setPerpage($perpage) {
		$this->db_perpage = $perpage;
	}
	
	function getALLIndexedThreads($page = 1){
		$sql = "SELECT p.tid FROM pw_postsfloor p GROUP BY p.tid ORDER BY p.tid DESC";
		$query = $this->db->query($sql);
		$count = 0;
		(int)$page == 0 && $page = 1;
		$start = ($page - 1) * $this->db_perpage;
		$end = $start + $this->db_perpage - 1;
		while ($rt = $this->db->fetch_array($query)) {
			if ($count >= $start && $count <= $end) { 
				$tid[] = $rt['tid'];
			}
			$count++;
		}
		(! is_numeric ( $page ) || $page < 1) && $page = 1;
		$result ['pages'] = numofpage ( $count, $page, ceil ( $count / $this->db_perpage ), 
		$this->basename . "&action=search&" );
		if ($tid) {
			$sql = "SELECT t.tid, t.subject, t.replies, t.postdate 
					FROM pw_threads t 
					WHERE t.tid IN ( ". pwImplode($tid) ." ) ORDER BY t.tid DESC";
			$query = $this->db->query ( $sql );
			while ( $rt = $this->db->fetch_array ( $query ) ) {
				list ( $lastDate ) = PostIndexUtility::getLastDate ( $rt ["postdate"] );
				$rt ["postdate"] = $lastDate;
				$result ['data'] [] = $rt;
			}
		}
		return $result;
	}
	
	/**
	 * @param $replies
	 * @param $order
	 * @param $isDesc
	 * @param $page
	 * @return unknown_type
	 */
	function getThreadsByReplies($replies, $page) {
		if (! $replies) {
			return;
		}
		$sql = "SELECT p.tid FROM pw_postsfloor p GROUP BY p.tid ORDER BY p.tid DESC";
		$query = $this->db->query($sql);
		while ($rt = $this->db->fetch_array($query)) {
			$tid[] = $rt['tid'];
		}
		if ($tid) {
			$w_tid = " t.tid NOT IN ( ". pwImplode($tid) ." ) AND ";
		}
		$sql = "SELECT count(*) AS sum FROM pw_threads t WHERE $w_tid t.replies > " . pwEscape($replies);
		$rt = $this->db->get_one ( $sql );
		(! is_numeric ( $page ) || $page < 1) && $page = 1;
		$limit = pwLimit ( ($page - 1) * $this->db_perpage, $this->db_perpage );
		$result ['pages'] = numofpage ( $rt ['sum'], $page, ceil ( $rt ['sum'] / $this->db_perpage ), 
		$this->basename . "&sub=y&action=search&replies=$replies&" );
		$sql = "SELECT t.tid, t.subject, t.replies, t.postdate 
				FROM pw_threads t 
				WHERE $w_tid t.replies > ".pwEscape($replies)." $orderby $limit";
		$query = $this->db->query ( $sql );
		while ( $rt = $this->db->fetch_array ( $query ) ) {
			list ( $lastDate ) = PostIndexUtility::getLastDate ( $rt ["postdate"] );
			$rt ["postdate"] = $lastDate;
			$result ['data'] [] = $rt;
		}
		return $result;
	}
	
	/**
	 * @param $tid
	 * @return unknown_type
	 */
	function getThreadsById($tid){
		$sql = "SELECT t.tid, t.subject, t.replies, t.postdate 
				FROM pw_threads t 
				WHERE t.tid = ".pwEscape($tid)." AND t.tpcstatus & 2 = '0'";
		$rt = $this->db->get_one($sql);
		if ($rt) {
			list ( $lastDate ) = PostIndexUtility::getLastDate ( $rt ["postdate"] );
			$rt ["postdate"] = $lastDate;
			$result['data'][]=$rt;
		}
		return $result;
	}
	
	/**
	 * @param $tid
	 * @param $postTable
	 * @return unknown_type
	 */
	function resetPostIndex($tid) {
		$this->deletePostIndex ( $tid );
		$this->addPostIndex ( $tid );
	}
	
	/**
	 * @param $tid
	 * @return unknown_type
	 */
	function deletePostIndex($tid) {
		$sql = "DELETE FROM pw_postsfloor WHERE tid = ".pwEscape($tid); 
		$this->db->update ( $sql );
		$sql = "UPDATE pw_threads SET tpcstatus = tpcstatus & conv('fD',16,10) WHERE tid = ".pwEscape($tid);
		$this->db->update ( $sql );

		//临时修改，待改进
		$threads = L::loadClass('Threads');
		$threads->delThreads($tid);
	}
	
	/**
	 * @param $tid
	 * @param $postTable
	 * @return unknown_type
	 */
	function addPostIndex($tid) {
		$ptable = PostIndexDB::getPostTable ( $tid );
		$sql = "SELECT p.tid, p.pid, p.postdate 
				FROM $ptable p 
				WHERE p.tid = ".pwEscape($tid)." ORDER BY p.postdate";
		$query = $this->db->query ( $sql );
		$floor = 1;
		while ( $rt = $this->db->fetch_array ( $query ) ) {
			$this->db->update ( "INSERT INTO pw_postsfloor 
							   SET pid=" .pwEscape($rt ["pid"]). ", tid=" . pwEscape($rt ["tid"]) . ", floor=" . pwEscape($floor));
			$floor ++;
		}
		if ($floor > 1) {
			$sql = "UPDATE pw_threads SET tpcstatus = tpcstatus | 2 WHERE tid =".pwEscape($tid);
			$this->db->update ( $sql );
		}
		//临时修改，待改进
		$threads = L::loadClass('Threads');
		$threads->delThreads($tid);
	}
	
	function getPostTable($tid) {
		$sql = "SELECT t.ptable FROM pw_threads t WHERE t.tid = ".pwEscape($tid);
		$rt = $this->db->get_one ( $sql );
		$ptable = GetPtable ( $rt ['ptable'] );
		return $ptable;
	}

}

class PostIndexUtility {
	function __construct() {
	}
	/**
	 * @param $time
	 * @param $type
	 * @return unknown_type
	 */
	function getLastDate($time, $type = 1) {
		global $timestamp, $tdtime;
		static $timelang = false;
		if ($timelang == false) {
			$timelang = array ('second' => getLangInfo ( 'other', 'second' ), 'yesterday' => getLangInfo ( 'other', 'yesterday' ), 'hour' => getLangInfo ( 'other', 'hour' ), 'minute' => getLangInfo ( 'other', 'minute' ), 'qiantian' => getLangInfo ( 'other', 'qiantian' ) );
		}
		$decrease = $timestamp - $time;
		$thistime = PwStrtoTime ( get_date ( $time, 'Y-m-d' ) );
		$thisyear = PwStrtoTime ( get_date ( $time, 'Y' ) );
		$thistime_without_day = get_date ( $time, 'H:i' );
		$yeartime = PwStrtoTime ( get_date ( $timestamp, 'Y' ) );
		$result = get_date ( $time );
		if ($thistime == $tdtime) {
			if ($type == 1) {
				if ($decrease <= 60) {
					return array ($decrease . $timelang ['second'], $result );
				}
				if ($decrease <= 3600) {
					return array (ceil ( $decrease / 60 ) . $timelang ['minute'], $result );
				} else {
					return array (ceil ( $decrease / 3600 ) . $timelang ['hour'], $result );
				}
			} else {
				return array (get_date ( $time, 'H:i' ), $result );
			}
		} elseif ($thistime == $tdtime - 86400) {
			if ($type == 1) {
				return array ($timelang ['yesterday'] . " " . $thistime_without_day, $result );
			} else {
				return array (get_date ( $time, 'm-d' ), $result );
			}
		} elseif ($thistime == $tdtime - 172800) {
			if ($type == 1) {
				return array ($timelang ['qiantian'] . " " . $thistime_without_day, $result );
			} else {
				return array (get_date ( $time, 'm-d' ), $result );
			}
		} elseif ($thisyear == $yeartime) {
			return array (get_date ( $time, 'm-d' ), $result );
		} else {
			if ($type == 1) {
				return array (get_date ( $time, 'Y-m-d' ), $result );
			} else {
				return array (get_date ( $time, 'y-n-j' ), $result );
			}
		}
	}
}
?>
