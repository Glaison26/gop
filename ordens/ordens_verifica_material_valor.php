<?php // controle de acesso ao formulário
///////////////////////////////////////////////////////////////////////
// modulo para enviar valor de custo do material selecionada para o formulário
//////////////////////////////////////////////////////////////////////

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");

$c_id = $_GET["id"];

// pesquisa do registro
$c_material = $c_id;
$c_sql_valor = "SELECT materiais.custo FROM materiais  where materiais.descricao='$c_material'";
$result_valor = $conection->query($c_sql_valor);
$c_linha_valor = $result_valor->fetch_assoc();
// retorna valor apurado no sql para variaves session
$_SESSION['valor_material'] = $c_linha_valor['custo'];
$_SESSION['nome_material'] = $c_material;

header('location: /gop/ordens/ordens_materiais_inclusao.php');