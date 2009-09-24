<?php
!defined('P_W') && exit('Forbidden');
/*
dbs:
	pw_tpl
	pw_invoke
	pw_invokepiece

	pw_pushdata

	pw_stamp
	pw_cachedata

	pw_mpageconfig
*/
class PW_InvokeService {
	var $_tplDB;
	var $_invokeDB;
	var $_invokePieceDB;

	var $_pushDataDB;
	var $_cacheDataDB;
	var $_stampDB;

	var $_mpageConfigDB;


/**	pw_tpl **/
	function getTpl($tplid) {
		$tplDb = $this->_getTplDB();
		return $tplDb->getData($tplid);
	}
	function insertTpl($data) {
		$tplDb = $this->_getTplDB();
		$tplDb->insertData($data);
	}
	function updateTpl($id,$data) {
		$tplDb = $this->_getTplDB();
		$tplDb->updataById($id,$data);
		$this->_updateInvokeByTplId($id);
	}
/**	pw_invoke **/
	function getInvokeByName($invokename,$cateid=0) {
		$invokeDB = $this->_getInvokeDB();
		return $invokeDB->getDataByName($invokename,$cateid);
	}
	function getInvokesByNames($names,$cateid=0,$type='') {
		$invokeDB = $this->_getInvokeDB();
		return $invokeDB->getDatasByNames($names,$cateid,$type);
	}
	function updateInvokeByName($name,$data) {
		$invokeDB = $this->_getInvokeDB();
		$invokeDB->updateByName($name,$data);
	}
	function getInvokeByTplId($tplid) {
		$invokeDB = $this->_getInvokeDB();
		return $invokeDB->getByTplId($tplid);
	}

	function _updateInvokeByTplId($tplid) {
		$parsetpl	= L::loadClass('parsetpl');
		$tempInvokes	= $this->getInvokeByTplId($tplid);
		foreach ($tempInvokes as $invoke) {
			$parsetpl->init($tplid,$invoke['name'],$invoke['ifloop']);
			$parsecode	= $parsetpl->getParseCode();
			$this->updateInvokeByName($invoke['name'],array('parsecode'=>$parsecode));

			$this->deleteInovkePieceByInvokeName($invoke['name']);		//更新所属的invokepiece
			$invokepiece = $parsetpl->getConditoin();
			$this->insertInvokePieces($invokepiece);
		}
	}
/**	pw_invokepiece **/
	function getInvokePieceByInvokeId($id) {
		$invokePieceDB = $this->_getInvokePieceDB();
		return $invokePieceDB->getDataById($id);
	}

	function getInvokePieceByInvokeName($invokename) {
		$invokePieceDB = $this->_getInvokePieceDB();
		return $invokePieceDB->getDatasByInvokeName($invokename);
	}

	function getInvokePiecesByInvokeNames($names) {
		$invokePieceDB = $this->_getInvokePieceDB();
		return $invokePieceDB->getDatasByInvokeNames($names);
	}

	function getInvokePieceByNameAndTitle($invokename,$title) {
		$invokePieceDB = $this->_getInvokePieceDB();
		return $invokePieceDB->getDataByInvokeNameAndTitle($invokename,$title);
	}

	function updateInvokePieceById($id,$array) {
		$invokePieceDB = $this->_getInvokePieceDB();
		$invokePieceDB->updateById($id,$array);
	}

	function insertInvokePiece($array) {
		$invokePieceDB = $this->_getInvokePieceDB();
		return $invokePieceDB->insertData($array);
	}

	function insertInvokePieces($array) {
		$invokePieceDB = $this->_getInvokePieceDB();
		$invokePieceDB->insertDatas($array);
	}
	function deleteInovkePieceByInvokeName($name) {
		$invokePieceDB = $this->_getInvokePieceDB();
		$invokePieceDB->deleteByInvokeName($name);
	}
	function updateInvokePieces($array) {
		if (!is_array($array) || !$array) return false;
		foreach ($array as $key=>$value) {
			if (!is_array($value)) return false;
			$this->_updateInvokePiece($value);
		}
	}
	function _updateInvokePiece($array) {
		if (!isset($array['invokename']) || !isset($array['title'])) return false;
		$temp = $this->getInvokePieceByNameAndTitle($array['invokename'],$array['title']);
		if ($temp) {
			$this->updateInvokePieceById($temp['id'],$array);
		} else {
			$this->insertInvokePiece($array);
		}
	}

/**	pw_pushdata **/

