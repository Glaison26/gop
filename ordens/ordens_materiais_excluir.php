<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");
$i_id_usuario = $_SESSION["id_usuario"];
$c_sql_acesso = "select usuarios.tipo, perfil_usuarios.gerenciar_ordem FROM usuarios
JOIN perfil_usuarios ON usuarios.id_perfil=perfil_usuarios.id
WHERE usuarios.id='$i_id_usuario'";
$result_acesso = $conection->query($c_sql_acesso);
$registro_acesso = $result_acesso->fetch_assoc();
if ($registro_acesso['tipo'] != 'Administrador' && $registro_acesso['gerenciar_ordem'] != 'S') {
    header('location: /gop/acesso.php');
}

//if (!isset($_GET["id"])) {
//    header('location: /gop/ordens/ordens_gerenciar.php');
//    exit;
//}

$c_id = $_GET["id"];
$c_id_ordem = $_SESSION['id_ordem'];

// Exclusão do registro
$c_sql = "delete from ordens_materiais where id=$c_id";
//echo $c_sql;
//die();
$result = $conection->query($c_sql);
 // somatório dos valores de custo de material
 $c_sql = "SELECT SUM(ordens_materiais.quantidade * ordens_materiais.valor) AS total
 FROM ordens_materiais
 WHERE ordens_materiais.id_ordem='$c_id_ordem'";
$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();
$c_custo_total= $c_linha['total'];
$c_custo_total = number_format($c_custo_total, 2, '.', ' ');
// edito o valor de materiais gastos na ordem de serviço
$c_sql = "update ordens set valor_material='$c_custo_total' where id='$c_id_ordem'";
$result = $conection->query($c_sql);
header('location: /gop/ordens/ordens_gerenciar.php');
