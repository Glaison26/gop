<?php // controle de acesso ao formulário
///////////////////////////////////////////////////////////////////////
// modulo para enviar valor de custo do material selecionada para o formulário
//////////////////////////////////////////////////////////////////////

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");

$c_grupo = $_GET["id"]; // pego grupo selecionado no combo box
if (!empty($c_grupo)) {
    $c_sql_grupo_sel = "SELECT obras_grupo.id FROM obras_grupo  where obras_grupo.descricao='$c_grupo'"; // sql para pegar a id do grupo selecionado no combobox
    $result_grupo_sel = $conection->query($c_sql_grupo_sel);
    $c_linha_grupo_sel = $result_grupo_sel->fetch_assoc();
    $_SESSION['id_grupo_select'] = $c_linha_grupo_sel['id'];
} else
    $_SESSION['id_grupo_select'] = 0;
// volto para inclusão "I" ou Edição 'E'
if ($_SESSION['insumo_crud'] = 'I')
    header('location: /gop/obras/obras_insumos_novo.php');
else
    header('location: /gop/obras/obras_insumos_editar.php');
