<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Erro de Exclusão de Registro<h5>
        </div>
    </div>
    <div class='alert alert-info' role='alert'>
        <div style="padding-left:15px;">
            <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

        </div>
        <h5>Houve um erro ao excluir o registro selecionado!</h5>
    </div>

</body>

</html>


<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

if (!isset($_GET["id"])) {
    header('location: /gop/cadastros/tipos/tipos_lista.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];
// conexão dom o banco de dados
include("../../conexao.php");
include("../../links2.php");

// Exclusão do registro
// verico se elxistem recursos com o tipo no cadastro
$c_sql_conta = "select count(*) nregistros from recursos where id_tipo=$c_id";
$result = $conection->query($c_sql_conta);
$registro = $result->fetch_assoc();
if ($registro['nregistros'] == 0) {
    $c_sql = "delete from tipos where id=$c_id";
    $result = $conection->query($c_sql);
    header('location: /gop/cadastros/tipos/tipos_lista.php');
} else {
    echo "<script>alert('Não é possivel excluir registro!')</script>";
    echo "<a class='btn btn-secondary' href='/gop/cadastros/tipos/tipos_lista.php'><span class='glyphicon glyphicon-off'></span> Voltar</a>";
}
