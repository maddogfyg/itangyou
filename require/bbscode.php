<?php
!function_exists('readover') && exit('Forbidden');

function convert($message,$allow,$type="post"){
	global $isGM,$pwPostHide,$pwSellHide,$pwEncodeHide,$code_num,$code_htm,$phpcode_htm,$foruminfo,$db_picpath,$imgpath,$stylepath,$db_attachname,$attachpath, $tpc_author,$tpc_buy,$db_cvtimes,$forumset,$tpc_tag;

	$code_num = 0;
	$code_htm = array();
	if (strpos($message,"[code]") !== false && strpos($message,"[/code]") !== false) {
		$message = preg_replace("/\[code\](.+?)\[\/code\]/eis","phpcode('\\1')",$message,$db_cvtimes);
	}
	if (strpos($message,"[payto]") !== false && strpos($message,"[/payto]") !== false) {
		require_once(R_P.'require/paytofunc.php');
		$message = preg_replace("/\[payto\](.+?)\[\/payto\]/eis","payto('\\1')",$message);
	}
	$message = preg_replace('/\[list=([aA1]?)\](.+?)\[\/list\]/is', "<ol type=\"\\1\" style=\"margin:0 0 0 25px\">\\2</ol>", $message);

	$searcharray = array('[u]','[/u]','[b]','[/b]','[i]','[/i]','[list]','[li]','[/li]','[/list]','[sub]', '[/sub]','[sup]','[/sup]','[strike]','[/strike]','[blockquote]','[/blockquote]','[hr]','[/backcolor]', '[/color]','[/font]','[/size]','[/align]'
	);
	$replacearray = array('<u>','</u>','<b>','</b>','<i>','</i>','<ul style="margin:0 0 0 15px">','<li>', '</li>','</ul>','<sub>','</sub>','<sup>','</sup>','<strike>','</strike>','<blockquote>','</blockquote>', '<hr />','</span>','</span>','</font>','</font>','</div>'
	);
	$message = str_replace($searcharray,$replacearray,$message);

	$message = str_replace("p_w_upload",$db_attachname,$message);//此处位置不可调换
	$message = str_replace("p_w_picpath",$db_picpath,$message);//此处位置不可调换

	$searcharray = array(
		"/\[font=([^\[\(&\\;]+?)\]/is",
		"/\[color=([#0-9a-z]{1,10})\]/is",
		"/\[backcolor=([#0-9a-z]{1,10})\]/is",
		"/\[email=([^\[]*)\]([^\[]*)\[\/email\]/is",
	    "/\[email\]([^\[]*)\[\/email\]/is",
		"/\[size=(\d+)\]/eis",
		"/\[align=(left|center|right|justify)\]/is",
		"/\[glow=(\d+)\,([0-9a-zA-Z]+?)\,(\d+)\](.+?)\[\/glow\]/is"
	);
	$replacearray = array(
		"<font face=\"\\1 \">",
		"<span style=\"color:\\1 \">",
		"<span style=\"background-color:\\1 \">",
		"<a href=\"mailto:\\1 \">\\2</a>",
		"<a href=\"mailto:\\1 \">\\1</a>",
		"size('\\1','$allow[size]')",
		"<div align=\"\\1\">",
		"<div style=\"width:\\1px;filter:glow(color=\\2,strength=\\3);\">\\4</div>"
	);
	$message = preg_replace($searcharray,$replacearray,$message);

	if ($allow['pic']) {
		$message = preg_replace("/\[img\]([^\<\r\n\"']+?)\[\/img\]/eis", "cvpic('\\1','','$allow[picwidth]','$allow[picheight]')",$message,$db_cvtimes);
    } else{
		$message = preg_replace("/\[img\]([^\<\r\n\"']+?)\[\/img\]/eis","nopic('\\1')",$message,$db_cvtimes);
	}

	if (strpos($message,'[/URL]') !== false || strpos($message,'[/url]') !== false) {
		$searcharray = array(
			"/\[url=(https?|ftp|gopher|news|telnet|mms|rtsp|thunder)([^\[\s]+?)(\,(1))?\](.+?)\[\/url\]/eis",
			"/\[url\]www\.([^\[]+?)\[\/url\]/eis",
			"/\[url\](https?|ftp|gopher|news|telnet|mms|rtsp|thunder)([^\[]+?)\[\/url\]/eis"
		);
		$replacearray = array(
			"cvurl('\\1','\\2','\\5','\\4','$allow[checkurl]')",
			"cvurl('\\1','','','','$allow[checkurl]')",
			"cvurl('\\1','\\2','','','$allow[checkurl]')",
		);
		$message = preg_replace($searcharray,$replacearray,$message);
	}

	$searcharray = array(
		"/\[fly\]([^\[]*)\[\/fly\]/is",
		"/\[move\]([^\[]*)\[\/move\]/is"
	);
	$replacearray = array(
		"<marquee width=90% behavior=alternate scrollamount=3>\\1</marquee>",
		"<marquee scrollamount=3>\\1</marquee>"
	);
	$message = preg_replace($searcharray,$replacearray,$message);

	if ($type == 'post') {
		if ($foruminfo['allowhide'] && strpos($message,"[post]")!==false && strpos($message,"[/post]")!==false) {
			$message=preg_replace("/\[post\](.+?)\[\/post\]/eis","post('\\1')",$message);
		}
		if ($forumset['allowencode'] && strpos($message,"[hide=")!==false && strpos($message,"[/hide]")!==false) {
			$message=preg_replace("/\[hide=(.+?)\](.+?)\[\/hide\]/eis","hidden('\\1','\\2')",$message);
		}
		if ($foruminfo['allowsell'] && strpos($message,"[sell")!==false && strpos($message,"[/sell]")!==false) {
			$message=preg_replace("/\[sell=(.+?)\](.+?)\[\/sell\]/eis","sell('\\1','\\2')",$message);
		}
	}
	if (strpos($message,"[quote]") !== false && strpos($message,"[/quote]") !== false) {
		$message = preg_replace("/\[quote\](.+?)\[\/quote\]/eis","qoute('\\1')",$message);
	}
	if (is_array($code_htm)) {
		krsort($code_htm);
		foreach ($code_htm as $codehtm) {
			foreach ($codehtm as $key => $value) {
				$message = str_replace("<\twind_code_$key\t>",$value,$message);
			}
		}
	}
	if ($allow['flash']) {
		$message = preg_replace("/\[flash=(\d+?)\,(\d+?)(\,(0|1))?\]([^\[\<\r\n\"']+?)\[\/flash\]/eis", "wplayer('\\5','\\1','\\2','\\4','flash')",$message,$db_cvtimes);
	} else {
		$message = preg_replace("/\[flash=(\d+?)\,(\d+?)(\,(0|1))?\]([^\[\<\r\n\"']+?)\[\/flash\]/is","<img src='$imgpath/$stylepath/file/music.gif' align='absbottom'> <a target='_blank' href='\\5 '>flash: \\5</a>",$message,$db_cvtimes);
	}
	if ($type == 'post') {
		$t = 0;
		while (strpos($message,'[table') !== false && strpos($message,'[/table]') !== false) {
			$message = preg_replace('/\[table(=(\d{1,3}(%|px)?))?\](.*?)\[\/table\]/eis', "tablefun('\\2','\\3','\\4')",$message);
			if (++$t>4) break;
		}
		if ($allow['mpeg']) {
			$message = preg_replace(
				array(
					"/\[wmv=(0|1)\]([^\[\<\r\n\"']+?)\[\/wmv\]/eis",
					"/\[wmv(=([0-9]{1,3})\,([0-9]{1,3})\,(0|1))?\]([^\[\<\r\n\"']+?)\[\/wmv\]/eis",
					"/\[rm(=([0-9]{1,3})\,([0-9]{1,3})\,(0|1))?\]([^\[\<\r\n\"']+?)\[\/rm\]/eis"
				),
				array(
					"wplayer('\\2','314','53','\\1','wmv')",
					"wplayer('\\5','\\2','\\3','\\4','wmv')",
					"wplayer('\\5','\\2','\\3','\\4','rm')"
				),$message,$db_cvtimes
			);
		} else{
			$message = preg_replace(
				array(
					"/\[wmv=[01]{1}\]([^\[\<\r\n\"']+?)\[\/wmv\]/is",
					"/\[wmv(?:=[0-9]{1,3}\,[0-9]{1,3}\,[01]{1})?\]([^\[\<\r\n\"']+?)\[\/wmv\]/is",
					"/\[rm(?:=[0-9]{1,3}\,[0-9]{1,3}\,[01]{1})\]([^\[\<\r\n\"']+?)\[\/rm\]/is"
				),
				"<img src=\"$imgpath/$stylepath/file/music.gif\" align=\"absbottom\"> <a target=\"_blank\" href=\"\\1 \">\\1</a>",$message,$db_cvtimes
			);
		}
		if ($allow['iframe']) {
			$message = preg_replace("/\[iframe\]([^\[\<\r\n\"']+?)\[\/iframe\]/is","<IFRAME SRC=\\1 FRAMEBORDER=0 ALLOWTRANSPARENCY=true SCROLLING=YES WIDTH=97% HEIGHT=340></IFRAME>",$message,$db_cvtimes);
		} else {
			$message = preg_replace("/\[iframe\]([^\[\<\r\n\"']+?)\[\/iframe\]/is","Iframe Close: <a target=_blank href='\\1 '>\\1</a>",$message,$db_cvtimes);
		}
		$tpc_tag && $message = relatetag($message,$tpc_tag);
		strpos($message,'[s:') !== false && $message = showface($message);
	}
	if (is_array($phpcode_htm)) {
		foreach($phpcode_htm as $key => $value){
			$message = str_replace("<\twind_phpcode_$key\t>",$value,$message);
		}
	}
	return $message;
}
function copyctrl() {
	$lenth=10;
	mt_srand((double)microtime() * 1000000);
	for ($i = 0; $i < $lenth; $i++) {
		$randval .= chr(mt_rand(0,126));
	}
	$randval = str_replace('<','&lt;',$randval);
	return "<span style=\"display:none\"> $randval </span>&nbsp;<br />";
}
function attachment($message) {
	$matches = $aids = array();
	preg_match_all('/\[(attachment|p_w_upload|p_w_picpath)=(\d+)\]/is', $message, $matches);
	foreach ($matches[2] as $aid) {
		$aids[] = $aid;
	}
	return $aids;
}
function attcontent($message, $atype, $att) {
	$html = '';
	switch ($atype) {
		case 'pic':
			$html = '<b>'.$att['desc'].'</b>'.$att['img'];break;
		case 'downattach':
			$html = "<img src=\"$GLOBALS[imgpath]/$GLOBALS[stylepath]/file/$att[type].gif\" align=\"absmiddle\" /><a href=\"job.php?action=download&aid=$att[aid]\" target=\"_blank\"> $att[name]</a> ($att[size] K) &#19979;&#36733;&#27425;&#25968;:$att[hits] ";
			if ($att['needrvrc'] > 0) {
				$html .= ($att['special'] == 2 ? '&#21806;&#20215;' : '&#38656;&#35201;') . ":{$att[needrvrc]}{$att[cname]} ";
			} elseif (in_array($att['ext'],array('mp3','wma','wmv','rm','swf'))) {
				$html .= "[<a style=\"cursor:pointer\" onclick=\"playatt('$att[aid]');\">&#35797;&#25773;</a>]";
			}
			break;
		case 'picurl':
			$html = "&#36828;&#31243;&#22270;&#29255;：<a href=\"job.php?action=showimg&tid={$GLOBALS[tid]}&pid={$GLOBALS[tpc_pid]}&fid={$GLOBALS[fid]}&aid={$att[aid]}&verify={$att[verify]}\" target=\"_blank\">$att[name]</a>";break;
	}
	$message = str_replace("[attachment={$att[aid]}]", "<span id=\"att_$att[aid]\">".$html.'</span>', $message);
	return $message;
}
function tablefun($width,$unit,$text) {
	global $tdcolor,$td_htm,$td_num;
	if ($width) {
		$unit !='%' && $unit = 'px';
		$width = $unit == 'px' ? ($width < 600 ? (int)$width : 600).'px' : ($width < 98 ? (int)$width : 98).'%';
	} else {
		$width = '98%';
	}
	$text = preg_replace(
		array(
		'/(\[\/td\]\s*)?\[\/tr\]\s*/is',
		'/\[(tr|\/td)\]\s*\[td(=(\d{1,2}),(\d{1,2})(,(\d{1,3}(%|px)?))?)?\]/eis',
		'/\[tr\]/is',
		"/\\n/is"
		),
		array('</td></tr>',"tdfun('\\1','\\3','\\4','\\6')",'<tr class="tr5"><td>','<br />'),
		trim(str_replace(array('\\"','<br />'),array('"',"\n"),$text))
	);
	return "<table style=\"border-top:1px solid $tdcolor;border-left:1px solid $tdcolor;width:$width\" cellspacing=\"0\" cellpadding=\"0\">$text</table>";
}
function tdfun($t,$col,$row,$width) {
	return ($t == 'tr' ? '<tr class="tr5">' : '</td>').(($col && $row) ? "<td colspan=\"$col\" rowspan=\"$row\" width=\"$width\">" : "<td>");
}
function size($size,$allowsize) {
	$allowsize && $size > $allowsize && $size = $allowsize;
	return "<font size=\"$size\">";
}
function cvurl($http,$url='',$name='',$ifdownload='',$checkurl) {
	global $code_num,$code_htm,$db_bbsurl;
	$code_num++;
	if ($checkurl == 1) {
		static $urlnum = 0;
		$addjs = 'onclick="return checkUrl(this)" id="url_' . ++$urlnum . '"';
	}
	if (!$url) {
		$url = "<a href=\"http://www.$http\" target=\"_blank\" $addjs>www.$http</a>";
	} elseif (!$name) {
		$url = "<a href=\"$http$url\" target=\"_blank\" $addjs>$http$url</a>";
	} elseif (!$ifdownload) {
		$url = "<a href=\"$http$url\" target=\"_blank\" $addjs>".str_replace('\\"','"',$name)."</a>";
	} else {
		$url = "<a class=\"down\" href=\"$http$url\" target=\"_blank\" $addjs>".str_replace('\\"','"',$name)."</a>";
	}
	$code_htm[0][$code_num] = $url;
	return "<\twind_code_$code_num\t>";
}

