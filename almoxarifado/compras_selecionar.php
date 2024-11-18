<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include('../conexao.php');
if (!isset($_GET["id"])) {
    header('location: /gop/almoxarifado/compras_fechamento.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];
// verifico status para ser alterado
$c_sql = "select compras_materiais.receber from compras_materiais where id=$c_id";
$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();
if ($c_linha['receber'] == 'S')
    $c_status = 'N';
else
    $c_status = 'S';
// alteração do campo de geração de registro da preventiva
$c_sql = "update compras_materiais set receber='$c_status' where id=$c_id";
$result = $conection->query($c_sql);
header('location: /gop/almoxarifado/compras_fechamento.php');
