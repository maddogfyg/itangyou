<?php
!defined('P_W') && exit('Forbidden');
class PW_ParseStopicTpl {
	var $_htmlConfig = array(
		'packclass'		=> 'groupWrapper',
		'itemclass'		=> 'groupItem',
		'headclass'		=> 'itemHeader',
		'editclass'		=> 'editEl',
		'closeclass'	=> 'closeEl',
		'contentclass'	=> 'itemContent',
	);
	var $service;
	var $stopic;
	var $units;
	var $blocks;
	var $ifadmin;
	var $delunits;

	function setIfAdmin($ifadmin) {
		$this->ifadmin = $ifadmin;
	}
	function setString($layout) {
		if ($layout && file_exists(Pcv(A_P.'data/layout/'.$layout.'/layout.htm'))) {
			$this->string = readover(Pcv(A_P.'data/layout/'.$layout.'/layout.htm'));
		} else {
			$this->string	= '';
		}
	}
	function exute($stopic_service,$stopic,$units,$blocks,$ifadmin) {
		$this->_register($stopic_service,$stopic,$units,$blocks,$ifadmin);
		if (!$this->string) return '';
		preg_match_all('/<div(.+?)>([^\x00]+?)<\/div>/is',$this->string,$match);
		$search = $replace = array();
		foreach ($match[1] as $key=>$value) {
			if (strpos($value,$this->_htmlConfig['packclass'])===false) {
				continue;
			}
			$id	= $this->_getId($value);
			if (!$id) {
				continue;
			}
			$search[]	= $match[0][$key];
			$replace[]	= $this->_getReplace($id,$value);
		}
		$this->_delOverageUnits();
		return str_replace($search,$replace,$this->string);
	}

	function _register($stopic_service,$stopic,$units,$blocks,$ifadmin) {
		$this->service	=&$stopic_service;
		$this->setString($stopic['layout']);
		$this->setIfAdmin($ifadmin);

		$this->stopic	= $stopic;
		$this->units	= $this->delunits = $units;
		$this->blocks	= $blocks;
	}

	function _delOverageUnits() {
		if ($this->delunits) {
			$keys = array_keys($this->delunits);
			$this->service->deleteUnits($this->stopic['stopic_id'],$keys);
		}
	}

	function _getId($string) {
		preg_match('/id=\s?("|\')([\w]*?)\\1/is',$string,$match);
		return $match[2];
	}
	function _getReplace($id,$divconfig) {
		$temp	= '';
		$temp	.= '<div'.$divconfig.'>';
		$temp	.= $this->_getUnitsByPack($id);
		$temp	.= '</div>';
		return $temp;
	}
	function _getUnitsByPack($id) {
		if (!isset($this->stopic['block_config'][$id])) return '';
		$temp	= '';
		foreach ($this->stopic['block_config'][$id] as $html_id) {
			$temp	.= $this->_getUnitHTML($html_id);
		}
		return $temp;
	}
	function _getUnitHTML($html_id) {
		$html_id	= trim($html_id);
		unset($this->delunits[$html_id]);
		$temp	= '<div class="'.$this->_htmlConfig['itemclass'].'" id="'.$html_id.'">';
		$temp	.= $this->_getHeadData($html_id);
		$temp	.= '<div class="'.$this->_htmlConfig['contentclass'].'">';
		$temp	.= $this->_getHtmlData($html_id);
		$temp	.= '</div>';
		$temp	.= '</div>';
		return $temp;
	}
	function _getHeadData($html_id) {
		$temp	= '';
		if (!$this->units[$html_id]['title'] && !$this->ifadmin) return '';
		$temp	.= '<div class="'.$this->_htmlConfig['headclass'].'"><span>';
		$temp	.= $this->units[$html_id]['title'];
		$temp	.= '</span>';
		if ($this->ifadmin) {
			$temp	.= '<a href="#" class="'.$this->_htmlConfig['editclass'].'">'.getLangInfo('other','stopic_edit').'</a>';
			$temp	.= '<a href="#" class="'.$this->_htmlConfig['closeclass'].'">[x]</a>';
		}
		$temp	.= '</div>';
		return $temp;
	}
	function _getHtmlData($html_id){
		$data	= $this->units[$html_id]['data'];
		$blockid	= $this->units[$html_id]['block_id'];
		$block	= $this->blocks[$blockid];
		return $this->service->getHtmlData($data,$block);
	}
}
?>