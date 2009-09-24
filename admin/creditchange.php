<?php
!function_exists('adminmsg') && exit('Forbidden');
$basename = "$admin_file?adminjob=creditchange";
require_once(R_P.'require/credit.php');

$rt = $db->get_one("SELECT db_value FROM pw_config WHERE db_name='jf_A'");
$jf_A = $rt['db_value'] ? unserialize($rt['db_value']) : array();

if (empty($action)) {

	$creditlist = '';
	foreach ($credit->cType as $key => $value) {
		$creditlist .= "<option value=\"$key\">$value</option>";
	}
	$jf = array();
	foreach ($jf_A as $key => $value) {
		list($j_1,$j_2) = explode('_',$key);
		$jf[$key] = array($credit->cType[$j_1],$credit->cType[$j_2],$value[0],$value[1],$value[2]);
	}
	include PrintEot('creditchange');exit;

} elseif ($_POST['action'] == 'add') {

	InitGP(array('cchange'));
	if ($cchange[0] == $cchange[1]) {
		adminmsg('bankset_save');
	}
	if (empty($cchange[2]) || $cchange[2]<=0 || empty($cchange[3]) || $cchange[3]<=0) {
		adminmsg('bankset_rate_error');
	}
	if (isset($jf_A[$cchange[0].'_'.$cchange[1]])) {
		adminmsg('bankset_exists');
	}
	$jf_A[$cchange[0].'_'.$cchange[1]] = array($cchange[2],$cchange[3],1);
	$value = serialize($jf_A);
	if ($rt) {
		$db->update("UPDATE pw_config SET db_value=".pwEscape($value,false)."WHERE db_name='jf_A'");
	} else{
		$db->update("INSERT INTO pw_config SET db_name='jf_A',db_value=".pwEscape($value,false));
	}
	adminmsg('operate_success');

} elseif ($_POST['action'] == 'submit') {

	InitGP(array('selid','ifopen'),'P');
	if ($selid) {
		foreach ($selid as $key => $value) {
			unset($jf_A[$value]);
		}
	}
	foreach ($jf_A as $key => $vlaue) {
		$jf_A[$key][2] = in_array($key,$ifopen) ? 1 : 0;
	}
	$value = serialize($jf_A);
	if ($rt) {
		$db->update("UPDATE pw_config SET db_value=".pwEscape($value,false)."WHERE db_name='jf_A'");
	} else {
		$db->update("INSERT INTO pw_config SET db_name='jf_A',db_value=".pwEscape($value,false));
	}
	adminmsg('operate_success');
}
?>