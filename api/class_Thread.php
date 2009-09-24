<?php

!defined('P_W') && exit('Forbidden');
//api mode 2

define('API_THREAD_FORUM_NOT_EXISTS', 200);
define('API_THREAD_FORUM_POST_CATEGORY', 201);
define('API_THREAD_AUTHOR_NOT_EXISTS', 202);
define('API_THREAD_TAG_LENGTH_LIMIT', 203);
define('API_THREAD_SUBJECT_LENGTH_LIMIT', 204);
define('API_THREAD_CONTENT_LENGTH_LIMIT', 205);

class Thread {

	var $base;
	var $db;

	function Thread($base) {
		$this->base = $base;
		$this->db = $base->db;
		$this->iftag =& $GLOBALS['db_iftag'];
		$this->titlemax =& $GLOBALS['db_titlemax'];
		$this->postmax =& $GLOBALS['db_postmax'];
		$this->postmin =& $GLOBALS['db_postmin'];
	}

	function post($fid, $author, $title, $content, $tags = '', $convert = 1, $usesign = 1, $usehtml = 0, $topped = 0, $digest = 0) {
		global $timestamp,$tdtime,$montime,$db_ptable,$db_iftag,$onlineip,$db_creditset;
		$pwforum = L::loadClass('forum');
		if (!$foruminfo = $pwforum->foruminfo($fid, true)) {
			return new ErrorMsg(API_THREAD_FORUM_NOT_EXISTS, 'Forum not exists');
		}
		if ($foruminfo['type'] == 'category') {
			return new ErrorMsg(API_THREAD_FORUM_POST_CATEGORY, 'Category can not post');
		}
		$user = $this->db->get_one('SELECT m.uid,md.lastpost FROM pw_members m LEFT JOIN pw_memberdata md USING(uid) WHERE m.username=' . pwEscape($author));

		if (!$user) {
			return new ErrorMsg(API_THREAD_AUTHOR_NOT_EXISTS, 'User not exists');
		}
		$winduid = $user['uid'];
		$windid  = $author;

		if ($tags && $this->iftag) {
			if (($tags = $this->checkTag($tags)) === false) {
				return new ErrorMsg(API_THREAD_TAG_LENGTH_LIMIT, 'Tag length error');
			}
		} else {
			$tags = '';
		}

		$atc_title   = trim($title);
		$atc_content = $content;
		if (!$atc_title || strlen($atc_title) > $this->titlemax) {
			return new ErrorMsg(API_THREAD_SUBJECT_LENGTH_LIMIT, 'Subject length error');
		}
		if (strlen($atc_content) >= $this->postmax || strlen(trim($atc_content)) < $this->postmin) {
			return new ErrorMsg(API_THREAD_CONTENT_LENGTH_LIMIT, 'Content length error');
		}

		require_once(R_P.'require/bbscode.php');

		$atc_title = Char_cv($atc_title);
		$wordsfb = wordsfb::getInstance();
		$ifwordsfb = $wordsfb->ifwordsfb($atc_content);
		$ifconvert = 1;

		if ($convert == 1) {
			$atc_content = html_check($atc_content);
			$atc_content != convert($atc_content,'') && $ifconvert = 2;
		}
		if (!$usehtml) {
			$atc_content = Char_cv($atc_content);
		} else {
			$atc_content = preg_replace(
				array("/<script.*>.*<\/script>/is","/<(([^\"']|\"[^\"]*\"|'[^']*')*?)>/eis","/javascript/i"),
				array("","jscv('\\1')","java script"),
				str_replace('.','&#46;',$atc_content)
			);
		}
		$pwSQL = pwSqlSingle(array(
			'fid'		=> $fid,		'icon'		=> '',
			'author'	=> $windid,		'authorid'	=> $winduid,
			'subject'	=> $atc_title,	'ifcheck'	=> 1,
			'postdate'	=> $timestamp,
			'lastpost'	=> $timestamp,  'lastposter'=> $windid,
			'hits'		=> 1,			'replies'	=> 0,
			'topped'	=> $topped,		'digest'	=> $digest,
			'special '	=> 0,			'state'		=> 0,
			'ifupload'	=> 0,			'ifmail'	=> 0,
			'anonymous'	=> 0,			'ptable'	=> $db_ptable,
			'ifhide'	=> 0
		));
		$this->db->update("INSERT INTO pw_threads SET $pwSQL");
		$tid = $this->db->insert_id();
		$threadList = L::loadClass("threadlist");
		$threadList->updateThreadIdsByForumId($fid,$tid);
		$pw_tmsgs = GetTtable($tid);
		if ($db_iftag) {
			if ($tags) {
				insert_tag($tid,$tags);
			}
			$tags .= "\t".relate_tag($atc_title,$atc_content);
		}
		$ipfrom = Char_cv(cvipfrom($onlineip));

		if ($usehtml) {
			$usesign += 2;
		}
		$pwSQL = pwSqlSingle(array(
			'tid'		=> $tid,
			'aid'		=> '',
			'userip'	=> $onlineip,
			'ifsign'	=> $usesign,
			'buy'		=> '',
			'ipfrom'	=> $ipfrom,
			'tags'		=> $tags,
			'ifconvert'	=> $ifconvert,
			'ifwordsfb'	=> $ifwordsfb,
			'content'	=> $atc_content,
			'magic'		=> ''
		));
		$this->db->update("INSERT INTO $pw_tmsgs SET $pwSQL");

		lastinfo($fid,0,'new');

		if ($topped > 1) {
			require_once(R_P.'require/updateforum.php');
			updatetop();
		}

		//论坛积分设置
		require_once(R_P.'require/credit.php');
		$creditset = $credit->creditset($foruminfo['creditset'],$db_creditset);
		$credit->addLog('topic_Post',$creditset['Post'],array(
			'uid'		=> $winduid,
			'username'	=> $windid,
			'ip'		=> $onlineip,
			'fname'		=> $foruminfo['name']
		));
		$credit->sets($winduid,$creditset['Post']);
		$sqladd  = $tdtime  >= $user['lastpost'] ? 'todaypost=1,' : 'todaypost=todaypost+1,';
		$sqladd .= $montime >= $user['lastpost'] ? 'monthpost=1,' : 'monthpost=monthpost+1,';
		if ($digest) {
			$sqladd .= "digests=digests+1,";
		}
		$this->db->update("UPDATE pw_memberdata SET {$sqladd}postnum=postnum+1,lastpost=".pwEscape($timestamp)." WHERE uid=".pwEscape($winduid));

		return new ApiResponse($tid);
	}

