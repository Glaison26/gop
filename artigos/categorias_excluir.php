<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}


$c_id = $_GET["id"];
// conexão dom o banco de dados
include("../conexao.php");
// verifico por sql se não existe um artigo técnico com essa categoria
$c_sql_verifica = "select id from artigos where id_categoria='$c_id'";
$result_verifica = $conection->query($c_sql_verifica);
if ($result_verifica->num_rows > 0) {
    // se existir, exibo uma mensagem de erro e redireciono para a lista de categorias
    echo "<script language='Javascript'>mensagem('Não é possível excluir esta categoria, pois existem artigos técnicos associados a ela.');</script>";
    header('location: /gop/artigos/categorias_lista.php');
    exit();
}

// Exclusão do registro

$c_sql = "delete from artigos_categoria where id=$c_id";
$result = $conection->query($c_sql);
header('location: /gop/artigos/categorias_lista.php');
