<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
$c_sql = $_SESSION['sql'];
echo $c_sql;
?>