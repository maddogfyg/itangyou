<?php
!defined('P_W') && exit('Forbidden');
class PW_Block{
	var $db;
	function PW_Block(){
		global $db;
		$this->db = &$db;
	}
	function getData($bid){
		return $this->db->get_one("SELECT * FROM pw_block WHERE bid=".pwEscape($bid));
	}
	function getDatasBySid($sid){
		$temp	= array();
		$query	= $this->db->query("SELECT * FROM pw_block WHERE sid=".pwEscape($sid));
		while ($rt = $this->db->fetch_array($query)) {
			$temp[] = $rt;
		}
		return $temp;
	}
}
?>