<?php

!defined('P_W') && exit('Forbidden');
//api mode 7

class UserApp {
	
	var $base;
	var $db;

	function UserApp($base) {
		$this->base = $base;
		$this->db = $base->db;
	}

	function isInstall($uid) {
		$appid = array();
		$query = $this->db->query("SELECT appid FROM pw_userapp WHERE uid=" . pwEscape($uid));
		while ($rt = $this->db->fetch_array($query)) {
			$appid[] = $rt['appid'];
		}
		return new ApiResponse($appid);
	}

	function add($uid, $appid, $appname, $allowfeed) {
		global $timestamp;
		$this->db->pw_update("SELECT * FROM pw_userapp WHERE uid=".pwEscape($uid)." AND appid=".pwEscape($appid),
			"UPDATE pw_userapp SET postdate=".pwEscape($timestamp)." WHERE uid=".pwEscape($uid)." AND appid=".pwEscape($appid),
			"REPLACE INTO pw_userapp SET " . pwSqlSingle(array(
			'uid'		=> $uid,
			'appid'		=> $appid,
			'appname'	=> $appname,
			'allowfeed'	=> $allowfeed
		)));
		return new ApiResponse(true);
	}

	function appsUpdateCache($apps){
		$filename="data/bbscache/apps_list_cache.php";
		if($apps && is_array($apps)){
			$cache="<?php\r\n\$appsdb=";
			$cache.=pw_var_export($apps);
			$cache.=";\r\n?>";
			writeover(D_P.$filename,$cache);
			return new ApiResponse(true);
		}else{
			return new ApiResponse(false);
		}
	}
}
?>