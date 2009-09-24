<?php
!defined('P_W') && exit('Forbidden');
define('AJAX',1);
InitGP(array('step','html_id','stopic_id'));
$temp	= explode('_',$html_id);
$block_id	= $temp[1];
if (!$block_id || !$stopic_id) showmsg('undefined_error');
$block	= $stopic_service->getBlockById($block_id);

if (!$step) {
	$unit	= $stopic_service->getStopicUnitByStopic($stopic_id,$html_id);
	if (!$unit) {
		$unit	= array('stopic_id'=>$stopic_id,'html_id'=>$html_id,'block_id'=>$block_id,'title'=>'');
		$stopic_service->addUnit($unit);
		$unit['data']	= array();
	}
	$cospan	= count($block['config'])+1;
	$ajaxurl = EncodeUrl($basename);
} else {
	$temp_config	= $block['config'];
	$temp_index = array_search('html',$temp_config);
	if ($temp_index !== false) {
		unset($temp_config[$temp_index]);
		$html = ieconvert($_POST['html']);
	}
	InitGP($temp_config);
	InitGP('unit_title');
	$current = current($block['config']);
	$data = array();
	foreach (${$current} as $key=>$value) {
		$temp = array();
		foreach ($block['config'] as $name) {
			if ($name=='html') {
				${$name}[$key] = stripslashes(${$name}[$key]);
			}
			$temp[$name] = ${$name}[$key];
		}
		$data[] = $temp;
	}
	$affect = $stopic_service->updateUnitByFild($stopic_id,$html_id,array('title'=>$unit_title,'data'=>$data));
	if ($affect) {
		$htmlData = $stopic_service->getHtmlData($data,$block);
		$result	= array(
			'title'		=> $unit_title,
			'content'	=> $htmlData
		);
		$result	= pwJsonEncode($result);
		echo "success\t".$result;
	} else {
		echo 'error';
	}
	ajax_footer();
}
include stopic_use_layout ('ajax');


function getParamName($type,$stamp='subject'){
	if ($type=='title') {
		if ($stamp=='forum') {
			return getLangInfo('other','element_title_forum');
		} elseif($stamp=='user') {
			return getLangInfo('other','element_title_user');
		} elseif($stamp=='tag') {
			return getLangInfo('other','element_title_tag');
		} else {
			return getLangInfo('other','element_title');
		}
	}
	return getLangInfo('other','element_'.$type);
}
?>