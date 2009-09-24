<?php
!defined('P_W') && exit('Forbidden');
$purview_index	= 0;
if ($admin_gid=='3' || $admin_gid=='4') {
	$purview_index	= 1;
}
include_once(D_P.'data/bbscache/area_config.php');
require_once(M_P.'require/invokeconfig.php');
require_once(M_P.'require/tagrelate.php');

$invokeService = L::loadClass('InvokeService');
if (!$action) {
	InitGP(array('step'));
	if (!$step) {
		$catedb = $forumdb = $subdb1 = $subdb2 = array();
		$space  = '<span class="fourm-two"></span>';
		$query = $db->query("SELECT fid,fup,type,name,vieworder,forumadmin,f_type,cms FROM pw_forums WHERE type='category' AND cms!='1' ORDER BY vieworder");
		while ($forums = $db->fetch_array($query)) {
			if (!$purview_index && !checkEditAdmin($admin_name,$forums['fid'])) continue;
			$forums['name'] = preg_replace("/\<(.+?)\>/is","",$forums['name']);//去除html标签
			$forums['name'] = str_replace("<","&lt;",$forums['name']);
			$forums['name'] = str_replace(">","&gt;",$forums['name']);

			$catedb[] = $forums;
		}

		$ajax_basename = EncodeUrl($basename);
	} else {
		InitGP(array('editadmin'));
		$update	= array('area_editadmin','array',serialize($editadmin),'');
		$db->update("REPLACE INTO pw_hack VALUES (".pwImplode($update).')');
		updatecache_conf('area',true);
		adminmsg('operate_success');
	}

} elseif ($action=='show') {
	InitGP(array('scr','showid'));
	include_once(D_P.'data/bbscache/forum_cache.php');
	$paramfid = 0;
	if ($scr == 'cate') {
		$paramfid	= $invokeService->getMPageConfigFid($showid);
	}
	$invokenames	= $invokeService->getMPageConfigInvoke('area',$scr,$paramfid);
	if (!$invokenames) {
		adminmsg('no_invoke_in_this_page');
	}
	$invokes = $invokeService->getInvokesByNames($invokenames,$showid);
	$invokepieces	= $invokeService->getInvokePiecesByInvokeNames($invokenames);
	foreach ($invokepieces as $value) {
		$invokes[$value['invokename']]['pieces'][] = $value;
	}
	if ($scr == 'index') {
		$thistitle = $db_modes['area']['m_name'].getLangInfo('other','pushto_index');
	} elseif ($scr == 'cate') {
		$thistitle = $forum[$showid]['name'];
	}
} elseif ($action=='editinvoke') {
	InitGP(array('step','name','scr','cateid'),'GP');

	$invokedata	= $invokeService->getInvokeByName($name);

	if (!$step) {
		if ($invokedata['ifloop']) {
			if (!$cateid) {
				@include_once(D_P.'data/bbscache/forumcache.php');
			} else {
				$forumcache	= getForumOption($cateid);
			}
			foreach ($invokedata['loops'] as $value) {
				$forumcache = str_replace('<option value="'.$value.'">','<option value="'.$value.'" selected>',$forumcache);
			}
			$loopmode	= '<select name="loops[]" multiple>'.$forumcache."</select>";
			$loopmode	.= '<input type="hidden" name="cateid" value="'.$cateid.'">';
		} else {
			@include_once(D_P.'data/bbscache/forum_cache.php');
			$forumoptions = '<option value="">'.getLangInfo('other','maketpl_siteinvoke').'</option><option value="fid">'.getLangInfo('other','maketpl_forumcommon').'</option>';
			if (!$cateid) {
				foreach ($forum as $key => $value) {
					if ($value['type'] == 'forum') {
						$forumoptions .= '<option value="'.$value['fid'].'">'.$value['name'].'</option>';
					}
				}
			}

		}

		$tpldata	= $invokeService->getTpl($invokedata['tplid']);
		$invokeimage= $tpldata['image'];
		$invokepieces = $invokeService->getInvokePieceByInvokeName($name);
		foreach ($invokepieces as $key => $piece) {
			$temp = $invokeService->getStampBlocks($piece['action']);
			if ($piece['action']=='subject' || $piece['action']=='image') {
				$temp_func = getLangInfo('other','set_invoke_type').'<select name="func['.$piece['id'].']">';
				foreach ($temp as $value) {
					$selected = $value['func'] == $piece['func'] ? 'selected' : '';
					$temp_func .= '<option value="'.$value['func'].'" '.$selected.'>'.$value['name'].'</option>';
				}
				$temp_func .= '</select>';
				$invokepieces[$key]['func'] = $temp_func;
				if ($invokedata['ifloop']) {
					$invokepieces[$key]['rang'] = '<input type="hidden" name="rang['.$piece['id'].']" value="0">';
				} else {
					$piece['rang'] = str_replace('<option value="'.$piece['rang'].'">','<option value="'.$piece['rang'].'" selected>',$forumoptions);
					$invokepieces[$key]['rang'] = getLangInfo('other','set_invoke_fid').'<select name="rang['.$piece['id'].']">'.$piece['rang'].'</select>';
				}
			} else {
				$invokepieces[$key]['func'] = '<input type="hidden" name="func['.$piece['id'].']" value="'.$piece['func'].'">';
				$temp_rang = getLangInfo('other','set_invoke_type').'<select name="rang['.$piece['id'].']">';
				foreach ($temp as $value) {
					$selected = $value['rang'] == $piece['rang'] ? 'selected' : '';
					$temp_rang .= '<option value="'.$value['rang'].'" '.$selected.'>'.$value['name'].'</option>';
				}
				$temp_rang .= '</select>';
				$invokepieces[$key]['rang'] = $temp_rang;
			}
			$temp_param = array();
			foreach ($piece['param'] as $k=>$value) {
				if ($value!='default') {
					$temp_param[] = getParamDiscrip($k,$piece['action']).'<input type="text" class="input" value="'.$value.'" name="param['.$piece['id'].']['.$k.']">';
				} else {
					$temp_param[] = '<input type="hidden" name="param['.$piece['id'].']['.$k.']" value="'.$value.'">';
				}
			}
			$invokepieces[$key]['param'] = $temp_param;
		}
	} else {
		InitGP(array('rang','func','num','param','loops','descrip','cachetime'),'GP');
		foreach ($num as $key=>$value) {
			$temp = array();
			$temp['num']	= (int)$value;
			$temp['func']	= $func[$key];
			$temp['rang']	= $rang[$key];
			$temp['param']	= $param[$key];
			$temp['cachetime']	= $cachetime[$key];

			$invokeService->updateInvokePieceById($key,$temp);
			$piece = $invokeService->getInvokePieceByInvokeId($key);
			$invokeService->updateCacheDataPiece($piece['id']);
		}
		$update_invoke	= array('descrip'=>$descrip);
		if ($invokedata['ifloop']) {
			@include_once(D_P.'data/bbscache/forum_cache.php');
			foreach ($loops as $key=>$value) {
				if ($forum[$value]['type'] == 'category') {
					unset($loops[$key]);
				}
			}
			if ($cateid) {
				$invoke = $invokeService->getInvokeByName($name);
				!$invoke['loops'] && $invoke['loops'] = array();
				foreach ($invoke['loops'] as $key=>$value) {
					if (getCateid($value)==$cateid) {
						unset($invoke['loops'][$key]);
					}
				}
				$loops = array_merge($invoke['loops'],$loops);
			}
			$update_invoke['loops']	= $loops;
		}
		$invokeService->updateInvokeByName($name,$update_invoke);
		adminmsg('operate_success',$basename.'&action=show&scr='.$scr.'&showid='.$cateid);
	}
} elseif ($action=='edit') {
	include_once(D_P.'data/bbscache/forum_cache.php');
	InitGP(array('invokepieceid','fid','loopid','scr','viewtype','page'));

	$invokepiece = $invokeService->getInvokePieceByInvokeId($invokepieceid);

	if ($scr == 'index') {
		$thistitle = $db_modes['area']['m_name'].getLangInfo('other','pushto_index');
	} elseif ($scr == 'cate') {

		$thistitle = $forum[$fid]['name'];
	}
	$thistitle = '<a href="'.$basename.'&action=show&scr='.$scr.'&showid='.$fid.'">'.$thistitle.'</a>';
	$thistitle	.= ' -&gt; '.$invokepiece['invokename'].' -&gt; '.$invokepiece['title'];
	if ($loopid) {
		$thistitle	.= ' -&gt; '.$forum[$loopid]['name'];
	}

	if ($invokepiece['rang']!='fid') {
		$fid = 0;
	}
	$param	= $invokepiece['param'];
	if ($viewtype=='overdue') {
		$count	= $invokeService->countOverduePushData($invokepieceid,$fid,$loopid);
		$page	= (int)$page;
		$page<1	&& $page = 1;
		$perpage= 20;
		$numofpage = ceil($count/$perpage);
		$start	= ($page-1)*$perpage;
		$pages	= numofpage($count,$page,$numofpage,"$basename&action=edit&invokepieceid=$invokepieceid&fid=$fid&loopid=$loopid&scr=$scr&viewtype=overdue&");
		$pushs	= $invokeService->getPushDataOverdue($invokepieceid,$fid,$loopid,$start.','.$perpage);
	} else {
		$pushs	= $invokeService->getPushDataEffect($invokepieceid,$fid,$loopid,$invokepiece['num']);
	}
	$custom = array();
	foreach ($pushs as $value) {
		$custom[$value['id']] = $value['data'];
	}

	$ajax_basename = EncodeUrl($basename);
} elseif ($action=='editpush') {
	define('AJAX',1);
	InitGP(array('id','step'),'GP');
	$push	= $invokeService->getPushDataById($id);
	$invokepiece = $invokeService->getInvokePieceByInvokeId($push['invokepieceid']);
	if (!$step) {
		if (!$push)  adminmsg('error');
		if ($push['endtime']) {
			$push['endtime'] = get_date($push['endtime'],'Y-m-d');
		} else {
			$push['endtime'] = '';
		}

		$ajax_basename = EncodeUrl($basename."&action=editpush");
		require_once PrintMode('ajax_tplcontent');ajax_footer();
	} else {
		InitGP(array('param','offset','endtime'),'GP');
		$offset = (int) $offset;
		if ($endtime) {
			$endtime	= PwStrtoTime($endtime);
			if ($endtime == -1) {
				$endtime = 0;
			}
		}
		if (isset($invokepiece['param']['tagrelate'])) {
			InitGP(array('tagrelate'));
			$param['tagrelate']	= getTagRelate($tagrelate);
		}
		$invokeService->updatePushData($id,array('starttime'=>$timestamp,'endtime'=>$endtime,'offset'=>$offset,'data'=>$param));
		$loopid		= $push['loopid'];
		if ($invokepiece['rang']!='fid') {
			$fid = 0;
		} else {
			$fid = $push['fid'];
		}
		$invokeService->updateCacheDataPiece($push['invokepieceid'],$fid,$loopid);

		echo getLangInfo('msg','operate_success')."\treload";
		ajax_footer();
	}
} elseif ($action=='addpush') {
	define('AJAX',1);
	InitGP(array('invokepieceid','fid','loopid','step'));
	$invokepiece = $invokeService->getInvokePieceByInvokeId($invokepieceid);
	if ($invokepiece['rang']!='fid') {
		$fid = 0;
	}
	if (!$step) {
		InitGP(array('pushtid'));
		$default	= array();
		if ($pushtid) {
			require(R_P.'lib/tplgetdata.class.php');
			$default	= getSubjectByTid($pushtid,$invokepiece['param']);
		} else {
			foreach ($invokepiece['param'] as $key=>$value) {
				$default[$key] = '';
			}
		}
		$ajax_basename	= EncodeUrl($basename."&action=addpush");
		require_once PrintMode('ajax_tplcontent');ajax_footer();
	} else {
		InitGP(array('param','offset','endtime'),'GP');
		if ($endtime) {
			$endtime	= PwStrtoTime($endtime);
			if ($endtime == -1) {
				$endtime = 0;
			}
		}

		if (isset($invokepiece['param']['tagrelate'])) {
			InitGP(array('tagrelate'));
			$param['tagrelate']	= getTagRelate($tagrelate);
		}

		$offset = (int) $offset;
		$invokeService->insertPushData(array('invokepieceid'=>$invokepieceid,'fid'=>$fid,'loopid'=>$loopid,'starttime'=>$timestamp,'endtime'=>$endtime,'offset'=>$offset,'data'=>$param));

		$invokeService->updateCacheDataPiece($invokepieceid,$fid,$loopid);

		echo getLangInfo('msg','operate_success')."\treload";
		ajax_footer();
	}
} elseif ($action == 'delpush') {
	define('AJAX',1);
	InitGP(array('pushid'),'',2);
	$pushdata	= $invokeService->getPushDataById($pushid);
	$invokeService->deletePushData($pushid);
	$invokeService->updateCacheDataPiece($pushdata['invokepieceid'],$pushdata['fid'],$pushdata['loopid']);

	echo getLangInfo('msg','operate_success')."\treload";
	ajax_footer();
} elseif ($action == 'delpushs') {
	define('AJAX',1);
	InitGP(array('invokepieceid','fid','loopid'));

	$invokeService->deleteOverduePushData($invokepieceid,$fid,$loopid);

	echo getLangInfo('msg','operate_success')."\treload";
	ajax_footer();
} elseif ($action == 'updatecache') {
	define('AJAX',1);
	InitGP(array('scr','fid'));
	$fid	= (int) $fid;
	$config = $invokeService->getMPageConfig('area',$scr,$fid);
	foreach ($config as $key=>$value) {
		if ($value == 1) {
			$invokeService->updateCacheDataPiece($key,$fid);
		} else {
			$invokeService->updateCacheDataPiece($key);
		}
	}
	echo getLangInfo('msg','operate_success')."\treload";
	ajax_footer();
}

include PrintMode('tplcontent');exit;
?>