<?php
!defined('P_W') && exit('Forbidden');

if (!$action) {
	require GetLang('left');
	$db_diy = $db->get_value("SELECT db_value FROM pw_config WHERE db_name='db_diy'");
	if ($db_diy) {
		$db_diy = ','.$db_diy.',';
	} else {
		$db_diy = ',setforum,setuser,level,postcache,article,';
	}
	$editset = $checkvar = '';
	foreach ($nav_left as $cate => $left) {
		foreach ($left as $title => $value) {
			$checkvar .= ",'chk_$title' : true";
			$editset .= '<tr class="tr3"><td width="15%"><a style="cursor:pointer" onclick="CheckForm(getObj(\''.$title.'\'))">'.$value[name].'</a></td><td id="'.$title.'"><ul class="list2">';
			foreach ($value['option'] as $key => $option) {
				if (isset($option[0]) && !is_array($option[0])) {
					$checked = (strpos($db_diy,','.$key.',')!==false) ? 'CHECKED' : '';
					$editset .= ' <li><input type="checkbox" name="diydb[]" value="'.$key.'" '.$checked.'> '.$option[0].'</li>';
				} else {
					foreach ($option as $k => $v) {
						$checked = (strpos($db_diy,','.$k.',')!==false) ? 'CHECKED' : '';
						$editset .= ' <li><input type="checkbox" name="diydb[]" value="'.$k.'" '.$checked.'> '.$v[0].'</li>';
					}
				}
			}
			$editset .= "</ul></td></tr>";
		}
	}
	$checkvar && $checkvar = substr($checkvar,1);
	include PrintEot('diyoption');exit;
} elseif ($action=='edit') {
	InitGP(array('diydb'),'P');
	if (is_array($diydb)) {
		if (count($diydb)>15) adminmsg('diyoption_maxlength');
		$diydb	= implode(',',$diydb);
	} else {
		$diydb	= '';
	}
	setConfig('db_diy', $diydb);
	updatecache_c();
	adminmsg('operate_success');
} else {
	ObHeader($basename);
}
?>