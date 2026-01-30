<?php // controle de acesso ao formulário
///////////////////////////////////////////////////////////////////////
// modulo para enviar valor da hora do executor selecionada para o formulário
//////////////////////////////////////////////////////////////////////

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");

$c_id = $_GET["id"];

// pego o valor do executor selecionado no formulário
$c_executor = $c_id;
$c_sql_valor = "SELECT executores.valorhora FROM executores  where executores.nome='$c_executor'";
$result_valor = $conection->query($c_sql_valor);
$c_linha_valor = $result_valor->fetch_assoc();

$_SESSION['valor_executor'] = $c_linha_valor['valorhora'];
$_SESSION['nome_executor'] = $c_executor;

header('location: /gop/ordens/ordens_executores_inclusao.php');