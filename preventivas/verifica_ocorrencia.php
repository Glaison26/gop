<?php // controle de acesso ao formulário
///////////////////////////////////////////////////////////////////////
// modulo para enviar texto da ocorrencia selecionada para o formulário
//////////////////////////////////////////////////////////////////////

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");

$c_id = $_GET["id"];

// Exclusão do registro
$c_ocorrencia = $c_id;
$c_sql_ocor = "select texto from ocorrencias where ocorrencias.descricao='$c_ocorrencia'";
$result_ocor = $conection->query($c_sql_ocor);
$c_linha_ocor = $result_ocor->fetch_assoc();

$_SESSION['ocorrencia'] = $c_linha_ocor['texto'];
$_SESSION['valor_ocorrencia'] = $c_ocorrencia;

header('location: /gop/preventivas/preventiva_conclusao.php');