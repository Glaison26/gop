<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}


$c_id = $_GET["id"];
// conexão dom o banco de dados
include("../conexao.php");

// Exclusão do registro

$c_sql = "delete from artigos_categoria where id=$c_id";
$result = $conection->query($c_sql);
header('location: /gop/artigos/categorias_lista.php');
