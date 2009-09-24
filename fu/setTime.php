<?php
$fp = fopen('settime','w');
fwrite($fp,$_GET["time"]*60);
$fp2 = fopen('settime','r');
echo fgets($fp2);
?>