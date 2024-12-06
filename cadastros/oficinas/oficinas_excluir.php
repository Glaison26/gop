<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}


if (!isset($_GET["id"])) {
    header('location: /gop/cadastros/oficinas/oficinas_lista.php');
    exit;
}

include("../../conexao.php");
include("../../links2.php");
include('../../cabec_exclusao.php');

$c_id = "";
$c_id = $_GET["id"];
// verico se elxistem recursos com o tipo no cadastro
$c_sql_conta = "select count(*) nregistros from executores where id_oficina=$c_id";  // verifico em executores
$result = $conection->query($c_sql_conta);
$registro = $result->fetch_assoc();
//
$c_sql_conta = "select count(*) nregistros from ordens where id_oficina=$c_id";  // verifico em ordens
$result = $conection->query($c_sql_conta);
$registro2 = $result->fetch_assoc();
//
$c_sql_conta = "select count(*) nregistros from preventivas where id_oficina=$c_id";  // verifico em ordens
$result = $conection->query($c_sql_conta);
$registro3 = $result->fetch_assoc();
if ($registro['nregistros']+$registro2['nregistros']+$registro3['nregistros'] == 0) {
    // Exclusão do registro
    $c_sql = "delete from oficinas where id=$c_id";
    $result = $conection->query($c_sql);
    header('location: /gop/cadastros/oficinas/oficinas_lista.php');
} else {
    echo "<script>alert('Não é possivel excluir registro!')</script>";
    echo "<div class='container-fluid'>
     <a class='btn btn-primary' href='/gop/cadastros/oficinas/oficinas_lista.php'><span class='glyphicon glyphicon-off'></span> Voltar a Lista</a>
    </div>";
}
