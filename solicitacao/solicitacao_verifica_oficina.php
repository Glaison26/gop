<?php // controle de acesso ao formulário
///////////////////////////////////////////////////////////////////////
// modulo para enviar id da oficina selecionada 
//////////////////////////////////////////////////////////////////////

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");

$c_id = $_GET["id"];

// pesquisa do registro
$c_oficina = $c_id;
$c_sql_oficina = "SELECT oficinas.id FROM oficinas  where oficinas.descricao='$c_oficina'";
$result_oficina = $conection->query($c_sql_oficina);
$c_linha_oficina = $result_oficina->fetch_assoc();
// retorna valor apurado no sql para variaves session
$_SESSION['i_id_oficina'] = $c_linha_oficina['id'];
header('location: /gop/solicitacao/solicitacao_gera_os.php');