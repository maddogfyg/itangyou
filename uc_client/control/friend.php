<?php
class friendcontrol {
    var $db;
    function friendcontrol(&$base) {
        $this->db = $base->db;
    }
    function add($uid, $friendid, $descrip) {
        $friend = array((int)$uid, (int)$friendid, 0, time(), $descrip);
        return $this->db->create('INSERT INTO uc_friends (uid, friendid, status, joindate, descrip) VALUES (?, ?, ?, ?, ?)', $friend);
    }
    function delete($uid, $friendids) {
        return $this->db->remove('DELETE FROM uc_friends WHERE uid = ? AND friendid IN (' . $friendids . ')', array($uid));
    }
    function totalnum($uid, $status) {
        $status_sql = $status == -1 ? ' ' : ' AND status = ' . (int)$status;
        $record = $this->db->fetch_one('SELECT COUNT(*) AS num FROM uc_friends WHERE uid = ?' . $status_sql, array($uid));
        return (int)$record['num'];
    }
    function get_list($uid, $page, $perpage, $status) {
        $status_sql = $status == -1 ? ' ' : ' AND status = ' . (int)$status;
        return $this->db->fetch('SELECT * FROM uc_friends WHERE uid = ? ' . $status_sql . ' ORDER BY id DESC LIMIT ?, ?', array($uid, ($page-1)*$perpage, $perpage));
    }
    function add_type($ftid, $uid, $friendid) {
        return $this->db->modify('UPDATE uc_friends SET ftid = ? WHERE uid = ? AND friendid = ?', array($ftid, $uid, $friendid));
    }
}
