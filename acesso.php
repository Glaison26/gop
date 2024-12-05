<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include('links2.php');
include('conexao.php');
include_once "lib_gop.php";
?>

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
            <h5>Acesso negado a página<h5>
        </div>
    </div>

    <div class="container -my5">
        <div class='alert alert-warning' role='alert'>
        <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\aviso.png" alt="100" height="100" width='100'>
            </div>
            <h1>Acesso Negado !!!</h1>
            <br>
        </div>
        <br>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Desculpe você não tem acesso a pagina requisitada do Sistema. Em caso de dúvida entre em contato com um dos admistradores do Sistema.</h5>
        </div>
        <a class="btn btn btn-success" href="/gop/menu.php"><span class="glyphicon glyphicon-off"></span> Voltar ao Menu</a>
    </div>

</body>

</html>