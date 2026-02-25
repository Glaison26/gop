<?php // controle de acesso ao formulário
///////////////////////////////////////////////////////////////////////
// modulo para enviar id do tipo de ocorrência selecionada 
//////////////////////////////////////////////////////////////////////

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");

$c_id = $_GET["id"];

// pesquisa do registro
$c_tipo_ocorrencia = $c_id;
$c_sql_tipo_ocorrencia = "SELECT Tipo_ocorrencia.id FROM Tipo_ocorrencia  where Tipo_ocorrencia.descricao='$c_tipo_ocorrencia'";
$result_tipo_ocorrencia = $conection->query($c_sql_tipo_ocorrencia);
$c_linha_tipo_ocorrencia = $result_tipo_ocorrencia->fetch_assoc();
// retorna valor apurado no sql para variaves session
$_SESSION['i_id_tipo_ocorrencia'] = $c_linha_tipo_ocorrencia['id'];
header('location: /gop/solicitacao/solicitacao_conclusao.php');