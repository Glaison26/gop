<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../../conexao.php");
if (!isset($_GET["id"])) {
    header('location: /gop/cadastros/contratos/parametros.php');
    exit;
}
$c_id = $_GET["id"];
// Exclusão do registro
$c_sql = "delete from contratos_parametros where id=$c_id";
$result = $conection->query($c_sql);
header('location: /gop/cadastros/contratos/parametros.php');