<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");

if (!isset($_GET["id"])) {
    header('location: /gop/preventivas/preventivas_anexos.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];
$c_id_preventiva = $_SESSION['id_preventiva'];

// Exclusão do registro
$c_sql = "delete from preventivas_executores where id=$c_id";
$result = $conection->query($c_sql);
 
header('location: /gop/preventivas/preventivas_anexos.php');