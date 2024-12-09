<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}


if (!isset($_GET["id"])) {
    header('location: /gop/cadastros/setores/setores_lista.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];
include("../../conexao.php");
include("../../links2.php");
include('../../cabec_exclusao.php');
// verico se elxistem recursos com o tipo no cadastro
$c_sql_conta = "select count(*) nregistros from recursos where id_setor=$c_id";  // verifico em recursos fisicos
$result = $conection->query($c_sql_conta);
$registro = $result->fetch_assoc();
//
$c_sql_conta = "select count(*) nregistros from ordens where id_setor=$c_id";  // verifico em ordens de serviços
$result = $conection->query($c_sql_conta);
$registro2 = $result->fetch_assoc();
//
$c_sql_conta = "select count(*) nregistros from preventivas where id_setor=$c_id";  // verifico em preventivas
$result = $conection->query($c_sql_conta);
$registro3 = $result->fetch_assoc();
//
$c_sql_conta = "select count(*) nregistros from solicitacao where id_setor=$c_id";  // verifico em solicitacoes de servicos
$result = $conection->query($c_sql_conta);
$registro4 = $result->fetch_assoc();
if ($registro['nregistros'] + $registro2['nregistros'] + $registro3['nregistros'] + $registro4['nregistros'] == 0) {
    // Exclusão do registro
    $c_sql = "delete from setores where id=$c_id";
  
    $result = $conection->query($c_sql);

    header('location: /gop/cadastros/setores/setores_lista.php');
} else {
    echo "<script>alert('Não é possivel excluir registro!')</script>";
    echo "<div class='container-fluid'>
     <a class='btn btn-primary' href='/gop/cadastros/setores/setores_lista.php'><span class='glyphicon glyphicon-off'></span> Voltar a Lista</a>
    </div>";
}