function nopic($url) {
	global $code_num,$code_htm,$imgpath,$stylepath;
	$code_num++;
	$code_htm[-1][$code_num]="<img src=\"$imgpath/$stylepath/file/img.gif\" align=\"absbottom\" border=\"0\"> <a target=\"_blank\" href=\"$url \">img: $url</a>";
	return "<\twind_code_$code_num\t>";
}

function cvpic($url,$type='',$picwidth='',$picheight='',$ifthumb='') {
	global $db_bbsurl,$db_picpath,$attachpath,$db_ftpweb,$code_num,$code_htm;
	$code_num++;
	$lower_url = strtolower($url);
	strncmp($lower_url,'http',4)!=0 && $url = "$db_bbsurl/$url";
	if (strpos($lower_url,'login')!==false && (strpos($lower_url,'action=quit')!==false || strpos($lower_url,'action-quit')!==false)) {
		$url = preg_replace('/login/i','log in',$url);
	}
	$url = str_replace(array("&#39;","'"),'',$url);
	$turl = $url;
	$wopen = 0;
	$alt = '';
	if ($ifthumb) {
		if ($db_ftpweb && !strpos($url,$attachpath)!==false) {
			$picurlpath = $db_ftpweb;
		} else{
			$picurlpath = $attachpath;
		}
		if (strpos($url,$picurlpath)!==false) {
			$wopen = 1;
			$alt = 'title="Click Here To EnLarge"';
			$turl = str_replace($picurlpath,"$picurlpath/thumb",$url);
		}
	}
	if ($picwidth || $picheight) {
		$wopen = !$wopen ? "if(this.width>=$picwidth)" : '';
		$onload = 'onload="';
		$picwidth  && $onload .= "if(this.offsetWidth>'$picwidth')this.width='$picwidth';";
		$picheight && $onload .= "if(this.offsetHeight>'$picheight')this.height='$picheight';";
		$onload .= '"';
		$code = "<img src=\"$turl\" border=\"0\" onclick=\"$wopen window.open('$url');\" $onload $alt>";
	} else{
		$wopen = !$wopen ? "if(this.width>screen.width-461)" : '';
		$code = "<img src=\"$turl\" border=\"0\" onclick=\"$wopen window.open('$url');\" $alt>";
	}
	$code_htm[-1][$code_num]=$code;
	if ($type) {
		return $code;
	} else {
		return "<\twind_code_$code_num\t>";
	}
}

