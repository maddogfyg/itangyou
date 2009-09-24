<?php
$forum=array(
	'1' => array(
		'fid' => '1',
		'fup' => '0',
		'ifsub' => '0',
		'childid' => '1',
		'type' => 'category',
		'name' => '美食',
		'style' => '0',
		'f_type' => 'forum',
		'cms' => '0',
		'ifhide' => '1',
	),
	'2' => array(
		'fid' => '2',
		'fup' => '1',
		'ifsub' => '0',
		'childid' => '0',
		'type' => 'forum',
		'name' => '健康食品',
		'style' => '0',
		'f_type' => 'forum',
		'cms' => '0',
		'ifhide' => '1',
	),
	'3' => array(
		'fid' => '3',
		'fup' => '0',
		'ifsub' => '0',
		'childid' => '1',
		'type' => 'category',
		'name' => '糖疾',
		'style' => '',
		'f_type' => 'forum',
		'cms' => '0',
		'ifhide' => '1',
	),
	'4' => array(
		'fid' => '4',
		'fup' => '3',
		'ifsub' => '0',
		'childid' => '0',
		'type' => 'forum',
		'name' => '糖疾交流',
		'style' => '0',
		'f_type' => 'forum',
		'cms' => '0',
		'ifhide' => '1',
	),
	'5' => array(
		'fid' => '5',
		'fup' => '0',
		'ifsub' => '0',
		'childid' => '1',
		'type' => 'category',
		'name' => '其它',
		'style' => '',
		'f_type' => 'forum',
		'cms' => '0',
		'ifhide' => '1',
	),
	'6' => array(
		'fid' => '6',
		'fup' => '5',
		'ifsub' => '0',
		'childid' => '0',
		'type' => 'forum',
		'name' => '社区事务',
		'style' => '0',
		'f_type' => 'forum',
		'cms' => '0',
		'ifhide' => '1',
	),
);
$forumcache='
<option value="1">&gt;&gt; 美食</option>
<option value="2"> &nbsp;|- 健康食品</option>
<option value="3">&gt;&gt; 糖疾</option>
<option value="4"> &nbsp;|- 糖疾交流</option>
<option value="5">&gt;&gt; 其它</option>
<option value="6"> &nbsp;|- 社区事务</option>
';
$cmscache='
';
$pwForumList=array(
	'1' => array(
		'name' => '美食',
		'child' => array(
			'2' => '健康食品',
		),
	),
	'3' => array(
		'name' => '糖疾',
		'child' => array(
			'4' => '糖疾交流',
		),
	),
	'5' => array(
		'name' => '其它',
		'child' => array(
			'6' => '社区事务',
		),
	),
);
$topic_type_cache=NULL;

$notice_A=array(
);
$notice_C=array(
);

?>