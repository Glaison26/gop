<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
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
                <h5>Menu de Opções de Gestão de Obras<h5>
            </div>
        </div>

        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Selecione a opção abaixo da Gestão de Obras</h5>
        </div>
        <div style="padding-bottom :2px;">
            <div class="topnav">
                <a href="\gop\obras\obras_lista.php"><img src="\gop\images\ooadwork.png" alt="" width="30" height="35">
                    Lançamentos de Obras</a>
                <a href="\gop\obras\obras_itens_lista.php"><img src="\gop\images\pedreiro.png" alt="" width="30" height="35">
                    Itens de Obras</a>
                <a href="\gop\obras\obras_grupos_lista.php"><img src="\gop\images\construcao2.png" alt="" width="30" height="35">
                    Grupos de Itens de Obras</a>
                <a href="\gop\menu.php"><img src="\gop\images\saida.png" alt="" width="30" height="35"> Voltar ao Menu</a>
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