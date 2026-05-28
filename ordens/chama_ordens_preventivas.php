<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
// acesso ao banco de dados
include("../conexao.php");
// verifico se usuário e operador de tem autorização de acesso
$i_id_usuario = $_SESSION["id_usuario"];
$c_sql_acesso = "select usuarios.tipo, perfil_usuarios.servicos_preventivas FROM usuarios
JOIN perfil_usuarios ON usuarios.id_perfil=perfil_usuarios.id
WHERE usuarios.id='$i_id_usuario'";
$result_acesso = $conection->query($c_sql_acesso);
$registro_acesso = $result_acesso->fetch_assoc();
if ($registro_acesso['tipo'] == 'Operador' && $registro_acesso['servicos_preventivas'] == 'N') {
    header('location: /gop/acesso.php');
} else {
    // configura chamada da lista de ordens pra abrir ordens de serviço preventivas e abertas
    $_SESSION['checa_preventiva'] = "S";
    // chama página

    header('location: /gop/ordens/ordens.php');
}
