<?php
class messagecontrol {
    var $db;
    function messagecontrol(&$base) {
        $this->db = $base->db;
    }
    function send($fromuid, $username, $touid, $title, $content, $save_to_sebox) {
        if (strlen($title) > 130 || strlen($content) > 65535) {
            return false;
        }
        $mdate = time();
        $result1 = $this->db->create('INSERT INTO uc_messages (fromuid,username,touid,mdate,ifnew,`type`,title,content) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', array($fromuid, $username, $touid, $mdate, 1, 'rebox', $title, $content));
        if ($save_to_sebox) {
            $result2 = $this->db->create('INSERT INTO uc_messages (fromuid,username,touid,mdate,ifnew,`type`,title,content) VALUES (?,?,?,?,?,?,?,?)', array($fromuid, $username, $touid, $mdate, 0, 'sebox', $title, $content));
        }
        $extra = $this->db->fetch_one("SELECT * FROM uc_messages_user WHERE uid = " . (int)$touid);
        if ($extra === null) {
            $this->db->create("INSERT INTO uc_messages_user (uid,newpm,delmsg,readmsg) VALUES (?,'1','','')", array($touid));
        }
        $result3 = $this->db->modify("UPDATE uc_messages_user SET newpm = 1 WHERE uid = " . (int)$touid);
        return $save_to_sebox ? ($result1 && $result2) : $result1;
    }
    function delete_rebox($ids, $uid) {
        return $this->db->remove("DELETE FROM uc_messages WHERE touid = ? AND `type` = 'rebox' AND mid IN (?)", array($uid, $ids));
    }
    function delete_sebox($ids, $uid) {
        return $this->db->remove("DELETE FROM uc_messages WHERE touid = ? AND `type` = 'sebox' AND mid IN (?)", array($uid, $ids));
    }
    function count_rebox($uid) {
        $record = $this->db->fetch_one("SELECT COUNT(*) AS num FROM uc_messages WHERE touid = ? AND `type` = 'rebox'", array($uid));
        return (int)$record['num'];
    }
    function count_sebox($uid) {
        $record = $this->db->fetch_one("SELECT COUNT(*) AS num FROM uc_messages WHERE fromuid = ? AND `type` = 'sebox'", array($uid));
        return (int)$record['num'];
    }
    function rebox_list($uid, $page, $num_per_page) {
        if ($page < 1) {
            $page = 1;
        }
        $sql = "SELECT * FROM uc_messages WHERE touid = ? AND `type` = 'rebox' ORDER BY mid DESC LIMIT ?, ?";
        return $this->db->fetch($sql, array($uid, ($page - 1) * $num_per_page, $num_per_page));
    }
    function sebox_list($uid, $page, $num_per_page) {
        if ($page < 1) {
            $page = 1;
        }
        $sql = "SELECT * FROM uc_messages WHERE fromuid = ? AND `type` = 'sebox' ORDER BY mid DESC LIMIT ?, ?";
        return $this->db->fetch($sql, array($uid, ($page - 1) * $num_per_page, $num_per_page));
    }
    function get_rebox($id, $uid) {
        $message = $this->db->fetch_one("SELECT * FROM uc_messages WHERE mid = ? AND touid = ? AND `type` = 'rebox'", array($id, $uid));
        if ($message !== null) {
            $this->db->modify('UPDATE uc_messages SET ifnew = 0 WHERE mid = ?', array($id));
        }
        return $message;
    }
    function get_sebox($id, $uid) {
        return $this->db->fetch_one("SELECT * FROM uc_messages WHERE mid = ? AND fromuid = ? AND `type` = 'sebox'", array($id, $uid));
    }
    function send_public($title, $content) {
        $result1 = $this->db->create("INSERT INTO uc_messages (touid,togroups,fromuid,username,`type`,title,mdate,content) VALUES (?,?,?,?,?,?,?,?)", array(0,'', 0,'SYSTEM','public',$title, time(),$content));
        $result2 = $this->db->modify('UPDATE uc_messages_user SET newpm = 1');
        return $result1 && $result2;
    }
    function delete_public($ids, $uid) {
        $sql = "SELECT delmsg FROM uc_messages_user WHERE uid = ?";
        $record = $this->db->fetch_one($sql, array($uid));
        if ($record === null) {
            $this->db->create("INSERT INTO uc_messages_user (uid,newpm,readmsg,delmsg) VALUES (?,'0','','')", array($uid));
            return true;
        }
        if ($record['delmsg'] === '') {
            $newdel = $ids;
        } else {
            $newdel .= ',' . $ids;
        }
        return $this->db->modify('UPDATE uc_messages_user SET delmsg = ? WHERE uid = ?', array($newdel, $uid));
    }
    function public_list($uid, $gid, $regdate) {
        $sql = "SELECT mid,fromuid,togroups,username,`type`,title,mdate FROM uc_messages WHERE type='public' AND togroups LIKE '%,$gid,%' AND mdate>'$regdate' ORDER BY mdate DESC";
        $messages = $this->db->fetch($sql);
        $extra = $this->db->fetch_one("SELECT * FROM uc_messages_user WHERE uid = ?", array($uid));
        $readmsg = explode(',',$extra['readmsg']);
        $delmsg = explode(',',$extra['delmsg']);
        $new_messages = array();
        foreach ($messages as $message) {
            if (in_array($message['mid'], $delmsg)) {
                continue;
            }
            if (in_array($message['mid'], $readmsg)) {
                $value['ifnew'] = '0';
            } else {
                $value['ifnew'] = '1';
            }
            $new_messages[] = $message;
        }
        return $new_messages;
    }
    function get_public($mid) {
        return $this->db->fetch_one("SELECT * FROM uc_messages WHERE mid = ? AND `type` = 'public'", array($mid));
    }
}
