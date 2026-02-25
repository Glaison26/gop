<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

if (!isset($_GET["id"])) {
    header('location: /gop/cadastros/ocorrencias/tipo_ocorrencias.php');
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
// verico se elxistem recursos com o tipo no cadastro
$c_sql_conta = "select count(*) nregistros from ocorrencias where id_tipo_ocorrencia=$c_id";  // relacionamnto com tabela de ocorrencias
$result = $conection->query($c_sql_conta);
$registro = $result->fetch_assoc();
if ($registro['nregistros'] == 0) {
    $c_sql = "delete from tipoocorrencia where id=$c_id";
    $result = $conection->query($c_sql);
    header('location: /gop/cadastros/ocorrenciaa/tipo_ocorrencias.php');
} else {
    echo "<script>alert('Não é possivel excluir registro!')</script>";
    echo "<div class='container-fluid'>
     <a class='btn btn-primary' href='/gop/cadastros/ocorrenciaa/tipo_ocorrencias.php'><span class='glyphicon glyphicon-off'></span> Voltar a Lista</a>
    </div>";
}
