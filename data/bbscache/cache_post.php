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

$ltitle=$lpic=$lneed=array();
/**
* default
*/
$ltitle[1]='default';		$lpic[1]='8';
$ltitle[2]='游客';		$lpic[2]='8';
$ltitle[6]='禁止发言';		$lpic[6]='8';
$ltitle[7]='未验证会员';		$lpic[7]='8';

/**
* system
*/
$ltitle[3]='管理员';		$lpic[3]='3';
$ltitle[4]='总版主';		$lpic[4]='4';
$ltitle[5]='论坛版主';		$lpic[5]='5';
$ltitle[17]='门户编辑';		$lpic[17]='5';

/**
* special
*/
$ltitle[16]='荣誉会员';		$lpic[16]='5';

/**
* member
*/
$ltitle[8]='散仙';		$lpic[8]='8';		$lneed[8]='0';
$ltitle[9]='赤天枢';		$lpic[9]='9';		$lneed[9]='1';
$ltitle[10]='橙天璇';		$lpic[10]='10';		$lneed[10]='100';
$ltitle[11]='金天玑';		$lpic[11]='11';		$lneed[11]='300';
$ltitle[12]='碧天权';		$lpic[12]='12';		$lneed[12]='1000';
$ltitle[13]='青玉衡';		$lpic[13]='13';		$lneed[13]='3000';
$ltitle[14]='靛开阳';		$lpic[14]='14';		$lneed[14]='10000';
$ltitle[15]='紫摇光';		$lpic[15]='14';		$lneed[15]='30000';


$faces=array(
	'default'=>array(
		'name'=>'默认表情',
		'child'=>array('2','14','13','12','11','10','9','8','7','6','5','4','3','15',),
	),
);
$face=array(
	'2'=>array('default/1.gif','',''),
	'14'=>array('default/13.gif','',''),
	'13'=>array('default/12.gif','',''),
	'12'=>array('default/11.gif','',''),
	'11'=>array('default/10.gif','',''),
	'10'=>array('default/9.gif','',''),
	'9'=>array('default/8.gif','',''),
	'8'=>array('default/7.gif','',''),
	'7'=>array('default/6.gif','',''),
	'6'=>array('default/5.gif','',''),
	'5'=>array('default/4.gif','',''),
	'4'=>array('default/3.gif','',''),
	'3'=>array('default/2.gif','',''),
	'15'=>array('default/14.gif','',''),
);

?>