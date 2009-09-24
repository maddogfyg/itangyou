<?php
!defined('P_W') && exit('Forbidden');

InitGP(array("jobact"));

$ajaxurl = EncodeUrl($stopic_admin_url);
$bg_perpage = 6;

if ("preadd" == $jobact) {
	InitGP(array("new_category", "layout_select",'style'));
	InitGP(array("is_new_category", "category_id", "is_new_bg", "bg_id", "copy_stopic_id"), null, 2);

	if ($is_new_category) {
		if (trim ( $new_category ) == "") Showmsg("对不起，新增分类名不能为空", $stopic_admin_url."&job=default");
		$new_category_id = $stopic_service->addCategory ( array ("title" => $new_category, "creator" => $admin_name ) );
		!$new_category_id && Showmsg ( "对不起，新分类增加失败", $stopic_admin_url."&job=default");
		$category_id = $new_category_id;
	}

	if (!$category_id) Showmsg("对不起，您既没有选择分类，也没有新建分类，请您重试", $stopic_admin_url."&job=default");
	if (!$layout_select) Showmsg("对不起，请选择布局", $stopic_admin_url."&job=default");

	$layoutDefaultSet	= $stopic_service->getLayoutSet($style);
	$defaultBanner	= $stopic_service->getStyleBanner($style);
	$styles	= $stopic_service->getStyles();

	$bg_list = $stopic_service->getPicturesAndDefaultBGs($category_id);
	$bg_total = ceil(count($bg_list) / $bg_perpage);
	
	include stopic_use_layout ('admin');
} elseif ("add" == $jobact) {
	InitGP(array("stopic_title", "banner_url", "nav_set", "layout_select", "layout_set", "seo_keyword", "seo_desc"));
	InitGP(array("category_id", "is_new_bg", "bg_id", "copy_stopic_id"), null, 2);

	$title = trim($stopic_title);
	if ("" == $title) Showmsg("对不起，请填写标题", "javascript:history.back();");

	if ($is_new_bg) $bg_id = 0;
	if ($is_new_bg && count($_FILES) && $_FILES["background"]["name"] && $_FILES["background"]["size"]) {
		$new_bg_id = $stopic_service->uploadPicture($_FILES, $category_id, $admin_name);
		!$new_bg_id && Showmsg ("对不起，背景图片增加失败", $stopic_admin_url);
		$bg_id = $new_bg_id;
	}

	$stopic_id = $stopic_service->addSTopic(array(
		"title" => $title,
		"category_id" => $category_id,
		"bg_id" => $bg_id,
		"copy_from" => $copy_stopic_id,
		"layout" => $layout_select,
		"banner_url" => $banner_url,
		"nav_config" => stopic_filter_navconfig($nav_set),
		"layout_config" => $layout_set,
		"seo_keyword" => $seo_keyword,
		"seo_desc" => $seo_desc,
	));
	if (!$stopic_id) Showmsg("对不起，添加专题失败，请您重试");

	ObHeader($basename.'&job=editstopic&stopic_id='.$stopic_id);
} elseif ("preedit" == $jobact) {
	InitGP(array("stopic_id"), null, 2);
	if ($stopic_id <= 0) Showmsg('参数错误，请您重试', $basename."&job=stman");
	$stopic_data = $stopic_service->getSTopicInfoById($stopic_id);
	if (null == $stopic_data) Showmsg('找不到专题数据，请您重试', $basename."&job=stman");
	$styles	= $stopic_service->getStyles();

	$bg_list = $stopic_service->getPicturesAndDefaultBGs($stopic_data['category_id']);
	$bg_total = ceil(count($bg_list) / $bg_perpage);
	
	include stopic_use_layout ( 'admin' );
} elseif ("edit" == $jobact) {
	InitGP(array("stopic_id"), null, 2);
	if ($stopic_id <= 0) Showmsg('参数错误，请您重试', "javascript:history.back();");
	$stopic_data = $stopic_service->getSTopicInfoById($stopic_id);
	if (null == $stopic_data) Showmsg('找不到专题数据，请您重试', "javascript:history.back();");

	InitGP(array("stopic_title", "banner_url", "nav_set", "layout_set", "is_new_bg", "bg_id", "seo_keyword", "seo_desc"));
	$title = trim($stopic_title);
	if ("" == $title) Showmsg("对不起，请填写标题", "javascript:history.back();");

	if ($is_new_bg) $bg_id = 0;
	if ($is_new_bg && count($_FILES) && $_FILES["background"]["name"] && $_FILES["background"]["size"]) {
		$new_bg_id = $stopic_service->uploadPicture($_FILES, $stopic_data['category_id'], $admin_name);
		!$new_bg_id && Showmsg ("对不起，背景图片增加失败", $stopic_admin_url);
		$bg_id = $new_bg_id;
	}

	$stopic_service->updateSTopicById($stopic_id, array(
		"title" => $title,
		"banner_url" => $banner_url,
		"nav_config" => stopic_filter_navconfig($nav_set),
		"layout_config" => $layout_set,
		"bg_id" => $bg_id,
		"seo_keyword" => $seo_keyword,
		"seo_desc" => $seo_desc,
	));

	ObHeader($basename.'&job=editstopic&stopic_id='.$stopic_id);
} else {
	Showmsg("对不起，参数错误");
}

function stopic_filter_navconfig($nav_set) {
	$nav_config = array();
	if (isset($nav_set['text']) && is_array($nav_set['text']) && count($nav_set['text'])) {
		foreach ($nav_set['text'] as $k => $v) {
			if ($v && $nav_set['url'][$k]) $nav_config[] = array('text'=>$v, 'url'=>$nav_set['url'][$k]);
		}
	} else {
		return "";
	}
	return $nav_config;
}
?>