<?php
define('SCR','survey');
require_once('global.php');
@require_once(D_P."data/bbscache/survey_cache.php");
require_once(R_P.'require/header.php');
InitGP(array('itemid'));
if (!$itemid) {
	foreach ($survey_cache as $itemdb) {
		$itemid = $itemdb['itemid'] > $itemid ? $itemdb['itemid'] : $itemid;
	}
	$rt = $survey_cache[$itemid];
} else {
	$rt = $survey_cache[$itemid];
}
require_once PrintEot('survey');
footer();
?>