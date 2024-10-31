<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

// conexão dom o banco de dados
include("../conexao.php");

if (!isset($_GET["id"])) {
    header('location: /gop/almoxarifado/cotacao_material.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];

// Exclusão do registro
$c_sql = "delete from cotacao_materiais_fornecedor where id=$c_id";

$result = $conection->query($c_sql);

header('location: /gop/almoxarifado/cotacao_material.php');