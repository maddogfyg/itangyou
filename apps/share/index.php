<?php
if ($route == "share") {
	require_once $basePath . '/action/m_share.php';
} elseif ($route == "sharelink") {
	require_once $basePath . '/action/m_sharelink.php';
}
?>