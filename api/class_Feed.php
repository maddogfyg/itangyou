<?php

!defined('P_W') && exit('Forbidden');
//api mode 5

class Feed {
	
	var $base;
	var $db;

	function Feed($base) {
		$this->base = $base;
		$this->db = $base->db;
	}

	function publishTemplatizedAction($uid, $descrip, $appid) {
		global $timestamp;
		$rt = $this->db->get_one("SELECT allowfeed FROM pw_userapp WHERE uid=".pwEscape($uid)." AND appid=".pwEscape($appid));
		if ($rt['allowfeed']) {
			$descrip = Char_cv($descrip);
			$this->db->update("INSERT INTO pw_feed SET " . pwSqlSingle(array(
				'uid'		=> $uid,
				'type'		=> 'app',
				'descrip'	=> $descrip,
				'timestamp'	=> $timestamp
			),false));
			return new ApiResponse(true);
		}
		return new ApiResponse(false);
	}
}
?>