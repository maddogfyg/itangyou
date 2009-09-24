<?php
!function_exists('adminmsg') && exit('Forbidden');
$basename="$admin_file?adminjob=setbwd";
require_once(R_P.'require/forum.php');

$db_perpage = 20;

if (!$action) {

	InitGP(array('page','keyword'));
	(!is_numeric($page) || $page<1) && $page = 1;
	$limit = pwLimit(($page-1)*$db_perpage,$db_perpage);
	$type!='1' && $type!='2' && $type='0';
	$sqladd = '';
	if($keyword){
		$sqladd = " AND (word LIKE ".pwEscape("%$keyword%")."OR wordreplace LIKE ".pwEscape("%$keyword%").") ";
	}
	$rt = $db->get_one("SELECT COUNT(*) AS sum FROM pw_wordfb WHERE type=".pwEscape($type).$sqladd);
	$pages = numofpage($rt['sum'],$page,ceil($rt['sum']/$db_perpage), "$basename&type=$type&keyword=".rawurlencode($keyword)."&");

	$replacedb = array();
	$query = $db->query("SELECT * FROM pw_wordfb WHERE type=".pwEscape($type).$sqladd." ORDER BY id $limit");
	while($rt = $db->fetch_array($query)){
		HtmlConvert($rt);
		$replacedb[$rt['id']]=$rt;
	}
	include PrintEot('setbwd');exit;

} elseif ($action == 'add') {

	if (!$_POST['step']) {

		include PrintEot('setbwd');exit;

	} elseif ($_POST['step'] == 3) {

		InitGP(array('word','rep','update'),'P');
		$type = (int)$type;
		$basename.="&type=$type";

		foreach ($word as $key => $value) {
			if ($value) {
				$db->update("INSERT INTO pw_wordfb"
					. " SET " . pwSqlSingle(array(
						'word'			=> $value,
						'wordreplace'	=> $rep[$key],
						'type'			=> $type
				)));
			}
		}
		if ($update) {
			($db_wordsfb > 0 && $db_wordsfb < 9) ? $db_wordsfb++ : $db_wordsfb = 1;
			setConfig('db_wordsfb', $db_wordsfb);
			updatecache_c();
		}
		updatecache_w();
		adminmsg('operate_success');
	}
} elseif ($action == 'batch') {

	if (!$_POST['step']) {

		include PrintEot('setbwd');exit;

	} elseif ($_POST['step'] == 3) {

		InitGP(array('update','mrep'),'P');

		$word   = $rep = array();
		$upload = $_FILES['upload'];

		if (is_array($upload)) {
			$upload_name = $upload['name'];
			$upload_size = $upload['size'];
			$upload = $upload['tmp_name'];
		}
		$basename.="&type=$type";

		if($upload && $upload!='none'){
			require_once(R_P.'require/postfunc.php');
			$attach_ext = strtolower(substr(strrchr($upload_name,'.'),1));
			if(!if_uploaded_file($upload)){
				adminmsg('upload_error');
			} elseif($attach_ext!='txt'){
				adminmsg('upload_type_error');
			}
			$source = D_P."data/tmp/word.txt";
			if(postupload($upload,$source)){
				include_once(D_P."data/bbscache/wordsfb.php");
				$content = explode("\n",readover($source));
				foreach($content as $key=>$value){
					list($w,$r)=explode("=>",$value);
					$r = trim($r);
					$w = explode("|",$w);
					foreach($w as $k=>$v){
						$v = trim($v);
						if(!isset($replace[$v]) && !isset($wordsfb[$v])){
							$word[] = $v;
							$rep[] = $r ? $r : $mrep;
						}
					}
				}
			} else{
				adminmsg('upload_error');
			}
			P_unlink($source);
		}
		if(empty($word) || !is_numeric($type)){
			adminmsg('operate_fail');
		}
		$pwSQL = array();
		foreach($word as $key=>$value){
			if($value){
				$pwSQL[] = array('word'=>$value,'wordreplace'=>$rep[$key],'type'=>$type);
			}
		}
		$pwSQL && $db->update("INSERT INTO pw_wordfb(word,wordreplace,type) VALUES".pwSqlMulti($pwSQL));
		if ($update) {
			($db_wordsfb > 0 && $db_wordsfb < 9) ? $db_wordsfb++ : $db_wordsfb = 1;
			setConfig('db_wordsfb', $db_wordsfb);
			updatecache_c();
		}
		updatecache_w();
		adminmsg('operate_success');

	} else{

		InitGP(array('filename'));
		!$filename && $filename = 'wordsfb';
		if (!eregi("^[-a-zA-Z0-9_]+$",$filename)) {
			adminmsg('undefined_action');
		}
		$sqladd = '';
		if ($type && is_array($type)) {
			$d_a	= array(0,1,2);
			$count	= count($type);
			if($count == 1){
				foreach($d_a as $key=>$value){
					if(isset($type[$value])){
						$sqladd = " AND type=".pwEscape($value);
						break;
					}
				}
			} elseif($count == 2){
				foreach($d_a as $key=>$value){
					if(!isset($type[$value])){
						$sqladd = " AND type!=".pwEscape($value);
						break;
					}
				}
			}
		} else{
			adminmsg('operate_error');
		}
		$words = '';
		$query = $db->query("SELECT * FROM pw_wordfb WHERE 1 $sqladd");
		while($rt = $db->fetch_array($query)){
			$words .= $rt['word']."=>".$rt['wordreplace']."\r\n";
		}
		header('Last-Modified: '.gmdate('D, d M Y H:i:s',$timestamp+86400).' GMT');
		header('Cache-control: no-cache');
		header('Content-Encoding: none');
		header('Content-Disposition: attachment; filename='.$filename.".txt");
		header('Content-type: txt');
		header('Content-Length: '.strlen($words));
		echo $words;exit;
	}
} elseif ($_POST['action'] == 'edit') {

	InitGP(array('selid','word','replace','update'),'P');
	$basename .= "&type=$type";
	if(is_array($selid)){
		$ids = array();
		foreach($selid as $key => $value){
			is_numeric($value) && $ids[] = $value;
		}
		$ids = pwImplode($ids);
		$ids && $db->update("DELETE FROM pw_wordfb WHERE id IN($ids)");
	}
	if(is_array($word)){
		foreach($word as $key=>$value){
			$db->update("UPDATE pw_wordfb SET word=".pwEscape($value).',wordreplace='.pwEscape($replace[$key]).'WHERE id='.pwEscape($key));
		}
	}
	if ($update) {
		($db_wordsfb > 0 && $db_wordsfb < 9) ? $db_wordsfb++ : $db_wordsfb = 1;
		setConfig('db_wordsfb', $db_wordsfb);
		updatecache_c();
	}
	updatecache_w();
	adminmsg('operate_success');

} elseif ($action == 'renew') {

	if (!$_POST['step']) {

		$desvalue = ($db_wordsfb > 0 && $db_wordsfb < 9) ? $db_wordsfb+1 : 1;
		include PrintEot('setbwd');exit;

	} else {

		InitGP(array('desvalue'),'P');
		(!is_numeric($desvalue) || $desvalue < 1 || $desvalue > 9) && $desvalue = 1;
		setConfig('db_wordsfb', $desvalue);
		updatecache_c();
		adminmsg('operate_success');
	}
}
?>