	function getPushDataById($id) {
		$pushDataDB = $this->_getPushDataDB();
		return $pushDataDB->getDataById($id);
	}

	function getPushDataEffect($invokepieceid,$fid=0,$loopid=0,$num = 10) {
		$pushDataDB = $this->_getPushDataDB();
		return $pushDataDB->getEffectData($invokepieceid,$fid,$loopid,$num);
	}
	function getPushDataOverdue($invokepieceid,$fid=0,$loopid=0,$num = 10) {
		$pushDataDB = $this->_getPushDataDB();
		return $pushDataDB->getOverdueData($invokepieceid,$fid,$loopid,$num);
	}
	function countEffectPushData($invokepieceid,$fid,$loopid) {
		$pushDataDB = $this->_getPushDataDB();
		return $pushDataDB->countEffect($invokepieceid,$fid,$loopid);
	}
	function countOverduePushData($invokepieceid,$fid,$loopid) {
		$pushDataDB = $this->_getPushDataDB();
		return $pushDataDB->countOverdue($invokepieceid,$fid,$loopid);
	}
	function insertPushData($array) {
		$pushDataDB = $this->_getPushDataDB();
		return $pushDataDB->insertData($array);
	}
	function updatePushData($id,$array) {
		$pushDataDB = $this->_getPushDataDB();
		$pushDataDB->update($id,$array);
	}
	function deletePushData($id) {
		$pushDataDB = $this->_getPushDataDB();
		$pushDataDB->delete($id);
	}

	function deleteOverduePushData($invokepieceid,$fid,$loopid) {
		$pushDataDB = $this->_getPushDataDB();
		$pushDataDB->deleteOverdues($invokepieceid,$fid,$loopid);
	}

/**	pw_stamp **/

	function getStampBlocks($stamp) {
		$stampDB = $this->_getStampDB();
		return $stampDB->getBlocksByStamp($stamp);
	}
/**	pw_cachedata **/
	function updateCacheDataPiece($invokepieceid,$fid=0,$loopid=0) {
		$this->deleteCacheData($invokepieceid,$fid,$loopid);
		updateAreaStaticRefreshTime();
	}
	function deleteCacheData($invokepieceid,$fid=0,$loopid=0) {
		$cacheDataDB = $this->_getCacheDataDB();
		$cacheDataDB->deleteData($invokepieceid,$fid,$loopid);
	}

/**	pw_mpageconfig **/

	function getMPageConfig($mode,$SCR,$fid=0) {
		$temp_fid	= $this->getMPageConfigFid($fid);
		$mpageConfigDB = $this->_getMPageConfigDB();
		return $mpageConfigDB->getConfig($mode,$SCR,$temp_fid);
	}
	function getMPageConfigFid($fid) {
		$mpageConfigDB = $this->_getMPageConfigDB();
		return $mpageConfigDB->getAreaFid($fid);
	}
	function getMPageConfigInvoke($db_mode,$SCR,$fid=0) {
		$mpageConfigDB = $this->_getMPageConfigDB();
		return $mpageConfigDB->getInvokes($db_mode,$SCR,$fid);
	}


/** getDBs **/
	function _getTplDB() {
		return L::loadDB('Tpl');
	}
	function _getInvokeDB() {
		return L::loadDB('Invoke');
	}
	function _getInvokePieceDB() {
		return L::loadDB('InvokePiece');
	}

	function _getPushDataDB() {
		return L::loadDB('PushData');
	}
	function _getStampDB() {
		return L::loadDB('Stamp');
	}
	function _getCacheDataDB() {
		return L::loadDB('CacheData');
	}
	function _getMPageConfigDB() {
		return L::loadDB('MPageConfig');
	}
}
?>