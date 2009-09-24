<?php
class friend_type {
    var $db;
    function friend_type($db) {
        $this->db = $db;
    }
    function add($uid, $name) {
        return $this->db->add('friend_type', array('uid' => $uid, 'name' => $name));
    }
    function del($ftid) {
        $this->db->del('friend_type', $ftid);
    }
}
