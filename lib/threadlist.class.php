<?php
/**
 * 贴子列表页
 */
class PW_ThreadList {
	var $_db;
    var $_connect = FALSE;          #缓存连接标识
    var $_tableName = "pw_threads"; #数据表名
    var $_number = 1000;            # 获取数据个数
    var $_prefix = "threadlist_";   # 缓存KEY前缀
    var $_expire = 0;               # 缓存失效时间
    var $_prePage = 20;             # 贴子列表页每页个数
    var $_exist = FALSE;            # 检查Memcache是否安装

    function PW_ThreadList() {
        $this->_init();
		$this->_db = $GLOBALS['db'];
    }

    function _init() {
        if($this->_isMemecacheOpen()) {
            $this->_exist = TRUE;
        }
    }

    /**
     * 获取贴子列表
     * @param <type> $forumId
     * @param <type> $offset
     * @param <type> $limit
     * @return <type>
     */
    function getThreads($forumId,$offset=0,$limit=20) {
        if(intval($forumId)<1){
            return null;
        }
        if($this->_exist == FALSE) {
            return $this->_getThreadsByFroumId($forumId,$offset,$limit);
        }
        $threadIds = $this->_getIdsByForumId($forumId,$offset,$limit);
		return $this->_getThreadsByThreadIds($threadIds);
    }

    /**
     *  获取版块某页的贴子ID列表
     * @param <int> $forumId
     * @param <int> $page
     * @return <array>
     */
    function _getIdsByForumId($forumId,$offset=0,$limit=20) {
        if($this->_exist == FALSE) {
            return null;
        }
        $result = $this->_getThreadIdsByForumId($forumId);
        if(!$result) {
            return null;
        }
        return array_slice($result,$offset,$limit);
    }

    /**
     * 重新排序缓存中的贴子列表
     * 如果已经存在则排序，否则弹出最后一个值，增加一个新值
     * @param <type> $forumId
     * @param <type> $threadId
     * @return <type>
     */
    function updateThreadIdsByForumId($forumId,$threadId) {
        if(intval($forumId)<1 || intval($threadId)<1){
            return null;
        }
        if($this->_exist == FALSE) {
            return null;
        }
        $result = $this->_getThreadIdsByForumId($forumId);
        if(!$result) {
            return null;
        }
        $threadId = (string)$threadId;
        $k = array_search($threadId,$result);
        if(FALSE === $k) {
            (count($result)>=$this->_number) && array_pop($result);
        }else {
            unset($result[$k]);
        }
        array_unshift($result,$threadId);
        if($result) {
            $key = $this->_getKey($forumId);
			$memcacheConnection = $this->_getMemcacheConnection();
            $memcacheConnection->set($key,$result,$this->_expire);
        }
        return $result;
    }

    /**
     * 从贴子列表中去掉贴子ID
     * @param <type> $forumId
     * @param <type> $threadId
     * @return <type>
     */
    function removeThreadIdsByForumId($forumId,$threadId) {
        if(intval($forumId)<1 || intval($threadId)<1){
            return null;
        }
        if($this->_exist == FALSE) {
            return null;
        }
        $result = $this->_getThreadIdsByForumId($forumId);
        if(!$result) {
            return null;
        }
        $threadId = (string)$threadId;
        $k = array_search($threadId,$result);
        if(FALSE === $k ) {
            return null;
        }
        unset($result[$k]);
        $key = $this->_getKey($forumId);
		$memcacheConnection = $this->_getMemcacheConnection();
        if($result){
            $memcacheConnection->set($key,$result,$this->_expire);
        }else{
            $memcacheConnection->delete($key);
        }
        return $result;
    }

    /**
     *  清空某个版块的缓存
     * @param <type> $forumId
     * @return <type>
     */
    function clearThreadIdsByForumId($forumId) {
        if(intval($forumId)<1){
            return null;
        }
        if($this->_exist == FALSE) {
            return null;
        }
        $key = $this->_getKey($forumId);
		$memcacheConnection = $this->_getMemcacheConnection();
        return $memcacheConnection->delete($key);
    }

    /**
     * 刷新某个版块的缓存
     * @param <type> $forumId
     */
    function refreshThreadIdsByForumId($forumId) {
        if(intval($forumId)<1){
            return null;
        }
        if($this->_exist == FALSE) {
            return null;
        }
        $this->clearThreadIdsByForumId($forumId);
        return $this->_getThreadIdsByForumId($forumId);
    }

    function _getThreadIdsByForumId($forumId) {
        $key = $this->_getKey($forumId);
		$memcacheConnection = $this->_getMemcacheConnection();
        $result = $memcacheConnection->get($key);
        if($result === FALSE) {
            $result = $this->_getThreadIdsByForumIdNoCache($forumId);
            if($result) {
                $memcacheConnection->set($key,$result,$this->_expire);
            }
        }
        return $result;
    }

    function _getKey($forumId) {
        return $this->_prefix.$forumId;
    }

    function _getThreadIdsByForumIdNoCache($forumId) {
        $query = $this->_db->query("SELECT tid FROM ".$this->_tableName." WHERE fid=".pwEscape($forumId)."AND ifcheck=1 ".($GLOBALS['db_topped'] ? 'AND topped<2' : '')." ORDER BY topped DESC, lastpost DESC LIMIT ".$this->_number);
        $result = array();
        while ( $rt = $this->_db->fetch_array ( $query ) ) {
            $result [] = $rt['tid'];
        }
        return $result;
    }

    function _getThreadsByFroumId($forumId,$offset,$limit) {
        $query = $this->_db->query("SELECT * FROM ".$this->_tableName." WHERE fid=".pwEscape($forumId)."AND ifcheck=1 ".($GLOBALS['db_topped'] ? 'AND topped<2' : '')." ORDER BY topped DESC, lastpost DESC LIMIT $offset,$limit");
        $result = array();
        while ( $rt = $this->_db->fetch_array ( $query ) ) {
            $result [] = $rt;
        }
        return $result;
    }

    function _getThreadsByThreadIds($threadIds) {
        if(!is_array($threadIds)){
            return null;
        }
        $query = $this->_db->query("SELECT * FROM ".$this->_tableName." WHERE tid IN (".pwImplode($threadIds,false).") ORDER BY topped DESC, lastpost DESC");
        $result = array();
        while ( $rt = $this->_db->fetch_array ( $query ) ) {
            $result [] = $rt;
        }
        return $result;
    }

    function _getMemcacheConnection() {
        if($this->_connect === FALSE) {
            $this->_connect = L::loadClass('Memcache');
        }
        return  $this->_connect;
    }

    function _getConnection() {
        return $GLOBALS['db'];
    }

	function _isMemecacheOpen() {
		return class_exists("Memcache") && strtolower($GLOBALS['db_datastore']) == 'memcache';
	}
}

?>
