<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include('../conexao.php');
if (!isset($_GET["id"])) {
    header('location: /gop/preventivas/preventivas_geracao.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];
// verifico status para ser aletrado
$c_sql = "select preventivas.gerar from preventivas where id=$c_id";
$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();
if ($c_linha['gerar']=='Sim')
  $c_status='Não';
else
  $c_status='Sim';
// alteração do campo de geração de registro da preventiva
$c_sql = "update preventivas set gerar='$c_status' where id=$c_id";
$result = $conection->query($c_sql);
header('location: /gop/preventivas/preventivas_geracao.php');
