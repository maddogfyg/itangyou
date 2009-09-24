<?php
!function_exists('readover') && exit('Forbidden');
require GetLang('purview');
/*
$nav_head = array(
	'initiator'		=> '创始人',
	'config'		=> '核心设置',
	'contentforums'	=> '内容版块',
	'consumer'		=> '用 户',
	'applicationcenter'=> '应用中心',
	'datacache'		=> '数据缓存',
	'markoperation'	=> '运营工具',
	'mode'			=> '模 式',
);
*/
$nav_manager = array(
	'name'		=> '创始人',
	'items'		=> array(
		'manager',
		'rightset',
		'optimize',
		'diyoption',
		'usercenter'=> array(
			'name'		=> '用户中心',
			'items'		=> array(
				'ucset',
				'ucapp',
				'uccredit',
				'ucnotify',
			),
		),
		'advanced' => array(
			'name'	=> '高级应用配置',
			'items'	=> array(
				'msphinx',
				'mmemcache',
			),
		),
	),
);

$nav_left = array(
	'config' => array(
		'name' => '核心设置',
		'items' => array(
			'basic',
			'regset'	=> array(
				'name'	=> '注册设置',
				'items'	=> array(
					'reg',
					'customfield',
				),
			),
			'creditset'	=> array(
				'name'	=> '积分设置',
				'items'	=> array(
					'credit',
					'creditdiy',
					'creditchange',
				)
			),
			'attftp'	=> array(
				'name'	=>'附件设置',
				'items'	=>array(
					'attmanager'	=> array(
						'name'	=> '附件基本管理',
						'items'	=> array(
							'att',
							'attachment',
							'attachrenew',
						)
					),
					'attachstats',
				)
			),
			'email',
			'help',
			'wap',
			'safe',
			'member',
			'pcache',
			'sethtm',
		),
	),
	'consumer' => array(
		'name'	=> '会员权限',
		'items'	=> array(
			'groups'	=> array(
				'name'	=> '会员组设置',
				'items'=> array(
					'level',
					'userstats',
					'upgrade',
					'editgroup',
					'uptime',
				),
			),
			'members'	=> array(
				'name'	=> '会员管理',
				'items'=>array(
					'setuser',
					'delmember',
					'banuser',
					'viewban',
					'unituser',
				),
			),
			'usercheck'		=> array(
				'name'			=> '会员审核',
				'items'			=> array(
					'checkreg',
					'checkemail',
				),
			),
			'customcredit',
		),
	),
	'contentforums'	=> array(
		'name'	=> '内容版块',
		'items'	=> array(
			'forums' => array(
				'name'	=> '版块管理',
				'items'=> array(
					'setforum',
					'singleright',
					'uniteforum',
					'forumsell',
					'creathtm',
				),
			),
			'contentmanage' => array(
				'name'	=> '内容管理',
				'items'=> array(
					'article',
					'app_photos',
					'app_diary',
					'app_groups',
					'app_share',
					'app_write',
					'o_comments',
					'message',
					'report',
					'draftset',
					'recycle',
				),
			),
			'contentcheck'	=> array(
				'name'	=> '内容审核',
				'items'	=> array(
					'tpccheck',
					'postcheck',
				),
			),
			'tagset',
			'pwcode',
			'setform',
			'rulelist'	=> array(
				'name'=>'内容过滤设置',
				'items'=>array(
					'setbwd',
					'urlcheck',
				)
			),
			'postcache',
		),
	),
	'datacache'	=> array(
		'name'	=>'数据缓存',
		'items'	=> array(
			'database'	=> array(
				'name'	=> '数据库',
				'items'	=> array(
					'bakout',
					'bakin',
					'repair',
					'ptable',
				),
			),
			'aboutip'=> array(
				'name'	=> 'IP相关',
				'items'	=> array(
					'ipban',
					'ipstates',
					'ipsearch',
				),
			),
			'log'	=> array(
				'name'	=> '管理日志',
				'items'	=> array(
					'adminlog',
					'forumlog',
					'creditlog',
					'adminrecord',
				),
			),
			'aboutcache'	=> array(
				'name'	=> '缓存相关',
				'items'	=> array(
					'updatecache',
					'pwcache',
					'guestdir',
				),
			),
			'check'	=> array(
				'name'	=> '文件检查',
				'items'	=> array(
					'chmod',
					'safecheck',
				),
			),
			'viewtoday',
			'datastate',
			'postindex',
		),
	),
	'applicationcenter'	=> array(
		'name'	=> '应用中心',
		'items'	=> array(
			'app',
			'topiccate',
			'app_stopic',
			'postcate',
			'hackcenter',
			'onlinepay' => array(
				'name'	=> '网上支付设置',
				'items' => array(
					'userpay',
					'orderlist',
				),
			),
		),
	),
	'markoperation'=> array(
		'name'	=> '运营工具',
		'items'	=> array(
			'setadvert',
			'announcement',
			'sendmail',
			'sendmsg',
			'navmenu'		=> array(
				'name'	=> '导航菜单管理',
				'items'=> array(
					'navmain',
					'navside',
					'navmode'
				),
			),
			'share',
			'plantodo',
			'present',
			'setads',
			'ystats',
			'sitemap',
		),
	),

	'mode' => array(
		'name'	=> '模式管理',
		'items'	=> array(
			'modemanage'=> array(
				'name'	=> '模式设置',
				'items'=> array(
					'modeset',
					//'modestamp',
					//'modepush',
				),
			),
			'bbs'	=> array(
				'name'	=> '论坛模式',
				'items'=> array(
					'detail'	=> array(
						'name' => '界面设置',
						'items' => array(
							'index',
							'thread',
							'read',
							'popinfo',
							'jsinvoke',
						)
					),
					'rebang',
					'setstyles',
				),
			)
		),
	),
);

if (isset($db_modes['area'])) {
	$nav_left['mode']['items']['area'] = array(
		'name'	=> '门户模式',
		'items'=> array(
			'area_tplcontent',
			'area_edittpl',
			'area_selecttpl',
			'maketemplate',
			'area_configarea',
		),
	);
}
if (isset($db_modes['o'])) {
	$nav_left['mode']['items']['o'] = array(
		'name'	=> '圈子模式',
		'items'=> array(
			'o_global',
			//'o_app'			=> array('app应用',"$admin_file?adminjob=mode&admintype=o_app"),
		),
	);
}
?>