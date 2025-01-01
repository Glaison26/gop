<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

if (!isset($_GET["id"])) {
    header('location: /gop/obras/obras_insumos_lista.php');
    exit;
}

$c_id = $_GET["id"];
// conexão dom o banco de dados

include("../conexao.php");
include("../links2.php");

// Exclusão do registro
$c_sql = "delete from obras_insumos where id=$c_id";
$result = $conection->query($c_sql);
header('location: /gop/obras/obras_insumos_lista.php');
