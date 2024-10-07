<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

if (!isset($_GET["id"])) {
    header('location: /gop/plano_acao/diretriz_lista.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];
// conexão dom o banco de dados
include("../conexao.php");
// Exclusão do registro
$c_sql = "delete from diretrizes where id=$c_id";
$result = $conection->query($c_sql);
header('location: /gop/plano_acao/diretriz_lista.php');
