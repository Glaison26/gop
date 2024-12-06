<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])){
 die('Acesso não autorizado!!!');
}


if (!isset($_GET["id"])) {
    header('location: /gop/cadastros/setores/setores_lista.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];
include("../../conexao.php");
include("../../links2.php");
include('../../cabec_exclusao.php');

// Exclusão do registro
$c_sql = "delete from setores where id=$c_id";
echo $c_sql;
echo $c_id;
$result = $conection->query($c_sql);

header('location: /gop/cadastros/setores/setores_lista.php');