function phpcode($code){
	global $phpcode_htm,$codeid;
	$code = str_replace(array("[attachment=",'\\"'),array("&#91;attachment=",'"'),$code);
	$codeid ++;
	$code = preg_replace('/^(<br \/>)?(.+?)(<br \/>)$/','\\2',$code);
	$code = str_replace("<br />", "</li><li>", $code);
	$phpcode_htm[$codeid] = "<table cellspacing=\"0\" cellpadding=\"0\" width=\"80%\"><tr><td><div class=\"c\"></div><span class=\"f10 s8\"><a href=\"javascript:\"  onclick=\"CopyCode(document.getElementById('code$codeid'));\">".getLangInfo('bbscode','copycode')."</a></span><div class=\"blockquote2\" id=\"code$codeid\"><ol><li>".preg_replace("/^(\<br \/\>)?(.*)/is","\\2",$code)."</li></ol></div></td></tr></table>";
	return "<\twind_phpcode_$codeid\t>";
}

function qoute($code) {
	global $code_num,$code_htm,$i_table;
	$code_num++;
	$code_htm[6][$code_num]="<blockquote class=\"blockquote3\"><div class=\"quote\">".getLangInfo('bbscode','qoute')." </div><div class=\"text\">".str_replace('\\"','"',$code)."</div></blockquote>";
	return "<\twind_code_$code_num\t>";
}
function ifpost($tid) {
	global $admincheck,$tpc_author,$winduid,$windid,$db,$pwPostHide;

	static $ifview = null;
	if (!isset($ifview)) {
		if ($windid && $tpc_author == $windid) {
			$ifview = 2;
		} elseif ($pwPostHide) {
			$ifview = 3;
		} elseif ($admincheck) {
			$ifview = 4;
		} else {
			$pw_posts = GetPtable($GLOBALS['ptable']);
			$rs = $db->get_one("SELECT count(*) AS count FROM $pw_posts WHERE tid=".pwEscape($tid)." AND authorid=".pwEscape($winduid));
			$ifview = $rs['count'] > 0 ? 1 : 0;
		}
	}
	return $ifview;
}
function post($code) {
	global $code_num,$tid,$code_htm;
	$code_num++;

	if (ifpost($tid) > 0) {
		$r_ifpost = ifpost($tid);
		$code_htm[3][$code_num] = "<h6 class=\"quote\" style=\"padding:0;margin:0;\"><span class=\"s3 f12 fn\">".getLangInfo('bbscode','bbcode_hide'.$r_ifpost)."</span></h6><blockquote class=\"blockquote\" style=\"margin:10px 0;\">".str_replace('\\"','"',$code)."</blockquote>";
	} else {
		$code_htm[3][$code_num] = "<blockquote class=\"blockquote f12\" style=\"margin:10px 0;\">".getLangInfo('bbscode','bbcode_hide')."</blockquote>";
	}
	return "<\twind_code_$code_num\t>";
}
function hidden($cost,$code) {
	global $groupid,$code_num,$code_htm;
	$code_num++;

	if ($groupid != 'guest') {
		global $db,$isGM,$winddb,$userrvrc,$userpath,$windid,$tpc_author,$_CREDITDB, $winduid,$db_enhideset,$pwEncodeHide;

		static $sCredit = null;
		list($creditvalue,$credittype) = explode(',',$cost);
		if (!$credittype || !CkInArray($credittype,$db_enhideset['type'])) {
			$credittype = 'rvrc';
		}
		if (in_array($credittype,array('money','rvrc','credit','currency'))) {
			$creditname = $GLOBALS['db_'.$credittype.'name'];
			$usercredit = $credittype == 'rvrc' ? $userrvrc : $winddb[$credittype];
		} elseif (isset($_CREDITDB[$credittype])) {
			$creditname = $_CREDITDB[$credittype][0];
			if (!isset($sCredit)) {
				$query = $db->query("SELECT uid,cid,value FROM pw_membercredit WHERE uid=".pwEscape($winduid));
				while ($rt = $db->fetch_array($query)) {
					$sCredit[$rt['cid']] = $rt['value'];
				}
				$db->free_result($query);
			}
			$usercredit = $sCredit[$credittype];
		} else {
			$creditname = $GLOBALS['db_moneyname'];
			$usercredit = $winddb['money'];
		}
		$creditvalue = intval(trim(stripslashes($creditvalue)));
		if ($windid != $tpc_author && $usercredit < $creditvalue && !$isGM && !$pwEncodeHide) {
			$code = "<blockquote class=\"blockquote\" style=\"margin:10px 0;\">"
					. getLangInfo('bbscode','bbcode_encode1',array('name'=>$creditname,'value'=>$creditvalue))
					. "</blockquote>";
		} else {
			$code = "<h6 class=\"quote\" style=\"padding:0;margin:0;\"><span class=\"s3 f12 fn\">"
					. getLangInfo('bbscode','bbcode_encode2',array('name'=>$creditname))
					. "</span></h6><blockquote class=\"blockquote\" style=\"margin:10px 0;\">"
					. str_replace('\\"','"',$code)
					. "</blockquote>";
		}
	} else {
		$code = "<blockquote class=\"blockquote\" style=\"margin:10px 0;\">"
				. getLangInfo('bbscode','bbcode_encode3')
				. "</blockquote>";
	}
	$code_htm[4][$code_num] = $code;
	return "<\twind_code_$code_num\t>";
}
function sell($cost,$code) {
	global $isGM,$windid,$tpc_author,$tpc_buy,$tpc_pid,$fid,$tid,$i_table,$groupid,$code_num,$code_htm, $db_bbsurl,$db_sellset,$_CREDITDB,$pwSellHide;
	$code_num++;
	list($creditvalue,$credittype) = explode(',',$cost);
	$creditvalue = (int)$creditvalue;
	if ($creditvalue < 0) {
		$creditvalue = 0;
	} elseif ($db_sellset['price'] && $creditvalue > $db_sellset['price']) {
		$creditvalue = $db_sellset['price'];
	}
	$creditname = isset($_CREDITDB[$credittype]) ? $_CREDITDB[$credittype][0] : (in_array($credittype,array('money','rvrc','credit','currency')) ? $GLOBALS['db_'.$credittype.'name'] : $GLOBALS['db_moneyname']);

	$userarray = explode(',',$tpc_buy);
	$count = 0;
	foreach ($userarray as $value) {
		if ($value) {
			$count++;
			$buyers.="<option value=''>".$value."</option>";
		}
	}
	if ($groupid != 'guest' && ($isGM || $tpc_author == $windid || ($userarray && @in_array($windid,$userarray)) || $pwSellHide)) {
		$printcode = "<div><span class=\"s3 f12\">"
					. getLangInfo('bbscode','bbcode_sell_info',array('value' => $creditvalue, 'name' => $creditname, 'count' => $count))
					. "</span> <select name=\"buyers\"><option>"
					. getLangInfo('bbscode','bbcode_sell_buy')
					. "</option>$buyers</select></div><blockquote style=\"margin:10px 0;background:none;border:1px dashed\" class=\"blockquote\">"
					. str_replace('\\"','"',$code)
					. "</blockquote>";
	} else {
		$printcode = "<div><span class=\"s3 f12\">"
					. getLangInfo('bbscode','bbcode_sell_info', array('value' => $creditvalue, 'name' => $creditname, 'count' => $count))
					. "</span> <select name=\"buyers\"><option value=''>"
					. getLangInfo('bbscode','bbcode_sell_buy')
					. "</option><option value=>-----------</option>$buyers</select> <input type=\"button\" value=\""
					. getLangInfo('bbscode','bbcode_sell_submit')
					. "\" class=\"btn\" onclick=\"location.href='job.php?action=buytopic&tid=$tid&pid=$tpc_pid&verify=$GLOBALS[verifyhash]&page={$GLOBALS['page']}'\" style=\"line-height:100%\"></div><blockquote style=\"margin:10px 0;border:1px dashed\" class=\"blockquote\">"
					. getLangInfo('bbscode','bbcode_sell_notice')
					. "</blockquote>";
	}
	$code_htm[5][$code_num] = $printcode;
	return "<\twind_code_$code_num\t>";
}

