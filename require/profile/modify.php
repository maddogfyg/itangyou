<?php
!function_exists('readover') && exit('Forbidden');

@include_once(D_P.'data/bbscache/customfield.php');

$ifppt = false;
$madd = $mbadd = '';

if (!$db_pptifopen || $db_ppttype == 'server') {
	$ifppt = true;
	$madd .= ',m.password';
}
!is_array($customfield) && $customfield = array();

foreach ($customfield as $key => $value) {
	$customfield[$key]['id'] = $value['id'] = (int)$value['id'];
	$customfield[$key]['field'] = "field_$value[id]";
	if ($value['type'] == 3 && $_POST['step'] != 2) {
		$customfield[$key]['options'] = explode("\n",$value['options']);
	} elseif ($value['type'] == 2) {
		$SCR = 'post';
	}
	$mbadd .= ",mb.field_$value[id]";
}
$db_union[7] && $mbadd .= ',mb.customdata';

$userdb = $db->get_one("SELECT m.email$madd,m.groupid,m.groups,m.icon,m.gender,m.signature,m.introduce,m.oicq,m.aliww,m.msn,m.yahoo,m.site,m.location,m.honor,m.bday,m.timedf,m.datefm,m.t_num,m.p_num,m.userstatus,md.currency,md.starttime,mb.tradeinfo{$mbadd} FROM pw_members m LEFT JOIN pw_memberdata md USING(uid) LEFT JOIN pw_memberinfo mb USING(uid) WHERE m.uid=" . pwEscape($winduid));
InitGP(array('info_type'));

