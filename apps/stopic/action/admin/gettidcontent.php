<?php
!defined('P_W') && exit('Forbidden');
define('AJAX',1);
InitGP(array('tid','block_id'));
$tid	= (int) $tid;
if (!$tid) exit;
$thread	= $db->get_one("SELECT tid,fid,author,authorid,subject,type,postdate,hits,replies FROM pw_threads WHERE tid=".pwEscape($tid));
$temp	= array();
if ($thread) {
	$thread['url'] 	= 'read.php?tid='.$thread['tid'];
	$thread['title'] 	= $thread['subject'];
	$thread['image']	= '';
	$thread['forumname']= getForumName($thread['fid']);
	$thread['forumurl']	= getForumUrl($thread['fid']);
	$block	= $stopic_service->getBlockById($block_id);
	foreach ($block['config'] as $value) {
		if ($value == 'descrip') {
			$temp[$value] = getDescripByTid($tid);
		} elseif (array_key_exists($value,$thread)) {
			$temp[$value] = $thread[$value];
		} else {
			$temp[$value] = '';
		}
	}
	$temp = pwJsonEncode($temp);
	echo "success\t".$temp;
} else {
	echo "error";
}

ajax_footer();
?>