function shield($code){
	global $groupid;
	$code = getLangInfo('bbscode',$code);
	return "<span style=\"color:black;background-color:#ffff66\">$code</span>";
}
function wplayer($wmvurl,$width='',$height='',$auto='',$type='wmv'){
	static $player_id = 0;
	!$width && $width = 314;
	!$height && $height = 256;
    return (++$player_id == 1 ? "<script id=\"js_player\" src=\"js/player.js\"></script>" : '')."<div id=\"player_$player_id\"><a onclick=\"player('player_$player_id','$wmvurl','$width','$height','$type');\" class=\"abtn f12\">".getLangInfo('bbscode','player_'.$type)."</a></div>".($auto == '1' ? "<script language=\"JavaScript\">player('player_{$player_id}','$wmvurl','$width','$height','$type');</script>" : '');
}
function showface($message) {
	global $face,$db_cvtimes;
	include_once(D_P.'data/bbscache/postcache.php');
	$message = preg_replace("/\[s:(.+?)\]/eis","postcache('\\1')",$message,$db_cvtimes);
	return $message;
}
function postcache($key) {
	global $face,$imgpath,$tpc_author;
	!$face[$key] && $face[$key] = current($face);
	if ($face[$key][2]) {
		return "<br /><img src=$imgpath/post/smile/{$face[$key][0]} /><br />[<font color=red><b>$tpc_author</b></font>] {$face[$key][2]}<br />";
	} else {
		return "<img src=\"$imgpath/post/smile/{$face[$key][0]}\" />";
	}
}

