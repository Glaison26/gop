<?php
date_default_timezone_set('America/Sao_Paulo');
$data_str = '2026-02-26 10:00:00';
$nova_data = date('Y-m-d H:i:s', strtotime('2026-02-26 10:00:00 +24 hours 0 minutes'));
echo $nova_data;