if (empty($_POST['step'])) {

	list($iconurl,$icontype,$iconwidth,$iconheight,$iconfile,,,$iconsize) = showfacedesign($userdb['icon'], true);
	include_once(D_P.'data/bbscache/dbreg.php');
	require_once(R_P.'require/forum.php');
	$customdata = $custominfo = $sexselect = $yearslect = $monthslect = $dayslect = array();
	$ifpublic = $groupselect = $httpurl = $email_Y = $email_N = '';
	$ifsign = false;
	!in_array($info_type, array('base','trade','link','face','safe','other')) && $info_type = 'base';
	getstatus($userdb['userstatus'],7) && $ifpublic = 'checked';
	${'email_' . (getstatus($userdb['userstatus'],8) ? 'Y' : 'N')} = 'checked';

	if ($db_selectgroup && $userdb['groups']) {
		$ltitle = L::config('ltitle', 'level');
		$groupselect = $userdb['groupid']=='-1' ? '<option></option>' : "<option value=\"$userdb[groupid]\">".$ltitle[$userdb['groupid']]."</option>";
		$groups = explode(',',$userdb['groups']);
		foreach ($groups as $value) {
			$ltitle = (is_array($ltitle)) ? $ltitle : array($ltitle);
			if ($value && array_key_exists($value,$ltitle)) {
				$groupselect .= "<option value=\"$value\">$ltitle[$value]</option>";
			}
		}
	}
	$db_union[7] && list($customdata,$custominfo) = Getcustom($userdb['customdata']);

	$sexselect[(int)$userdb['gender']] = 'checked';

	!$rg_timestart && $rg_timestart = 1960;
	!$rg_timeend && $rg_timeend = 2000;
	$getbirthday = explode('-',$userdb['bday']);
	$yearslect[(int)$getbirthday[0]] = $monthslect[(int)$getbirthday[1]] = $dayslect[(int)$getbirthday[2]] = 'selected';

	//$width2 = $iconwidth;
	//$height2 = $iconheight;
	//$iconwidth && $iconsize = " width=\"$iconwidth\"";
	//$iconheight && $iconsize .= " height=\"$iconheight\"";
	if ($icontype == 2) {
		$httpurl = $iconurl;
	}
	if ($icontype != 1) {
		$iconfile = '';
	}
	if ($userdb['signature'] || $userdb['introduce']) {
		$SCR = 'post';
	}
	if (!is_array($trade = unserialize($userdb['tradeinfo']))) {
		$trade = array();
	}
	//系统头像
	$img = @opendir("$imgdir/face");
	while ($imgname = @readdir($img)) {
		if ($imgname!='.' && $imgname!='..' && $imgname!='' && preg_match('/\.(gif|jpg|png|bmp)$/i',$imgname)) {
			$num++;
			$imgname_array[] = $imgname;
			if ($num >= 10) break;
		}
	}
	@closedir($img);

	//flash头像上传参数
	if ($db_ifupload && $_G['upload']) {
		list($db_upload,$db_imglen,$db_imgwidth,$db_imgsize) = explode("\t",$db_upload);
		$pwServer['HTTP_USER_AGENT'] = 'Shockwave Flash';
		$swfhash = GetVerify($winduid);
		$upload_param = rawurlencode($db_bbsurl.'/job.php?action=uploadicon&verify='.$swfhash.'&uid='.$winduid.'&');
		$save_param = rawurlencode($db_bbsurl.'/job.php?action=uploadicon&step=2&');
		$default_pic = rawurlencode("$db_picpath/facebg.jpg");
		$icon_encode_url = 'up='.$upload_param.'&saveFace='.$save_param.'&url='.$default_pic.'&PHPSESSID='.$sid.'&'.'imgsize='.$db_imgsize.'&';
	} else {
		$icon_encode_url = '';
	}
	if ($userdb['timedf']) {
		$temptimedf = str_replace('.','_',abs($userdb['timedf']));
		$userdb['timedf'] < 0 ? ${'zone_0'.$temptimedf} = 'selected' : ${'zone_'.$temptimedf} = 'selected';
	}

	require_once PrintEot('profile_modify');
	footer();

} else {

	PostCheck();
	Add_S($userdb);
	$ustatus = '';
	$upmembers = $upmemdata = $upmeminfo = array();

	if ($ifppt) {

		include_once(D_P.'data/bbscache/dbreg.php');
		InitGP(array('propwd','proemail'),'P');
		if ($propwd || $userdb['email'] != $proemail) {
			if ($_POST['oldpwd']) {
				if (strlen($userdb['password']) == 16) {
					$_POST['oldpwd'] = substr(md5($_POST['oldpwd']),8,16);//支持 16 位 md5截取密码
				} else {
					$_POST['oldpwd'] = md5($_POST['oldpwd']);
				}
			}
			$userdb['password'] != $_POST['oldpwd'] && Showmsg('pwd_confirm_fail');
			if ($propwd) {
				CkInArray($windid,$manager) && Showmsg('pro_manager');
				$propwd != $_POST['check_pwd'] && Showmsg('password_confirm');
				if ($propwd != str_replace(array("\\",'&',' ',"'",'"','/','*',',','<','>',"\r","\t","\n",'#','%'),'',$propwd)) {
					Showmsg('illegal_password');
				}
				if ($rg_pwdcomplex) {
					$arr_rule = array();
					$arr_rule = explode(',',$rg_pwdcomplex);
					foreach ($arr_rule as $value) {
						$value = (int)$value;
						if (!$value) continue;
						switch ($value) {
							case 1:
								if (!preg_match('/[a-z]/',$propwd)) {
									Showmsg('reg_password_lowstring');
								}
								break;
							case 2:
								if (!preg_match('/[A-Z]/',$propwd)) {
									Showmsg('reg_password_upstring');
								}
								break;
							case 3:
								if (!preg_match('/[0-9]/',$propwd)) {
									Showmsg('reg_password_num');
								}
								break;
							case 4:
								if (!preg_match('/[^a-zA-Z0-9\\\/\&\'\"\*\,<>#\?% ]/',$propwd)) {
									Showmsg('reg_password_specialstring');
								}
								break;
						}
					}
				}
				$upmembers['password'] = md5($propwd);
				$upmemdata['pwdctime'] = $timestamp;
			}
			if ($userdb['email'] != $proemail) {
				include_once(D_P.'data/bbscache/dbreg.php');
				$rg_emailcheck && Showmsg('pro_emailcheck');

				$email_check = $db->get_one("SELECT COUNT(*) AS count FROM pw_members WHERE email=".pwEscape($proemail));
				if ($email_check['count'] > 1) {
					Showmsg('reg_email_have_same');
				} else {
					unset($email_check);
				}
			}
		}
		if ($_POST['propublicemail'] != getstatus($userdb['userstatus'],7)) {
			$ustatus .= ',userstatus=userstatus'.($_POST['propublicemail'] ? '|' : '&~') .'(1<<6)';
		}
	} else {
		$proemail = $userdb['email'];
	}
	if ($proemail && !preg_match('/^[-a-zA-Z0-9_\.]+\@([0-9A-Za-z][0-9A-Za-z-]+\.)+[A-Za-z]{2,5}$/',$proemail)) {
		Showmsg('illegal_email');
	}
	InitGP(array('proicon','prosign','profrom','proyahoo','promsn','prohomepage','prohonor', 'prointroduce','customdata', 'prooicq', 'proaliww','proicq','alipay','tradetype','question','timedf'),'P');
	InitGP(array('newgroupid','progender','proyear','promonth','proday','facetype','proreceivemail'), 'P', 2);

	if ($db_ifsafecv && $question != '-2') {
		$safecv = '';
		if ($db_ifsafecv) {
			require_once(R_P.'require/checkpass.php');
			$safecv = questcode($question,$_POST['customquest'],$_POST['answer']);
		}
		$upmembers['safecv'] = $safecv;
	}

	if ($db_selectgroup && $newgroupid && $newgroupid != $userdb['groupid'] && $userdb['groups']) {
		if (strpos($userdb['groups'],','.$newgroupid.',') === false) {
			Showmsg('undefined_action');
		} else {
			if ($userdb['groupid'] == '-1') {
				$groups = str_replace(",$newgroupid,",',',$userdb['groups']);
				$groups == ',' && $groups = '';
			} else {
				$groups = str_replace(",$newgroupid,",",$userdb[groupid],",$userdb['groups']);
			}
			$upmembers['groupid']	= $newgroupid;
			$upmembers['groups']	= $groups;
		}
	}
	$prooicq && !is_numeric($prooicq) && Showmsg('illegal_OICQ');
	$proicq && !is_numeric($proicq) && Showmsg('illegal_OICQ');

	strlen($prointroduce)>500 && Showmsg('introduce_limit');
	$_G['signnum'] && strlen($prosign) > $_G['signnum'] && Showmsg('sign_limit');
	if ($_G['allowhonor']) {
		$prohonor = substrs($prohonor,90);
		$upmembers['honor'] = $prohonor;
		if ($userdb['honor'] <> $prohonor) {
			pwAddFeed($winduid,'honor','',array('honor' => $prohonor));
		}
	}
	require_once(R_P . 'require/bbscode.php');
	$wordsfb = wordsfb::getInstance();
	foreach (array($prosign, $prointroduce, $prohonor) as $key => $value) {
		if (($banword = $wordsfb->comprise($value)) !== false) {
			Showmsg('sign_wordsfb');
		}
	}
	//upmeminfo
	if ($db_union[7]) {
		list($customdata) = Getcustom($customdata,false,true);
		!empty($customdata) && $upmeminfo['customdata'] = addslashes(serialize($customdata));
	}
	foreach ($customfield as $value) {
		$fieldvalue = Char_cv($_POST[$value['field']]);
		if ($value['required'] && !$fieldvalue) {
			Cookie('pro_modify', 'other', 'F', false);
			Showmsg('field_empty');
		}
		if ($userdb[$value['field']] != $fieldvalue) {
			if ($value['maxlen'] && strlen($fieldvalue) > $value['maxlen']) {
				Showmsg('field_lenlimit');
			}
			$upmeminfo[$value['field']] = $fieldvalue;
		}
	}
	$trade = array();
	if ($alipay) {
		if (preg_match('/^[-a-zA-Z0-9_\.]+\@([0-9A-Za-z][0-9A-Za-z-]+\.)+[A-Za-z]{2,5}$/',$alipay) || preg_match('/^[\d]{11}/',$alipay)) {
			$trade['alipay'] = stripslashes($alipay);
		} else {
			Showmsg('alipay_error');
		}
	}
	/*
	if ($tenpay) {
		$trade['tenpay'] = stripslashes($tenpay);
	}
	*/
	if ($tradetype && is_array($tradetype)) {
		$i = 0;
		foreach ($tradetype as $key => $value) {
			if ($key > 0 && $value && is_string($value)) {
				$trade['tradetype'][$key] = stripslashes($value);
			}
			if (++$i > 100) break;
		}
	}
	$tradeinfo = $trade ? addslashes(serialize($trade)) : '';
	if ($tradeinfo <> $userdb['tradeinfo']) {
		$upmeminfo['tradeinfo'] = $tradeinfo;
	}

	$user_a = explode('|',$winddb['icon']);
	$usericon = '';
	if ($facetype == 1) {
		$usericon = setIcon($proicon, $facetype, $user_a);
	} elseif ($_G['allowportait'] && $facetype == 2) {
		$httpurl = $_POST['httpurl'];
		if (strncmp($httpurl[0],'http',4) != 0 || strrpos($httpurl[0],'|') !== false) {
			Showmsg('illegal_customimg');
		}
		$proicon = $httpurl[0];
		$httpurl[1] = (int)$httpurl[1];
		$httpurl[2] = (int)$httpurl[2];
		$httpurl[3] = (int)$httpurl[3];
		$httpurl[4] = (int)$httpurl[4];
		list($user_a[2], $user_a[3]) = flexlen($httpurl[1], $httpurl[2], $httpurl[3], $httpurl[4]);
		$usericon = setIcon($proicon, $facetype, $user_a);
		unset($httpurl);
	}
	pwFtpClose($ftp);
	//update memdata
	if ($upmemdata) {
		$pwSQL = pwSqlSingle($upmemdata);
		$db->update("UPDATE pw_memberdata SET $pwSQL WHERE uid=".pwEscape($winduid));
	}
	//update meminfo
	if ($upmeminfo) {
		$pwSQL = pwSqlSingle($upmeminfo);
		$db->pw_update(
			"SELECT uid FROM pw_memberinfo WHERE uid=".pwEscape($winduid),
			"UPDATE pw_memberinfo SET $pwSQL WHERE uid=".pwEscape($winduid),
			"INSERT INTO pw_memberinfo SET uid=".pwEscape($winduid).','.$pwSQL
		);
	}
	unset($upmemdata,$upmeminfo, $facetype, $customfield);
	//other
	$prohomepage && substr($prohomepage,0,4)!='http' && $prohomepage = "http://$prohomepage";

	$probday = '';
	if ($proyear || $promonth || $proday) {
		$probday = $proyear.'-'.$promonth.'-'.$proday;
	}
	$cksign = convert($prosign,$db_windpic,2);
	$signstatus = $cksign != $prosign ? 1 : 0;

	if ($signstatus != getstatus($userdb['userstatus'],9)) {
		$ustatus .= ',userstatus=userstatus'.($signstatus ? '|' : '&~') .'(1<<8)';
	}
	if ($proreceivemail != getstatus($userdb['userstatus'],8)) {
		$ustatus.= ',userstatus=userstatus'.($proreceivemail ? '|' : '&~') .'(1<<7)';
	}
	//update member
	$pwSQL = array_merge($upmembers,array(
		'email' => $proemail, 'gender' => $progender, 'signature' => $prosign, 'introduce' => $prointroduce, 'oicq' => $prooicq, 'aliww' => $proaliww, 'icq' => $proicq, 'yahoo' => $proyahoo, 'msn' => $promsn, 'site' => $prohomepage, 'location' => $profrom, 'bday' => $probday,'timedf' => $timedf
	));
	$usericon && $pwSQL['icon'] = $usericon;
	$db->update("UPDATE pw_members SET " . pwSqlSingle($pwSQL) . "$ustatus WHERE uid=" . pwEscape($winduid));

	$_cache = getDatastore();
	$_cache->delete('UID_'.$winduid);

	refreshto("profile.php?action=modify&info_type=$info_type",'operate_success',2,true);
}

function Getcustom($data,$unserialize=true,$strips=null){
	global $db_union;
	$customdata = array();
	if (!$data || ($unserialize ? !is_array($data=unserialize($data)) : !is_array($data))) {
		$data = array();
	} elseif (!is_array($custominfo = unserialize($db_union[7]))) {
		$custominfo = array();
	}
	if (!empty($data) && !empty($custominfo)) {
		foreach ($data as $key => $value) {
			if (!empty($strips)) {
				$customdata[stripslashes(Char_cv($key))] = stripslashes(Char_cv($value));
			} elseif ($custominfo[$key] && $value) {
				$customdata[$key] = $value;
			}
		}
	}
	return array($customdata,$custominfo);
}
?>