/* 词语过滤、替换，禁用词语操作入口
*  fix by sky_hold@163.com
*
*/
class wordsfb {

	var $fbwords = array();		//禁用词语
	var $replace = array();		//替换词语
	var $alarm = array();		//报警词语
	var $pwcode = array();		//自定义标签
	var $code;					//系统设置的词语更新系数 $db_wordsfb
	var $yes_arr = array();		//没有出现替换词语的列表
	var $no_arr = array();		//出现替换词语的列表

	function wordsfb() {
		$wordsfb = $replace = $alarm = array();
		include(D_P."data/bbscache/wordsfb.php");
		$this->fbwords = (array)$wordsfb;
		$this->replace = (array)$replace;
		$this->alarm = (array)$alarm;
		//$this->pwcode = $pwcode;
		$this->code = $GLOBALS['db_wordsfb'];
	}

	/* 返回唯一实例,本例为单件
	*
	*
	*/
	function getInstance() {
		static $instance = null;
		if (!isset($instance)) {
			$instance = new wordsfb();
		}
		return $instance;
	}
	/* 检测字符串是否需要经过词语替换
	*
	*/
	function ifwordsfb($str) {
		return ($this->comprise($str) === false) ? $this->code : 0;
	}

	function equal($currcode) {
		return ($currcode == $this->code);
	}
	/* 返回一个经过词语替换的字符串
	*
	*/
	function convert($str, $wdstruct = null) {
		$replacedb = $this->fbwords + $this->replace;
		$msg = $str;
		if ($replacedb) {
			foreach ($replacedb as $key => $value) {
				$msg = preg_replace($key,$value,$msg);
			}
		}
		if (is_object($wdstruct)) {
			if ($msg == $str) {
				$this->yes_arr[$wdstruct->type][] = $wdstruct->id;
			} elseif ($wdstruct->currcode > 0) {
				$this->no_arr[$wdstruct->type][] = $wdstruct->id;
			}
		}
		/*
		if ($this->pwcode && in_array($type,array('topic','posts'))) {
			$msg = preg_replace($this->pwcode['searcharray'],$this->pwcode['replacearray'],$msg);
		}
		*/
		return $msg;
	}
	/* 更新所有内容的词语系数
	*
	*
	*/
	function updateWordsfb() {
		if ($this->yes_arr) {
			$this->_update($this->yes_arr, $this->code);
			$this->yes_arr = array();
		}
		if ($this->no_arr) {
			$this->_update($this->no_arr, 0);
			$this->no_arr = array();
		}
	}