	function checkTag($tags) {
		$tags = array_unique(explode(" ",preg_replace('/\s+/is',' ',trim($tags))));
		foreach ($tags as $key => $value) {
			if ((strlen($value) > 15 || strlen($value) < 3)) {
				return false;
			}
		}
		return implode(" ",$tags);
	}

	function post2($fid, $author, $title, $content, $tags = '', $convert = 1, $usesign = 1, $usehtml = 0, $topped = 0, $digest = 0) {
		global $db_iftag,$timestamp,$onlineip,$winduid,$windid,$tid,$foruminfo,$atc_title,$db_creditset,$db_titlemax,$db_postmin, $db_postmax,$db_ptable,$tdtime,$montime;

		$foruminfo = $this->db->get_one("SELECT * FROM pw_forums f LEFT JOIN pw_forumsextra fe USING(fid) WHERE f.fid=" . pwEscape($fid));
		if (!$foruminfo) {
			return new ErrorMsg(API_THREAD_FORUM_NOT_EXISTS, 'Forum not exists');
		}
		if ($foruminfo['type'] == 'category') {
			return new ErrorMsg(API_THREAD_FORUM_POST_CATEGORY, 'Category can not post');
		}
		$user = $this->db->get_one('SELECT m.uid,md.lastpost FROM pw_members m LEFT JOIN pw_memberdata md USING(uid) WHERE m.username=' . pwEscape($author));

		if (!$user) {
			return new ErrorMsg(API_THREAD_AUTHOR_NOT_EXISTS, 'User not exists');
		}
		$winduid = $user['uid'];
		$windid  = $author;

		require_once(R_P.'require/postfunc.php');

		if ($db_iftag && $tags) {
			$tags = array_unique(explode(" ",preg_replace('/\s+/is',' ',trim($tags))));
			foreach ($tags as $key => $value) {
				if ((strlen($value) > 15 || strlen($value) < 3)) {
					return new ErrorMsg(API_THREAD_TAG_LENGTH_LIMIT, 'Tag length error');
				}
			}
			$tags = implode(" ",$tags);
		} else {
			$tags = '';
		}

		$atc_title   = trim($title);
		$atc_content = $content;
		if (!$atc_title || strlen($atc_title) > $db_titlemax) {
			return new ErrorMsg(API_THREAD_SUBJECT_LENGTH_LIMIT, 'Subject length error');
		}
		if (strlen($atc_content) >= $db_postmax || strlen(trim($atc_content)) < $db_postmin) {
			return new ErrorMsg(API_THREAD_CONTENT_LENGTH_LIMIT, 'Content length error');
		}
		require_once(R_P.'require/bbscode.php');

		$atc_title = Char_cv($atc_title);
		$wordsfb = wordsfb::getInstance();
		$ifwordsfb = $wordsfb->ifwordsfb($atc_content);
		$ifconvert = 1;

		if ($convert == 1) {
			$atc_content = html_check($atc_content);
			$atc_content != convert($atc_content,'') && $ifconvert = 2;
		}
		if (!$usehtml) {
			$atc_content = Char_cv($atc_content);
		} else {
			$atc_content = preg_replace(
				array("/<script.*>.*<\/script>/is","/<(([^\"']|\"[^\"]*\"|'[^']*')*?)>/eis","/javascript/i"),
				array("","jscv('\\1')","java script"),
				str_replace('.','&#46;',$atc_content)
			);
		}
		$pwSQL = pwSqlSingle(array(
			'fid'		=> $fid,		'icon'		=> '',
			'author'	=> $windid,		'authorid'	=> $winduid,
			'subject'	=> $atc_title,	'ifcheck'	=> 1,
			'postdate'	=> $timestamp,
			'lastpost'	=> $timestamp,  'lastposter'=> $windid,
			'hits'		=> 1,			'replies'	=> 0,
			'topped'	=> $topped,		'digest'	=> $digest,
			'special '	=> 0,			'state'		=> 0,
			'ifupload'	=> 0,			'ifmail'	=> 0,
			'anonymous'	=> 0,			'ptable'	=> $db_ptable,
			'ifhide'	=> 0
		));
		$this->db->update("INSERT INTO pw_threads SET $pwSQL");
		$tid = $this->db->insert_id();
                $threadList = L::loadClass("threadlist");
		$threadList->updateThreadIdsByForumId($fid,$tid);
		$pw_tmsgs = GetTtable($tid);
		if ($db_iftag) {
			if ($tags) {
				insert_tag($tid,$tags);
			}
			$tags .= "\t".relate_tag($atc_title,$atc_content);
		}
		$ipfrom = Char_cv(cvipfrom($onlineip));

		if ($usehtml) {
			$usesign += 2;
		}
		$pwSQL = pwSqlSingle(array(
			'tid'		=> $tid,
			'aid'		=> '',
			'userip'	=> $onlineip,
			'ifsign'	=> $usesign,
			'buy'		=> '',
			'ipfrom'	=> $ipfrom,
			'tags'		=> $tags,
			'ifconvert'	=> $ifconvert,
			'ifwordsfb'	=> $ifwordsfb,
			'content'	=> $atc_content,
			'magic'		=> ''
		));
		$this->db->update("INSERT INTO $pw_tmsgs SET $pwSQL");

		lastinfo($fid,0,'new');

		if ($topped > 1) {
			require_once(R_P.'require/updateforum.php');
			updatetop();
		}

		//论坛积分设置
		require_once(R_P.'require/credit.php');
		$creditset = $credit->creditset($foruminfo['creditset'],$db_creditset);
		$credit->addLog('topic_Post',$creditset['Post'],array(
			'uid'		=> $winduid,
			'username'	=> $windid,
			'ip'		=> $onlineip,
			'fname'		=> $foruminfo['name']
		));
		$credit->sets($winduid,$creditset['Post']);
		$sqladd  = $tdtime  >= $user['lastpost'] ? 'todaypost=1,' : 'todaypost=todaypost+1,';
		$sqladd .= $montime >= $user['lastpost'] ? 'monthpost=1,' : 'monthpost=monthpost+1,';
		if ($digest) {
			$sqladd .= "digests=digests+1,";
		}
		$this->db->update("UPDATE pw_memberdata SET {$sqladd}postnum=postnum+1,lastpost=".pwEscape($timestamp)." WHERE uid=".pwEscape($winduid));

		return new ApiResponse($tid);
	}
}
?>