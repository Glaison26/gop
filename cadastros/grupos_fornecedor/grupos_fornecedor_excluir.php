<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

if (!isset($_GET["id"])) {
    header('location: /gop/cadastros/grupos/grupos_lista.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];
// conexão dom o banco de dados
// conexão dom o banco de dados
include("../../conexao.php");
include("../../links2.php");
include('../../cabec_exclusao.php');
// Exclusão do registro
// verico se eexistem fornecedores vinculados a este grupo
$c_sql = "select count(*) as nregistros from fornecedores where id_grupo_fornecedor=$c_id";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();

if ($registro['nregistros'] == 0) {
    $c_sql = "delete from grupos_fornecedores where id=$c_id";
    $result = $conection->query($c_sql);
    header('location: /gop/cadastros/grupos/grupos_lista.php');
} else {
    echo "<script>alert('Não é possivel excluir registro!')</script>";
    echo "<div class='container-fluid'>
     <a class='btn btn-primary' href='/gop/cadastros/grupos/grupos_lista.php'><span class='glyphicon glyphicon-off'></span> Voltar a Lista</a>
    </div>";
}
