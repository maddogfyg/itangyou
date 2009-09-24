<?php
!function_exists('readover') && exit('Forbidden');

//主题分类
$t_typedb = $t_subtypedb = array();
$t_per = 0;$t_exits = 0;$article=0;$t_sub_exits = 0;
$t_db = $topic_type_cache[$fid];
if ($t_db) {
	foreach ($t_db as $value) {
		if ($value['upid'] == 0) {
			$t_typedb[$value['id']] = $value;
		} else {
			$t_subtypedb[$value['upid']][$value['id']] = strip_tags($value['name']);
		}
		$t_exits = 1;
	}
}
if ($t_subtypedb) {
	$t_subtypedb = pwJsonEncode($t_subtypedb);
	$t_sub_exits = 1;
}

$t_per = $pwforum->foruminfo['t_type'];
$forumcate = $pwforum->foruminfo['forumcate'];

$db_forcetype = $t_exits && $t_per=='2' && !$pwpost->admincheck ? 1 : 0; // 是否需要强制主题分类

if (!$pwpost->admincheck && !$pwforum->allowpost($pwpost->user, $pwpost->groupid)) {
	Showmsg('postnew_forum_right');
}
if (!$pwforum->foruminfo['allowpost'] && !$pwpost->admincheck && $_G['allowpost'] == 0) {
	Showmsg('postnew_group_right');
}
$postSpecial = null;
if ($forumcate == 1) {
	if ($special && file_exists(R_P . "lib/special/post_{$special}.class.php")) {
		require_once(R_P . "lib/special/post_{$special}.class.php");
		$postSpecial = new postSpecial($pwpost);
		$postSpecial->postCheck();
	} else {
		$special = 0;
	}
} elseif ($forumcate == 2) {
	if (!$cateid || !$modelid) Showmsg('undefined_action');
	require_once(R_P.'lib/posttopic.class.php');
	$postTopic = new postTopic($pwpost);
	if ($postTopic) {
		$postTopic->postCheck();
	}
	$selectmodelhtml = $postTopic->getModelHtml();
	$topichtml = $postTopic->getTopicHtml($modelid);
} elseif ($forumcate == 3) {
	if (!$pcid) Showmsg('undefined_action');
	require_once(R_P.'lib/postcate.class.php');
	$postCate = new postCate($pwpost);
	if ($postTopic) {
		$postTopic->postCheck();
	}
	$selectmodelhtml = $postCate->getPcHtml();
	$topichtml = $postCate->getCateHtml($pcid);
}

$icon = (int)$icon;

if (empty($_POST['step'])) {
	
	if ($special && method_exists($postSpecial, 'setInfo')) {
		$set = $postSpecial->setInfo();
	}
	list($guidename, $forumtitle) = $pwforum->getTitle();
	$db_metakeyword = str_replace(array('|',' - '),',',$forumtitle).'phpwind';

	require_once(R_P.'require/header.php');
	$msg_guide = $pwforum->headguide($guidename);

	require_once PrintEot('post');footer();

} elseif ($_POST['step'] == 2) {

	InitGP(array('atc_title','atc_content'), 'P', 0);
	InitGP(array('atc_anonymous','atc_newrp','atc_tags','atc_hideatt','magicid','magicname','atc_enhidetype','atc_credittype','flashatt'),'P');
	InitGP(array('atc_iconid','atc_email','digest','topped','atc_hide','atc_requireenhide','atc_rvrc','atc_requiresell','atc_money', 'atc_usesign', 'atc_html', 'p_type', 'p_sub_type', 'atc_convert', 'atc_autourl'), 'P', 2);

	require_once(R_P . 'require/bbscode.php');

	$postdata = new topicPostData($pwpost);
	$postdata->setWtype($p_type, $p_sub_type, $t_per, $t_db, $db_forcetype);
	$postdata->setTitle($atc_title);
	$postdata->setContent($atc_content);
	$postdata->setConvert($atc_convert, $atc_autourl);
	$postdata->setTags($atc_tags);
	$postdata->setAnonymous($atc_anonymous);
	$postdata->setHideatt($atc_hideatt);
	$postdata->setIfmail($atc_email,$atc_newrp);
	$postdata->setDigest($digest);
	$postdata->setTopped($topped);
	$postdata->setIconid($atc_iconid);
	$postdata->setIfsign($atc_usesign, $atc_html);
	$postdata->setMagic($magicid,$magicname);

	$postdata->setHide($atc_hide);
	$postdata->setEnhide($atc_requireenhide, $atc_rvrc, $atc_enhidetype);
	$postdata->setSell($atc_requiresell, $atc_money, $atc_credittype);
	//$newpost->checkdata();
	$postdata->conentCheck();
	
	if ($postSpecial) {
		$postSpecial->initData();
		$postdata->setData('special', $postSpecial->special);
	}

	if ($postTopic) {//分类主题初始化
		$postTopic->initData();
		$postdata->setData('cateid', $postTopic->cateid);
		$postdata->setData('modelid', $postTopic->modelid);
	}

	if ($postCate) {//团购活动初始化
		$postCate->initData();
		$postdata->setData('special', 20+$postCate->pcid);
	}

	require_once(R_P . 'lib/upload/attupload.class.php');
	if (PwUpload::getUploadNum() || $flashatt) {
		$postdata->att = new AttUpload($winduid, $flashatt);
		$postdata->att->check();
		$postdata->att->transfer();
		PwUpload::upload($postdata->att);
	}
	require_once(R_P . 'lib/topicpost.class.php');
	$topicpost = new topicPost($pwpost);
	$topicpost->execute($postdata);

	$tid = $topicpost->getNewId();

	if ($postSpecial) {
		$postSpecial->insertData($tid);
	}

	if ($postTopic) {//分类主题插入数据
		$postTopic->insertData($tid,$fid);
	}

	if ($postCate) {//团购活动插入数据
		$postCate->insertData($tid,$fid);
	}

	/*
	$db_tcheck && $winddb['postcheck'] == tcheck($atc_content) && Showmsg('content_same'); //内容验证
	*/
	$j_p = '';

	if (empty($j_p) || $pwforum->foruminfo['cms']) $j_p = "read.php?tid=$tid";
	refreshto($j_p, $postdata->getIfcheck() ? 'enter_thread' : 'post_check');
}
?>