	function _update($arr, $val) {//private function
		global $db;
		foreach ($arr as $k => $v) {
			list($table, $field) = $this->tablestruct($k);
			$table && $db->update("UPDATE $table SET ifwordsfb=" . pwEscape($val) . " WHERE $field IN (" . pwImplode($v) . ')');
		}
	}

	function tablestruct($type) {
		$struct = array(
			'topic'		=> array($GLOBALS['pw_tmsgs'], 'tid'),
			'posts'		=> array($GLOBALS['pw_posts'], 'pid'),
			'comments'	=> array('pw_comment', 'id'),
			'oboard'	=> array('pw_oboard','id'),
			'diary'		=> array('pw_diary','did')
		);
		return isset($struct[$type]) ? $struct[$type] : array('','');
	}

	/* 检测字符串中是否包含禁用词语
	*
	*
	*/
	function comprise($str, $replace = true,$alarm = false) {
		if (empty($str)) {
			return false;
		}
		foreach ($this->fbwords as $key => $value) {
			if (preg_match($key, $str)) {
				return $this->getTrueBanword($key);
			}
		}
		if ($replace) {
			foreach ($this->replace as $key => $value) {
				if (preg_match($key, $str)) {
					return $this->getTrueBanword($key);
				}
			}
		}
		if ($alarm) {
			foreach ($this->alarm as $key => $value) {
				if (preg_match($key, $str)) {
					return $this->getTrueBanword($key);
				}
			}
		}
		return false;
	}

