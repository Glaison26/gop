<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");

if (!isset($_GET["id"])) {
    header('location: /gop/ordens/ordens_gerenciar.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];
$c_id_ordem = $_SESSION['id_ordem'];

// Exclusão do registro
$c_sql2 = "delete from ordens_prestadores where id=$c_id";
$result2 = $conection->query($c_sql2);
// somatório dos valores de custo de serviço de prestadores
$c_sql = "SELECT SUM(ordens_prestadores.valor_total) AS total
                FROM ordens_prestadores
                WHERE ordens_prestadores.id_ordem='$c_id'";
$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();
$c_custo_total = $c_linha['total'];
// somátorio dos valores de custo de serviço de executores
$c_sql = "SELECT SUM(ordens_executores.valor_total) AS total
                FROM ordens_executores
                WHERE ordens_executores.id_ordem='$c_id'";
$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();
$c_custo_executores = $c_linha['total'];
// somatório dos valores de custo de serviço de prestadores e executores
$c_custo_total = $c_custo_total + $c_custo_executores;
//$c_custo_total = number_format($c_custo_total, 2, '.', ' ');
// edito o valor de materiais gastos na ordem de serviço
$c_sql = "update ordens set valor_servico='$c_custo_total' where id='$c_id_ordem'";
$result = $conection->query($c_sql);
header('location: /gop/ordens/ordens_gerenciar.php');
