<?php
!function_exists('adminmsg') && exit('Forbidden');

$basename="$admin_file?adminjob=attachrenew";
($attach_url || $db_ifftp) && adminmsg('attachrenew_forbidden');

if(empty($_POST['action'])){
	InitGP(array('S_start','orderway'));
	$rs = $db->get_one("SELECT COUNT(*) AS count FROM pw_attachs");
	$A_count  = $rs['count'];
	$threaddb = array();
	if($A_count!=0){
		$P_N = 1000;
		$A_C = ceil($A_count/$P_N);
		$L_N = $P_N-$A_C*$P_N+$A_count;
		$S_end = $L_N;
		for($i=1;$i<=$A_C;$i++){
			$num = ($i-1)*$P_N;
			$E_num = $i==$A_C ? $num+$L_N : $num+$P_N;
			$S_num = "$num To $E_num";
			$A_option.="<option value=$i>$S_num</option>";
		}
		!$S_start && $S_start=1;
		$S_start==$A_C ? $S_end=$L_N : $S_end=$P_N;
		$start_limit=($S_start-1)*$P_N;
		$orderway!='size' && $orderway='aid';
		$query=$db->query("SELECT aid,fid,name,size,attachurl FROM pw_attachs ORDER BY $orderway".pwLimit($start_limit,$S_end));

		while($attach=$db->fetch_array($query)){
			if(!file_exists("$attachdir/$attach[attachurl]")){
				$thread['aid']=$attach['aid'];
				$thread['size']=$attach['size'];
				$thread['url']=$attach['attachurl'];
				$thread['name']=$attach['name'];
				$thread['where']="thread.php?fid=$fid";
				$threaddb[]=$thread;
			}
		}
	}
	include PrintEot('attachrenew');exit;
} else{
	$count = 0;
	$ttable_a = array('pw_tmsgs');
	if($db_tlist){
		$tlistdb = unserialize($db_tlist);
		foreach($tlistdb as $key=>$val){
			$ttable_a[] = 'pw_tmsgs'.$key;
		}
	}
	foreach($ttable_a as $pw_tmsgs){
		$query=$db->query("SELECT t.fid,t.tid,t.authorid,aid FROM $pw_tmsgs tm LEFT JOIN pw_threads t ON t.tid=tm.tid  WHERE aid<>''");
		while($aids=$db->fetch_array($query)){
			$attachs= unserialize(stripslashes($aids['aid']));
			if(is_array($attachs)){
				$update=0;
				foreach($attachs as $key=>$attach){
					if($attach['attachurl'] && file_exists($attachdir.'/'.$attach['attachurl'])){
						$check=$db->get_one("SELECT aid FROM pw_attachs WHERE aid=".pwEscape($attach['aid']));
						if(!$check){
							$uploadtime=pwFilemtime($attachdir.'/'.$attach['attachurl']);
							$count++;
							$db->update("INSERT INTO pw_attachs"
								. " SET " . pwSqlSingle(array(
									'aid'		=> $attach['aid'],		'fid'		=> $aids['fid'],
									'uid'		=> $aids['authorid'],	'tid'		=> $aids['tid'],
									'pid'		=> 0,					'name'		=> $attach['name'],
									'type'		=> $attach['type'],		'size'		=> $attach['size'],
									'attachurl'	=> $attach['attachurl'],'hits'		=> $attach['hits'],
									'needrvrc'	=> $attach['needrvrc'],	'uploadtime'=> $uploadtime,
									'descrip'	=> $attach['desc']
							),false));
						}
					} else{
						$count++;
						$check=$db->get_one("SELECT aid FROM pw_attachs WHERE aid=".pwEscape($attach['aid']));
						if($check){
							$db->update("DELETE FROM pw_attachs WHERE aid=".pwEscape($attach['aid']));
						}
						$update=1;
						unset($attachs[$key]);
					}
				}
				if($update){
					$attachs=$attachs ? serialize($attachs):'';
					$db->update("UPDATE $pw_tmsgs SET aid=".pwEscape($attachs,false)."WHERE tid=".pwEscape($aids['tid']));
				}
			} else{
				$count++;
				$db->update("UPDATE $pw_tmsgs SET aid='' WHERE tid=".pwEscape($aids['tid']));
			}
		}
	}
	$ptable_a = array('pw_posts');
	if($db_plist){
		$p_list=explode(',',$db_plist);
		foreach($p_list as $val){
			$ptable_a[] = 'pw_posts'.$val;
		}
	}
	foreach($ptable_a as $pw_posts){
		$query=$db->query("SELECT fid,tid,authorid,aid FROM $pw_posts WHERE aid<>''");
		while($aids=$db->fetch_array($query)){
			$attachs= unserialize(stripslashes($aids['aid']));
			if(is_array($attachs)){
				$update=0;
				foreach($attachs as $key=>$attach){
					if($attach['attachurl'] && file_exists($attachdir.'/'.$attach['attachurl'])){
						$check=$db->get_one("SELECT aid FROM pw_attachs WHERE aid=".pwEscape($attach['aid']));
						if(!$check){
							$uploadtime=pwFilemtime($attachdir.'/'.$attach['attachurl']);
							$count++;
							$db->update("INSERT INTO pw_attachs"
								. " SET " . pwSqlSingle(array(
									'aid'		=> $attach['aid'],
									'fid'		=> $aids['fid'],
									'uid'		=> $aids['authorid'],
									'tid'		=> $aids['tid'],
									'pid'		=> 0,
									'name'		=> $attach['name'],
									'type'		=> $attach['type'],
									'size'		=> $attach['size'],
									'attachurl'	=> $attach['attachurl'],
									'hits'		=> $attach['hits'],
									'needrvrc'	=> $attach['needrvrc'],
									'uploadtime'=> $uploadtime,
									'descrip'	=> $attach['desc']
							),false));
						}
					} else{
						$count++;
						$check=$db->get_one("SELECT aid FROM pw_attachs WHERE aid=".pwEscape($attach['aid']));
						if($check){
							$db->update("DELETE FROM pw_attachs WHERE aid=".pwEscape($attach['aid']));
						}
						$update=1;
						unset($attachs[$key]);
					}
				}
				if($update){
					$attachs=$attachs ?  addslashes(serialize($attachs)):'';
					$db->update("UPDATE $pw_posts SET aid=".pwEscape($attachs)."WHERE tid=".pwEscape($aids['tid']));
				}
			} else{
				$count++;
				$db->update("UPDATE $pw_posts SET aid='' WHERE tid=".pwEscape($aids['tid']));
			}
		}
	}
	adminmsg('attach_renew');
}
?>