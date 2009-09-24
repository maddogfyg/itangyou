<?php
!function_exists('adminmsg') && exit('Forbidden');
$basename="$admin_file?adminjob=creditdiy";

if(empty($action)){
	$credit=$db->query("SELECT * FROM pw_credits");
	include PrintEot('creditdiy');exit;
} elseif($action=='edit'){
	InitGP(array('cid'));
	if(!$_POST['step']){
		$creditdb=$db->get_one("SELECT * FROM pw_credits WHERE cid=".pwEscape($cid));
		if(!$creditdb)adminmsg('credit_error');
		include PrintEot('creditdiy');exit;
	} else{
		InitGP(array('name','unit','description'),'P');
		$db->update("UPDATE pw_credits"
			. " SET " . pwSqlSingle(array(
					'name'		=> $name,
					'unit'		=> $unit,
					'description'=>$description
				))
			. " WHERE cid=".pwEscape($cid));
		updatecache_c();
		adminmsg('operate_success');
	}
} elseif($action=='newcredit'){
	if(!$_POST['step']){
		include PrintEot('creditdiy');exit;
	} else{
		InitGP(array('name','unit','description'),'P');
		$db->update("INSERT INTO pw_credits"
			. " SET " . pwSqlSingle(array(
				'name'		=> $name,
				'unit'		=> $unit,
				'description'=>$description
		)));
		updatecache_c();
		adminmsg('operate_success');
	}
} elseif($_POST['action']=='delete'){
	InitGP(array('delcid'),'P');
	$delcids=array();
	if(!$delcid)adminmsg('operate_error');
	foreach($delcid as $id){
		is_numeric($id) && $delcids[] = $id;
	}
	if($delcids){
		$delcids = pwImplode($delcids);
		$db->update("DELETE FROM pw_credits WHERE cid IN($delcids)");
		$db->update("DELETE FROM pw_membercredit WHERE cid IN($delcids)");
		updatecache_c();
		adminmsg('operate_success');
	} else{
		adminmsg('operate_fail');
	}
}
?>
