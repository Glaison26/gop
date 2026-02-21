<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
// configura chamada da lista de ordens pra abrir ordens de serviço preventivas e abertas
$_SESSION['checa_preventiva'] = "S";
// chama página
header('location: /gop/ordens/ordens.php');