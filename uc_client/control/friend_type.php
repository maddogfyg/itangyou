<?php
class friend_typecontrol {
    var $db;
    function friend_typecontrol(&$base) {
        $this->db = $base->db;
    }
    function create($uid, $name) {
        return $this->db->create('INSERT INTO uc_friend_type (uid, name) VALUES (?, ?)', array($uid, $name));
    }
    function delete($uid, $ftid) {
        return $this->db->remove('DELETE FROM uc_friend_type WHERE ftid = ? AND uid = ?', array($ftid, $uid));
    }
}
