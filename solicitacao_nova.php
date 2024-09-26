<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
$_SESSION['tiposolicitacao'] = 'V';
$_SESSION['opcao'] = "S";
include("conexao.php");
include("links2.php");
?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="container -my5">
        <div class="panel panel-primary class">
            <div class="panel-heading text-center">
                <h4>GOP - Gestão Operacional</h4>
                <h5>Solicitações de Serviços<h5>
            </div>
        </div>

        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Escolha o tipo da solicitação entre Recurso Fisico, Espaço Físico ou solicitação avulsa</h5>
        </div>
        <div style="padding-bottom :2px;">
            <div class="topnav">
                <a href="\gop\recurso_pesquisa.php"><img src="\gop\images\construcao.png" alt="" width="30" height="35">
                    Serviço em Recurso Físico</a>
                <a href="\gop\espaco_pesquisa.php"><img src="\gop\images\pedreiro.png" alt="" width="30" height="35">
                    Serviço em Espaços Físicos</a>
                <a href="\gop\solicitacao_conclusao.php"><img src="\gop\images\ordem.png" alt="" width="30" height="35">
                    Solicitação de Serviço Avulso</a>
                <a href="\gop\solicitacao.php"><img src="\gop\images\saida.png" alt="" width="30" height="35"> Voltar as opções</a>
            </div>
        </div>
    </div>
</body>

</html>

<style>
    /* Add a black background color to the top navigation */
    .topnav {
        background-color: #4682B4;
        overflow: hidden;
    }

    /* Style the links inside the navigation bar */
    .topnav a {
        float: left;
        color: #f2f2f2;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
        font-size: 17px;
    }

    /* Change the color of links on hover */
    .topnav a:hover {
        background-color: #4682B4;
        color: black;
    }

    /* Add a color to the active/current link */
    .topnav a.active {
        background-color: #4682B4;
        color: white;
    }
</style>