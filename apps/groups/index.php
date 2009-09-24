<?php
if ($route == "groups") {
	require_once $basePath . '/action/m_groups.php';
} elseif ($route == "group") {
	require_once $basePath . '/action/m_group.php';
} elseif ($route == "galbum") {
	require_once $basePath . '/action/m_galbum.php';
}
?>