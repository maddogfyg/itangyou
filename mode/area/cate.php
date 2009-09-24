<?php
!defined('M_P') && exit('Forbidden');
require_once(R_P.'require/forum.php');
include_once(D_P.'data/bbscache/forum_cache.php');

InitGP(array('cateid'),'GP',2);
!$cateid && Showmsg('no_cateid');
$fid = $cateid;
$metakeyword = strip_tags($forum[$cateid]['name']);
$subject = $metakeyword.' - ';
$db_metakeyword = $metakeyword;
require_once(M_P.'require/header.php');

$forum[$fid]['type'] != 'category' && Showmsg('not_is_category');

$forumdb = array();
foreach ($forum as $key=>$value) {
	if ($value['fup'] == $fid && $value['f_type'] !='hidden') {
		$value['name'] = strip_tags($value['name']);
		$forumdb[$key] = $value;
	}
}

require_once PrintEot('cate');footer();
?>