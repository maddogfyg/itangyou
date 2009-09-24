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

$md_appgroups='';
$md_groups=',3,';
$md_ifapply='1';
$md_ifmsg='1';
$md_ifopen='1';


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


$gp_right=array(
	'1' => array(
		'fontsize' => '',
		'imgheight' => '',
		'imgwidth' => '',
	),
	'2' => array(
		'fontsize' => '',
		'imgheight' => '',
		'imgwidth' => '',
	),
	'3' => array(
		'fontsize' => '',
		'imgheight' => '',
		'imgwidth' => '',
	),
	'4' => array(
		'fontsize' => '',
		'imgheight' => '',
		'imgwidth' => '',
	),
	'5' => array(
		'fontsize' => '',
		'imgheight' => '',
		'imgwidth' => '',
	),
	'6' => array(
		'fontsize' => '',
		'imgheight' => '',
		'imgwidth' => '',
	),
	'7' => array(
		'fontsize' => '',
		'imgheight' => '',
		'imgwidth' => '',
	),
	'8' => array(
		'fontsize' => '3',
		'imgheight' => '',
		'imgwidth' => '',
	),
	'16' => array(
		'fontsize' => '',
		'imgheight' => '',
		'imgwidth' => '',
	),
);

$customfield=array(
	'0' => array(
		'id' => '1',
		'title' => '糖友类型',
		'maxlen' => '0',
		'vieworder' => '0',
		'type' => '3',
		'state' => '1',
		'required' => '0',
		'viewinread' => '1',
		'editable' => '1',
		'descrip' => '请认真填写此栏，以便于与他人深入交流，谢谢!',
		'viewright' => '',
		'options' => '1=暂时保密
2=Ⅱ型糖友
3=Ⅰ型糖友
4=妊娠型糖友
5=其它型糖友
6=糖耐量异常者
7=糖友亲朋
8=相关业者',
	),
);

$_MEDALDB=array(
	'1' => array(
		'id' => '1',
		'name' => '终身成就奖',
		'intro' => '谢谢您为社区发展做出的不可磨灭的贡献!!',
		'picurl' => '1.gif',
	),
	'2' => array(
		'id' => '2',
		'name' => '优秀斑竹奖',
		'intro' => '辛劳地为论坛付出劳动，收获快乐，感谢您!',
		'picurl' => '2.gif',
	),
	'3' => array(
		'id' => '3',
		'name' => '宣传大使奖',
		'intro' => '谢谢您为社区积极宣传,特颁发此奖!',
		'picurl' => '3.gif',
	),
	'4' => array(
		'id' => '4',
		'name' => '特殊贡献奖',
		'intro' => '您为论坛做出了特殊贡献,谢谢您!',
		'picurl' => '4.gif',
	),
	'5' => array(
		'id' => '5',
		'name' => '金点子奖',
		'intro' => '为社区提出建设性的建议被采纳,特颁发此奖!',
		'picurl' => '5.gif',
	),
	'6' => array(
		'id' => '6',
		'name' => '原创先锋奖',
		'intro' => '谢谢您积极发表原创作品,特颁发此奖!',
		'picurl' => '6.gif',
	),
	'7' => array(
		'id' => '7',
		'name' => '贴图大师奖',
		'intro' => '帖图高手,堪称大师!',
		'picurl' => '7.gif',
	),
	'8' => array(
		'id' => '8',
		'name' => '灌水天才奖',
		'intro' => '能够长期提供优质的社区水资源者,可得这个奖章!',
		'picurl' => '8.gif',
	),
	'9' => array(
		'id' => '9',
		'name' => '新人进步奖',
		'intro' => '新人有很大的进步可以得到这个奖章!',
		'picurl' => '9.gif',
	),
	'10' => array(
		'id' => '10',
		'name' => '幽默大师奖',
		'intro' => '您总是能给别人带来欢乐,谢谢您!',
		'picurl' => '10.gif',
	),
);

?>