<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
$_SESSION['tiposolicitacao'] = 'V';
$_SESSION['opcao'] = "S";
$_SESSION['ocorrencia'] = "";
$_SESSION['valor_ocorrencia'] = "";
include("../conexao.php");
include("../links2.php");
// sql do arquivo de configurações 
$c_sql_conf = "select * from configuracoes";
$result = $conection->query($c_sql_conf);
$registro = $result->fetch_assoc();
// verifico se apenas uma opção ente solicitação avulsa, recursos físicos ou espaços físicos está habilitada
if (($registro['solicitacao_avulsa'] == 'S') && ($registro['solicitacao_recursos'] == 'N') && ($registro['solicitacao_espacos'] == 'N') && ($_SESSION['tipo'] == 'Solicitante')) {
    header("Location: \gop\solicitacao\solicitacao_conclusao.php");
    exit();
}
if (($registro['solicitacao_avulsa'] == 'N') && ($registro['solicitacao_recursos'] == 'S') && ($registro['solicitacao_espacos'] == 'N') && ($_SESSION['tipo'] == 'Solicitante')) {
    header("Location: \gop\recurso_pesquisa.php");
    exit();
}
if (($registro['solicitacao_avulsa'] == 'N') && ($registro['solicitacao_recursos'] == 'N') && ($registro['solicitacao_espacos'] == 'S') && ($_SESSION['tipo'] == 'Solicitante')) {
    header("Location: \gop\espaco_pesquisa.php");
    exit();
}

?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="container-fluid">
        <div class="panel panel-primary class">
            <div class="panel-heading text-center">
                <h4>GOP - Gestão Operacional</h4>
                <h5>Solicitações de Serviços<h5>
            </div>
        </div>
        <!-- painel con instruçoes dobre as escolhas -->
        <div class="container -my5">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
                </div>
                <h5>Escolha o tipo da Solicitação entre Avulsa, Recurso Fisico ou Espaço Físico</h5>
            </div>

            <hr>

            <div style="padding-bottom :2px;">

                <?php
                if (($registro['solicitacao_avulsa'] == 'S') || ($_SESSION['tipo'] <> 'Solicitante')) {
                    echo '
                
                <a class="btn btn btn-sm" href="\gop\solicitacao\solicitacao_conclusao.php"><img src="\gop\images\ordem.png" alt="" width="30" height="35">
                    Iniciar nova Solicitação de Serviço</a>';
                }
                if (($registro['solicitacao_recursos'] == 'S') || ($_SESSION['tipo'] <> 'Solicitante')) {
                    echo '
                <a class="btn btn btn-sm" href="\gop\recurso_pesquisa.php"><img src="\gop\images\construcao.png" alt="" width="30" height="35">
                    Iniciar nova Solicitação em Recurso Físico</a>';
                }
                if (($registro['solicitacao_espacos'] == 'S') || ($_SESSION['tipo'] <> 'Solicitante')) {
                    echo '
                <a class="btn btn btn-sm" href="\gop\espaco_pesquisa.php"><img src="\gop\images\pedreiro.png" alt="" width="30" height="35">
                    Iniciar nova Solicitação em Espaço Físico</a>';
                }

                ?>
                <a class="btn btn btn-sm" href="\gop\solicitacao\solicitacao.php"><img src="\gop\images\saida.png" alt="" width="30" height="35"> Voltar as opções</a>

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