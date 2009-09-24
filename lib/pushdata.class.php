<?php
!defined('P_W') && exit('Forbidden');
class PW_pushData{
	var $db;
	function PW_pushData(){
		global $db;
		$this->db = &$db;
	}

	function getEffectData($invokepieceid,$fid=0,$loopid=0,$num = 10){
		return $this->_getDatas('effect',$invokepieceid,$fid,$loopid,$num);
	}
	function getOverdueData($invokepieceid,$fid=0,$loopid=0,$num = 10){
		return $this->_getDatas('overdue',$invokepieceid,$fid,$loopid,$num);
	}
	function countEffect($invokepieceid,$fid,$loopid){
		return $this->_countByInvokepiece('effect',$invokepieceid,$fid,$loopid);
	}
	function countOverdue($invokepieceid,$fid,$loopid){
		return $this->_countByInvokepiece('overdue',$invokepieceid,$fid,$loopid);
	}
	function getDataById($id){
		$temp	= $this->db->get_one("SELECT * FROM pw_pushdata WHERE id=".pwEscape($id));
		if ($temp) {
			$temp['data'] = unserialize($temp['data']);
		}
		return $temp;
	}

	function insertData($array){
		!$array['offset'] && $array['offset'] = 0;
		if (!isset($array['invokepieceid']) || !isset($array['fid']) || !isset($array['loopid'])) {
			Showmsg('pushdata_insert_data_error');
		}
		$temp	= $this->_getDataByOffset($array['offset'],$array['invokepieceid'],$array['fid'],$array['loopid']);
		if ($temp) {
			global $timestamp;
			$this->update($temp['id'],array('endtime'=>$timestamp));
		}
		return $this->_insertData($array);
	}
	function update($id,$array){
		$array = $this->_checkData($array);
		$this->db->update("UPDATE pw_pushdata SET ".pwSqlSingle($array,false)." WHERE id=".pwEscape($id));
	}
	function delete($id){
		$this->db->update("DELETE FROM pw_pushdata WHERE id=".pwEscape($id));
	}
	function deleteOverdues($invokepieceid,$fid,$loopid){
		$sqladd	= $this->_getAddSqlByType('overdue');
		$this->db->update("DELETE FROM pw_pushdata WHERE invokepieceid=".pwEscape($invokepieceid)." AND fid=".pwEscape($fid)." AND loopid=".pwEscape($loopid)." $sqladd");
	}

	/*
	 * private functions
	 */
	function _countByInvokepiece($type,$invokepieceid,$fid,$loopid){
		$sqladd	= $this->_getAddSqlByType($type);
		return $this->db->get_value("SELECT COUNT(*) AS count FROM pw_pushdata WHERE invokepieceid=".pwEscape($invokepieceid)." AND fid=".pwEscape($fid)." AND loopid=".pwEscape($loopid)." $sqladd");
	}
	function _getDatas($type,$invokepieceid,$fid=0,$loopid=0,$num = 10){
		$temp	= array();
		$sqladd	= $this->_getAddSqlByType($type);
		list($start,$num)	= $this->_parseNum($num);
		$query	= $this->db->query("SELECT * FROM pw_pushdata WHERE invokepieceid=".pwEscape($invokepieceid)." AND fid=".pwEscape($fid)." AND loopid=".pwEscape($loopid)." $sqladd ORDER BY offset ASC,starttime DESC ".pwLimit($start,$num));
		while ($rt = $this->db->fetch_array($query)) {
			$rt['data'] = unserialize($rt['data']);
			$temp[$rt['id']] = $rt;
		}
		return $temp;
	}

	function _getAddSqlByType($type){
		global $timestamp;
		$sqladd	= '';
		if ($type=='effect') {
			$sqladd	= ' AND (endtime>'.pwEscape($timestamp).' OR endtime=0)';
		} else if ($type=='overdue') {
			$sqladd	= ' AND endtime<'.pwEscape($timestamp).' AND endtime<>0';
		}
		return $sqladd;
	}

	function _parseNum($num){
		$num_temp	= explode(',',$num);
		if (count($num_temp)==2) {
			$start	= $num_temp[0];
			$num	= $num_temp[1];
		} else {
			$start	= 0;
			$num	= $num_temp[0];
		}
		return array($start,$num);
	}

	function _insertData($array){
		$array = $this->_checkData($array);
		if (!$array['invokepieceid'] || !$array['data']) {
			Showmsg('pushdata_insert_data_error');
		}
		$this->db->update("INSERT INTO pw_pushdata SET ".pwSqlSingle($array,false));
		return $this->db->insert_id();
	}

	function _getDataByOffset($offset,$invokepieceid,$fid=0,$loopid=0){
		global $timestamp;
		$temp	= $this->db->get_one("SELECT * FROM pw_pushdata WHERE invokepieceid=".pwEscape($invokepieceid)." AND fid=".pwEscape($fid)." AND loopid=".pwEscape($loopid)." AND offset=".pwEscape($offset)." AND (endtime>".pwEscape($timestamp)." OR endtime=0)");
		if ($temp) {
			$temp['data'] = unserialize($temp['data']);
		}
		return $temp;
	}

	function _getStruct(){
		return array('id','invokepieceid','fid','loopid','uid','starttime','endtime','offset','data');
	}

	function _checkData($array){
		if (!is_array($array)) Showmsg('data_is_not_array');
		$strtct = $this->_getStruct();
		foreach ($array as $key=>$value) {
			if (!in_array($key,$strtct)) {
				unset($array[$key]);
			}
		}
		if ($array['data'] && is_array($array['data'])) {
			foreach ($array['data'] as $key=>$value) {
				$array['data'][$key] = stripslashes($value);
			}
			$array['data']	= serialize($array['data']);
		}
		return $array;
	}
}
?>