	function getTrueBanword($word) {
		$s_word = stripslashes($word);
		$banword = substr($s_word,1,strlen($s_word)-3);
		$banword = preg_replace('/\.\{0\,(\d+)\}/i','',$banword);
		return $banword;
	}
	/* 检测内容中是否有报警词语
	*
	*/
	function alarm($title, $content = '') {
		if ($this->alarm) {
			foreach ($this->alarm as $key => $value) {
				if (preg_match($key,$title) || preg_match($key,$content)) {
					return true;
				}
			}
		}
		return false;
	}
}
// 数据结构:表明禁用词语中当前词条的状态
class wdstruct {
	var $id;
	var $type;
	var $currcode;

	function wdstruct($id, $type, $currcode) {
		$this->id = $id;
		$this->type = $type;
		$this->currcode = $currcode;
	}
}
function leaveword($code,$pid) {
	global $admincheck,$imgpath,$tid;
	return "<div id=\"lwd_$pid\"><h6 class=\"quote\" style=\"padding:0;margin:0;\">".($admincheck ? "<span class=\"fr\" style=\"cursor:pointer\" onclick=\"read.obj=getObj('lwd_$pid');ajax.send('pw_ajax.php?action=leaveword','step=3&tid=$tid&pid=$pid',worded);\"><img src=\"$imgpath/close.gif\" /></span>" : '')."<span class=\"s3 f12 fn\">".getLangInfo('bbscode','post_reply')."</span></h6><blockquote class=\"blockquote f12\" style=\"margin:0;width:64%;\">".str_replace("\n","<br />",$code)."</blockquote></div>";
}
function relatetag($message,$tags) {
	$tags = explode(' ',$tags);
	foreach ($tags as $key => $tag) {
		$message = preg_replace("/(?<=[\s\"\]>()]|[\x7f-\xff]|^)(".preg_quote($tag, '/').")([.,:;-?!()\s\"<\[]|[\x7f-\xff]|$)/siUe","tagfont('\\1','\\2')",$message,1);
	}
	return $message;
}
function tagfont($tag,$code) {
	static $rlt_id = 0;
	$rlt_id++;
	return "<span onclick=\"sendmsg('pw_ajax.php','action=relatetag&tagname=$tag',this.id)\" style=\"cursor:pointer;border-bottom: 1px solid #FA891B;\" id=\"rlt_$rlt_id\">$tag</span>$code";
}
?>