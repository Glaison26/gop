<?php // controle de acesso ao formulário
///////////////////////////////////////////////////////////////////////
// modulo para enviar valor da hora do prestador selecionada para o formulário
//////////////////////////////////////////////////////////////////////

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");

$c_id = $_GET["id"];

// pego o valor do prestador selecionado no formulário
$c_prestador = $c_id;
$c_sql_valor = "SELECT prestadores.valor_visita FROM prestadores  where prestadores.nome='$c_prestador'";
$result_valor = $conection->query($c_sql_valor);
$c_linha_valor = $result_valor->fetch_assoc();

$_SESSION['valor_prestador'] = $c_linha_valor['valor_visita'];
$_SESSION['nome_prestador'] = $c_prestador;

header('location: /gop/ordens/ordens_prestadores_inclusao.php');