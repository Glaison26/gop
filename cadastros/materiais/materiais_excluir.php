<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

if (!isset($_GET["id"])) {
    header('location: /gop/cadastros/materiais/materiais_lista.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];
// conexão dom o banco de dados
include("../../conexao.php");
include("../../links2.php");
include('../../cabec_exclusao.php');
// verico se elxistem recursos com o tipo no cadastro
$c_sql_conta = "select count(*) nregistros from ordens_materiais where id_material=$c_id";  // relacionamento com tabela de ordens  X materiais
$result = $conection->query($c_sql_conta);
$registro = $result->fetch_assoc();
//
$c_sql_conta = "select count(*) nregistros from compras_materiais where id_material=$c_id";  // relacionamento com tabela de compras  X materiais
$result = $conection->query($c_sql_conta);
$registro2 = $result->fetch_assoc();
//
$c_sql_conta = "select count(*) nregistros from cotacao_materiais where id_material=$c_id";  // relacionamento com tabela de cotacao X materiais
$result = $conection->query($c_sql_conta);
$registro3 = $result->fetch_assoc();
if ($registro['nregistros'] + $registro2['nregistros'] + $registro3['nregistros'] == 0) {
    // Exclusão do registro
    $c_sql = "delete from materiais where id=$c_id";
    $result = $conection->query($c_sql);
    header('location: /gop/cadastros/materiais/materiais_lista.php');
} else {
    echo "<script>alert('Não é possivel excluir registro!')</script>";
    echo "<div class='container-fluid'>
     <a class='btn btn-primary' href='/gop/cadastros/materiais/materiais_lista.php'><span class='glyphicon glyphicon-off'></span> Voltar a Lista</a>
    </div>";
}
