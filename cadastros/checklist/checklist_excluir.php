<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

if (!isset($_GET["id"])) {
    header('location: /gop/cadastros/checklist/checklist_lista.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];

// conexão dom o banco de dados
include("../../conexao.php");
include("../../links2.php");
include('../../cabec_exclusao.php');
// verico se elxistem tabelas filhas vinculado ao checklist
$c_sql_conta = "select count(*) nregistros from ordens_check where id_check=$c_id";  // relacionamnto com tabela de checklist X ordens de serviços
$result = $conection->query($c_sql_conta);
$registro = $result->fetch_assoc();
if ($registro['nregistros'] == 0) {
    // Exclusão do registro
    $c_sql = "delete from checklist where id=$c_id";

    $result = $conection->query($c_sql);

    header('location: /gop/cadastros/checklist/checklist_lista.php');
} else {
    echo "<script>alert('Não é possivel excluir registro!')</script>";
    echo "<div class='container-fluid'>
     <a class='btn btn-primary' href='/gop/cadastros/checklist/checklist_lista.php'><span class='glyphicon glyphicon-off'></span> Voltar a Lista</a>
    </div>";
}
