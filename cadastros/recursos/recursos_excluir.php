<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
if (!isset($_GET["id"])) {
    header('location: /gop/cadastros/recursos/recursos_lista.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];
// conexão dom o banco de dados
include("../../conexao.php");
include("../../links2.php");
include('../../cabec_exclusao.php');
// Exclusão do registro
// verico se elxistem recursos com o tipo no cadastro
$c_sql_conta = "select count(*) nregistros from solicitacao where id_recursos=$c_id";  // verifica solicitações
$result = $conection->query($c_sql_conta);
$registro = $result->fetch_assoc();
//
$c_sql_conta = "select count(*) nregistros from ordens where id_recurso=$c_id"; // verifica ordens de serviços
$result = $conection->query($c_sql_conta);
$registro2 = $result->fetch_assoc();
//
$c_sql_conta = "select count(*) nregistros from preventivas where id_recurso=$c_id"; // verifica preventivas
$result = $conection->query($c_sql_conta);
$registro3 = $result->fetch_assoc();
//
if ($registro['nregistros']+$registro2['nregistros']+$registro3['nregistros'] == 0) {
    $c_sql = "delete from recursos where id=$c_id";
    $result = $conection->query($c_sql);
    header('location: /gop/cadastros/recursos/recursos_lista.php');
}else{
    echo "<script>alert('Não é possivel excluir registro!')</script>";
    echo "<div class='container-fluid'>
     <a class='btn btn-primary' href='/gop/cadastros/recursos/recursos_lista.php'><span class='glyphicon glyphicon-off'></span> Voltar a Lista</a>
    </div>";   
}
